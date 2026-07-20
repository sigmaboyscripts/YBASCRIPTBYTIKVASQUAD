local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YBASoftUI"
ScreenGui.Parent = game.CoreGui

-- Главный контейнер (Main2)
local Main2 = Instance.new("Frame")
Main2.Name = "MainFrame"
Main2.Parent = ScreenGui
Main2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main2.Position = UDim2.new(0.35, 0, 0.3, 0)
Main2.Size = UDim2.new(0, 560, 0, 360)
Main2.ClipsDescendants = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = Main2

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(40, 40, 40)
mainStroke.Thickness = 1
mainStroke.Parent = Main2

-- Анимация плавного появления меню
Main2.Size = UDim2.new(0, 560, 0, 0)
game:GetService("TweenService"):Create(Main2, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, 360)}):Play()

-- Драг (Перетаскивание меню)
local Drag = Instance.new("UIDragDetector")
Drag.Parent = Main2

-- Шапка / Заголовок
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = Main2
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 15, 0, 10)
title.Size = UDim2.new(0, 300, 0, 25)
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "YBA SCRIPT BY TIKVA SQUAD"
title.Font = Enum.Font.SourceSansBold

-- Кнопка закрытия [X]
local close = Instance.new("TextButton")
close.Name = "CloseBtn"
close.Parent = Main2
close.BackgroundTransparency = 1
close.Position = UDim2.new(1, -35, 0, 10)
close.Size = UDim2.new(0, 25, 0, 25)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(150, 150, 150)
close.TextSize = 24
close.Font = Enum.Font.SourceSansBold

-- Боковая панель вкладок (Sidebar)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = Main2
Sidebar.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.Size = UDim2.new(0, 130, 1, -45)

local sideStroke = Instance.new("UIStroke")
sideStroke.Color = Color3.fromRGB(25, 25, 25)
sideStroke.Thickness = 1
sideStroke.Parent = Sidebar

-- Контейнер для контента вкладок
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = Main2
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 140, 0, 45)
ContentContainer.Size = UDim2.new(1, -145, 1, -55)

-- Создание страниц вкладок
local Tabs = {
    Main = Instance.new("Frame"),
    Character = Instance.new("Frame"),
    Other = Instance.new("Frame")
}

for name, frame in pairs(Tabs) do
    frame.Name = name .. "Tab"
    frame.Parent = ContentContainer
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = (name == "Main") -- По умолчанию открыта Main
end

-- Функция создания красивых кнопок вкладок
local tabButtons = {}
local function createTabButton(name, posy)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(1, -16, 0, 32)
    btn.Position = UDim2.new(0, 8, 0, posy)
    btn.BackgroundColor3 = (name == "Main") and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(15, 15, 15)
    btn.Text = "  " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextColor3 = (name == "Main") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(30, 30, 30)
    btnStroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        for tName, tFrame in pairs(Tabs) do
            tFrame.Visible = (tName == name)
        end
        for bName, bBtn in pairs(tabButtons) do
            bBtn.BackgroundColor3 = (bName == name) and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(15, 15, 15)
            bBtn.TextColor3 = (bName == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        end
    end)
    tabButtons[name] = btn
end

createTabButton("Main", 10)
createTabButton("Character", 47)
createTabButton("Other", 84)

-- Функция для стилизации кнопок функций
local function styleFunctionalButton(btn, text, size, pos)
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(245, 245, 245)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 40, 40)
    stroke.Parent = btn
end

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local ItemNotifier = Instance.new("TextButton")
ItemNotifier.Parent = Tabs.Main
styleFunctionalButton(ItemNotifier, "ItemNotifier: OFF", UDim2.new(0, 150, 0, 38), UDim2.new(0, 180, 0, 10))
local ItemNotifierActive = false
ItemNotifier.MouseButton1Click:Connect(function()
    ItemNotifierActive = not ItemNotifierActive
    if not ItemNotifierActive then
         for i, v in ipairs(game.workspace:GetDescendants()) do
			if v.Name == "ItemHint2" or v.Name == "ItemHint" then
				v:Destroy()
			end
		end

        ItemNotifier.Text = "ItemNotifier: OFF"
        ItemNotifier.TextColor3 = Color3.fromRGB(245, 245, 245)
        ItemNotifierActive = false
		return
    end
    ItemNotifier.Text = "ItemNotifier: ON"
    ItemNotifier.TextColor3 = Color3.fromRGB(100, 255, 100)
	 ItemNotifierActive = true
	  for i, v in ipairs(game.workspace.Item_Spawns.Items:GetDescendants()) do
		 if v:IsA("Model") then
		 if v.Parent == game.workspace.Dialogues then return end
			 
		 
			 local hint = game:GetService("ReplicatedStorage").Objects.ItemHint:Clone()
			  local hint2 = game:GetService("ReplicatedStorage").Objects.ItemHint2:Clone()
hint.Parent = v
hint.Size = UDim2.new(0, 350, 0, 350)
hint2.Parent = v
hint2.TextLabel.Text = v.ProximityPrompt.ObjectText

		 end
	 end
	end)
