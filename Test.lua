local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local flying = false
local speed = 60
local flyConnection
local bodyVelocity
local bodyGyro

-- Crear GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FlyMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 55)
frame.Position = UDim2.new(0.5, -80, 1, -75)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -10, 1, -10)
button.Position = UDim2.new(0, 5, 0, 5)
button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 18
button.Font = Enum.Font.GothamBold
button.Text = "VOLAR: OFF"
button.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = button

local function stopFlying()
	flying = false

	if flyConnection then
		flyConnection:Disconnect()
		flyConnection = nil
	end

	if bodyVelocity then
		bodyVelocity:Destroy()
		bodyVelocity = nil
	end

	if bodyGyro then
		bodyGyro:Destroy()
		bodyGyro = nil
	end

	button.Text = "VOLAR: OFF"
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end

local function startFlying()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart")

	flying = true

	button.Text = "VOLAR: ON"
	button.BackgroundColor3 = Color3.fromRGB(40, 150, 70)

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = root

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyGyro.P = 9000
	bodyGyro.Parent = root

	flyConnection = RunService.RenderStepped:Connect(function()
		if not flying or not character.Parent then
			stopFlying()
			return
		end

		local camera = workspace.CurrentCamera
		local direction = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			direction += camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			direction -= camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			direction -= camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			direction += camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			direction += Vector3.new(0, 1, 0)
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			direction -= Vector3.new(0, 1, 0)
		end

		if direction.Magnitude > 0 then
			direction = direction.Unit * speed
		end

		bodyVelocity.Velocity = direction
		bodyGyro.CFrame = camera.CFrame

		humanoid.PlatformStand = true
	end)
end

button.MouseButton1Click:Connect(function()
	if flying then
		stopFlying()

		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.PlatformStand = false
			end
		end
	else
		startFlying()
	end
end)

player.CharacterAdded:Connect(function()
	if flying then
		stopFlying()
	end
end)
