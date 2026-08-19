-- LocalScript en StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StealMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenBtn"
openBtn.Size = UDim2.new(0, 140, 0, 55)
openBtn.Position = UDim2.new(1, -155, 0, 25)
openBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
openBtn.Text = "MENÚ"
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.TextScaled = true
openBtn.Font = Enum.Font.GothamBold
openBtn.Parent = screenGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.85, 0, 0.7, 0)
mainFrame.Position = UDim2.new(0.075, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Visible = false
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 55)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "Jugadores"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 55, 0, 55)
closeBtn.Position = UDim2.new(1, -55, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local playerList = Instance.new("ScrollingFrame")
playerList.Size = UDim2.new(1, -20, 1, -70)
playerList.Position = UDim2.new(0, 10, 0, 60)
playerList.BackgroundTransparency = 1
playerList.ScrollBarThickness = 10
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.Parent = mainFrame

local function updatePlayers()
	for _, child in ipairs(playerList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	local y = 0
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr \~= player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 60)
			btn.Position = UDim2.new(0, 0, 0, y)
			btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
			btn.Text = plr.Name
			btn.TextColor3 = Color3.new(1,1,1)
			btn.TextScaled = true
			btn.Font = Enum.Font.Gotham
			btn.Parent = playerList
			
			btn.MouseButton1Click:Connect(function()
				print("Seleccionado:", plr.Name)
			end)
			
			y = y + 65
		end
	end
	playerList.CanvasSize = UDim2.new(0, 0, 0, y)
end

openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	if mainFrame.Visible then
		updatePlayers()
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

Players.PlayerAdded:Connect(updatePlayers)
Players.PlayerRemoving:Connect(updatePlayers)
