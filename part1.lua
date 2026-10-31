-- wannacry client v1.0 — Part 1 (FULL, NO CUTS)
-- Core, Auth, Icons, Visuals, Models, ESP, Drone, BodyMods
local _authEnv = (typeof(getgenv) == "function" and getgenv()) or _G
_authEnv.__WANNA_AUTH = _authEnv.__WANNA_AUTH or false

-- ============================================================
-- AUTH SYSTEM (FULL)
-- ============================================================
if not _authEnv.__WANNA_AUTH then
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local player = Players.LocalPlayer
    
    local VALID_KEYS = {
        "WANNA-X1Y6-Z9W4-Y24D", "MY-FRIEND-KEY-F423D", "MY-FRIEND-KEY-R4C2DS",
        "WANNA-A9F3-K2P7-M4Z8", "WANNA-B7N2-Q8L5-R3T9", "WANNA-C4M9-V6X1-P2W5",
        "WANNA-D8L3-W2Y7-N5K1", "WANNA-E5P1-X9Z4-M3R8", "WANNA-F2T6-Y4W9-K7L3",
        "WANNA-G9R4-Z1M6-P8X2", "WANNA-H3W7-A5K9-N2Y4", "WANNA-J6X2-B8L3-R5Z7",
        "WANNA-K1Z5-C3M8-W9P4", "MY-FRIEND-KEY-T7K4", "MY-FRIEND-KEY-L2M9",
        "MY-FRIEND-KEY-B5N3", "MY-FRIEND-KEY-W8P1", "MY-FRIEND-KEY-R6X7",
        "MY-FRIEND-KEY-K3Y9", "MY-FRIEND-KEY-M1Z4", "MY-FRIEND-KEY-N9P2",
        "MY-FRIEND-KEY-Q4R8", "MY-FRIEND-KEY-X6T5"
    }

    local authGui = Instance.new("ScreenGui")
    authGui.Name = "WannaAuth"
    authGui.ResetOnSpawn = false
    authGui.IgnoreGuiInset = true
    authGui.DisplayOrder = 9999
    authGui.Parent = player:WaitForChild("PlayerGui")

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.5
    bg.BorderSizePixel = 0
    bg.Parent = authGui

    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 420, 0, 320)
    panel.Position = UDim2.new(0.5, -210, 0.5, -160)
    panel.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    panel.BackgroundTransparency = 0.05
    panel.BorderSizePixel = 0
    panel.Parent = authGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 24)
    corner.Parent = panel

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.85
    stroke.Thickness = 1
    stroke.Parent = panel

    -- Big W Logo
    local wLogo = Instance.new("TextLabel")
    wLogo.Text = "W"
    wLogo.Font = Enum.Font.ArialBlack
    wLogo.TextSize = 72
    wLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
    wLogo.Size = UDim2.new(1, 0, 0, 100)
    wLogo.Position = UDim2.new(0, 0, 0, 20)
    wLogo.BackgroundTransparency = 1
    wLogo.ZIndex = 2
    wLogo.Parent = panel

    local subtitle = Instance.new("TextLabel")
    subtitle.Text = "ENTER YOUR KEY"
    subtitle.Font = Enum.Font.ArialBold
    subtitle.TextSize = 12
    subtitle.LetterSpacing = 2
    subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    subtitle.TextTransparency = 0.5
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 125)
    subtitle.BackgroundTransparency = 1
    subtitle.ZIndex = 2
    subtitle.Parent = panel

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -48, 0, 48)
    input.Position = UDim2.new(0, 24, 0, 155)
    input.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    input.BackgroundTransparency = 0.2
    input.BorderSizePixel = 0
    input.Font = Enum.Font.Arial
    input.TextSize = 15
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.PlaceholderText = "WANNA-XXXX-XXXX-XXXX"
    input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    input.Text = ""
    input.ClearTextOnFocus = false
    input.Parent = panel

    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(0, 14)
    ic.Parent = input

    local is_ = Instance.new("UIStroke")
    is_.Color = Color3.fromRGB(255, 255, 255)
    is_.Transparency = 0.8
    is_.Parent = input

    local status = Instance.new("TextLabel")
    status.Text = ""
    status.Font = Enum.Font.Arial
    status.TextSize = 13
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.TextXAlignment = Enum.TextXAlignment.Center
    status.Size = UDim2.new(1, 0, 0, 18)
    status.Position = UDim2.new(0, 0, 0, 210)
    status.BackgroundTransparency = 1
    status.Parent = panel

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -48, 0, 48)
    btn.Position = UDim2.new(0, 24, 0, 240)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.05
    btn.BorderSizePixel = 0
    btn.Text = "ACTIVATE"
    btn.Font = Enum.Font.ArialBold
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.AutoButtonColor = false
    btn.Parent = panel

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 14)
    bc.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local key = input.Text
        local valid = false
        for _, k in ipairs(VALID_KEYS) do
            if k == key then
                valid = true
                break
            end
        end
        
        if valid then
            status.TextColor3 = Color3.fromRGB(100, 255, 150)
            status.Text = "Access granted. Loading..."
            _authEnv.__WANNA_AUTH = true
            task.wait(0.5)
            
            TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            
            TweenService:Create(bg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            authGui:Destroy()
        else
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            status.Text = "Invalid key."
        end
    end)
end

while not _authEnv.__WANNA_AUTH do
    task.wait()
end

-- ============================================================
-- CORE SERVICES
-- ============================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local ScriptUnloaded = false
local Connections = {}

local function addConnection(c)
    table.insert(Connections, c)
    return c
end

local CONFIG_FOLDER = "wannacry_configs"

local function hasFileAPI()
    return type(writefile) == "function" and type(readfile) == "function"
end

local function safeWriteFile(n, d)
    if not hasFileAPI() then return false end
    return pcall(writefile, n, d)
end

local function safeReadFile(n)
    if not hasFileAPI() then return nil end
    local o, d = pcall(readfile, n)
    return o and d or nil
end

-- Sound System
local SoundFolder = Instance.new("Folder")
SoundFolder.Name = "WannaSounds"
SoundFolder.Parent = SoundService

local SFX = {}

local function makeSound(id, vol, speed)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://" .. id
    s.Volume = vol or 0.5
    s.PlaybackSpeed = speed or 1
    s.Parent = SoundFolder
    return s
end

SFX.MenuOpen = makeSound("6895079853", 10, 1.4)
SFX.MenuClose = makeSound("6895079853", 10, 0.7)
SFX.On = makeSound("6895079853", 10, 1.6)
SFX.Off = makeSound("6895079853", 10, 0.6)
SFX.Click = makeSound("6895079853", 6, 2.0)

local function playSound(s)
    if s then
        s:Stop()
        s:Play()
    end
end

-- Fonts
local FONT_BLACK = Enum.Font.ArialBlack
local FONT_REG = Enum.Font.Arial
local FONT_BOLD = Enum.Font.ArialBold