-- ==========================================
-- ТАБ: MAIN (PLAYER ESP)
-- ==========================================
local ESP = Instance.new("TextButton")
ESP.Parent = Tabs.Main
styleFunctionalButton(ESP, "Player ESP: OFF", UDim2.new(0, 150, 0, 38), UDim2.new(0, 10, 0, 10))

local espActive = false
local currentEsps = {}

ESP.MouseButton1Click:Connect(function()
    espActive = not espActive
    if not espActive then
        for _, obj in ipairs(currentEsps) do if obj then obj:Destroy() end end
        table.clear(currentEsps)
        ESP.Text = "Player ESP: OFF"
        ESP.TextColor3 = Color3.fromRGB(245, 245, 245)
        return
    end
    ESP.Text = "Player ESP: ON"
    ESP.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local character = player.Character
            local highlight = Instance.new("Highlight")
            highlight.Parent = character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            table.insert(currentEsps, highlight)
            
            local glow = Instance.new("BillboardGui")
            glow.Parent = character.Head
            glow.StudsOffset = Vector3.new(0, 2.5, 0)
            glow.Size = UDim2.new(5, 0, 1, 0)
            glow.AlwaysOnTop = true
            table.insert(currentEsps, glow)
            
            local NameText = Instance.new("TextLabel")
            NameText.Parent = glow
            NameText.Size = UDim2.new(1, 0, 1, 0)
            NameText.BackgroundTransparency = 1
            NameText.TextSize = 14
            NameText.Font = Enum.Font.SourceSansBold
            NameText.TextColor3 = Color3.fromRGB(255, 255, 255)
            
            local standName = "No Stand"
            pcall(function()
                if player:FindFirstChild("PlayerStats") and player.PlayerStats:FindFirstChild("Stand") then
                    standName = player.PlayerStats.Stand.Value
                end
            end)
            NameText.Text = player.Name .. " [" .. standName .. "]"
        end
    end
end)

-- ==========================================
-- ТАБ: CHARACTER (SPEED SLIDER & GOD MODE)
-- ==========================================
local EnabledSpeed = false
local TargetSpeed = 35 

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = Tabs.Character
SpeedLabel.Position = UDim2.new(0, 10, 0, 10)
SpeedLabel.Size = UDim2.new(0, 150, 0, 20)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.Text = "WalkSpeed: " .. TargetSpeed .. " [X]"
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Font = Enum.Font.SourceSansBold

local SppedBtn = Instance.new("TextButton")
SppedBtn.Parent = Tabs.Character
styleFunctionalButton(SppedBtn, "Speed: OFF", UDim2.new(0, 120, 0, 32), UDim2.new(0, 10, 0, 35))
SppedBtn.TextColor3 = Color3.fromRGB(255, 100, 100)

local SliderBG = Instance.new("Frame")
SliderBG.Parent = Tabs.Character
SliderBG.Position = UDim2.new(0, 145, 0, 46)
SliderBG.Size = UDim2.new(0, 200, 0, 8)
SliderBG.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
local slCorner = Instance.new("UICorner") lip = UDim.new(0,4) slCorner.Parent = SliderBG

local SliderBtn = Instance.new("TextButton")
SliderBtn.Parent = SliderBG
SliderBtn.Size = UDim2.new(0, 14, 0, 14)
SliderBtn.Position = UDim2.new(0.15, -7, -0.4, 0)
SliderBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
SliderBtn.Text = ""
local sbtnCorner = Instance.new("UICorner") sbtnCorner.CornerRadius = UDim.new(1,0) sbtnCorner.Parent = SliderBtn

local dragging = false
SliderBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mousePos = UserInputService:GetMouseLocation().X
        local sliderLeft = SliderBG.AbsolutePosition.X
        local sliderWidth = SliderBG.AbsoluteSize.X
        local percentage = math.clamp((mousePos - sliderLeft) / sliderWidth, 0, 1)
        SliderBtn.Position = UDim2.new(percentage, -7, -0.4, 0)
        TargetSpeed = math.floor(16 + (percentage * (150 - 16)))
        SpeedLabel.Text = "WalkSpeed: " .. TargetSpeed .. " [X]"
    end
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") and EnabledSpeed then
        character.Humanoid.WalkSpeed = TargetSpeed
    end
end)

