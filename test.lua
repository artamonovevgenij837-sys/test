local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ========== НАСТРОЙКИ ==========
local SETTINGS = {
    AutoParry = true,
    AutoSpam = false,
    SpamMessage = "/e dance",
    SpamDelay = 0.5,
    WalkSpeed = 16,
    JumpPower = 50,
    ParryRadius = 12,
    ParrySpeed = 0.05,
}

-- ========== ОБХОД АНТИЧИТА ==========
local function bypassMemory()
    local old = getrawmetatable and getrawmetatable(game) or nil
    if old then
        local backup = old.__index
        setreadonly(old, false)
        old.__index = newcclosure(function(self, key)
            if key == "Velocity" or key == "WalkSpeed" then
                return 0
            end
            return backup(self, key)
        end)
        setreadonly(old, true)
    end
end
bypassMemory()

local function mimicHumanInput()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        hum.WalkSpeed = SETTINGS.WalkSpeed
        hum.JumpPower = SETTINGS.JumpPower
        hum.AutoRotate = true
    end
end
mimicHumanInput()

local function fakeInput()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end

-- ========== АВТООТБИВ ==========
local function parryBall()
    if not SETTINGS.AutoParry then return end
    local ball = workspace:FindFirstChild("Ball")
    if not ball then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local distance = (hrp.Position - ball.Position).Magnitude
    if distance < SETTINGS.ParryRadius then
        local lookVector = (ball.Position - hrp.Position).Unit
        hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + lookVector)
        fakeInput()
        game:GetService("ReplicatedStorage"):WaitForChild("SwingEvent"):FireServer()
    end
end

-- ========== АВТОСПАМ ==========
local function spamMessage()
    if not SETTINGS.AutoSpam then return end
    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(SETTINGS.SpamMessage, "All")
end