-- ============================================================
-- STATE
-- ============================================================
local State = {
    FogEnabled = false,
    FogSettings = {Density = 0.4, Offset = 0.25, Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125)},
    AspectEnabled = false,
    AspectValue = 0.80,
    FullbrightEnabled = false,
    FullbrightBrightness = 3,
    MotionBlurEnabled = false,
    MotionBlurStrength = 16,
    WorldEnabled = false,
    WorldSettings = {Saturation = 0, Contrast = 0, Brightness = 0, TintColor = Color3.fromRGB(255, 255, 255)},
    JumpCircleEnabled = false,
    JumpCircleUseTheme = true,
    JumpCircleCustomColor = Color3.fromRGB(255, 255, 255),
    JumpCircleStyle = "segments",
    JumpCircleGlow = true,
    ParticlesEnabled = false,
    ParticlesUseTheme = true,
    ParticlesCustomColor = Color3.fromRGB(255, 255, 255),
    TrailsEnabled = false,
    TrailsUseTheme = true,
    TrailsCustomColor = Color3.fromRGB(255, 255, 255),
    ChinaHatEnabled = false,
    ChinaHatUseTheme = true,
    ChinaHatCustomColor = Color3.fromRGB(80, 200, 80),
    ChinaHatGlow = true,
    WingsEnabled = false,
    WingsUseTheme = true,
    WingsCustomColor = Color3.fromRGB(255, 255, 255),
    WingsGlow = true,
    KaguneEnabled = false,
    KaguneUseTheme = false,
    KaguneCustomColor = Color3.fromRGB(220, 30, 30),
    KaguneGlow = true,
    CompanionEnabled = false,
    CompanionUseTheme = true,
    CompanionCustomColor = Color3.fromRGB(180, 150, 255),
    KorbloxEnabled = false,
    GhostLegsEnabled = false,
    ESPEnabled = false,
    ESPUseTheme = true,
    ESPCustomColor = Color3.fromRGB(255, 80, 80),
    ESPShowName = true,
    ESPShowDistance = true,
    CurrentTheme = "Dark",
    OpenSettings = nil,
    MenuOpen = false,
    SelectedConfig = nil,
    ActiveAnimPack = nil,
    DroneEnabled = false,
    DroneTarget = nil,
    AutoMonetEnabled = false,
    AutoMonetStats = 0,
    AimBotEnabled = false,
    AimBotFOV = 200
}

-- Lighting Backup
local _genv = (typeof(getgenv) == "function" and getgenv()) or _G
if not _genv.__WANNA_ORIG_LIGHTING then
    _genv.__WANNA_ORIG_LIGHTING = {
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        GlobalShadows = Lighting.GlobalShadows
    }
end

local originalLighting = _genv.__WANNA_ORIG_LIGHTING

-- Themes
local Themes = {
    Dark = {VisualColor = Color3.fromRGB(255, 255, 255)},
    Purple = {VisualColor = Color3.fromRGB(200, 160, 255)},
    Crimson = {VisualColor = Color3.fromRGB(255, 120, 150)},
    Blue = {VisualColor = Color3.fromRGB(100, 150, 255)},
    Pink = {VisualColor = Color3.fromRGB(255, 140, 200)},
    Emerald = {VisualColor = Color3.fromRGB(80, 220, 150)},
    Orange = {VisualColor = Color3.fromRGB(255, 160, 80)}, -- FIXED: Removed space in name
    Cyan = {VisualColor = Color3.fromRGB(100, 220, 255)},
    Gold = {VisualColor = Color3.fromRGB(255, 215, 100)},
    Red = {VisualColor = Color3.fromRGB(255, 80, 80)},
    Lime = {VisualColor = Color3.fromRGB(170, 230, 90)}
}

local ThemeOrder = {"Dark", "Purple", "Crimson", "Blue", "Pink", "Emerald", "Orange", "Cyan", "Gold", "Red", "Lime"} -- FIXED: Removed spaces

local function getVisualColor(useTheme, custom)
    if useTheme then
        return Themes[State.CurrentTheme].VisualColor
    end
    return custom
end

-- ============================================================
-- ICON ENGINE (SVG-LIKE, PROCEDURAL)
-- ============================================================
local IconEngine = {}

-- Eye (Visuals)
function IconEngine.createEye(parent, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 24, 0, 24)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local eye = Instance.new("Frame")
    eye.Size = UDim2.new(0, 20, 0, 12)
    eye.Position = UDim2.new(0.5, -10, 0.5, -6)
    eye.BackgroundColor3 = color
    eye.BackgroundTransparency = 0
    eye.BorderSizePixel = 0
    eye.Parent = frame
    
    local ec = Instance.new("UICorner")
    ec.CornerRadius = UDim.new(1, 0)
    ec.Parent = eye
    
    local pupil = Instance.new("Frame")
    pupil.Size = UDim2.new(0, 6, 0, 6)
    pupil.Position = UDim2.new(0.5, -3, 0.5, -3)
    pupil.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    pupil.BorderSizePixel = 0
    pupil.Parent = eye
    
    local pc = Instance.new("UICorner")
    pc.CornerRadius = UDim.new(1, 0)
    pc.Parent = pupil
end

-- Palette (Themes)
function IconEngine.createPalette(parent, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 24, 0, 24)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 20, 0, 20)
    main.Position = UDim2.new(0.5, -10, 0.5, -10)
    main.BackgroundColor3 = color
    main.BackgroundTransparency = 0
    main.BorderSizePixel = 0
    main.Parent = frame
    
    local mc = Instance.new("UICorner")
    mc.CornerRadius = UDim.new(0, 8)
    mc.Parent = main
    
    local h1 = Instance.new("Frame")
    h1.Size = UDim2.new(0, 4, 0, 4)
    h1.Position = UDim2.new(0, 4, 0, 4)
    h1.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    h1.BorderSizePixel = 0
    h1.Parent = main
    local h1c = Instance.new("UICorner"); h1c.CornerRadius = UDim.new(1, 0); h1c.Parent = h1
    
    local h2 = Instance.new("Frame")
    h2.Size = UDim2.new(0, 4, 0, 4)
    h2.Position = UDim2.new(0, 12, 0, 4)
    h2.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    h2.BorderSizePixel = 0
    h2.Parent = main
    local h2c = Instance.new("UICorner"); h2c.CornerRadius = UDim.new(1, 0); h2c.Parent = h2
    
    local h3 = Instance.new("Frame")
    h3.Size = UDim2.new(0, 4, 0, 4)
    h3.Position = UDim2.new(0, 8, 0, 12)
    h3.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    h3.BorderSizePixel = 0
    h3.Parent = main
    local h3c = Instance.new("UICorner"); h3c.CornerRadius = UDim.new(1, 0); h3c.Parent = h3
end

-- Roblox Logo (Places)
function IconEngine.createRobloxLogo(parent, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 24, 0, 24)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0, 16, 0, 16)
    box.Position = UDim2.new(0.5, -8, 0.5, -8)
    box.BackgroundColor3 = color
    box.BorderSizePixel = 0
    box.Rotation = 20
    box.Parent = frame
    
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 2)
    bc.Parent = box
    
    local hole = Instance.new("Frame")
    hole.Size = UDim2.new(0, 5, 0, 5)
    hole.Position = UDim2.new(0.5, -2.5, 0.5, -2.5)
    hole.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    hole.BorderSizePixel = 0
    hole.Rotation = 20
    hole.Parent = frame
    
    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(0, 1)
    hc.Parent = hole
end

