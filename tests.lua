-- ============================================================
-- 🔥 BLADE BALL MOBILE ULTIMATE 2026 🔥
-- ПОЛНАЯ ВЕРСИЯ: МЕНЮ + КНОПКА + АВТООТБИВ + АВТОСПАМ
-- ДЛЯ ТЕЛЕФОНА (И ПК ТОЖЕ РАБОТАЕТ)
-- ============================================================

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
    SpamDelay = 0.004,      -- 250 KPS
    WalkSpeed = 16,
    JumpPower = 50,
    ParryRadius = 12,
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
local function sendSpam()
    if not SETTINGS.AutoSpam then return end
    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(SETTINGS.SpamMessage, "All")
end

-- ========== МЕНЮ С НАСТРОЙКАМИ ==========
local function createMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BladeBallMenu"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer.PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 320, 0, 460)
    mainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
    mainFrame.BackgroundTransparency = 0.08
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 16)

    local stroke = Instance.new("UIStroke", mainFrame)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 200, 255)

    -- Заголовок
    local header = Instance.new("Frame", mainFrame)
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    header.BackgroundTransparency = 0.3
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner", header)
    headerCorner.CornerRadius = UDim.new(0, 16)

    local title = Instance.new("TextLabel", header)
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚡ BLADE BALL ULTIMATE"
    title.TextColor3 = Color3.fromRGB(0, 255, 200)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold

    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton", header)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 8)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.BackgroundTransparency = 0.5
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold

    local closeCorner = Instance.new("UICorner", closeBtn)
    closeCorner.CornerRadius = UDim.new(0, 8)

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Функции для создания элементов
    local function createLabel(text, y)
        local lbl = Instance.new("TextLabel", mainFrame)
        lbl.Size = UDim2.new(0.5, 0, 0, 25)
        lbl.Position = UDim2.new(0.05, 0, y, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(200, 200, 255)
        lbl.TextSize = 14
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        return lbl
    end

    local function createInput(x, y, default, callback)
        local box = Instance.new("TextBox", mainFrame)
        box.Size = UDim2.new(0.25, 0, 0, 25)
        box.Position = UDim2.new(x, 0, y, 0)
        box.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        box.Text = tostring(default)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.TextSize = 14
        box.PlaceholderText = tostring(default)
        box.ClearTextOnFocus = false
        box.FocusLost:Connect(function()
            local val = tonumber(box.Text) or default
            callback(val)
        end)
        return box
    end

    local function createToggle(text, y, getter, setter)
        local btn = Instance.new("TextButton", mainFrame)
        btn.Size = UDim2.new(0.8, 0, 0, 30)
        btn.Position = UDim2.new(0.1, 0, y, 0)
        btn.BackgroundColor3 = getter() and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
        btn.Text = text .. ": " .. (getter() and "ON" or "OFF")
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold

        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            setter(not getter())
            btn.BackgroundColor3 = getter() and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
            btn.Text = text .. ": " .. (getter() and "ON" or "OFF")
        end)
        return btn
    end

    -- Элементы меню
    createLabel("🚀 Walk Speed", 0.12)
    createInput(0.7, 0.12, SETTINGS.WalkSpeed, function(v)
        SETTINGS.WalkSpeed = v
        mimicHumanInput()
    end)

    createLabel("🦘 Jump Power", 0.22)
    createInput(0.7, 0.22, SETTINGS.JumpPower, function(v)
        SETTINGS.JumpPower = v
        mimicHumanInput()
    end)

    createLabel("🎯 Parry Radius", 0.32)
    createInput(0.7, 0.32, SETTINGS.ParryRadius, function(v)
        SETTINGS.ParryRadius = v
    end)

    createToggle("🛡️ Auto Parry", 0.43,
        function() return SETTINGS.AutoParry end,
        function(v) SETTINGS.AutoParry = v end
    )

    -- Кнопка для открытия окна AutoSpam
    local viewBtn = Instance.new("TextButton", mainFrame)
    viewBtn.Size = UDim2.new(0.8, 0, 0, 35)
    viewBtn.Position = UDim2.new(0.1, 0, 0.58, 0)
    viewBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    viewBtn.Text = "📥 VIEW AUTOSPAM"
    viewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    viewBtn.TextScaled = true
    viewBtn.Font = Enum.Font.GothamBold

    local viewCorner = Instance.new("UICorner", viewBtn)
    viewCorner.CornerRadius = UDim.new(0, 8)

    viewBtn.MouseButton1Click:Connect(function()
        createAutoSpamWindow()
    end)

    -- Перетаскивание меню
    local dragging = false
    local dragStart, startPos

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ========== ОКНО AUTOSPAM ==========
function createAutoSpamWindow()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoSpamWindow"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 300)
    frame.Position = UDim2.new(0.4, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
    frame.BackgroundTransparency = 0.08
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 16)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 200, 255)

    -- Заголовок
    local header = Instance.new("TextLabel", frame)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    header.BackgroundTransparency = 0.3
    header.Text = "⚡ AUTOSPAM CONTROL"
    header.TextColor3 = Color3.fromRGB(0, 255, 200)
    header.TextScaled = true
    header.Font = Enum.Font.GothamBold

    local closeBtn = Instance.new("TextButton", header)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.BackgroundTransparency = 0.5
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Toggle AutoSpam
    local spamToggle = Instance.new("TextButton", frame)
    spamToggle.Size = UDim2.new(0.8, 0, 0, 40)
    spamToggle.Position = UDim2.new(0.1, 0, 0.2, 0)
    spamToggle.BackgroundColor3 = SETTINGS.AutoSpam and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    spamToggle.Text = "💬 AUTO SPAM: " .. (SETTINGS.AutoSpam and "ON" or "OFF")
    spamToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    spamToggle.TextScaled = true
    spamToggle.Font = Enum.Font.GothamBold

    local spamCorner = Instance.new("UICorner", spamToggle)
    spamCorner.CornerRadius = UDim.new(0, 8)

    spamToggle.MouseButton1Click:Connect(function()
        SETTINGS.AutoSpam = not SETTINGS.AutoSpam
        spamToggle.BackgroundColor3 = SETTINGS.AutoSpam and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
        spamToggle.Text = "💬 AUTO SPAM: " .. (SETTINGS.AutoSpam and "ON" or "OFF")
    end)

    -- Сообщение для спама
    local msgLabel = Instance.new("TextLabel", frame)
    msgLabel.Size = UDim2.new(0.4, 0, 0, 25)
    msgLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = "📝 Сообщение:"
    msgLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    msgLabel.TextSize = 14
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left

    local msgInput = Instance.new("TextBox", frame)
    msgInput.Size = UDim2.new(0.5, 0, 0, 25)
    msgInput.Position = UDim2.new(0.45, 0, 0.45, 0)
    msgInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    msgInput.Text = SETTINGS.SpamMessage
    msgInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    msgInput.TextSize = 14
    msgInput.FocusLost:Connect(function()
        SETTINGS.SpamMessage = msgInput.Text
    end)

    -- Задержка спама
    local delayLabel = Instance.new("TextLabel", frame)
    delayLabel.Size = UDim2.new(0.4, 0, 0, 25)
    delayLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
    delayLabel.BackgroundTransparency = 1
    delayLabel.Text = "⏱️ Задержка (сек):"
    delayLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    delayLabel.TextSize = 14
    delayLabel.TextXAlignment = Enum.TextXAlignment.Left

    local delayInput = Instance.new("TextBox", frame)
    delayInput.Size = UDim2.new(0.25, 0, 0, 25)
    delayInput.Position = UDim2.new(0.6, 0, 0.6, 0)
    delayInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    delayInput.Text = tostring(SETTINGS.SpamDelay)
    delayInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    delayInput.TextSize = 14
    delayInput.FocusLost:Connect(function()
        local val = tonumber(delayInput.Text) or 0.004
        SETTINGS.SpamDelay = val
    end)

    -- Перетаскивание окна
    local dragging = false
    local dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ========== ПЛАВАЮЩАЯ КНОПКА АВТОСПАМА ==========
