#
#  Do not edit this file.  This file is generated from 
#  package.bld.  Any modifications to this file will be 
#  overwritten whenever makefiles are re-generated.
#

unexport MAKEFILE_LIST
MK_NOGENDEPS := $(filter clean,$(MAKECMDGOALS))
override PKGDIR = am335x_SRAM
XDCINCS = -I. -I$(strip $(subst ;, -I,$(subst $(space),\$(space),$(XPKGPATH))))
XDCCFGDIR = package/cfg/

#
# The following dependencies ensure package.mak is rebuilt
# in the event that some included BOM script changes.
#
ifneq (clean,$(MAKECMDGOALS))
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/utils.js:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/utils.js
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/xdc.tci:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/xdc.tci
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/template.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/template.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/om2.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/om2.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/xmlgen.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/xmlgen.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/xmlgen2.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/xmlgen2.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/Warnings.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/Warnings.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/IPackage.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/IPackage.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/package.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/package.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/services/global/Clock.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/services/global/Clock.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/services/global/Trace.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/services/global/Trace.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/bld.js:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/bld.js
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/BuildEnvironment.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/BuildEnvironment.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/PackageContents.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/PackageContents.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/_gen.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/_gen.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Library.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Library.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Executable.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Executable.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Repository.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Repository.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Configuration.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Configuration.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Script.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Script.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Manifest.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Manifest.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Utils.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/Utils.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITarget.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITarget.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITarget2.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITarget2.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITarget3.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITarget3.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITargetFilter.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/ITargetFilter.xs
/home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/package.xs:
package.mak: /home/clarkson/ti/ccs910/xdctools_3_55_02_22_core/packages/xdc/bld/package.xs
package.mak: config.bld
package.mak: package.bld
endif


all: .executables 
.executables: .libraries .dlls
.libraries: .interfaces

PKGCFGS := $(wildcard package.xs) package/build.cfg
.interfaces: package/package.xdc.inc package/package.defs.h package.xdc $(PKGCFGS)

-include package/package.xdc.dep
package/%.xdc.inc package/%_am335x_SRAM.c package/%.defs.h: %.xdc $(PKGCFGS)
	@$(MSG) generating interfaces for package am335x_SRAM" (because $@ is older than $(firstword $?))" ...
	$(XSRUN) -f xdc/services/intern/cmd/build.xs $(MK_IDLOPTS) -m package/package.xdc.dep -i package/package.xdc.inc package.xdc

ifeq (,$(MK_NOGENDEPS))
-include package/package.cfg.dep
endif

package/package.cfg.xdc.inc: .interfaces $(XDCROOT)/packages/xdc/cfg/cfginc.js package.xdc
	@$(MSG) generating schema include file list ...
	$(CONFIG) -f $(XDCROOT)/packages/xdc/cfg/cfginc.js am335x_SRAM $@

test:;
%,copy:
	@$(if $<,,$(MSG) don\'t know how to build $*; exit 1)
	@$(MSG) cp $< $@
	$(RM) $@
	$(CP) $< $@

$(XDCCFGDIR)%.c $(XDCCFGDIR)%.h $(XDCCFGDIR)%.xdl: $(XDCCFGDIR)%.cfg $(XDCROOT)/packages/xdc/cfg/Main.xs | .interfaces
	@$(MSG) "configuring $(_PROG_NAME) from $< ..."
	$(CONFIG) $(_PROG_XSOPTS) xdc.cfg $(_PROG_NAME) $(XDCCFGDIR)$*.cfg $(XDCCFGDIR)$*

.PHONY: release,am335x_SRAM
ifeq (,$(MK_NOGENDEPS))
-include package/rel/am335x_SRAM.zip.dep
endif
package/rel/am335x_SRAM/am335x_SRAM/package/package.rel.xml: package/package.bld.xml
package/rel/am335x_SRAM/am335x_SRAM/package/package.rel.xml: package/build.cfg
package/rel/am335x_SRAM/am335x_SRAM/package/package.rel.xml: package/package.xdc.inc
package/rel/am335x_SRAM/am335x_SRAM/package/package.rel.xml: package/package.cfg.xdc.inc
package/rel/am335x_SRAM/am335x_SRAM/package/package.rel.xml: .force
	@$(MSG) generating external release references $@ ...
	$(XS) $(JSENV) -f $(XDCROOT)/packages/xdc/bld/rel.js $(MK_RELOPTS) . $@

am335x_SRAM.zip: package/rel/am335x_SRAM.xdc.inc package/rel/am335x_SRAM/am335x_SRAM/package/package.rel.xml
	@$(MSG) making release file $@ "(because of $(firstword $?))" ...
	-$(RM) $@
	$(call MKRELZIP,package/rel/am335x_SRAM.xdc.inc,package/rel/am335x_SRAM.zip.dep)


release release,am335x_SRAM: all am335x_SRAM.zip
clean:: .clean
	-$(RM) am335x_SRAM.zip
	-$(RM) package/rel/am335x_SRAM.xdc.inc
	-$(RM) package/rel/am335x_SRAM.zip.dep

clean:: .clean
	-$(RM) .libraries $(wildcard .libraries,*)
clean:: 
	-$(RM) .dlls $(wildcard .dlls,*)
#
# The following clean rule removes user specified
# generated files or directories.
#

ifneq (clean,$(MAKECMDGOALS))
ifeq (,$(wildcard package))
    $(shell $(MKDIR) package)
endif
ifeq (,$(wildcard package/cfg))
    $(shell $(MKDIR) package/cfg)
endif
ifeq (,$(wildcard package/lib))
    $(shell $(MKDIR) package/lib)
endif
ifeq (,$(wildcard package/rel))
    $(shell $(MKDIR) package/rel)
endif
ifeq (,$(wildcard package/internal))
    $(shell $(MKDIR) package/internal)
endif
endif
clean::
	-$(RMDIR) package