-- Sliders (Configs)
function IconEngine.createSliders(parent, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 24, 0, 24)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local l1 = Instance.new("Frame")
    l1.Size = UDim2.new(0, 18, 0, 2)
    l1.Position = UDim2.new(0.5, -9, 0.5, -5)
    l1.BackgroundColor3 = color
    l1.BorderSizePixel = 0
    l1.Parent = frame
    
    local k1 = Instance.new("Frame")
    k1.Size = UDim2.new(0, 6, 0, 6)
    k1.Position = UDim2.new(0.5, -6, 0.5, -8)
    k1.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    k1.BorderSizePixel = 0
    k1.Parent = frame
    local k1s = Instance.new("UIStroke"); k1s.Color = color; k1s.Thickness = 1.5; k1s.Parent = k1
    local k1c = Instance.new("UICorner"); k1c.CornerRadius = UDim.new(1, 0); k1c.Parent = k1
    
    local l2 = Instance.new("Frame")
    l2.Size = UDim2.new(0, 18, 0, 2)
    l2.Position = UDim2.new(0.5, -9, 0.5, 5)
    l2.BackgroundColor3 = color
    l2.BorderSizePixel = 0
    l2.Parent = frame
    
    local k2 = Instance.new("Frame")
    k2.Size = UDim2.new(0, 6, 0, 6)
    k2.Position = UDim2.new(0.5, 2, 0.5, 2)
    k2.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    k2.BorderSizePixel = 0
    k2.Parent = frame
    local k2s = Instance.new("UIStroke"); k2s.Color = color; k2s.Thickness = 1.5; k2s.Parent = k2
    local k2c = Instance.new("UICorner"); k2c.CornerRadius = UDim.new(1, 0); k2c.Parent = k2
end

-- Star / Sparkle (Cosmetics)
function IconEngine.createStar(parent, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 24, 0, 24)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local lbl = Instance.new("TextLabel")
    lbl.Text = "✦"
    lbl.Font = Enum.Font.ArialBlack
    lbl.TextSize = 22
    lbl.TextColor3 = color
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Parent = frame
end

-- ============================================================
-- MATERIAL HELPER
-- ============================================================
local function applyEmissiveMaterial(part, color, intensity)
    part.Material = Enum.Material.SmoothPlastic
    part.Color = color
    part.Transparency = 0.1
    part.EmissiveColor = color * intensity
    part.Emissivity = 1
end

-- ============================================================
-- VISUAL EFFECTS
-- ============================================================

-- Aspect Ratio
local aspectBase, aspectLast = nil, nil
addConnection(RunService.RenderStepped:Connect(function()
    if ScriptUnloaded then return end
    if State.AspectEnabled then
        local cur = camera.CFrame
        if not aspectBase or (aspectLast and (cur.Position - aspectLast.Position).Magnitude > 0.001) then
            aspectBase = cur
        end
        aspectLast = cur
        _genv.__WANNA_ASPECT_ACTIVE = true
        _genv.__WANNA_ASPECT_VALUE = State.AspectValue
        camera.CFrame = aspectBase * CFrame.new(0, 0, 0, 1, 0, 0, 0, State.AspectValue, 0, 0, 0, 1)
    else
        aspectBase = nil
        aspectLast = nil
        _genv.__WANNA_ASPECT_ACTIVE = false
        _genv.__WANNA_ASPECT_VALUE = 1
    end
end))

-- Fog
local function applyFog()
    local ex = Lighting:FindFirstChild("WannaFog")
    if ex then ex:Destroy() end
    if not State.FogEnabled then return end
    
    local fog = Instance.new("Atmosphere")
    fog.Name = "WannaFog"
    fog.Density = State.FogSettings.Density
    fog.Offset = State.FogSettings.Offset
    fog.Color = State.FogSettings.Color
    fog.Decay = State.FogSettings.Decay
    fog.Glare = 0
    fog.Haze = 1.5
    fog.Parent = Lighting
end

-- Fullbright
local function applyFullbright()
    if not State.FullbrightEnabled then
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.GlobalShadows = originalLighting.GlobalShadows
        return
    end
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = State.FullbrightBrightness
    Lighting.ClockTime = 12
    Lighting.GlobalShadows = false
end

-- Motion Blur
local MB = {effect = nil, lastRot = nil, amount = 0}
addConnection(RunService.RenderStepped:Connect(function(dt)
    if ScriptUnloaded then return end
    if not State.MotionBlurEnabled then
        if MB.effect then MB.effect.Size = 0 end
        MB.lastRot = nil
        MB.amount = 0
        return
    end
    if not MB.effect then
        MB.effect = Instance.new("BlurEffect")
        MB.effect.Name = "WannaMotionBlur"
        MB.effect.Size = 0
        MB.effect.Parent = Lighting
    end
    local cur = camera.CFrame.LookVector
    local speed = 0
    if MB.lastRot then
        local dot = cur:Dot(MB.lastRot)
        local angle = math.acos(math.clamp(dot, -1, 1))
        speed = angle / math.max(dt, 0.001)
    end
    MB.lastRot = cur
    local target = math.clamp(speed * 2, 0, State.MotionBlurStrength)
    MB.amount = MB.amount + (target - MB.amount) * math.min(dt * 10, 1)
    MB.effect.Size = MB.amount
end))

-- World Color Correction
local function applyWorld()
    local ex = Lighting:FindFirstChild("WannaWorld")
    if ex then ex:Destroy() end
    if not State.WorldEnabled then return end
    
    local cc = Instance.new("ColorCorrectionEffect")
    cc.Name = "WannaWorld"
    cc.Saturation = State.WorldSettings.Saturation
    cc.Contrast = State.WorldSettings.Contrast
    cc.Brightness = State.WorldSettings.Brightness
    cc.TintColor = State.WorldSettings.TintColor
    cc.Parent = Lighting
end

-- ============================================================
-- CHINA HAT MODEL
-- ============================================================
local CH = {model = nil, conn = nil}
local function applyChinaHat()
    if CH.model then CH.model:Destroy(); CH.model = nil end
    if CH.conn then CH.conn:Disconnect(); CH.conn = nil end
    if not State.ChinaHatEnabled then return end
    
    local char = player.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    local color = getVisualColor(State.ChinaHatUseTheme, State.ChinaHatCustomColor)
    
    CH.model = Instance.new("Model")
    CH.model.Name = "WannaChinaHat"
    CH.model.Parent = Workspace
    
    local brim = Instance.new("Part")
    brim.Name = "HatBrim"
    brim.Shape = Enum.PartType.Cylinder
    brim.Size = Vector3.new(0.1, 3.2, 3.2)
    brim.Anchored = true
    brim.CanCollide = false
    brim.CanQuery = false
    brim.CanTouch = false
    brim.CastShadow = false
    brim.Massless = true
    applyEmissiveMaterial(brim, color, State.ChinaHatGlow and 0.5 or 0)
    brim.Parent = CH.model
    
    local layerCount, baseD, topD, coneH, thick = 40, 2.9, 0.05, 1.4, 0.08
    local coneParts = {}
    for i = 1, layerCount do
        local t = i / layerCount
        local diameter = baseD * (1 - t) + topD * t
        local p = Instance.new("Part")
        p.Name = "ConeLayer" .. i
        p.Shape = Enum.PartType.Cylinder
        p.Size = Vector3.new(thick, diameter, diameter)
        p.Anchored = true
        p.CanCollide = false
        p.CanQuery = false
        p.CanTouch = false
        p.CastShadow = false
        p.Massless = true
        applyEmissiveMaterial(p, color, State.ChinaHatGlow and 0.5 or 0)
        p.Parent = CH.model
        p:SetAttribute("YOffset", 0.2 + t * coneH)
        table.insert(coneParts, p)
    end
    
    CH.conn = RunService.RenderStepped:Connect(function()
        if ScriptUnloaded or not State.ChinaHatEnabled then return end
        if not CH.model or not CH.model.Parent then return end
        
        local c = player.Character
        if not c then return end
        local h = c:FindFirstChild("Head")
        if not h then return end
        
        local cf = h.CFrame
        brim.CFrame = cf * CFrame.new(0, 0.6, 0) * CFrame.Angles(0, 0, math.rad(90))
        
        for _, p in ipairs(coneParts) do
            if p and p.Parent then
                p.CFrame = cf * CFrame.new(0, 0.6 + p:GetAttribute("YOffset"), 0) * CFrame.Angles(0, 0, math.rad(90))
            end
        end
    end)