local function createFloatingSpamButton()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FloatingSpamButton"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer.PlayerGui

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 90, 0, 90)
    button.Position = UDim2.new(0.8, 0, 0.15, 0)
    button.BackgroundColor3 = SETTINGS.AutoSpam and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    button.BackgroundTransparency = 0.2
    button.BorderSizePixel = 0
    button.Text = SETTINGS.AutoSpam and "🔴 ON" or "⚪ OFF"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = screenGui

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(1, 0)

    local stroke = Instance.new("UIStroke", button)
    stroke.Thickness = 3
    stroke.Color = SETTINGS.AutoSpam and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)

    -- Пульсация
    local function pulse()
        if not SETTINGS.AutoSpam then return end
        TweenService:Create(button, TweenInfo.new(0.4), {Size = UDim2.new(0, 100, 0, 100)}):Play()
        task.wait(0.2)
        TweenService:Create(button, TweenInfo.new(0.4), {Size = UDim2.new(0, 90, 0, 90)}):Play()
        task.wait(0.2)
        if SETTINGS.AutoSpam then pulse() end
    end

    -- Тогл
    button.MouseButton1Click:Connect(function()
        SETTINGS.AutoSpam = not SETTINGS.AutoSpam
        button.BackgroundColor3 = SETTINGS.AutoSpam and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
        button.Text = SETTINGS.AutoSpam and "🔴 ON" or "⚪ OFF"
        stroke.Color = SETTINGS.AutoSpam and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        if SETTINGS.AutoSpam then pulse() end
    end)

    -- Перетаскивание для телефона
    local dragging = false
    local dragStart, startPos

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
        end
    end)

    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ========== ЗАПУСК ВСЕГО ==========
createMenu()
createFloatingSpamButton()

-- ========== ЛУПЫ ==========
RunService.Heartbeat:Connect(function()
    parryBall()
end)

task.spawn(function()
    while true do
        sendSpam()
        task.wait(SETTINGS.SpamDelay)
    end
end)

-- ========== ГОРЯЧАЯ КЛАВИША ==========
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightAlt then
        createMenu()
    end
end)

print("🔥 Blade Ball Ultimate 2026 Loaded! Press RightAlt to open menu.")
