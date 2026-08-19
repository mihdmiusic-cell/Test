-- SECRET C v1
-- LocalScript → StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- CONFIGURACIÓN
local MIN_SPEED = 16
local MAX_SPEED = 500
local SPEED_STEP = 10
local currentSpeed = 16

-- GUI PRINCIPAL
local gui = Instance.new("ScreenGui")
gui.Name = "SecretCV1"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- BOTÓN SC
local scButton = Instance.new("TextButton")
scButton.Name = "SCButton"
scButton.Size = UDim2.new(0, 55, 0, 55)
scButton.Position = UDim2.new(0, 20, 0.5, -27)
scButton.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
scButton.Text = "SC"
scButton.TextColor3 = Color3.fromRGB(255, 255, 255)
scButton.TextSize = 20
scButton.Font = Enum.Font.GothamBold
scButton.AutoButtonColor = false
scButton.Parent = gui

local scCorner = Instance.new("UICorner")
scCorner.CornerRadius = UDim.new(0, 12)
scCorner.Parent = scButton

local scStroke = Instance.new("UIStroke")
scStroke.Color = Color3.fromRGB(0, 170, 255)
scStroke.Thickness = 2
scStroke.Parent = scButton

-- MENÚ
local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.Size = UDim2.new(0, 330, 0, 310)
menu.Position = UDim2.new(0.5, -165, 0.5, -155)
menu.BackgroundColor3 = Color3.fromRGB(8, 12, 25)
menu.Visible = false
menu.ClipsDescendants = true
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 18)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(0, 170, 255)
menuStroke.Thickness = 2
menuStroke.Parent = menu

-- ❄️ COPOS DE NIEVE
local snowContainer = Instance.new("Frame")
snowContainer.Name = "SnowContainer"
snowContainer.Size = UDim2.new(1, 0, 1, 0)
snowContainer.BackgroundTransparency = 1
snowContainer.ClipsDescendants = true
snowContainer.ZIndex = 2
snowContainer.Parent = menu

local function createSnowflake()

	local snowflake = Instance.new("TextLabel")

	local size = math.random(7, 15)

	snowflake.Size = UDim2.new(0, size, 0, size)

	snowflake.Position = UDim2.new(
		math.random(0, 100) / 100,
		0,
		-0.1,
		0
	)

	snowflake.BackgroundTransparency = 1
	snowflake.Text = "❄"
	snowflake.TextColor3 = Color3.fromRGB(
		220,
		245,
		255
	)

	snowflake.TextTransparency =
		math.random(0, 25) / 100

	snowflake.TextSize = size + 5
	snowflake.Font = Enum.Font.GothamBold
	snowflake.ZIndex = 3
	snowflake.Parent = snowContainer

	local duration = math.random(4, 8)

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
			Rotation = math.random(-180, 180)
		}
	)

	tween:Play()

	tween.Completed:Connect(function()
		snowflake:Destroy()
	end)

end

-- GENERADOR DE COPOS
task.spawn(function()

	while gui.Parent do

		if menu.Visible then
			createSnowflake()
		end

		task.wait(0.12)

	end

end)

-- TÍTULO
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 55)
title.Position = UDim2.new(0, 15, 0, 10)
title.BackgroundTransparency = 1
title.Text = "secreth C v1"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 26
title.Font = Enum.Font.GothamBold
title.ZIndex = 5
title.Parent = menu

-- LÍNEA DECORATIVA
local line = Instance.new("Frame")
line.Size = UDim2.new(1, -40, 0, 2)
line.Position = UDim2.new(0, 20, 0, 65)
line.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
line.BorderSizePixel = 0
line.ZIndex = 5
line.Parent = menu

-- TEXTO VELOCIDAD
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -40, 0, 55)
speedLabel.Position = UDim2.new(0, 20, 0, 80)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad: 16"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 22
speedLabel.Font = Enum.Font.GothamSemibold
speedLabel.ZIndex = 5
speedLabel.Parent = menu

-- FUNCIÓN PARA CREAR BOTONES
local function createButton(text, position)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, -40, 0, 50)
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(12, 20, 40)
	button.Text = text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 18
	button.Font = Enum.Font.GothamBold
	button.AutoButtonColor = false
	button.ZIndex = 5
	button.Parent = menu

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(0, 170, 255)
	stroke.Thickness = 2
	stroke.Parent = button

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 =
					Color3.fromRGB(15, 50, 85)
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 =
					Color3.fromRGB(12, 20, 40)
			}
		):Play()

	end)

	return button

end

-- BOTONES
local increaseButton = createButton(
	"▲  SUBIR VELOCIDAD",
	UDim2.new(0, 20, 0, 145)
)

local decreaseButton = createButton(
	"▼  BAJAR VELOCIDAD",
	UDim2.new(0, 20, 0, 205)
)

-- ACTUALIZAR VELOCIDAD
local function updateSpeed()

	currentSpeed = math.clamp(
		currentSpeed,
		MIN_SPEED,
		MAX_SPEED
	)

	speedLabel.Text =
		"Velocidad: " .. currentSpeed

	local character = player.Character

	if character then

		local humanoid =
			character:FindFirstChildOfClass(
				"Humanoid"
			)

		if humanoid then
			humanoid.WalkSpeed =
				currentSpeed
		end

	end

end

-- SUBIR VELOCIDAD
increaseButton.MouseButton1Click:Connect(function()

	currentSpeed += SPEED_STEP

	updateSpeed()

end)

-- BAJAR VELOCIDAD
decreaseButton.MouseButton1Click:Connect(function()

	currentSpeed -= SPEED_STEP

	updateSpeed()

end)

-- REAPLICAR DESPUÉS DE MORIR
player.CharacterAdded:Connect(function(character)

	local humanoid =
		character:WaitForChild("Humanoid")

	humanoid.WalkSpeed =
		currentSpeed

end)

-- ABRIR / CERRAR MENÚ
local menuOpen = false

scButton.MouseButton1Click:Connect(function()

	menuOpen = not menuOpen

	if menuOpen then

		menu.Visible = true

		menu.Size =
			UDim2.new(
				0,
				280,
				0,
				260
			)

		TweenService:Create(
			menu,
			TweenInfo.new(
				0.2,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size =
					UDim2.new(
						0,
						330,
						0,
						310
					)
			}
		):Play()

	else

		TweenService:Create(
			menu,
			TweenInfo.new(0.15),
			{
				Size =
					UDim2.new(
						0,
						280,
						0,
						260
					)
			}
		):Play()

		task.wait(0.15)

		menu.Visible = false

	end

end)

-- EFECTO DEL BOTÓN SC
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
		scButton,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 =
				Color3.fromRGB(10, 15, 30)
		}
	):Play()

end)

-- VELOCIDAD INICIAL
updateSpeed()