end

-- ============================================================
-- ANGEL WINGS MODEL
-- ============================================================
local WG = {model = nil, conn = nil, flap = 0, blend = 0}
local function applyWings()
    if WG.model then WG.model:Destroy(); WG.model = nil end
    if WG.conn then WG.conn:Disconnect(); WG.conn = nil end
    if not State.WingsEnabled then return end
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local color = Color3.fromRGB(255, 255, 255) -- Always white per user request
    
    WG.model = Instance.new("Model")
    WG.model.Name = "WannaWings"
    WG.model.Parent = Workspace
    
    local layers = {
        {name = "L1", count = 14, lMul = 0.75, hMul = 1.6, bMul = 1.0, sAdd = 0.0, yMul = 1.0, tMul = 1.0},
        {name = "L2", count = 12, lMul = 0.65, hMul = 1.5, bMul = 1.15, sAdd = 0.10, yMul = 0.85, tMul = 0.9},
        {name = "L3", count = 10, lMul = 0.55, hMul = 1.4, bMul = 1.3, sAdd = 0.20, yMul = 0.7, tMul = 0.8}
    }
    
    local all = {}
    local function createWing(sign)
        local parts = {}
        for li, L in ipairs(layers) do
            for i = 1, L.count do
                local t = (i - 1) / (L.count - 1)
                local sideOff = 1.5 + L.sAdd + t * 3.2
                local upOff = math.sin(t * math.pi * 0.7) * 1.6 * L.yMul
                local len = 3.2 * (1 - t * 0.25) * L.lMul
                local ang = math.rad(10 + t * 40)
                local back = (0.8 + t * 0.3) * L.bMul
                local h = 1.45 * L.hMul
                local w = 0.22 * L.tMul
                
                local f = Instance.new("Part")
                f.Name = L.name .. "_" .. i .. (sign > 0 and "_R" or "_L")
                f.Shape = Enum.PartType.Block
                f.Size = Vector3.new(len, h, w)
                f.Anchored = true
                f.CanCollide = false
                f.CanQuery = false
                f.CanTouch = false
                f.CastShadow = false
                f.Massless = true
                applyEmissiveMaterial(f, color, State.WingsGlow and 0.8 or 0)
                f.Parent = WG.model
                
                f:SetAttribute("SO", sideOff * sign)
                f:SetAttribute("UO", upOff)
                f:SetAttribute("BO", back)
                f:SetAttribute("FA", ang * sign)
                f:SetAttribute("FI", i)
                f:SetAttribute("LI", li)
                
                table.insert(parts, f)
            end
        end
        return parts
    end
    
    local rw = createWing(1)
    local lw = createWing(-1)
    for _, f in ipairs(rw) do table.insert(all, f) end
    for _, f in ipairs(lw) do table.insert(all, f) end
    
    WG.flap = 0
    WG.blend = 0
    
    WG.conn = RunService.RenderStepped:Connect(function(dt)
        if ScriptUnloaded or not State.WingsEnabled then return end
        if not WG.model or not WG.model.Parent then return end
        
        local c = player.Character
        if not c then return end
        local r = c:FindFirstChild("HumanoidRootPart")
        if not r then return end
        
        local hum = c:FindFirstChildOfClass("Humanoid")
        local cf = r.CFrame
        
        WG.flap = WG.flap + dt
        
        local walking = false
        if hum then walking = hum.MoveDirection.Magnitude > 0.1 end
        
        local target = walking and 1 or 0
        WG.blend = WG.blend + (target - WG.blend) * math.min(dt * 4, 1)
        
        local idle = math.sin(WG.flap * 2.5) * 0.12
        local walk = math.sin(WG.flap * 6) * 0.15
        local tiltX = -WG.blend * math.rad(15)
        
        for _, f in ipairs(all) do
            if f and f.Parent then
                local wd = math.sin(WG.flap * 6 - f:GetAttribute("FI") * 0.3 - f:GetAttribute("LI") * 0.4) * 0.12
                local fo = idle * (1 - WG.blend) + (walk + wd) * WG.blend
                
                local off = Vector3.new(f:GetAttribute("SO"), f:GetAttribute("UO") + fo + f:GetAttribute("LI") * 0.05, f:GetAttribute("BO"))
                
                f.CFrame = cf * CFrame.new(off)
                    * CFrame.Angles(0, 0, f:GetAttribute("FA") + fo * 0.3)
                    * CFrame.Angles(tiltX + math.rad(fo * 30), 0, 0)
            end
        end
    end)
end

-- ============================================================
-- KAGUNE MODEL
-- ============================================================
local KG = {model = nil, conn = nil, flap = 0, blend = 0}
local function applyKagune()
    if KG.model then KG.model:Destroy(); KG.model = nil end
    if KG.conn then KG.conn:Disconnect(); KG.conn = nil end
    if not State.KaguneEnabled then return end
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local color = Color3.fromRGB(220, 30, 30) -- Always red per user request
    
    KG.model = Instance.new("Model")
    KG.model.Name = "WannaKagune"
    KG.model.Parent = Workspace
    
    local all = {}
    local function makeTentacle(sx, sy)
        local parts = {}
        local segments, baseBlock = 30, 0.55
        for i = 1, segments do
            local t = (i - 1) / (segments - 1)
            local pX = (0.5 + t * 2.0) * sx
            local pY = (0.3 + t * 1.6) * sy
            local tipP = math.max(0, (t - 0.5) / 0.5)
            local tilt = tipP * math.rad(75)
            local pZ = 0.5 - tipP * 1.5
            local cy = math.sin(t * math.pi * 0.5) * 0.8 * sy
            local cz = math.sin(t * math.pi) * 0.3
            
            local sf
            if t < 0.8 then
                sf = 1 - t * 0.5
            else
                sf = 0.6 * (1 - (t - 0.8) / 0.2)
            end
            
            local bs = baseBlock * sf
            local az = math.atan2(pY, pX) - math.rad(90) * sx
            
            local s = Instance.new("Part")
            s.Name = "Kagune_" .. sx .. "_" .. sy .. "_" .. i
            s.Shape = Enum.PartType.Block
            s.Size = Vector3.new(bs, bs, bs)
            s.Anchored = true
            s.CanCollide = false
            s.CanQuery = false
            s.CanTouch = false
            s.CastShadow = false
            s.Massless = true
            applyEmissiveMaterial(s, color, State.KaguneGlow and 0.8 or 0)
            s.Parent = KG.model
            
            s:SetAttribute("X", pX)
            s:SetAttribute("Y", pY + cy)
            s:SetAttribute("Z", pZ + cz)
            s:SetAttribute("TT", tilt)
            s:SetAttribute("AZ", az)
            s:SetAttribute("SI", i)
            s:SetAttribute("US", sy)
            s:SetAttribute("T", t)
            
            table.insert(parts, s)
        end
        return parts
    end
    
    for sx = -1, 1, 2 do
        for sy = -1, 1, 2 do
            for _, p in ipairs(makeTentacle(sx, sy)) do
                table.insert(all, p)
            end
        end
    end
    
    KG.flap = 0
    KG.blend = 0
    
    KG.conn = RunService.RenderStepped:Connect(function(dt)
        if ScriptUnloaded or not State.KaguneEnabled then return end
        if not KG.model or not KG.model.Parent then return end
        
        local c = player.Character
        if not c then return end
        local r = c:FindFirstChild("HumanoidRootPart")
        if not r then return end
        
        local hum = c:FindFirstChildOfClass("Humanoid")
        local cf = r.CFrame
        
        KG.flap = KG.flap + dt
        
        local walking = false
        if hum then walking = hum.MoveDirection.Magnitude > 0.1 end
        
        local target = walking and 1 or 0
        KG.blend = KG.blend + (target - KG.blend) * math.min(dt * 4, 1)
        
        local idle = math.sin(KG.flap * 2.0) * 0.15
        local walk = math.sin(KG.flap * 5) * 0.2
        
        for _, s in ipairs(all) do
            if s and s.Parent then
                local us = s:GetAttribute("US")
                local t = s:GetAttribute("T")
                local wd = math.sin(KG.flap * 5 - s:GetAttribute("SI") * 0.3) * 0.15
                local fo = idle * (1 - KG.blend) + (walk + wd) * KG.blend
                
                local off = Vector3.new(s:GetAttribute("X") + fo * 0.5 * t, s:GetAttribute("Y") + fo * us * t, s:GetAttribute("Z"))
                
                s.CFrame = cf * CFrame.new(off)
                    * CFrame.Angles(0, s:GetAttribute("AZ") + fo * 0.25, 0)
                    * CFrame.Angles(0, 0, math.rad(us * 45) + fo * us * 0.25)
                    * CFrame.Angles(s:GetAttribute("TT"), 0, 0)
            end
        end
    end)
