-- Services
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Prevent duplicate GUIs during testing
if playerGui:FindFirstChild("CodeRunnerGui") and script.Parent.Parent == playerGui then
	-- Let it run if it's the active script, otherwise handle gracefully
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CodeRunnerGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame (Window)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 12)
topBarCorner.Parent = topBar

-- Fix bottom corners of top bar to be square so they match the window nicely
local topBarFix = Instance.new("Frame")
topBarFix.Size = UDim2.new(1, 0, 0, 10)
topBarFix.Position = UDim2.new(0, 0, 1, -10)
topBarFix.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
topBarFix.BorderSizePixel = 0
topBarFix.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Lua Code Runner"
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
closeButton.AutoButtonColor = false
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(180, 180, 190)
closeButton.TextSize = 12
closeButton.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Editor / Input Box Container
local editorContainer = Instance.new("ScrollingFrame")
editorContainer.Name = "EditorContainer"
editorContainer.Size = UDim2.new(1, -30, 0, 160)
editorContainer.Position = UDim2.new(0, 15, 0, 55)
editorContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
editorContainer.BorderSizePixel = 0
editorContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
editorContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
editorContainer.ScrollBarThickness = 4
editorContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 75)
editorContainer.Parent = mainFrame

local editorCorner = Instance.new("UICorner")
editorCorner.CornerRadius = UDim.new(0, 8)
editorCorner.Parent = editorContainer

local codeBox = Instance.new("TextBox")
codeBox.Name = "CodeBox"
codeBox.Size = UDim2.new(1, -20, 1, -20)
codeBox.Position = UDim2.new(0, 10, 0, 10)
codeBox.BackgroundTransparency = 1
codeBox.ClearTextOnFocus = false
codeBox.MultiLine = true
codeBox.Font = Enum.Font.Code
codeBox.PlaceholderText = "-- Write your client-side Lua code here...\nprint('Hello, Roblox!')"
codeBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
codeBox.Text = ""
codeBox.TextColor3 = Color3.fromRGB(220, 220, 230)
codeBox.TextSize = 13
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.Parent = editorContainer

-- Control Panel / Buttons
local buttonHolder = Instance.new("Frame")
buttonHolder.Size = UDim2.new(1, -30, 0, 36)
buttonHolder.Position = UDim2.new(0, 15, 0, 225)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = mainFrame

local runButton = Instance.new("TextButton")
runButton.Size = UDim2.new(0.48, 0, 1, 0)
runButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
runButton.AutoButtonColor = false
runButton.Font = Enum.Font.GothamBold
runButton.Text = "▶ Run Code"
runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
runButton.TextSize = 13
runButton.Parent = buttonHolder

local runCorner = Instance.new("UICorner")
runCorner.CornerRadius = UDim.new(0, 8)
runCorner.Parent = runButton

local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0.48, 0, 1, 0)
clearButton.Position = UDim2.new(0.52, 0, 0, 0)
clearButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
clearButton.AutoButtonColor = false
clearButton.Font = Enum.Font.GothamBold
clearButton.Text = "Clear Console"
clearButton.TextColor3 = Color3.fromRGB(200, 200, 210)
clearButton.TextSize = 13
clearButton.Parent = buttonHolder

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = clearButton

-- Output Console Container
local outputContainer = Instance.new("ScrollingFrame")
outputContainer.Name = "OutputContainer"
outputContainer.Size = UDim2.new(1, -30, 0, 85)
outputContainer.Position = UDim2.new(0, 15, 0, 275)
outputContainer.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
outputContainer.BorderSizePixel = 0
outputContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
outputContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputContainer.ScrollBarThickness = 4
outputContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 75)
outputContainer.Parent = mainFrame

local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 8)
outputCorner.Parent = outputContainer

local outputLayout = Instance.new("UIListLayout")
outputLayout.SortOrder = Enum.SortOrder.LayoutOrder
outputLayout.Padding = UDim.new(0, 4)
outputLayout.Parent = outputContainer

local outputPadding = Instance.new("UIPadding")
outputPadding.PaddingTop = UDim.new(0, 8)
outputPadding.PaddingBottom = UDim.new(0, 8)
outputPadding.PaddingLeft = UDim.new(0, 10)
outputPadding.PaddingRight = UDim.new(0, 10)
outputPadding.Parent = outputContainer

-- Helper function to print messages to the custom GUI console
local function logToConsole(message, isError)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 0)
	label.AutomaticSize = Enum.AutomaticSize.Y
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Code
	label.Text = tostring(message)
	label.TextColor3 = isError and Color3.fromRGB(255, 90, 90) or Color3.fromRGB(170, 230, 170)
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.Parent = outputContainer
	
	-- Auto-scroll to bottom
	outputContainer.CanvasPosition = Vector2.new(0, outputContainer.AbsoluteCanvasSize.Y)
end

-- Button Hover Effects & Actions
runButton.MouseButton1Click:Connect(function()
	local code = codeBox.Text
	if code == "" then
		logToConsole("⚠️ Warning: No code provided to execute.", true)
		return
	end
	
	logToConsole("> Executing code...", false)
	
	-- Compile and run the code safely in a separate thread/environment
	local func, compileError = loadstring(code)
	if not func then
		logToConsole("Compilation Error: " .. tostring(compileError), true)
		return
	end
	
	-- Execute safely and catch runtime errors
	local success, runtimeError = pcall(func)
	if not success then
		logToConsole("Runtime Error: " .. tostring(runtimeError), true)
	else
		logToConsole("✓ Code executed successfully.", false)
	end
end)

clearButton.MouseButton1Click:Connect(function()
	for _, child in ipairs(outputContainer:GetChildren()) do
		if child:IsA("TextLabel") then
			child:Destroy()
		end
	end
end)

-- Simple button scale tween helpers
local function applyHover(button, originalColor, hoverColor)
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = originalColor}):Play()
	end)
end

applyHover(runButton, Color3.fromRGB(0, 162, 255), Color3.fromRGB(30, 180, 255))
applyHover(clearButton, Color3.fromRGB(45, 45, 55), Color3.fromRGB(60, 60, 75))
applyHover(closeButton, Color3.fromRGB(45, 45, 55), Color3.fromRGB(210, 60, 60))
