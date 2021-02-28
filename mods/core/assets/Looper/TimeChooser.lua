local app = app
local Env = require "Env"
local Drawings = require "Drawings"
local Class = require "Base.Class"
local Window = require "Base.Window"
local Message = require "Message"

local threshold = Env.EncoderThreshold.DurationControl
local ply = app.SECTION_PLY

-- heights
local line1 = app.GRID4_LINE1
local line2 = app.GRID4_LINE2
local line3 = app.GRID4_LINE3

local TimeChooser = Class {}
TimeChooser:include(Window)

function TimeChooser:init(channelCount)
  Window.init(self)
  self:setClassName("builtins.Looper.TimeChooser")

  self.mainButtons = {
    app.MainButton(" mins ", 1),
    app.MainButton(" secs ", 2),
    app.MainButton("  ms  ", 3),
    app.MainButton(" unit ", 4),
    app.MainButton(" chan ", 5),
    app.MainButton(" rate ", 6)
  }

  for _, button in ipairs(self.mainButtons) do
    self.mainGraphic:addChild(button)
  end

  self.subButtons = {
    app.SubButton("zero", 3)
  }

  for _, button in ipairs(self.subButtons) do self.subGraphic:addChild(button) end

  self.durationControl = app.DurationControl()
  self.durationControl:setCenter(app.BUTTON2_CENTER, line2)
  self.mainGraphic:addChild(self.durationControl)
  self:setMainCursorController(self.durationControl)

  local drawing = app.Drawing(0, 0, 256, 64)
  self.mainGraphic:addChild(drawing)
  drawing:add(Drawings.Main.TitleLine)

  self.unitBox = app.ListBox(0, 0, ply, 24)
  self.unitBox:setFocus()
  self.unitBox:enableCircularScrolling()
  self.unitBox:disableFollow()
  self.unitBox:setTextSize(10)
  self.unitBox:setCenter(app.BUTTON4_CENTER, line2)
  self.unitBox:addItem("time")
  self.unitBox:addItem("beats")
  self.unitBox:hideScrollbar()
  self.mainGraphic:addChild(self.unitBox)

  self.channelBox = app.ListBox(0, 0, ply, 24)
  self.channelBox:setFocus()
  self.channelBox:enableCircularScrolling()
  self.channelBox:disableFollow()
  self.channelBox:setTextSize(10)
  self.channelBox:setCenter(app.BUTTON5_CENTER, line2)
  if channelCount > 1 then
    self.channelBox:addItem("2ch")
  else
    self.channelBox:addItem("1ch")
  end
  self.channelBox:hideScrollbar()
  self.mainGraphic:addChild(self.channelBox)

  self.rateBox = app.ListBox(0, 0, ply, 24)
  self.rateBox:setFocus()
  self.rateBox:enableCircularScrolling()
  self.rateBox:disableFollow()
  self.rateBox:setTextSize(10)
  self.rateBox:setCenter(app.BUTTON6_CENTER, line2)
  -- only support one sample rate at the moment
  self.rateBox:addItem(
      string.format("%dkHz", app.globalConfig.sampleRate // 1000))
  self.rateBox:hideScrollbar()
  self.mainGraphic:addChild(self.rateBox)

  local label = app.Label("Choose time interval and press ENTER.", 10)
  label:setPosition(3, line1 + 3)
  label:setJustification(app.justifyLeft)
  self.mainGraphic:addChild(label)

  self.memLabel = app.Label("", 12)
  self.memLabel:setPosition(5, line2)
  self.memLabel:setJustification(app.justifyLeft)
  self.subGraphic:addChild(self.memLabel)

  self.maxLabel = app.Label("", 12)
  self.maxLabel:setPosition(5, line3)
  self.maxLabel:setJustification(app.justifyLeft)
  self.subGraphic:addChild(self.maxLabel)

  label = app.Label("Memory", 12)
  label:setPosition(3, line1 + 3)
  label:setJustification(app.justifyLeft)
  self.subGraphic:addChild(label)
  self:updateMemoryEstimate()

  drawing = app.Drawing(0, 0, 128, 64)
  self.subGraphic:addChild(drawing)
  drawing:add(Drawings.Sub.TitleLine)

  -- initialize task tables
  self.mainTasks = {
    self.focusMinutes,
    self.focusSeconds,
    self.focusMilliseconds,
    self.toggleUnits,
    self.toggleChannel,
    self.toggleRate
  }
end

-- memory usage display
local memUnit = 1024 * 1024
local memFormat = "%3.2fMB req"
local maxFormat = "%3dMB max"

function TimeChooser:onShow()
  local largest = app.BigHeap.largest(memUnit)
  self.maxLabel:setText(string.format(maxFormat, largest))
  self:focusSeconds()
end

function TimeChooser:updateMemoryEstimate()
  local ch = self.channelBox:getSelectedIndex() + 1
  local secs = self.durationControl:getTotalSeconds()
  local f = (4 * app.globalConfig.sampleRate) // memUnit
  local memRequired = ch * secs * f
  local largest = app.BigHeap.largest(memUnit)
  self.memLabel:setText(string.format(memFormat, memRequired))
  return memRequired < largest
end

function TimeChooser:focusMinutes()
  self.durationControl:setEncoderFocus(0)
end

function TimeChooser:focusSeconds()
  self.durationControl:setEncoderFocus(1)
end

function TimeChooser:focusMilliseconds()
  self.durationControl:setEncoderFocus(2)
end

function TimeChooser:toggleUnits()
  self.unitBox:scrollDown()
  local unit = self.unitBox:getSelected()
  if unit == "time" then
    self.durationControl:setMode(app.durationMMSSXXX)
    self.mainButtons[1]:setText("mins")
    self.mainButtons[2]:setText("secs")
    self.mainButtons[3]:setText(" ms ")
  elseif unit == "beats" then
    self.durationControl:setMode(app.durationBeats)
    self.mainButtons[1]:setText("beats")
    self.mainButtons[2]:setText("----")
    self.mainButtons[3]:setText("BPM")
  end
end

function TimeChooser:toggleChannel()
  self.channelBox:scrollDown()
  self:updateMemoryEstimate()
end

function TimeChooser:toggleRate()
  self.rateBox:scrollDown()
  self:updateMemoryEstimate()
end

function TimeChooser:mainReleased(i, shifted)
  if shifted then
    return false
  else
    self.mainTasks[i](self)
    return true
  end
end

function TimeChooser:subReleased(i, shifted)
  if shifted then
    return false
  elseif i == 3 then
    -- zero
    self.durationControl:setTotalSeconds(0)
    self:updateMemoryEstimate()
    return true
  end
end

function TimeChooser:encoder(change, shifted)
  self.durationControl:encoder(change, shifted, threshold)
  self:updateMemoryEstimate()
  return true
end

function TimeChooser:cancelReleased(shifted)
  if shifted then return false end
  self:hide()
  self:emitSignal("done")
  return true
end

function TimeChooser:enterReleased()
  if not self:updateMemoryEstimate() then
    local dialog = Message.Main("Not enough contiguous memory",
                                "to create this buffer.")
    dialog:show()
    return true
  end
  local secs = self.durationControl:getTotalSeconds()
  self:hide()
  self:emitSignal("done", secs)
  return true
end

function TimeChooser:upReleased(shifted)
  if shifted then return false end
  self:hide()
  self:emitSignal("done")
  return true
end

return TimeChooser
