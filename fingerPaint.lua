-- fingerPaint Library for Corona SDK v1.5
-- Copyright (c) 2015 Jason Schroeder
-- http://www.jasonschroeder.com
-- http://www.twitter.com/schroederapps

--[[ Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE. ]]--

------------------------------------------------------------------------------------
-- HOW TO USE THIS MODULE
------------------------------------------------------------------------------------
-- Step One: put this lua file in your project's root directory
-- Step Two: require the module in your project as such:
	-- local fingerPaint = require("fingerPaint")
-- Step Three: create a finger painting "canvas" object as such:
	-- local canvas = fingerPaint.newCanvas()
	-- You can customize your canvas by including a single table as an argument when calling fingerPaint.newCanvas(). The table can include any of the following key/value pairs (but none are required):
		-- width: the width of your canvas. Defaults to the full screen width.
		-- height: the height of your canvas. Defaults to the full screen height.
		-- strokeWidth: the width of your fingerpainting "strokes," or the lines that the user draws. Defaults to 10 pixels.
		-- canvasColor: a table containing 4 numbers between 0 and 1, representing the RBGA values of your canvas' background color. Defaults to {1, 1, 1, 1} (white). TIP: Set the 4th value to 0 for a canvas with a transparent background.
		-- paintColor: a table containing 4 numbers between 0 and 1, representing the RBGA values of the "paint" color. Defaults to {0, 0, 0, 1} (black).
		-- segmented: a boolean (true/false) that, when set to true, results in paint strokes that are comprised of separate line object segments. USE WITH CAUTION: setting this value to true can substantially increase the memory usage of your app. Defaults to false.
		-- x: the x coordinate where you want your canvas to be placed. Defaults to the horizontal center of the screen.
		-- y: the y coordinate where you want your canvas to be placed. Defaults to the vertical center of the screen.
		-- isActive: a boolean (true/false) that disables painting when set to false, and enables painting when set to true. Defaults to true.
		
-- Step Four: you can adjust the behavior of your finger painting canvas using the following methods:
	-- canvas:setPaintColor() will change the paint color for all future paint strokes (older paint strokes will be unaffected). You must pass a single table into the function containing 4 numbers between 0 and 1, representing the RBGA values of the new paint color.
	-- canvas:setCanvasColor() will change the canvas' background color. You must pass a single table into the function containing 4 numbers between 0 and 1, representing the RBGA values of the new background color. TIP: Set the 4th value to 0 for a canvas with a transparent background.
	-- canvas:setStrokeWidth() will change the width of future paint strokes (older paint strokes will be unaffected). You must pass a single number into the function, representing the new stroke width.
	-- canvas:undo() will remove existing paint strokes, in reverse order, one at a time.
	-- canvas:redo() will restore "undone" paint strokes, in the order in which they were created, one at a time.
	-- canvas:erase() will remove all paint strokes from the canvas. It cannot be undone.
	-- canvas.isActive is a boolean (true/false) property of the canvas object that can be changed as needed to enable or disable painting.

------------------------------------------------------------------------------------
-- CREATE TABLE TO HOLD MODULE
------------------------------------------------------------------------------------
local fingerPaint = {}

------------------------------------------------------------------------------------
-- SCREEN POSITIONING VARIABLES
------------------------------------------------------------------------------------
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local screenTop = display.screenOriginY
local screenLeft = display.screenOriginX
local screenBottom = display.screenOriginY+display.actualContentHeight
local screenRight = display.screenOriginX+display.actualContentWidth
local screenWidth = screenRight - screenLeft
local screenHeight = screenBottom - screenTop