local function toggleSpeed()
    EnabledSpeed = not EnabledSpeed
    local character = LocalPlayer.Character
    if EnabledSpeed then
        SppedBtn.Text = "Speed: ON"
        SppedBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        SppedBtn.Text = "Speed: OFF"
        SppedBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        if character and character:FindFirstChild("Humanoid") then character.Humanoid.WalkSpeed = 16 end
    end
end
SppedBtn.MouseButton1Click:Connect(toggleSpeed)
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.X then toggleSpeed() end
end)

-- КНОПКА GOD MODE (БЕЗОПАСНАЯ)
local godModeState = 0 
local godConnections = {}

local GodBtn = Instance.new("TextButton")
GodBtn.Parent = Tabs.Character
styleFunctionalButton(GodBtn, "God Mode: OFF", UDim2.new(0, 160, 0, 38), UDim2.new(0, 10, 0, 100))
GodBtn.TextColor3 = Color3.fromRGB(255, 100, 100)

local function clearGod()
    for _, conn in ipairs(godConnections) do if conn then conn:Disconnect() end end
    table.clear(godConnections)
end

GodBtn.MouseButton1Click:Connect(function()
    godModeState = (godModeState + 1) % 4
    clearGod()
    if godModeState == 0 then
        GodBtn.Text = "God Mode: OFF"
        GodBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    elseif godModeState == 1 then
        GodBtn.Text = "God: Anti-Ragdoll"
        GodBtn.TextColor3 = Color3.fromRGB(245, 245, 245)
        local c = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            end
        end)
        table.insert(godConnections, c)
    elseif godModeState == 2 then
        GodBtn.Text = "God: Not Touch"
        GodBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        local c = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
       
		--_G.Stun = char:SetAttribute("TRADING", false)
			--char:SetAttribute("TRADING", _G.Stun)
		
						  
            
        end)
        table.insert(godConnections, c)
    elseif godModeState == 3 then
        GodBtn.Text = "God: Anti-Anchor"
        GodBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
        local c = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.Anchored = false end
        end)
        table.insert(godConnections, c)
    end
end)
local StandControl = Instance.new("TextButton")
StandControl.Parent = Tabs.Main
styleFunctionalButton(StandControl, "StandControl: OFF", UDim2.new(0, 150, 0, 38), UDim2.new(0, 10, 0, 70))
local EnabledPilot = false

StandControl.MouseButton1Click:Connect(function()

EnabledPilot = not EnabledPilot
    if not EnabledPilot then
       
        StandControl.Text = "StandControl: OFF"
		EnabledPilot = false
        StandControl.TextColor3 = Color3.fromRGB(245, 245, 245)
        return
    end
	
     for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer and player.Character then
		local char = player.Character
		local stand = char:FindFirstChild("StandMorph")
	--	local root = stand.LowerTorso.Root
  --Ð² Overrides physics to maintain speed



	
		
	

		StandControl.Text = "StandControl: ON"
		
		EnabledPilot = true
        StandControl.TextColor3 = Color3.fromRGB(245, 245, 245)
--game:GetService("RunService").RenderStepped:Connect(function()
--game.workspace.Camera.CameraSubject = stand.UpperTorso

--end)
	while EnabledPilot == true do
	--game:GetService("RunService").RenderStepped:Connect(function()
	local vel = Instance.new("BodyVelocity")
 vel.Parent = stand.HumanoidRootPart
 vel.Velocity = stand.HumanoidRootPart.CFrame.LookVector * 45  -- Moves the part up at 20 studs per second
vel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)



		  wait(.001)
    vel:Destroy()
		end
		end
		
end
	
end)



-- ==========================================
-- ТАБ: OTHER (FOV)
-- ==========================================
local ChangeFOV = Instance.new("TextButton")
ChangeFOV.Parent = Tabs.Other
styleFunctionalButton(ChangeFOV, "Change FOV (120)", UDim2.new(0, 150, 0, 35), UDim2.new(0, 10, 0, 10))

local ResetFOV = Instance.new("TextButton")
ResetFOV.Parent = Tabs.Other
styleFunctionalButton(ResetFOV, "Reset FOV (70)", UDim2.new(0, 150, 0, 35), UDim2.new(0, 10, 0, 55))

ChangeFOV.MouseButton1Click:Connect(function() game.workspace.Camera.FieldOfView = 120 end)
ResetFOV.MouseButton1Click:Connect(function() game.workspace.Camera.FieldOfView = 70 end)

-- Закрытие меню с плавной анимацией
close.MouseButton1Click:Connect(function()
    clearGod()
	
    local tween = game:GetService("TweenService"):Create(Main2, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 560, 0, 0)})
    tween:Play()
    tween.Completed:Connect(function() ScreenGui:Destroy() end)
end)
