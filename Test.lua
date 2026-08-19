--// SECRET C v1
--// Speed Menu + Snow + velocidad durante el robo de Brainrots
--// LocalScript -> StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURACIÓN
--==================================================

local MIN_SPEED = 16
local MAX_SPEED = 500
local SPEED_STEP = 10

local currentSpeed = 16

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "SecretCV1"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

--==================================================
-- BOTÓN SC
--==================================================

local scButton = Instance.new("TextButton")
scButton.Name = "SCButton"
scButton.Size = UDim2.fromOffset(58, 58)
scButton.Position = UDim2.new(0, 20, 0.5, -29)
scButton.BackgroundColor3 = Color3.fromRGB(7, 12, 25)
scButton.Text = "SC"
scButton.TextColor3 = Color3.fromRGB(235, 250, 255)
scButton.TextSize = 20
scButton.Font = Enum.Font.GothamBold
scButton.AutoButtonColor = false
scButton.ZIndex = 20
scButton.Parent = gui

local scCorner = Instance.new("UICorner")
scCorner.CornerRadius = UDim.new(0, 13)
scCorner.Parent = scButton

local scStroke = Instance.new("UIStroke")
scStroke.Color = Color3.fromRGB(0, 180, 255)
scStroke.Thickness = 2
scStroke.Parent = scButton

--==================================================
-- MENÚ
--==================================================

local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.Size = UDim2.fromOffset(340, 320)
menu.Position = UDim2.new(0.5, -170, 0.5, -160)
menu.BackgroundColor3 = Color3.fromRGB(5, 9, 20)
menu.Visible = false
menu.ClipsDescendants = true
menu.ZIndex = 1
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 18)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(0, 175, 255)
menuStroke.Thickness = 2
menuStroke.Parent = menu

--==================================================
-- NIEVE
--==================================================

local snowContainer = Instance.new("Frame")
snowContainer.Name = "Snow"
snowContainer.Size = UDim2.fromScale(1, 1)
snowContainer.BackgroundTransparency = 1
snowContainer.ClipsDescendants = true
snowContainer.ZIndex = 2
snowContainer.Parent = menu

local function createSnowflake()

	local snowflake = Instance.new("TextLabel")

	local size = math.random(7, 16)

	snowflake.Size = UDim2.fromOffset(size, size)

	snowflake.Position = UDim2.new(
		math.random(0, 100) / 100,
		0,
		-0.1,
		0
	)

	snowflake.BackgroundTransparency = 1
	snowflake.Text = "❄"

	snowflake.TextColor3 = Color3.fromRGB(
		210,
		240,
		255
	)

	snowflake.TextTransparency =
		math.random(0, 30) / 100

	snowflake.TextSize = size + 5
	snowflake.Font = Enum.Font.GothamBold
	snowflake.ZIndex = 3
	snowflake.Parent = snowContainer

	local duration = math.random(4, 9)

	local endX =
		math.random(-10, 110) / 100

	local tween = TweenService:Create(
		snowflake,
		TweenInfo.new(
			duration,
			Enum.EasingStyle.Linear
		),
		{
			Position = UDim2.new(
				endX,
				0,
				1.1,
				0
			),

			Rotation = math.random(
				-180,
				180
			)
		}
	)

	tween:Play()

	tween.Completed:Connect(function()
		snowflake:Destroy()
	end)
end

task.spawn(function()

	while gui.Parent do

		if menu.Visible then
			createSnowflake()
		end

		task.wait(0.12)
	end

end)

--==================================================
-- TÍTULO
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 55)
title.Position = UDim2.fromOffset(15, 8)
title.BackgroundTransparency = 1
title.Text = "secreth C v1"
title.TextColor3 = Color3.fromRGB(240, 250, 255)
title.TextSize = 27
title.Font = Enum.Font.GothamBold
title.ZIndex = 5
title.Parent = menu

--==================================================
-- LÍNEA
--==================================================

local line = Instance.new("Frame")
line.Size = UDim2.new(1, -40, 0, 2)
line.Position = UDim2.fromOffset(20, 67)
line.BackgroundColor3 = Color3.fromRGB(0, 175, 255)
line.BorderSizePixel = 0
line.ZIndex = 5
line.Parent = menu