end

-- ============================================================
-- COMPANION MODEL
-- ============================================================
local CMP = {model = nil, conn = nil, flap = 0, box = nil, core = nil}
local function applyCompanion()
    if CMP.model then CMP.model:Destroy(); CMP.model = nil end
    if CMP.conn then CMP.conn:Disconnect(); CMP.conn = nil end
    if not State.CompanionEnabled then return end
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local color = getVisualColor(State.CompanionUseTheme, State.CompanionCustomColor)
    
    CMP.model = Instance.new("Model")
    CMP.model.Name = "WannaCompanion"
    CMP.model.Parent = Workspace
    
    local box = Instance.new("Part")
    box.Name = "Box"
    box.Shape = Enum.PartType.Block
    box.Size = Vector3.new(0.6, 0.6, 0.6)
    box.Anchored = true
    box.CanCollide = false
    box.CanQuery = false
    box.CanTouch = false
    box.CastShadow = false
    applyEmissiveMaterial(box, color, 0.8)
    box.Parent = CMP.model
    
    local core = Instance.new("Part")
    core.Name = "Core"
    core.Shape = Enum.PartType.Ball
    core.Size = Vector3.new(0.25, 0.25, 0.25)
    core.Anchored = true
    core.CanCollide = false
    core.CanQuery = false
    core.CanTouch = false
    core.CastShadow = false
    core.Material = Enum.Material.SmoothPlastic
    core.Color = Color3.fromRGB(255, 255, 255)
    core.Transparency = 0.2
    core.Parent = CMP.model
    
    CMP.flap = 0
    CMP.box = box
    CMP.core = core
    
    CMP.conn = RunService.RenderStepped:Connect(function(dt)
        if ScriptUnloaded or not State.CompanionEnabled then return end
        if not CMP.model or not CMP.model.Parent then return end
        
        local c = player.Character
        if not c then return end
        local r = c:FindFirstChild("HumanoidRootPart")
        if not r then return end
        
        CMP.flap = CMP.flap + dt
        local t = CMP.flap
        
        local bobY = math.sin(t * 2.5) * 0.15
        local swayZ = math.sin(t * 1.8) * 0.2
        
        local targetPos = r.Position + r.CFrame.LookVector * (2.5 + swayZ) + r.CFrame.RightVector * 2.0 + r.CFrame.UpVector * (1.2 + bobY)
        local lerpedPos = box.Position:Lerp(targetPos, math.min(dt * 8, 1))
        
        local spinAngle = t * 3
        local tiltAngle = math.sin(t * 2) * 0.3
        
        box.CFrame = CFrame.new(lerpedPos) * CFrame.Angles(tiltAngle, spinAngle, tiltAngle * 0.5)
        
        local coreSize = 0.25 + math.sin(t * 4) * 0.05
        core.Size = Vector3.new(coreSize, coreSize, coreSize)
        core.CFrame = box.CFrame
        core.Transparency = 0.2 + math.sin(t * 4) * 0.1
    end)
end

-- ============================================================
-- BODY MODS
-- ============================================================
local BodyMods = {connections = {}}

local function toggleKorblox(enable)
    State.KorbloxEnabled = enable
    local char = player.Character
    if not char then return end
    
    for _, conn in ipairs(BodyMods.connections) do 
        conn:Disconnect() 
    end
    BodyMods.connections = {}
    
    if enable then
        local leg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLeg")
        if leg then
            leg.Transparency = 1
            leg.CanCollide = false
            local shoe = leg:FindFirstChildOfClass("Accessory") or leg:FindFirstChild("Shoe")
            if shoe then shoe.Transparency = 1 end
        end
    else
        local leg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLeg")
        if leg then
            leg.Transparency = 0
            leg.CanCollide = true
            local shoe = leg:FindFirstChildOfClass("Accessory") or leg:FindFirstChild("Shoe")
            if shoe then shoe.Transparency = 0 end
        end
    end
end

local function toggleGhostLegs(enable)
    State.GhostLegsEnabled = enable
    local char = player.Character
    if not char then return end
    
    for _, conn in ipairs(BodyMods.connections) do 
        conn:Disconnect() 
    end
    BodyMods.connections = {}
    
    if enable then
        local leftLeg = char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftLeg")
        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLeg")
        if leftLeg then leftLeg.Transparency = 1; leftLeg.CanCollide = false end
        if rightLeg then rightLeg.Transparency = 1; rightLeg.CanCollide = false end
    else
        local leftLeg = char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftLeg")
        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLeg")
        if leftLeg then leftLeg.Transparency = 0; leftLeg.CanCollide = true end
        if rightLeg then rightLeg.Transparency = 0; rightLeg.CanCollide = true end
    end
end

addConnection(player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if State.KorbloxEnabled then toggleKorblox(true) end
    if State.GhostLegsEnabled then toggleGhostLegs(true) end
end))

-- ============================================================
-- ESP SYSTEM
-- ============================================================
local ESP = {boxes = {}}

local function getESPColor()
    return getVisualColor(State.ESPUseTheme, State.ESPCustomColor)
end

local espGui = Instance.new("ScreenGui")
espGui.Name = "WannaESP2D"
espGui.ResetOnSpawn = false
espGui.IgnoreGuiInset = true
espGui.DisplayOrder = 500
espGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
espGui.Parent = player:WaitForChild("PlayerGui")