-- ========== СОЗДАНИЕ МЕНЮ ==========
local function createMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BladeBallMenu"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer.PlayerGui

    -- ОСНОВНОЕ ОКНО
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 16)

    local gradient = Instance.new("UIGradient", mainFrame)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 50, 150)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 150))
    }

    local stroke = Instance.new("UIStroke", mainFrame)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 200, 255)

    -- ЗАГОЛОВОК
    local title = Instance.new("TextLabel", mainFrame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚡ BLADE BALL MENU ⚡"
    title.TextColor3 = Color3.fromRGB(0, 255, 200)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold

    -- ===== WALK SPEED =====
    local wsLabel = Instance.new("TextLabel", mainFrame)
    wsLabel.Size = UDim2.new(0.6, 0, 0, 25)
    wsLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
    wsLabel.BackgroundTransparency = 1
    wsLabel.Text = "🚀 Walk Speed: " .. SETTINGS.WalkSpeed
    wsLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    wsLabel.TextSize = 16
    wsLabel.TextXAlignment = Enum.TextXAlignment.Left

    local wsSlider = Instance.new("TextBox", mainFrame)
    wsSlider.Size = UDim2.new(0.25, 0, 0, 25)
    wsSlider.Position = UDim2.new(0.7, 0, 0.15, 0)
    wsSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    wsSlider.Text = tostring(SETTINGS.WalkSpeed)
    wsSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    wsSlider.TextSize = 16
    wsSlider.PlaceholderText = "16"
    wsSlider.ClearTextOnFocus = false

    wsSlider.FocusLost:Connect(function()
        local val = tonumber(wsSlider.Text) or 16
        val = math.clamp(val, 0, 100)
        SETTINGS.WalkSpeed = val
        wsLabel.Text = "🚀 Walk Speed: " .. val
        mimicHumanInput()
    end)

    -- ===== JUMP POWER =====
    local jpLabel = Instance.new("TextLabel", mainFrame)
    jpLabel.Size = UDim2.new(0.6, 0, 0, 25)
    jpLabel.Position = UDim2.new(0.05, 0, 0.24, 0)
    jpLabel.BackgroundTransparency = 1
    jpLabel.Text = "🦘 Jump Power: " .. SETTINGS.JumpPower
    jpLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    jpLabel.TextSize = 16
    jpLabel.TextXAlignment = Enum.TextXAlignment.Left

    local jpSlider = Instance.new("TextBox", mainFrame)
    jpSlider.Size = UDim2.new(0.25, 0, 0, 25)
    jpSlider.Position = UDim2.new(0.7, 0, 0.24, 0)
    jpSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    jpSlider.Text = tostring(SETTINGS.JumpPower)
    jpSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    jpSlider.TextSize = 16
    jpSlider.PlaceholderText = "50"
    jpSlider.ClearTextOnFocus = false

    jpSlider.FocusLost:Connect(function()
        local val = tonumber(jpSlider.Text) or 50
        val = math.clamp(val, 0, 200)
        SETTINGS.JumpPower = val
        jpLabel.Text = "🦘 Jump Power: " .. val
        mimicHumanInput()
    end)

    -- ===== AUTO PARRY TOGGLE =====
    local parryToggle = Instance.new("TextButton", mainFrame)
    parryToggle.Size = UDim2.new(0.8, 0, 0, 30)
    parryToggle.Position = UDim2.new(0.1, 0, 0.34, 0)
    parryToggle.BackgroundColor3 = SETTINGS.AutoParry and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    parryToggle.Text = "🛡️ Auto Parry: " .. (SETTINGS.AutoParry and "ON" or "OFF")
    parryToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    parryToggle.TextScaled = true
    parryToggle.Font = Enum.Font.GothamBold

    parryToggle.MouseButton1Click:Connect(function()
        SETTINGS.AutoParry = not SETTINGS.AutoParry
        parryToggle.BackgroundColor3 = SETTINGS.AutoParry and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
        parryToggle.Text = "🛡️ Auto Parry: " .. (SETTINGS.AutoParry and "ON" or "OFF")
    end)

    -- ===== AUTO SPAM TOGGLE =====
    local spamToggle = Instance.new("TextButton", mainFrame)
    spamToggle.Size = UDim2.new(0.8, 0, 0, 30)
    spamToggle.Position = UDim2.new(0.1, 0, 0.44, 0)
    spamToggle.BackgroundColor3 = SETTINGS.AutoSpam and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    spamToggle.Text = "💬 Auto Spam: " .. (SETTINGS.AutoSpam and "ON" or "OFF")
    spamToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    spamToggle.TextScaled = true
    spamToggle.Font = Enum.Font.GothamBold

    spamToggle.MouseButton1Click:Connect(function()
        SETTINGS.AutoSpam = not SETTINGS.AutoSpam
        spamToggle.BackgroundColor3 = SETTINGS.AutoSpam and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
        spamToggle.Text = "💬 Auto Spam: " .. (SETTINGS.AutoSpam and "ON" or "OFF")
    end)

    -- ===== SPAM MESSAGE =====
    local msgLabel = Instance.new("TextLabel", mainFrame)
    msgLabel.Size = UDim2.new(0.6, 0, 0, 25)
    msgLabel.Position = UDim2.new(0.05, 0, 0.54, 0)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = "📝 Spam: " .. SETTINGS.SpamMessage
    msgLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    msgLabel.TextSize = 14
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left

    local msgInput = Instance.new("TextBox", mainFrame)
    msgInput.Size = UDim2.new(0.55, 0, 0, 25)
    msgInput.Position = UDim2.new(0.4, 0, 0.54, 0)
    msgInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    msgInput.Text = SETTINGS.SpamMessage
    msgInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    msgInput.TextSize = 14
    msgInput.PlaceholderText = "/e dance"

    msgInput.FocusLost:Connect(function()
        SETTINGS.SpamMessage = msgInput.Text
        msgLabel.Text = "📝 Spam: " .. SETTINGS.SpamMessage
    end)

    -- ===== PARRY RADIUS =====
    local prLabel = Instance.new("TextLabel", mainFrame)
    prLabel.Size = UDim2.new(0.6, 0, 0, 25)
    prLabel.Position = UDim2.new(0.05, 0, 0.64, 0)
    prLabel.BackgroundTransparency = 1
    prLabel.Text = "🎯 Parry Radius: " .. SETTINGS.ParryRadius
    prLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    prLabel.TextSize = 14
    prLabel.TextXAlignment = Enum.TextXAlignment.Left

    local prInput = Instance.new("TextBox", mainFrame)
    prInput.Size = UDim2.new(0.25, 0, 0, 25)
    prInput.Position = UDim2.new(0.7, 0, 0.64, 0)
    prInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    prInput.Text = tostring(SETTINGS.ParryRadius)
    prInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    prInput.TextSize = 14

    prInput.FocusLost:Connect(function()
        local val = tonumber(prInput.Text) or 12
        SETTINGS.ParryRadius = val
        prLabel.Text = "🎯 Parry Radius: " .. val
    end)

    -- ===== ЗАКРЫТЬ МЕНЮ =====
    local closeBtn = Instance.new("TextButton", mainFrame)
    closeBtn.Size = UDim2.new(0.3, 0, 0, 30)
    closeBtn.Position = UDim2.new(0.35, 0, 0.82, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "✕ ЗАКРЫТЬ"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- ===== ПЕРЕТАСКИВАНИЕ МЕНЮ =====
    local dragging = false
    local dragStart, startPos

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ========== ЗАПУСК МЕНЮ ==========
createMenu()

-- ========== ЛУПЫ ==========
RunService.Heartbeat:Connect(function()
    parryBall()
end)

task.spawn(function()
    while true do
        spamMessage()
        task.wait(SETTINGS.SpamDelay)
    end
end)

-- ========== ГОРЯЧАЯ КЛАВИША ==========
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightAlt then
        createMenu()
    end
end)

print("🔥 Blade Ball Ultimate Loaded! Press RightAlt to open menu.")