--==================================================
-- VELOCIDAD
--==================================================

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -40, 0, 50)
speedLabel.Position = UDim2.fromOffset(20, 82)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad: 16"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 21
speedLabel.Font = Enum.Font.GothamSemibold
speedLabel.ZIndex = 5
speedLabel.Parent = menu

--==================================================
-- CREADOR DE BOTONES
--==================================================

local function createButton(text, y)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, -40, 0, 52)
	button.Position = UDim2.fromOffset(20, y)

	button.BackgroundColor3 =
		Color3.fromRGB(9, 19, 38)

	button.Text = text
	button.TextColor3 =
		Color3.fromRGB(240, 250, 255)

	button.TextSize = 17
	button.Font = Enum.Font.GothamBold

	button.AutoButtonColor = false
	button.ZIndex = 5
	button.Parent = menu

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(0, 180, 255)
	stroke.Thickness = 2
	stroke.Parent = button

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 =
					Color3.fromRGB(12, 48, 80)
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 =
					Color3.fromRGB(9, 19, 38)
			}
		):Play()

	end)

	return button
end

local increaseButton =
	createButton(
		"▲  SUBIR VELOCIDAD",
		145
	)

local decreaseButton =
	createButton(
		"▼  BAJAR VELOCIDAD",
		207
	)

--==================================================
-- APLICAR VELOCIDAD
--==================================================

local function applySpeed()

	currentSpeed = math.clamp(
		currentSpeed,
		MIN_SPEED,
		MAX_SPEED
	)

	speedLabel.Text =
		"Velocidad: " .. currentSpeed

	local character =
		player.Character

	if not character then
		return
	end

	local humanoid =
		character:FindFirstChildOfClass(
			"Humanoid"
		)

	if humanoid then
		humanoid.WalkSpeed =
			currentSpeed
	end
end

--==================================================
-- SUBIR VELOCIDAD
--==================================================

increaseButton.MouseButton1Click:Connect(function()

	currentSpeed += SPEED_STEP

	applySpeed()

end)

--==================================================
-- BAJAR VELOCIDAD
--==================================================

decreaseButton.MouseButton1Click:Connect(function()

	currentSpeed -= SPEED_STEP

	applySpeed()

end)

--==================================================
-- MANTENER VELOCIDAD
--==================================================

local function protectSpeed(humanoid)

	if not humanoid then
		return
	end

	humanoid.WalkSpeed =
		currentSpeed

	humanoid:GetPropertyChangedSignal(
		"WalkSpeed"
	):Connect(function()

		if humanoid.Parent
			and humanoid.WalkSpeed
			~= currentSpeed then

			task.defer(function()

				if humanoid.Parent then

					humanoid.WalkSpeed =
						currentSpeed

				end

			end)

		end

	end)

end

--==================================================
-- PERSONAJE
--==================================================

local function setupCharacter(character)

	local humanoid =
		character:WaitForChild(
			"Humanoid"
		)

	humanoid.WalkSpeed =
		currentSpeed

	protectSpeed(humanoid)

end

if player.Character then

	setupCharacter(
		player.Character
	)

end

player.CharacterAdded:Connect(
	setupCharacter
)

--==================================================
-- BOTÓN SC: ABRIR / CERRAR
--==================================================

local menuOpen = false

scButton.MouseButton1Click:Connect(function()

	menuOpen = not menuOpen

	if menuOpen then

		menu.Visible = true

		menu.Size =
			UDim2.fromOffset(
				280,
				265
			)

		TweenService:Create(
			menu,
			TweenInfo.new(
				0.25,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size =
					UDim2.fromOffset(
						340,
						320
					)
			}
		):Play()

	else

		local closeTween =
			TweenService:Create(
				menu,
				TweenInfo.new(
					0.15,
					Enum.EasingStyle.Quad,
					Enum.EasingDirection.In
				),
				{
					Size =
						UDim2.fromOffset(
							280,
							265
						)
				}
			)

		closeTween:Play()

		closeTween.Completed:Wait()

		menu.Visible = false

	end

end)

--==================================================
-- EFECTO BOTÓN SC
--==================================================

scButton.MouseEnter:Connect(function()

	TweenService:Create(
		scButton,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 =
				Color3.fromRGB(10, 45, 75)
		}
	):Play()

end)

scButton.MouseLeave:Connect(function()

	TweenService:Create(