local function projectPoint(worldPos)
    local cam = camera
    local viewport = cam.ViewportSize
    local vw, vh = viewport.X, viewport.Y
    if vw == 0 or vh == 0 then return nil, false end
    
    local cf = cam.CFrame
    local aspect = 1
    if _genv.__WANNA_ASPECT_ACTIVE then 
        aspect = _genv.__WANNA_ASPECT_VALUE or 1 
    end
    
    local rel = cf:PointToObjectSpace(worldPos)
    rel = Vector3.new(rel.X, rel.Y * aspect, rel.Z)
    
    if rel.Z >= 0 then return nil, false end
    
    local fovRad = math.rad(cam.FieldOfView)
    local tanHalfFov = math.tan(fovRad * 0.5)
    local aspectRatio = vw / vh
    
    local ndcX = (rel.X / -rel.Z) / (tanHalfFov * aspectRatio)
    local ndcY = (rel.Y / -rel.Z) / tanHalfFov
    
    local screenX = (ndcX * 0.5 + 0.5) * vw
    local screenY = (1 - (ndcY * 0.5 + 0.5)) * vh
    
    return Vector2.new(screenX, screenY), true
end

local function createESPBox(targetPlayer)
    if not targetPlayer or targetPlayer == player then return end
    if ESP.boxes[targetPlayer] then return end
    
    local box = {}
    box.frame = Instance.new("Frame")
    box.frame.Name = "ESPBox_" .. targetPlayer.Name
    box.frame.BackgroundTransparency = 1
    box.frame.BorderSizePixel = 0
    box.frame.Visible = false
    box.frame.ZIndex = 500
    box.frame.Parent = espGui
    
    local color = getESPColor()
    local thickness = 2
    local stripes = {}
    
    local function makeStripe(name, size, pos)
        local s = Instance.new("Frame")
        s.Name = name
        s.BackgroundColor3 = color
        s.BorderSizePixel = 0
        s.Size = size
        s.Position = pos
        s.ZIndex = 501
        s.Parent = box.frame
        table.insert(stripes, s)
        return s
    end
    
    makeStripe("Top", UDim2.new(1, 0, 0, thickness), UDim2.new(0, 0, 0, 0))
    makeStripe("Bottom", UDim2.new(1, 0, 0, thickness), UDim2.new(0, 0, 1, -thickness))
    makeStripe("Left", UDim2.new(0, thickness, 1, 0), UDim2.new(0, 0, 0, 0))
    makeStripe("Right", UDim2.new(0, thickness, 1, 0), UDim2.new(1, -thickness, 0, 0))
    
    box.stripes = stripes
    
    box.nameLabel = Instance.new("TextLabel")
    box.nameLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    box.nameLabel.BackgroundTransparency = 0.15
    box.nameLabel.Text = targetPlayer.Name
    box.nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.nameLabel.Font = FONT_BOLD
    box.nameLabel.TextSize = 14
    box.nameLabel.TextStrokeTransparency = 0.4
    box.nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    box.nameLabel.Size = UDim2.new(0, 140, 0, 22)
    box.nameLabel.Position = UDim2.new(0.5, -70, 0, -28)
    box.nameLabel.Visible = State.ESPShowName
    box.nameLabel.ZIndex = 502
    box.nameLabel.Parent = box.frame
    
    local nc = Instance.new("UICorner"); nc.CornerRadius = UDim.new(0, 6); nc.Parent = box.nameLabel
    local ns = Instance.new("UIStroke"); ns.Color = Color3.fromRGB(255, 255, 255); ns.Thickness = 1; ns.Transparency = 0.7; ns.Parent = box.nameLabel
    
    box.distLabel = Instance.new("TextLabel")
    box.distLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    box.distLabel.BackgroundTransparency = 0.25
    box.distLabel.Text = ""
    box.distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.distLabel.Font = FONT_BOLD
    box.distLabel.TextSize = 12
    box.distLabel.TextStrokeTransparency = 0.5
    box.distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    box.distLabel.Size = UDim2.new(0, 90, 0, 18)
    box.distLabel.Position = UDim2.new(0.5, -45, 1, 6)
    box.distLabel.Visible = State.ESPShowDistance
    box.distLabel.ZIndex = 502
    box.distLabel.Parent = box.frame
    
    local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(0, 6); dc.Parent = box.distLabel
    local ds = Instance.new("UIStroke"); ds.Color = Color3.fromRGB(255, 255, 255); ds.Thickness = 1; ds.Transparency = 0.7; ds.Parent = box.distLabel
    
    ESP.boxes[targetPlayer] = box
end

local function updateESPBoxes()
    if ScriptUnloaded or not State.ESPEnabled then return end
    
    for targetPlayer, box in pairs(ESP.boxes) do
        local char = targetPlayer.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if root and hum and hum.Health > 0 then
                local minV = Vector3.new(math.huge, math.huge, math.huge)
                local maxV = Vector3.new(-math.huge, -math.huge, -math.huge)
                
                for _, partName in ipairs({"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso", "Torso"}) do
                    local p = char:FindFirstChild(partName)
                    if p and p:IsA("BasePart") then
                        local sz, pos = p.Size, p.Position
                        minV = Vector3.new(
                            math.min(minV.X, pos.X - sz.X / 2),
                            math.min(minV.Y, pos.Y - sz.Y / 2),
                            math.min(minV.Z, pos.Z - sz.Z / 2)
                        )
                        maxV = Vector3.new(
                            math.max(maxV.X, pos.X + sz.X / 2),
                            math.max(maxV.Y, pos.Y + sz.Y / 2),
                            math.max(maxV.Z, pos.Z + sz.Z / 2)
                        )
                    end
                end
                
                if minV.X == math.huge then
                    local sz, pos = root.Size, root.Position
                    minV = pos - sz / 2
                    maxV = pos + sz / 2
                end
                
                local corners = {}
                local allOnScreen = true
                
                for xi = 0, 1 do
                    for yi = 0, 1 do
                        for zi = 0, 1 do
                            local v = Vector3.new(
                                xi == 0 and minV.X or maxV.X,
                                yi == 0 and minV.Y or maxV.Y,
                                zi == 0 and minV.Z or maxV.Z
                            )
                            local sp, onScreen = projectPoint(v)
                            if not onScreen or not sp then
                                allOnScreen = false
                                break
                            end
                            table.insert(corners, sp)
                        end
                        if not allOnScreen then break end
                    end
                    if not allOnScreen then break end
                end
                
                if allOnScreen and #corners == 8 then
                    local minX, minY = math.huge, math.huge
                    local maxX, maxY = -math.huge, -math.huge
                    
                    for _, sp in ipairs(corners) do
                        minX = math.min(minX, sp.X)
                        maxX = math.max(maxX, sp.X)
                        minY = math.min(minY, sp.Y)
                        maxY = math.max(maxY, sp.Y)
                    end
                    
                    local w, h = maxX - minX, maxY - minY
                    box.frame.Visible = true
                    box.frame.Position = UDim2.new(0, minX, 0, minY)
                    box.frame.Size = UDim2.new(0, w, 0, h)
                    
                    if State.ESPShowDistance and player.Character then
                        local myRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            box.distLabel.Text = math.floor((myRoot.Position - root.Position).Magnitude) .. "m"
                        end
                    end
                else
                    box.frame.Visible = false
                end
            else
                box.frame.Visible = false
            end
        else
            box.frame.Visible = false
        end
    end
end

local function cleanupBox(targetPlayer)
    local box = ESP.boxes[targetPlayer]
    if not box then return end
    if box.frame then box.frame:Destroy() end
    ESP.boxes[targetPlayer] = nil
