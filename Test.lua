-- SC Menu + Noclip
-- LocalScript en StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local noclip = false
local menuOpen = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SCMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Botón SC
local scButton = Instance.new("TextButton")
scButton.Name = "SCButton"
scButton.Size = UDim2.new(0, 55, 0, 55)
scButton.Position = UDim2.new(0, 15, 1, -70)
scButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scButton.TextColor3 = Color3.fromRGB(255, 255, 255)
scButton.Text = "SC"
scButton.TextSize = 20
scButton.Font = Enum.Font.GothamBold
scButton.Parent = gui

local scCorner = Instance.new("UICorner")
scCorner.CornerRadius = UDim.new(0, 10)
scCorner.Parent = scButton

-- Menú
local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Size = UDim2.new(0, 220, 0, 120)
menu.Position = UDim2.new(0, 15, 1, -200)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
menu.Visible = false
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 12)
menuCorner.Parent = menu

-- Botón Noclip
local noclipButton = Instance.new("TextButton")
noclipButton.Name = "NoclipButton"
noclipButton.Size = UDim2.new(1, -20, 0, 55)
noclipButton.Position = UDim2.new(0, 10, 0, 15)
noclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Text = "Noclip: OFF"
noclipButton.TextSize = 18
noclipButton.Font = Enum.Font.GothamBold
noclipButton.Parent = menu

local noclipCorner = Instance.new("UICorner")
noclipCorner.CornerRadius = UDim.new(0, 8)
noclipCorner.Parent = noclipButton

-- Abrir/cerrar menú
scButton.MouseButton1Click:Connect(function()
	menuOpen = not menuOpen
	menu.Visible = menuOpen
end)

-- Activar/desactivar noclip
noclipButton.MouseButton1Click:Connect(function()
	noclip = not noclip

	if noclip then
		noclipButton.Text = "Noclip: ON"
		noclipButton.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
	else
		noclipButton.Text = "Noclip: OFF"
		noclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end
end)

-- Noclip
RunService.Stepped:Connect(function()
	if not noclip then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			-- El HumanoidRootPart y las partes del personaje
			-- atraviesan paredes.
			-- El suelo sigue funcionando normalmente mediante
			-- la gravedad y el Humanoid.
			part.CanCollide = false
		end
	end
end)

-- Al desactivar, recuperar colisiones
RunService.Stepped:Connect(function()
	if noclip then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			if part.Name ~= "HumanoidRootPart" then
				part.CanCollide = true
			end
		end
	end
end)
