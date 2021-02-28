include env.mk
include utils.mk

program_name := app
program_dir := $(top_dir)/$(program_name)
xroot_dir := $(top_dir)/xroot
out_dir := $(build_dir)/$(program_name)
exports_file := $(program_dir)/exports.txt

src_dirs := $(program_dir) $(hal_dir) $(arch_hal_dir) $(od_dir) $(ti_dir)

includes += $(top_dir) $(arch_dir) $(lua_dir) $(ne10_dir)/inc $(lodepng_dir) $(miniz_dir)

libraries :=
libraries += $(libs_build_dir)/lib$(lua_name).a
libraries += $(libs_build_dir)/libne10.a
libraries += $(libs_build_dir)/liblodepng.a
libraries += $(libs_build_dir)/libminiz.a

# sysbios configuration
XDCLOCAL = $(sysbios_dir)/platforms
XDCPATH = $(bios_install_dir);$(uia_install_dir);$(XDCLOCAL);
sysbios_target = gnu.targets.arm.A8F
sysbios_platform = am335x_DDR3_512MB
sysbios_buildtype = release
sysbios_build_dir = $(out_dir)/sysbios
#sysbios_objects = er301.cfg
sysbios_objects = $(sysbios_buildtype).cfg common.cfg $(XDCLOCAL)/linkcmd_er301.xdt
	 
# Recursive search for source files
cpp_sources := $(foreach D,$(src_dirs),$(call rwildcard,$D,*.cpp)) 
c_sources := $(foreach D,$(src_dirs),$(call rwildcard,$D,*.c)) 
xroot_files := $(call rwildcard,$(xroot_dir),*)

objects := $(subst $(top_dir),$(out_dir),$(c_sources:%.c=%.o) $(cpp_sources:%.cpp=%.o)) 

# Manually add objects for swig wrappers and the ramdisk image.
objects += $(out_dir)/od/glue/$(program_name)_swig.o
objects += $(out_dir)/$(program_name)/xroot.o
objects += $(out_dir)/$(program_name)/symtab.o

CFLAGS += $(sysbios_cflags)
LFLAGS = $(sysbios_lflags) -Wl,--gc-sections -lm -lstdc++ -lc -lnosys -u _printf_float 

# Set search path for prerequisites
vpath %.c $(top_dir)
vpath %.cpp $(top_dir)
vpath %.c.swig $(top_dir)
vpath %.cpp.swig $(top_dir)
vpath %.cfg $(sysbios_dir)

all: $(out_dir)/kernel.bin

$(objects): $(sysbios_build_dir)/.timestamp

$(sysbios_build_dir)/.timestamp: $(sysbios_objects)
	@echo $(describe_env) XS $<
	@$(XS) -t $(sysbios_target) -p $(sysbios_platform) -r $(sysbios_buildtype) -o $(sysbios_build_dir) $<
	@touch $(sysbios_build_dir)/.timestamp

$(out_dir)/$(program_name)/xroot.S: $(xroot_files)
	@echo $(describe_env) GEN $(describe_target)
	@mkdir -p $(@D)
	@$(PYTHON) ramdisk.py $@ $(xroot_dir)

$(out_dir)/$(program_name)/symtab.cpp: $(program_dir)/symtab.cpp.awk $(out_dir)/$(program_name)/symtab.h $(exports_file)
	@echo $(describe_env) AWK $(describe_target)
	@sort -u $(exports_file) | awk -f $< > $@

$(out_dir)/$(program_name)/symtab.h: $(program_dir)/symtab.h.awk $(exports_file)
	@echo $(describe_env) AWK $(describe_target)
	@sort -u $(exports_file) | awk -f $< > $@

$(out_dir)/$(program_name).elf: $(objects) $(libraries)
	@mkdir -p $(@D)	
	@echo $(describe_env) LINK $(describe_target)
	@$(CC) $(CFLAGS) -o $@ $(objects) $(libraries) $(LFLAGS)
	@echo $(describe_env) NM $(program_name).sym
	@$(NM) --extern-only --defined-only --format=posix $@ | awk '{print $$1;}' > $(out_dir)/$(program_name).sym

$(out_dir)/$(program_name).bin: $(out_dir)/$(program_name).elf
	@echo $(describe_env) OBJCOPY $(describe_target)
	@mkdir -p $(@D)
	@$(SIZE) $<
	@$(OBJCOPY) -O binary $< $@

$(out_dir)/kernel.bin: $(out_dir)/$(program_name).bin
	@echo $(describe_env) TIIMAGE $(describe_target)
	@$(TIIMAGE) 0x80000000 MMCSD $< $@	

clean:
	rm -rf $(out_dir)

addr2line: $(out_dir)/$(program_name).elf
	@echo $(describe_env) Find ${ADDRESS} in $(out_dir)/$(program_name).elf
	@$(ADDR2LINE) -p -f -i -C -e $(out_dir)/$(program_name).elf -a $(ADDRESS)

FLASHFILE ?= $(out_dir)/$(program_name).elf
flash: all
	@echo $(describe_env) Flashing $(FLASHFILE)
	@$(uniflash_install_dir)/dslite.sh --config=uniflash/ER-301-USB560v2.ccxml --verbose --core=1 $(FLASHFILE)

libs: 
	+$(MAKE) -f lua.mk
	+$(MAKE) -f miniz.mk
	+$(MAKE) -f lodepng.mk
	+$(MAKE) -f ne10.mk

clean-libs: 
	+$(MAKE) -f lua.mk clean
	+$(MAKE) -f miniz.mk clean
	+$(MAKE) -f lodepng.mk clean
	+$(MAKE) -f ne10.mk clean

include rules.mk