------------------------------------------------------------------------------------
-- CREATE NEW FINGERPAINT CANVAS
------------------------------------------------------------------------------------
function fingerPaint.newCanvas(...)
	-- available params are: width, height, strokeWidth, canvasColor, paintColor, segmented, x, y, isActive
	local arguments = {...}
	local params = arguments[1]
	if params == nil then params = {} end
	
	--------------------------------------------------------------------------------
	-- BACKWARDS COMPATIBILITY WITH v1.0 SYNTAX
	--------------------------------------------------------------------------------
	if type(params) ~= "table" then
		params = {
			width = arguments[1],
			height = arguments[2],
			strokeWidth = arguments[3],
			paintColor = arguments[4],
			canvasColor = arguments[5],
		}
	end
	
	--------------------------------------------------------------------------------
	-- LOCALIZE PARAMS & SET DEFAULTS
	--------------------------------------------------------------------------------
	local width = params.width or screenWidth
	local height = params.height or screenHeight
	local strokeWidth = params.strokeWidth or 10
	local canvasColor = params.canvasColor or {1, 1, 1, 1}
		if canvasColor[4] == nil then canvasColor[4] = 1 end
		local canvasR = canvasColor[1]
		local canvasG = canvasColor[2]
		local canvasB = canvasColor[3]
		local canvasA = canvasColor[4]
	local paintColor = params.paintColor or {0, 0, 0, 1}
		if paintColor[4] == nil then paintColor[4] = 1 end
		local paintR = paintColor[1]
		local paintG = paintColor[2]
		local paintB = paintColor[3]
		local paintA = paintColor[4]
	local segmented = params.segmented or false
	local x = params.x or centerX
	local y = params.y or centerY
	local isActive = params.isActive or true
	local circleRadius = strokeWidth * .5
	
	--------------------------------------------------------------------------------
	-- CREATE CANVAS CONTAINER OBJECT
	--------------------------------------------------------------------------------
	local canvas = display.newContainer(width, height)
	canvas.x, canvas.y = x, y
	canvas.isActive = isActive
	canvas.paintR, canvas.paintG, canvas.paintB, canvas.paintA = paintR, paintG, paintB, paintA
	canvas.canvasR, canvas.canvasG, canvas.canvasB, canvas.canvasA = canvasR, canvasG, canvasB, canvasA
	
	--------------------------------------------------------------------------------
	-- CREATE CANVAS BACKGROUND RECT
	--------------------------------------------------------------------------------
	local background = display.newRect(canvas, screenLeft - screenWidth, screenTop - screenHeight, screenWidth * 3, screenHeight * 3)
	background:setFillColor(canvasR, canvasG, canvasB)
	background.isHitTestable = true
		
	--------------------------------------------------------------------------------
	-- CREATE TABLE TO HOLD PAINT STROKES
	--------------------------------------------------------------------------------
	canvas.strokes = {}
	local strokes = canvas.strokes
	
	--------------------------------------------------------------------------------
	-- CREATE TABLE TO HOLD UNDONE PAINT STROKES
	--------------------------------------------------------------------------------
	canvas.undone = {}
	local undone = canvas.undone
	
	--------------------------------------------------------------------------------
	-- SET VARIABLE TO TEST IF TOUCHES BEGAN ON CANVAS
	--------------------------------------------------------------------------------
	local touchBegan = false
	
	--------------------------------------------------------------------------------
	-- TOUCH EVENT HANDLER FUNCTION
	--------------------------------------------------------------------------------
	local function touch(event)
		-- set local variables
		local phase = event.phase
		local target = event.target
		local stroke = strokes[#strokes]
		
		-- recalculate touch cooridnates, taking into account canvas position
		local canvasX, canvasY = canvas:localToContent(canvas.anchorX, canvas.anchorY)
		local x = event.x - canvasX
		local y = event.y - canvasY
		local xStart = event.xStart - canvasX
		local yStart = event.yStart - canvasY
		
		local function getDistance(x1,y1,x2,y2)
			return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
		end
		
		if target.lastX == nil then
			target.lastX, target.lastY = x, y
		end
		
		local distance = getDistance(x, y, target.lastX, target.lastY)
		
		-- check for event phase & start, update, or end stroke accordingly
		if phase == "began" and canvas.isActive then
			-- empty undone table
			for i=#undone,1,-1 do
				display.remove(undone[i])
				undone[i] = nil
			end
			-- start stroke
			display.getCurrentStage():setFocus(target, event.id)
			touchBegan = true
			strokes[#strokes+1] = display.newGroup()
			stroke = strokes[#strokes]
			canvas:insert(stroke)
			local circle = display.newCircle(stroke, x, y, circleRadius)
			circle:setFillColor(paintR, paintG, paintB, paintA)
			target.lastX, target.lastY = x, y
		elseif phase=="moved" and touchBegan == true and distance > circleRadius*.5 then
			-- append to stroke
			if segmented then
				stroke.line = display.newLine(stroke, target.lastX, target.lastY, x, y)
				local circle = display.newCircle(stroke, x, y, circleRadius)
				circle:setFillColor(paintR, paintG, paintB, paintA)
			else
				if stroke.line == nil then 
					stroke.line = display.newLine(stroke, xStart, yStart, x, y)
					stroke.circle = display.newCircle(stroke, x, y, circleRadius)
					stroke.circle:setFillColor(paintR, paintG, paintB, paintA)
				else
					stroke.line:append(x, y)
					stroke.circle.x, stroke.circle.y = x, y
				end
			end
			stroke.line:setStrokeColor(paintR, paintG, paintB, paintA)
			stroke.line.strokeWidth = strokeWidth
			target.lastX, target.lastY = x, y
		elseif (phase == "cancelled" or phase == "ended") and touchBegan == true then
			-- end stroke
			display.getCurrentStage():setFocus(nil, event.id)
			touchBegan = false
			local circle = display.newCircle(stroke, x, y, circleRadius)
				circle:setFillColor(paintR, paintG, paintB, paintA)
			target.lastX, target.lastY = nil, nil
			return true
		end
	end
	
	--------------------------------------------------------------------------------
	-- ADD TOUCH LISTENER TO CANVAS
	--------------------------------------------------------------------------------
	canvas:addEventListener("touch", touch)
	
	--------------------------------------------------------------------------------
	-- FUNCTION TO CHANGE PAINT COLOR
	--------------------------------------------------------------------------------
	function canvas:setPaintColor(r, g, b, a)
		paintR = r
		paintG = g
		paintB = b
		paintA = a or paintA
		canvas.paintR, canvas.paintG, canvas.paintB, canvas.paintA = paintR, paintG, paintB, paintA
	end
	
	--------------------------------------------------------------------------------
	-- FUNCTION TO CHANGE CANVAS COLOR
	--------------------------------------------------------------------------------
	function canvas:setCanvasColor(r, g, b, a)
		background:setFillColor(r,g,b,a)
		canvasR = r
		canvasG = g
		canvasB = b
		canvasA = a or canvasA
		canvas.canvasR, canvas.canvasG, canvas.canvasB, canvas.canvasA = canvasR, canvasG, canvasB, canvasA
	end
	
	--------------------------------------------------------------------------------
	-- FUNCTION TO CHANGE STROKE WIDTH
	--------------------------------------------------------------------------------
	function canvas:setStrokeWidth(newWidth)
		strokeWidth = newWidth
		circleRadius = newWidth * .5
	end
	
	--------------------------------------------------------------------------------
	-- FUNCTION TO UNDO PAINT STROKES
	--------------------------------------------------------------------------------
	function canvas:undo()
		if #strokes>0 then
			local n = #strokes
			local stroke = strokes[n]
			table.remove(strokes, n)
			strokes[n] = nil
			undone[#undone+1] = stroke
			stroke.isVisible = false
		end
	end
	
	--------------------------------------------------------------------------------
	-- FUNCTION TO REDO PAINT STROKES
	--------------------------------------------------------------------------------
	function canvas:redo()
		if #undone>0 then
			local n = #undone
			local stroke = undone[n]
			table.remove(undone, n)
			undone[n] = nil
			strokes[#strokes+1] = stroke
			stroke.isVisible = true
		end
	end
	
	--------------------------------------------------------------------------------
	-- FUNCTION TO ERASE ALL PAINT STROKES
	--------------------------------------------------------------------------------
	function canvas:erase()
		if #strokes>0 then
			for n = #strokes, 1, -1 do
				local stroke = strokes[n]
				table.remove(strokes, n)
				strokes[n] = nil
				display.remove(stroke)
				undone = {}
			end
		end
	end
	
	return canvas
end

return fingerPaint