end

local function destroyAllESP()
    for targetPlayer, _ in pairs(ESP.boxes) do 
        cleanupBox(targetPlayer) 
    end
    ESP.boxes = {}
end

local function applyESP()
    if not State.ESPEnabled then
        destroyAllESP()
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        createESPBox(p)
    end
end

local function updateESPColors()
    local c = getESPColor()
    for _, box in pairs(ESP.boxes) do
        if box.stripes then
            for _, s in ipairs(box.stripes) do 
                s.BackgroundColor3 = c 
            end
        end
        if box.nameLabel then
            box.nameLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            local s = box.nameLabel:FindFirstChildOfClass("UIStroke")
            if s then s.Color = Color3.fromRGB(255, 255, 255) end
        end
        if box.distLabel then
            box.distLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            local s = box.distLabel:FindFirstChildOfClass("UIStroke")
            if s then s.Color = Color3.fromRGB(255, 255, 255) end
        end
    end
end

addConnection(Players.PlayerAdded:Connect(function(p)
    if State.ESPEnabled then createESPBox(p) end
end))

addConnection(Players.PlayerRemoving:Connect(function(p)
    cleanupBox(p)
end))

addConnection(RunService.RenderStepped:Connect(function()
    updateESPBoxes()
end))

-- ============================================================
-- SHAHED-136 DRONE
-- ============================================================
local Shahed = {
    model = nil,
    conn = nil,
    flyTime = 0,
    active = false,
    originalChar = nil,
    originalCharParent = nil,
    droneProp = nil,
    targetPlayer = nil
}

local function createShahedModel()
    local model = Instance.new("Model")
    model.Name = "WannaShahed136"
    
    local bodyColor = Color3.fromRGB(200, 205, 210)
    local darkColor = Color3.fromRGB(80, 85, 90)
    local metalColor = Color3.fromRGB(100, 100, 105)
    local propColor = Color3.fromRGB(180, 140, 100)
    local blueStripe = Color3.fromRGB(60, 100, 180)
    
    local fuselage = Instance.new("Part")
    fuselage.Name = "Fuselage"
    fuselage.Shape = Enum.PartType.Cylinder
    fuselage.Size = Vector3.new(0.5, 5.0, 0.5)
    fuselage.Color = bodyColor
    fuselage.Material = Enum.Material.SmoothPlastic
    fuselage.Anchored = true
    fuselage.CanCollide = false
    fuselage.CanQuery = false
    fuselage.CanTouch = false
    fuselage.CastShadow = true
    fuselage.Massless = true
    fuselage.Parent = model
    
    local nose = Instance.new("Part")
    nose.Name = "Nose"
    nose.Shape = Enum.PartType.Ball
    nose.Size = Vector3.new(0.55, 0.55, 1.2)
    nose.Color = bodyColor
    nose.Material = Enum.Material.SmoothPlastic
    nose.Anchored = true
    nose.CanCollide = false
    nose.CanQuery = false
    nose.CanTouch = false
    nose.CastShadow = true
    nose.Massless = true
    nose.Parent = model
    nose.CFrame = fuselage.CFrame * CFrame.new(0, 0, -3.0)
    
    local stripe = Instance.new("Part")
    stripe.Name = "BlueStripe"
    stripe.Shape = Enum.PartType.Cylinder
    stripe.Size = Vector3.new(0.08, 4.5, 0.08)
    stripe.Color = blueStripe
    stripe.Material = Enum.Material.SmoothPlastic
    stripe.Anchored = true
    stripe.CanCollide = false
    stripe.CanQuery = false
    stripe.CanTouch = false
    stripe.CastShadow = false
    stripe.Massless = true
    stripe.Parent = model
    stripe.CFrame = fuselage.CFrame * CFrame.new(0, 0.28, 0)
    
    local wingL = Instance.new("Part")
    wingL.Name = "WingL"
    wingL.Shape = Enum.PartType.Block
    wingL.Size = Vector3.new(3.5, 0.08, 2.5)
    wingL.Color = bodyColor
    wingL.Material = Enum.Material.SmoothPlastic
    wingL.Anchored = true
    wingL.CanCollide = false
    wingL.CanQuery = false
    wingL.CanTouch = false
    wingL.CastShadow = true
    wingL.Massless = true
    wingL.Parent = model
    wingL.CFrame = fuselage.CFrame * CFrame.new(2.0, 0, 0.3) * CFrame.Angles(0, 0, math.rad(-8))
    
    local wingR = Instance.new("Part")
    wingR.Name = "WingR"
    wingR.Shape = Enum.PartType.Block
    wingR.Size = Vector3.new(3.5, 0.08, 2.5)
    wingR.Color = bodyColor
    wingR.Material = Enum.Material.SmoothPlastic
    wingR.Anchored = true
    wingR.CanCollide = false
    wingR.CanQuery = false
    wingR.CanTouch = false
    wingR.CastShadow = true
    wingR.Massless = true
    wingR.Parent = model
    wingR.CFrame = fuselage.CFrame * CFrame.new(-2.0, 0, 0.3) * CFrame.Angles(0, 0, math.rad(8))
    
    for _, wing in ipairs({wingL, wingR}) do
        for i = 1, 3 do
            local panel = Instance.new("Part")
            panel.Name = "Panel_" .. wing.Name .. "_" .. i
            panel.Shape = Enum.PartType.Block
            panel.Size = Vector3.new(0.8, 0.02, 0.6)
            panel.Color = darkColor
            panel.Material = Enum.Material.SmoothPlastic
            panel.Anchored = true
            panel.CanCollide = false
            panel.CanQuery = false
            panel.CanTouch = false
            panel.CastShadow = false
            panel.Massless = true
            panel.Parent = model
            local offset = (i - 2) * 0.9
            panel.CFrame = wing.CFrame * CFrame.new(offset * (wing == wingL and 1 or -1), 0.05, 0)
        end
    end
    
    local tailV = Instance.new("Part")
    tailV.Name = "TailV"
    tailV.Shape = Enum.PartType.Block
    tailV.Size = Vector3.new(0.08, 0.7, 1.0)
    tailV.Color = bodyColor
    tailV.Material = Enum.Material.SmoothPlastic
    tailV.Anchored = true
    tailV.CanCollide = false
    tailV.CanQuery = false
    tailV.CanTouch = false
    tailV.CastShadow = true
    tailV.Massless = true
    tailV.Parent = model
    tailV.CFrame = fuselage.CFrame * CFrame.new(0, 0.4, 2.2)
    
    local tailH = Instance.new("Part")
    tailH.Name = "TailH"
    tailH.Shape = Enum.PartType.Block
    tailH.Size = Vector3.new(1.2, 0.06, 0.5)
    tailH.Color = bodyColor
    tailH.Material = Enum.Material.SmoothPlastic
    tailH.Anchored = true
    tailH.CanCollide = false
    tailH.CanQuery = false
    tailH.CanTouch = false
    tailH.CastShadow = true
    tailH.Massless = true
    tailH.Parent = model
    tailH.CFrame = fuselage.CFrame * CFrame.new(0, 0, 2.3)
    
    local engine = Instance.new("Part")
    engine.Name = "Engine"
    engine.Shape = Enum.PartType.Block
    engine.Size = Vector3.new(0.5, 0.5, 0.6)
    engine.Color = darkColor
    engine.Material = Enum.Material.Metal
    engine.Anchored = true
    engine.CanCollide = false
    engine.CanQuery = false
    engine.CanTouch = false
    engine.CastShadow = true
    engine.Massless = true
    engine.Parent = model
    engine.CFrame = fuselage.CFrame * CFrame.new(0, 0, 2.6)
    
    for i = 1, 4 do
        local cyl = Instance.new("Part")
        cyl.Name = "EngineCyl_" .. i
        cyl.Shape = Enum.PartType.Cylinder
        cyl.Size = Vector3.new(0.12, 0.3, 0.12)
        cyl.Color = metalColor
        cyl.Material = Enum.Material.Metal
        cyl.Anchored = true
        cyl.CanCollide = false
        cyl.CanQuery = false
        cyl.CanTouch = false
        cyl.CastShadow = true
        cyl.Massless = true
        cyl.Parent = model
        local angle = (i - 1) * math.pi / 2
        cyl.CFrame = engine.CFrame * CFrame.new(math.cos(angle) * 0.2, math.sin(angle) * 0.2, 0)
    end
    
    local prop = Instance.new("Part")
    prop.Name = "Propeller"
    prop.Shape = Enum.PartType.Block
    prop.Size = Vector3.new(0.1, 1.4, 0.15)
    prop.Color = propColor
    prop.Material = Enum.Material.Wood
    prop.Anchored = true
    prop.CanCollide = false
    prop.CanQuery = false
    prop.CanTouch = false
    prop.CastShadow = true
    prop.Massless = true
    prop.Parent = model
    prop.CFrame = engine.CFrame * CFrame.new(0, 0, 0.4)
    
    Shahed.droneProp = prop
    
    local hub = Instance.new("Part")
    hub.Name = "PropHub"
    hub.Shape = Enum.PartType.Ball
    hub.Size = Vector3.new(0.2, 0.2, 0.2)
    hub.Color = darkColor
    hub.Material = Enum.Material.Metal
    hub.Anchored = true
    hub.CanCollide = false
    hub.CanQuery = false
    hub.CanTouch = false
    hub.CastShadow = true
    hub.Massless = true
    hub.Parent = model
    hub.CFrame = engine.CFrame * CFrame.new(0, 0, 0.4)
    
    local sensor = Instance.new("Part")
    sensor.Name = "Sensor"
    sensor.Shape = Enum.PartType.Ball
    sensor.Size = Vector3.new(0.15, 0.15, 0.15)
    sensor.Color = Color3.fromRGB(20, 20, 20)
    sensor.Material = Enum.Material.SmoothPlastic
    sensor.Anchored = true
    sensor.CanCollide = false
    sensor.CanQuery = false
    sensor.CanTouch = false
    sensor.CastShadow = false
    sensor.Massless = true
    sensor.Parent = model
    sensor.CFrame = nose.CFrame * CFrame.new(0, -0.15, -0.3)
    
    local antenna = Instance.new("Part")
    antenna.Name = "Antenna"
    antenna.Shape = Enum.PartType.Cylinder
    antenna.Size = Vector3.new(0.04, 0.4, 0.04)
    antenna.Color = darkColor
    antenna.Material = Enum.Material.Metal
    antenna.Anchored = true
    antenna.CanCollide = false
    antenna.CanQuery = false
    antenna.CanTouch = false
    antenna.CastShadow = false
    antenna.Massless = true
    antenna.Parent = model
    antenna.CFrame = fuselage.CFrame * CFrame.new(0, 0.45, 1.5)
    
    Shahed.model = model
    return model
end

local function stopDrone()
    Shahed.active = false
    if Shahed.conn then
        Shahed.conn:Disconnect()
        Shahed.conn = nil
    end
    if Shahed.model and Shahed.model.Parent then
        Shahed.model:Destroy()
    end
    Shahed.model = nil
    Shahed.targetPlayer = nil
    if Shahed.originalChar and Shahed.originalCharParent then
        Shahed.originalChar.Parent = Shahed.originalCharParent
    end
    Shahed.originalChar = nil
    Shahed.originalCharParent = nil
end

local function startDrone(targetType)
    if Shahed.active then return end
    Shahed.active = true
    Shahed.originalChar = player.Character
    if Shahed.originalChar then
        Shahed.originalCharParent = Shahed.originalChar.Parent
        Shahed.originalChar.Parent = nil
    end
    
    local droneModel = createShahedModel()
    local startPos = Shahed.originalChar and Shahed.originalChar:FindFirstChild("HumanoidRootPart") and Shahed.originalChar.HumanoidRootPart.Position or Vector3.new(0, 50, 0)
    droneModel:SetPrimaryPartCFrame(CFrame.new(startPos))
    droneModel.Parent = Workspace
    
    local target = nil 
    local targetDist = math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local dist = (root.Position - startPos).Magnitude
                if dist < targetDist then
                    targetDist = dist
                    target = plr
                end
            end
        end
    end
    
    Shahed.targetPlayer = target
    Shahed.flyTime = 0
    
    Shahed.conn = RunService.Heartbeat:Connect(function(dt)
        if not Shahed.active or not droneModel or not droneModel.Parent then return end
        Shahed.flyTime = Shahed.flyTime + dt
        
        if Shahed.droneProp then
            Shahed.droneProp.CFrame = Shahed.droneProp.CFrame * CFrame.Angles(0, 0, dt * 30)
        end
        
        local root = droneModel:FindFirstChild("Fuselage")
        if root then
            local forward = root.CFrame.LookVector
            local speed = 40
            root.CFrame = root.CFrame + forward * speed * dt
            
            if Shahed.targetPlayer and Shahed.targetPlayer.Character then
                local targetRoot = Shahed.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local dist = (root.Position - targetRoot.Position).Magnitude
                    if dist < 3 then
                        local hum = Shahed.targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if hum then hum.Health = 0 end
                        stopDrone()
                    end
                end
            end
            
            if Shahed.flyTime > 30 then
                stopDrone()
            end
        end
    end)
end

-- ============================================================
-- EXPORT TO PART 2
-- ============================================================
getgenv().WannaCore = {
    State = State,
    Themes = Themes,
    ThemeOrder = ThemeOrder,
    player = player,
    camera = camera,
    addConnection = addConnection,
    getVisualColor = getVisualColor,
    playSound = playSound,
    SFX = SFX,
    FONT_BLACK = FONT_BLACK,
    FONT_REG = FONT_REG,
    FONT_BOLD = FONT_BOLD,
    applyFog = applyFog,
    applyFullbright = applyFullbright,
    applyWorld = applyWorld,
    applyChinaHat = applyChinaHat,
    applyWings = applyWings,
    applyKagune = applyKagune,
    applyCompanion = applyCompanion,
    toggleKorblox = toggleKorblox,
    toggleGhostLegs = toggleGhostLegs,
    ESP = ESP,
    applyESP = applyESP,
    updateESPColors = updateESPColors,
    destroyAllESP = destroyAllESP,
    CONFIG_FOLDER = CONFIG_FOLDER,
    safeWriteFile = safeWriteFile,
    safeReadFile = safeReadFile,
    hasFileAPI = hasFileAPI,
    Shahed = Shahed,
    startDrone = startDrone,
    stopDrone = stopDrone,
    createShahedModel = createShahedModel,
    IconEngine = IconEngine,
    ScriptUnloadedRef = function() return ScriptUnloaded end
}

print("wannacry client — Part 1 loaded successfully!")