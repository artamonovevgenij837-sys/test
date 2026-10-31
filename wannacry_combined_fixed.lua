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
    -- BasePart has no EmissiveColor/Emissivity properties.
    -- Use Neon when glow is requested, SmoothPlastic otherwise.
    part.Material = (intensity or 0) > 0 and Enum.Material.Neon or Enum.Material.SmoothPlastic
    part.Color = color
    part.Transparency = 0.1
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

-- ============================================================
-- PART 2: UI & FEATURES
-- Combined into a single execution
-- ============================================================
-- wannacry client v1.0 — Part 2 (UI & Features)
-- Requires Part 1 to be injected first!
-- Features: New Logo, SVG-like Icons, Ripple Click Effect, Search Cursor, MM2 Hub, Emotes

local Core = getgenv().WannaCore
if not Core then
    warn("[WANNA] Part 1 not loaded! Please inject Part 1 first.")
    return
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Core.player
local camera = Core.camera
local State = Core.State
local Themes = Core.Themes
local ThemeOrder = Core.ThemeOrder
local addConnection = Core.addConnection
local getVisualColor = Core.getVisualColor
local playSound = Core.playSound
local SFX = Core.SFX
local applyFog = Core.applyFog
local applyFullbright = Core.applyFullbright
local applyWorld = Core.applyWorld
local applyChinaHat = Core.applyChinaHat
local applyWings = Core.applyWings
local applyKagune = Core.applyKagune
local applyCompanion = Core.applyCompanion
local toggleKorblox = Core.toggleKorblox
local toggleGhostLegs = Core.toggleGhostLegs
local ESP = Core.ESP
local applyESP = Core.applyESP
local updateESPColors = Core.updateESPColors
local destroyAllESP = Core.destroyAllESP
local CONFIG_FOLDER = Core.CONFIG_FOLDER
local safeWriteFile = Core.safeWriteFile
local safeReadFile = Core.safeReadFile
local hasFileAPI = Core.hasFileAPI
local Shahed = Core.Shahed
local createShahedModel = Core.createShahedModel
local startDrone = Core.startDrone
local stopDrone = Core.stopDrone
local IconEngine = Core.IconEngine

local FONT_BLACK = Enum.Font.ArialBlack
local FONT_REG = Enum.Font.Arial
local FONT_BOLD = Enum.Font.ArialBold
local ScriptUnloaded = false

-- ==== RIPPLE EFFECT HELPER ====
local function createRippleEffect(parent, x, y)
    local ripple = Instance.new("Frame")
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, x, 0, y)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.BorderSizePixel = 0
    ripple.ZIndex = parent.ZIndex + 1
    ripple.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- Perfect circle
    corner.Parent = ripple
    
    -- Animate expansion and fade
    TweenService:Create(ripple, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 1.5, 0, math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 1.5),
        BackgroundTransparency = 1
    }):Play()
    
    task.delay(0.4, function()
        if ripple and ripple.Parent then
            ripple:Destroy()
        end
    end)
end

-- Attach ripple to any GuiObject on MouseButton1Down
local function attachRipple(guiObj)
    guiObj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local absPos = guiObj.AbsolutePosition
            local mouseLoc = UserInputService:GetMouseLocation()
            -- Calculate relative position within the object
            local relX = mouseLoc.X - absPos.X
            local relY = mouseLoc.Y - absPos.Y
            -- Clamp to bounds just in case
            relX = math.clamp(relX, 0, guiObj.AbsoluteSize.X)
            relY = math.clamp(relY, 0, guiObj.AbsoluteSize.Y)
            createRippleEffect(guiObj, relX, relY)
        end
    end)
end

-- ==== UI SETUP ====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WannaUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 100
screenGui.Parent = player:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local dimOverlay = Instance.new("Frame")
dimOverlay.Size = UDim2.new(1, 0, 1, 0)
dimOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dimOverlay.BackgroundTransparency = 1
dimOverlay.BorderSizePixel = 0
dimOverlay.Visible = false
dimOverlay.ZIndex = 5
dimOverlay.Active = false
dimOverlay.Parent = screenGui

-- Main Window Frame
local UI = {}
UI.main = Instance.new("Frame")
UI.main.Size = UDim2.new(0, 720, 0, 480)
UI.main.Position = UDim2.new(0.5, -360, 0.5, -240)
UI.main.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
UI.main.BackgroundTransparency = 0
UI.main.BorderSizePixel = 0
UI.main.Visible = false
UI.main.ZIndex = 10
UI.main.ClipsDescendants = true
UI.main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = UI.main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Transparency = 0.88
mainStroke.Thickness = 1.5
mainStroke.Parent = UI.main

-- Header Section
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundTransparency = 1
header.ZIndex = 11
header.Parent = UI.main

local hLine = Instance.new("Frame")
hLine.Size = UDim2.new(1, 0, 0, 1)
hLine.Position = UDim2.new(0, 0, 1, -1)
hLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hLine.BackgroundTransparency = 0.9
hLine.BorderSizePixel = 0
hLine.ZIndex = 11
hLine.Parent = header

-- NEW LOGO W
local wLogoContainer = Instance.new("Frame")
wLogoContainer.Size = UDim2.new(0, 50, 0, 40)
wLogoContainer.Position = UDim2.new(0, 24, 0, 7)
wLogoContainer.BackgroundTransparency = 1
wLogoContainer.ZIndex = 12
wLogoContainer.Parent = header

local wLogo = Instance.new("TextLabel")
wLogo.Text = "W"
wLogo.Font = FONT_BLACK
wLogo.TextSize = 32
wLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
wLogo.Size = UDim2.new(1, 0, 1, 0)
wLogo.BackgroundTransparency = 1
wLogo.ZIndex = 12
wLogo.Parent = wLogoContainer

local title = Instance.new("TextLabel")
title.Text = "WANNACRY"
title.Font = FONT_BLACK
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Size = UDim2.new(0, 140, 0, 28)
title.Position = UDim2.new(0, 80, 0, 13)
title.BackgroundTransparency = 1
title.ZIndex = 12
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Text = "CLIENT"
subtitle.Font = FONT_BLACK
subtitle.TextSize = 14
subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
subtitle.TextTransparency = 0.5
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Size = UDim2.new(0, 80, 0, 20)
subtitle.Position = UDim2.new(0, 225, 0, 17)
subtitle.BackgroundTransparency = 1
subtitle.ZIndex = 12
subtitle.Parent = header

-- Window Controls (Dots)
for i, op in ipairs({0.25, 0.25, 0.9}) do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 12, 0, 12)
    dot.Position = UDim2.new(1, -24 - (3 - i) * 24, 0, 21)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.BackgroundTransparency = 1 - op
    dot.BorderSizePixel = 0
    dot.ZIndex = 12
    dot.Parent = header
    local dc = Instance.new("UICorner")
    dc.CornerRadius = UDim.new(1, 0)
    dc.Parent = dot
end

-- Sidebar Container
UI.sidebar = Instance.new("Frame")
UI.sidebar.Size = UDim2.new(0, 170, 1, -18)
UI.sidebar.Position = UDim2.new(0, 18, 0, 72)
UI.sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UI.sidebar.BackgroundTransparency = 0.965
UI.sidebar.BorderSizePixel = 0
UI.sidebar.ZIndex = 11
UI.sidebar.Parent = UI.main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 12)
sideCorner.Parent = UI.sidebar

local sideStroke = Instance.new("UIStroke")
sideStroke.Color = Color3.fromRGB(255, 255, 255)
sideStroke.Transparency = 0.92
sideStroke.Thickness = 1
sideStroke.Parent = UI.sidebar

-- Tabs Configuration
local tabs = {"visuals", "themes", "places", "configs", "cosmetics"}
local tabLabels = {"Visuals", "Themes", "Places", "Configs", "Cosmetics"}
UI.tabButtons = {}
UI.tabFrames = {}

for i, name in ipairs(tabs) do
    -- Tab Button
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -28, 0, 46)
    btn.Position = UDim2.new(0, 14, 0, 12 + (i - 1) * 54)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 12
    btn.AutoButtonColor = false
    btn.Name = name .. "Btn"
    btn.Parent = UI.sidebar
    
    -- Attach Ripple Effect to Tab Button
    attachRipple(btn)
    
    -- Tab Background (for active state)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    bg.BackgroundTransparency = 1
    bg.BorderSizePixel = 0
    bg.ZIndex = 12
    bg.Parent = btn
    
    local bgc = Instance.new("UICorner")
    bgc.CornerRadius = UDim.new(0, 9)
    bgc.Parent = bg
    
    local bgs = Instance.new("UIStroke")
    bgs.Color = Color3.fromRGB(255, 255, 255)
    bgs.Transparency = 1
    bgs.Thickness = 1.2
    bgs.Parent = bg
    
    -- Icon Holder
    local iconHolder = Instance.new("Frame")
    iconHolder.Size = UDim2.new(0, 30, 0, 30)
    iconHolder.Position = UDim2.new(0, 8, 0.5, -15)
    iconHolder.BackgroundTransparency = 1
    iconHolder.ZIndex = 13
    iconHolder.Parent = bg
    
    -- Draw Procedural Icon based on new Engine
    local iconColor = Color3.fromRGB(255, 255, 255)
    if name == "visuals" then 
        IconEngine.createEye(iconHolder, iconColor)
    elseif name == "themes" then 
        IconEngine.createPalette(iconHolder, iconColor)
    elseif name == "places" then 
        IconEngine.createRobloxLogo(iconHolder, iconColor)
    elseif name == "configs" then 
        IconEngine.createSliders(iconHolder, iconColor)
    elseif name == "cosmetics" then 
        IconEngine.createStar(iconHolder, iconColor)
    end
    
    -- Tab Label
    local txt = Instance.new("TextLabel")
    txt.Text = tabLabels[i]
    txt.Font = FONT_REG
    txt.TextSize = 15
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.TextTransparency = 0.45
    txt.Size = UDim2.new(1, -40, 1, 0)
    txt.Position = UDim2.new(0, 46, 0, 0)
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.BackgroundTransparency = 1
    txt.ZIndex = 13
    txt.Parent = bg
    
    -- Active State Logic
    local function setActive(active)
        if active then
            bg.BackgroundTransparency = 0.86
            bgs.Transparency = 0.65
            txt.TextTransparency = 0
            txt.Font = FONT_BOLD
        else
            bg.BackgroundTransparency = 1
            bgs.Transparency = 1
            txt.TextTransparency = 0.45
            txt.Font = FONT_REG
        end
    end
    
    -- Tab Click Handler
    btn.MouseButton1Click:Connect(function()
        for j, tBtn in ipairs(UI.tabButtons) do
            tBtn.set(j == i)
            UI.tabFrames[j].Visible = (j == i)
        end
        playSound(SFX.On)
    end)
    
    UI.tabButtons[i] = {btn = btn, bg = bg, txt = txt, set = setActive}
    
    -- Content Frame for this Tab
    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, -220, 1, -18)
    frame.Position = UDim2.new(0, 202, 0, 72)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.Visible = (i == 1)
    frame.ZIndex = 11
    frame.Parent = UI.main
    
    local cp = Instance.new("UIPadding")
    cp.PaddingLeft = UDim.new(0, 24)
    cp.PaddingRight = UDim.new(0, 24)
    cp.PaddingTop = UDim.new(0, 20)
    cp.PaddingBottom = UDim.new(0, 20)
    cp.Parent = frame
    
    local layout = Instance.new("UIGridLayout")
    layout.CellSize = UDim2.new(0.48, 0, 0, 64)
    layout.CellPadding = UDim2.new(0.04, 0, 0, 16)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = frame
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 40)
    end)
    
    UI.tabFrames[i] = frame
end

-- Set Visuals as default active tab
UI.tabButtons[1].set(true)

-- ==== SEARCH BAR SYSTEM ====
local searchBarContainer = Instance.new("Frame")
searchBarContainer.Size = UDim2.new(1, -24, 0, 40)
searchBarContainer.Position = UDim2.new(0, 12, 0, 12)
searchBarContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
searchBarContainer.BorderSizePixel = 0
searchBarContainer.ZIndex = 12
searchBarContainer.Parent = UI.main

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 8)
sbCorner.Parent = searchBarContainer

local sbStroke = Instance.new("UIStroke")
sbStroke.Color = Color3.fromRGB(255, 255, 255)
sbStroke.Transparency = 0.9
sbStroke.Thickness = 1
sbStroke.Parent = searchBarContainer

-- Search Icon (Magnifying Glass)
local searchIconHolder = Instance.new("Frame")
searchIconHolder.Size = UDim2.new(0, 20, 0, 20)
searchIconHolder.Position = UDim2.new(0, 10, 0.5, -10)
searchIconHolder.BackgroundTransparency = 1
searchIconHolder.ZIndex = 13
searchIconHolder.Parent = searchBarContainer

local glassCircle = Instance.new("Frame")
glassCircle.Size = UDim2.new(0, 10, 0, 10)
glassCircle.Position = UDim2.new(0, 2, 0, 2)
glassCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
glassCircle.BackgroundTransparency = 1
glassCircle.BorderSizePixel = 0
glassCircle.ZIndex = 13
glassCircle.Parent = searchIconHolder

local gcCorner = Instance.new("UICorner")
gcCorner.CornerRadius = UDim.new(1, 0)
gcCorner.Parent = glassCircle

local gcStroke = Instance.new("UIStroke")
gcStroke.Color = Color3.fromRGB(255, 255, 255)
gcStroke.Transparency = 0.5
gcStroke.Thickness = 1.5
gcStroke.Parent = glassCircle

local glassHandle = Instance.new("Frame")
glassHandle.Size = UDim2.new(0, 6, 0, 2)
glassHandle.Position = UDim2.new(0, 10, 0, 10)
glassHandle.Rotation = 45
glassHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glassHandle.BackgroundTransparency = 0.5
glassHandle.BorderSizePixel = 0
glassHandle.ZIndex = 13
glassHandle.Parent = searchIconHolder

-- Search Input Field
local searchInput = Instance.new("TextBox")
searchInput.Size = UDim2.new(1, -40, 1, 0)
searchInput.Position = UDim2.new(0, 35, 0, 0)
searchInput.BackgroundTransparency = 1
searchInput.Font = FONT_REG
searchInput.TextSize = 14
searchInput.TextColor3 = Color3.fromRGB(255, 255, 255)
searchInput.PlaceholderText = "Search features..."
searchInput.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
searchInput.PlaceholderTextTransparency = 0.6
searchInput.Text = ""
searchInput.ClearTextOnFocus = false
searchInput.ZIndex = 13
searchInput.Parent = searchBarContainer

-- Animated Cursor
local cursor = Instance.new("Frame")
cursor.Size = UDim2.new(0, 1, 0, 16)
cursor.Position = UDim2.new(0, 35, 0.5, -8)
cursor.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
cursor.BorderSizePixel = 0
cursor.Visible = false
cursor.ZIndex = 14
cursor.Parent = searchBarContainer

local cursorConn
cursorConn = RunService.RenderStepped:Connect(function()
    if not searchInput.Focused and searchInput.Text == "" then
        cursor.Visible = false
    else
        cursor.Visible = true
        local blink = math.abs(math.sin(tick() * 3))
        cursor.BackgroundTransparency = blink * 0.5
    end
end)

-- Card Registry for Search Filtering
local allCards = {}
local function filterCards(query)
    query = query:lower()
    for _, cardData in ipairs(allCards) do
        local matches = true
        if query ~= "" then
            local textMatch = cardData.title:lower():find(query, 1, true)
            local descMatch = cardData.desc and cardData.desc:lower():find(query, 1, true)
            if not textMatch and not descMatch then
                matches = false
            end
        end
        if matches then
            if not cardData.instance.Visible then
                cardData.instance.Visible = true
                TweenService:Create(cardData.instance, TweenInfo.new(0.2), {BackgroundTransparency = 0.96}):Play()
            end
        else
            if cardData.instance.Visible then
                TweenService:Create(cardData.instance, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                task.delay(0.2, function()
                    if not cardData.instance.Visible then 
                        cardData.instance.Visible = false 
                    end
                end)
            end
        end
    end
end

searchInput:GetPropertyChangedSignal("Text"):Connect(function()
    filterCards(searchInput.Text)
end)

-- ==== CARD CREATOR WITH CHECKBOX & RIPPLE ====
local function createCard(title, desc, stateKey, lmb, rmb, parent)
    local c = Instance.new("TextButton")
    c.Size = UDim2.new(0.48, 0, 0, 64)
    c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    c.BackgroundTransparency = 0.96
    c.BorderSizePixel = 0
    c.Text = ""
    c.AutoButtonColor = false
    c.ZIndex = 12
    c.Parent = parent
    c:SetAttribute("Active", false)
    
    -- Attach Ripple Effect to Card
    attachRipple(c)
    
    local co = Instance.new("UICorner")
    co.CornerRadius = UDim.new(0, 10)
    co.Parent = c
    
    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(255, 255, 255)
    st.Transparency = 0.91
    st.Thickness = 1
    st.Parent = c
    
    local tl = Instance.new("TextLabel")
    tl.Text = title
    tl.Font = FONT_BOLD
    tl.TextSize = 13
    tl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tl.TextTransparency = 0.5
    tl.Size = UDim2.new(1, -40, 0, 20)
    tl.Position = UDim2.new(0, 18, 0, 14)
    tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.BackgroundTransparency = 1
    tl.ZIndex = 13
    tl.Parent = c
    
    local dl = Instance.new("TextLabel")
    dl.Text = desc
    dl.Font = FONT_REG
    dl.TextSize = 10
    dl.TextColor3 = Color3.fromRGB(255, 255, 255)
    dl.TextTransparency = 0.7
    dl.Size = UDim2.new(1, -40, 0, 30)
    dl.Position = UDim2.new(0, 18, 0, 34)
    dl.TextXAlignment = Enum.TextXAlignment.Left
    dl.TextYAlignment = Enum.TextYAlignment.Top
    dl.TextWrapped = true
    dl.BackgroundTransparency = 1
    dl.ZIndex = 13
    dl.Parent = c
    
    -- Checkbox Element
    local checkBox = Instance.new("Frame")
    checkBox.Size = UDim2.new(0, 20, 0, 20)
    checkBox.Position = UDim2.new(1, -30, 0.5, -10)
    checkBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    checkBox.BackgroundTransparency = 1
    checkBox.BorderSizePixel = 0
    checkBox.ZIndex = 13
    checkBox.Parent = c
    
    local cbBorder = Instance.new("UIStroke")
    cbBorder.Color = Color3.fromRGB(255, 255, 255)
    cbBorder.Transparency = 0.7
    cbBorder.Thickness = 1.5
    cbBorder.Parent = checkBox
    
    local checkMark = Instance.new("TextLabel")
    checkMark.Text = "✓"
    checkMark.Font = FONT_BLACK
    checkMark.TextSize = 16
    checkMark.TextColor3 = Color3.fromRGB(0, 255, 204)
    checkMark.Size = UDim2.new(1, 0, 1, 0)
    checkMark.BackgroundTransparency = 1
    checkMark.Visible = false
    checkMark.ZIndex = 14
    checkMark.Parent = checkBox
    
    -- Click Handler
    addConnection(c.MouseButton1Click:Connect(function()
        if ScriptUnloaded then return end
        local isActive = c:GetAttribute("Active") == true
        c:SetAttribute("Active", not isActive)
        if not isActive then
            playSound(SFX.On)
            checkMark.Visible = true
            cbBorder.Color = Color3.fromRGB(0, 255, 204)
            cbBorder.Transparency = 0
        else
            playSound(SFX.Off)
            checkMark.Visible = false
            cbBorder.Color = Color3.fromRGB(255, 255, 255)
            cbBorder.Transparency = 0.7
        end
        if lmb then lmb(not isActive) end
    end))
    
    -- Right Click Handler
    if rmb then
        addConnection(c.MouseButton2Click:Connect(function()
            if ScriptUnloaded then return end
            rmb()
        end))
    end
    
    -- Register for search filtering
    table.insert(allCards, {instance = c, title = title, desc = desc})
    return c
end

-- ==== SETTINGS WINDOWS SYSTEM ====
local WINS = {}
local function closeAllSettings()
    for _, w in pairs(WINS) do
        if w.frame then w.frame.Visible = false end
    end
    State.OpenSettings = nil
    UI.main.Visible = true
    TweenService:Create(dimOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    task.delay(0.35, function()
        if not State.OpenSettings and not State.MenuOpen then
            dimOverlay.Visible = false
        end
    end)
end

local function createSettingsWindow(name, title, size)
    local W = {}
    W.frame = Instance.new("Frame")
    W.frame.Size = UDim2.new(0, size.X, 0, size.Y)
    W.frame.Position = UDim2.new(0.5, -size.X / 2, 0.5, -size.Y / 2)
    W.frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    W.frame.BackgroundTransparency = 0.05
    W.frame.BorderSizePixel = 0
    W.frame.Visible = false
    W.frame.ZIndex = 600
    W.frame.Parent = screenGui
    
    local wc = Instance.new("UICorner")
    wc.CornerRadius = UDim.new(0, 18)
    wc.Parent = W.frame
    
    local ws = Instance.new("UIStroke")
    ws.Color = Color3.fromRGB(255, 255, 255)
    ws.Transparency = 0.88
    ws.Thickness = 1.5
    ws.Parent = W.frame
    
    -- Settings Header
    local hdr = Instance.new("Frame")
    hdr.Size = UDim2.new(1, 0, 0, 54)
    hdr.BackgroundTransparency = 1
    hdr.ZIndex = 601
    hdr.Parent = W.frame
    
    local hl = Instance.new("Frame")
    hl.Size = UDim2.new(1, 0, 0, 1)
    hl.Position = UDim2.new(0, 0, 1, -1)
    hl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hl.BackgroundTransparency = 0.9
    hl.BorderSizePixel = 0
    hl.ZIndex = 601
    hl.Parent = hdr
    
    local tl = Instance.new("TextLabel")
    tl.Text = title
    tl.Font = FONT_BLACK
    tl.TextSize = 18
    tl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tl.Size = UDim2.new(1, -60, 1, 0)
    tl.Position = UDim2.new(0, 24, 0, 0)
    tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.BackgroundTransparency = 1
    tl.ZIndex = 602
    tl.Parent = hdr
    
    -- Close Button
    local cb = Instance.new("TextButton")
    cb.Text = "×"
    cb.Font = FONT_REG
    cb.TextSize = 24
    cb.TextColor3 = Color3.fromRGB(255, 255, 255)
    cb.TextTransparency = 0.4
    cb.Size = UDim2.new(0, 32, 0, 32)
    cb.Position = UDim2.new(1, -42, 0.5, -16)
    cb.BackgroundTransparency = 1
    cb.ZIndex = 602
    cb.Parent = hdr
    
    addConnection(cb.MouseButton1Click:Connect(function()
        closeAllSettings()
    end))
    
    -- Draggable Logic
    local dragging, dragStart, startPos = false, nil, nil
    hdr.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = W.frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            W.frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    WINS[name] = W
    return W
end

-- Slider Helper
local function makeSlider(parent, label, minV, maxV, initV, yPos, cb)
    local lbl = Instance.new("TextLabel")
    lbl.Text = label
    lbl.Font = FONT_REG
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextTransparency = 0.5
    lbl.Size = UDim2.new(1, -44, 0, 22)
    lbl.Position = UDim2.new(0, 24, 0, yPos)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.ZIndex = 602
    lbl.Parent = parent
    
    local valLbl = Instance.new("TextLabel")
    valLbl.Text = string.format("%.2f", initV)
    valLbl.Font = FONT_REG
    valLbl.TextSize = 13
    valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLbl.TextTransparency = 0.7
    valLbl.Size = UDim2.new(0, 60, 0, 22)
    valLbl.Position = UDim2.new(1, -85, 0, yPos)
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.BackgroundTransparency = 1
    valLbl.ZIndex = 602
    valLbl.Parent = parent
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.9, 0, 0, 6)
    bg.Position = UDim2.new(0.05, 0, 0, yPos + 28)
    bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    bg.BackgroundTransparency = 0.88
    bg.BorderSizePixel = 0
    bg.ZIndex = 602
    bg.Parent = parent
    
    local bgc = Instance.new("UICorner")
    bgc.CornerRadius = UDim.new(1, 0)
    bgc.Parent = bg
    
    local fill = Instance.new("Frame")
    local ratio = (initV - minV) / (maxV - minV)
    fill.Size = UDim2.new(ratio, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.BorderSizePixel = 0
    fill.ZIndex = 603
    fill.Parent = bg
    
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1, 0)
    fc.Parent = fill
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(ratio, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 604
    knob.Parent = bg
    
    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob
    
    local dragging = false
    local function update()
        if ScriptUnloaded then return end
        local mx = UserInputService:GetMouseLocation().X
        local ax = bg.AbsolutePosition.X
        local w = bg.AbsoluteSize.X
        local r = math.clamp((mx - ax) / w, 0, 1)
        fill.Size = UDim2.new(r, 0, 1, 0)
        knob.Position = UDim2.new(r, -7, 0.5, -7)
        local v = minV + (maxV - minV) * r
        valLbl.Text = string.format("%.2f", v)
        cb(v)
    end
    
    addConnection(bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update()
        end
    end))
    
    addConnection(UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update()
        end
    end))
    
    addConnection(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end))
end

-- Create Settings Windows
do
    local fogW = createSettingsWindow("Fog", "FOG SETTINGS", Vector2.new(380, 300))
    makeSlider(fogW.frame, "Density", 0, 1, State.FogSettings.Density, 60, function(v)
        State.FogSettings.Density = v
        applyFog()
    end)
    makeSlider(fogW.frame, "Offset", -1, 1, State.FogSettings.Offset, 120, function(v)
        State.FogSettings.Offset = v
        applyFog()
    end)
    
    local fbW = createSettingsWindow("Fullbright", "FULLBRIGHT", Vector2.new(380, 170))
    makeSlider(fbW.frame, "Brightness", 1, 10, State.FullbrightBrightness, 60, function(v) 
        State.FullbrightBrightness = v
        if State.FullbrightEnabled then applyFullbright() end 
    end)
    
    local mbW = createSettingsWindow("MotionBlur", "MOTION BLUR", Vector2.new(380, 170))
    makeSlider(mbW.frame, "Strength", 0, 56, State.MotionBlurStrength, 60, function(v) 
        State.MotionBlurStrength = v 
    end)
    
    local worldW = createSettingsWindow("World", "WORLD COLOR", Vector2.new(380, 300))
    makeSlider(worldW.frame, "Saturation", -1, 1, State.WorldSettings.Saturation, 60, function(v) 
        State.WorldSettings.Saturation = v
        applyWorld() 
    end)
    makeSlider(worldW.frame, "Contrast", -1, 1, State.WorldSettings.Contrast, 120, function(v) 
        State.WorldSettings.Contrast = v
        applyWorld() 
    end)
end

local openSettings = function(name)
    for _, w in pairs(WINS) do
        if w.frame then w.frame.Visible = false end
    end
    if WINS[name] then
        UI.main.Visible = false
        WINS[name].frame.Visible = true
        local sizes = {
            Fog = Vector2.new(380, 300),
            Fullbright = Vector2.new(380, 170),
            MotionBlur = Vector2.new(380, 170),
            World = Vector2.new(380, 300)
        }
        local ts = sizes[name] or Vector2.new(380, 170)
        WINS[name].frame.Size = UDim2.new(0, 0, 0, 0)
        WINS[name].frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(WINS[name].frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, ts.X, 0, ts.Y),
            Position = UDim2.new(0.5, -ts.X / 2, 0.5, -ts.Y / 2)
        }):Play()
        State.OpenSettings = name
        dimOverlay.Visible = true
        dimOverlay.BackgroundTransparency = 1
        TweenService:Create(dimOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.6}):Play()
    end
end

-- ==== POPULATE VISUALS TAB ====
createCard("Fog", "Atmospheric fog effect.", "FogEnabled", function(a) applyFog() end, function() openSettings("Fog") end, UI.tabFrames[1])
createCard("Aspect", "Screen stretching.", "AspectEnabled", nil, nil, UI.tabFrames[1])
createCard("Fullbright", "Maximum brightness.", "FullbrightEnabled", function(a) applyFullbright() end, function() openSettings("Fullbright") end, UI.tabFrames[1])
createCard("Motion Blur", "Blur on movement.", "MotionBlurEnabled", nil, function() openSettings("MotionBlur") end, UI.tabFrames[1])
createCard("World", "Color correction.", "WorldEnabled", function(a) applyWorld() end, function() openSettings("World") end, UI.tabFrames[1])
createCard("ESP 2D", "Box, Name & Distance.", "ESPEnabled", function(a) applyESP() end, nil, UI.tabFrames[1])

-- ==== POPULATE THEMES TAB ====
local themeFrame = UI.tabFrames[2]
themeFrame:FindFirstChildOfClass("UIGridLayout").CellSize = UDim2.new(0.31, 0, 0, 50)
for i, tName in ipairs(ThemeOrder) do
    local th = Themes[tName]
    local c = Instance.new("TextButton")
    c.Size = UDim2.new(0.31, 0, 0, 50)
    c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    c.BackgroundTransparency = 0.96
    c.BorderSizePixel = 0
    c.Text = ""
    c.AutoButtonColor = false
    c.ZIndex = 12
    c.Parent = themeFrame
    attachRipple(c)
    
    local co = Instance.new("UICorner")
    co.CornerRadius = UDim.new(0, 10)
    co.Parent = c
    
    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(255, 255, 255)
    st.Transparency = 0.91
    st.Thickness = 1
    st.Parent = c
    
    local tl = Instance.new("TextLabel")
    tl.Text = tName
    tl.Font = FONT_REG
    tl.TextSize = 12
    tl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tl.TextTransparency = 0.5
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.ZIndex = 13
    tl.Parent = c
    
    addConnection(c.MouseButton1Click:Connect(function()
        State.CurrentTheme = tName
        playSound(SFX.On)
    end))
end

-- ==== PLACES TAB ====
local placesFrame = UI.tabFrames[3]
if placesFrame then
    local oldLayout = placesFrame:FindFirstChildOfClass("UIGridLayout")
    if oldLayout then oldLayout:Destroy() end
    
    local placesList = Instance.new("UIListLayout")
    placesList.Padding = UDim.new(0, 16)
    placesList.SortOrder = Enum.SortOrder.LayoutOrder
    placesList.Parent = placesFrame
    
    local placesTitle = Instance.new("TextLabel")
    placesTitle.Text = "SELECT GAME"
    placesTitle.Font = FONT_BLACK
    placesTitle.TextSize = 18
    placesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    placesTitle.Size = UDim2.new(1, 0, 0, 30)
    placesTitle.BackgroundTransparency = 1
    placesTitle.ZIndex = 12
    placesTitle.Parent = placesFrame
    
    -- MM2 Card
    local mm2Card = Instance.new("TextButton")
    mm2Card.Size = UDim2.new(1, 0, 0, 80)
    mm2Card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mm2Card.BackgroundTransparency = 0.96
    mm2Card.BorderSizePixel = 0
    mm2Card.Text = ""
    mm2Card.AutoButtonColor = false
    mm2Card.LayoutOrder = 1
    mm2Card.ZIndex = 12
    mm2Card.Parent = placesFrame
    attachRipple(mm2Card)
    
    local mm2c = Instance.new("UICorner")
    mm2c.CornerRadius = UDim.new(0, 12)
    mm2c.Parent = mm2Card
    
    local mm2s = Instance.new("UIStroke")
    mm2s.Color = Color3.fromRGB(255, 255, 255)
    mm2s.Transparency = 0.91
    mm2s.Thickness = 1
    mm2s.Parent = mm2Card
    
    local mm2Title = Instance.new("TextLabel")
    mm2Title.Text = "Murder Mystery 2"
    mm2Title.Font = FONT_BOLD
    mm2Title.TextSize = 16
    mm2Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    mm2Title.TextTransparency = 0.3
    mm2Title.Size = UDim2.new(1, -40, 0, 24)
    mm2Title.Position = UDim2.new(0, 20, 0, 16)
    mm2Title.TextXAlignment = Enum.TextXAlignment.Left
    mm2Title.BackgroundTransparency = 1
    mm2Title.ZIndex = 13
    mm2Title.Parent = mm2Card
    
    local mm2Desc = Instance.new("TextLabel")
    mm2Desc.Text = "AutoFarm, Drones, Skin Changer"
    mm2Desc.Font = FONT_REG
    mm2Desc.TextSize = 12
    mm2Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    mm2Desc.TextTransparency = 0.6
    mm2Desc.Size = UDim2.new(1, -40, 0, 20)
    mm2Desc.Position = UDim2.new(0, 20, 0, 44)
    mm2Desc.TextXAlignment = Enum.TextXAlignment.Left
    mm2Desc.BackgroundTransparency = 1
    mm2Desc.ZIndex = 13
    mm2Desc.Parent = mm2Card
    
    local mm2Arrow = Instance.new("TextLabel")
    mm2Arrow.Text = "→"
    mm2Arrow.Font = FONT_BLACK
    mm2Arrow.TextSize = 24
    mm2Arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    mm2Arrow.TextTransparency = 0.5
    mm2Arrow.Size = UDim2.new(0, 30, 1, 0)
    mm2Arrow.Position = UDim2.new(1, -40, 0, 0)
    mm2Arrow.BackgroundTransparency = 1
    mm2Arrow.ZIndex = 13
    mm2Arrow.Parent = mm2Card
    
    -- Define openMM2Menu BEFORE connecting click
    local mm2Menu = {}
    mm2Menu.frame = Instance.new("Frame")
    mm2Menu.frame.Size = UDim2.new(0, 720, 0, 480)
    mm2Menu.frame.Position = UDim2.new(0.5, -360, 0.5, -240)
    mm2Menu.frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    mm2Menu.frame.BackgroundTransparency = 0
    mm2Menu.frame.BorderSizePixel = 0
    mm2Menu.frame.Visible = false
    mm2Menu.frame.ZIndex = 10
    mm2Menu.frame.ClipsDescendants = true
    mm2Menu.frame.Parent = screenGui
    
    local mm2Corner = Instance.new("UICorner")
    mm2Corner.CornerRadius = UDim.new(0, 18)
    mm2Corner.Parent = mm2Menu.frame
    
    local mm2Stroke = Instance.new("UIStroke")
    mm2Stroke.Color = Color3.fromRGB(255, 255, 255)
    mm2Stroke.Transparency = 0.88
    mm2Stroke.Thickness = 1.5
    mm2Stroke.Parent = mm2Menu.frame
    
    -- MM2 Header
    local mm2Header = Instance.new("Frame")
    mm2Header.Size = UDim2.new(1, 0, 0, 54)
    mm2Header.BackgroundTransparency = 1
    mm2Header.ZIndex = 11
    mm2Header.Parent = mm2Menu.frame
    
    local mm2HLine = Instance.new("Frame")
    mm2HLine.Size = UDim2.new(1, 0, 0, 1)
    mm2HLine.Position = UDim2.new(0, 0, 1, -1)
    mm2HLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mm2HLine.BackgroundTransparency = 0.9
    mm2HLine.BorderSizePixel = 0
    mm2HLine.ZIndex = 11
    mm2HLine.Parent = mm2Header
    
    local mm2WLogo = Instance.new("TextLabel")
    mm2WLogo.Text = "W"
    mm2WLogo.Font = FONT_BLACK
    mm2WLogo.TextSize = 24
    mm2WLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
    mm2WLogo.Size = UDim2.new(0, 40, 0, 40)
    mm2WLogo.Position = UDim2.new(0, 24, 0, 7)
    mm2WLogo.BackgroundTransparency = 1
    mm2WLogo.ZIndex = 12
    mm2WLogo.Parent = mm2Header
    
    local mm2TitleLbl = Instance.new("TextLabel")
    mm2TitleLbl.Text = "wannacry"
    mm2TitleLbl.Font = FONT_BLACK
    mm2TitleLbl.TextSize = 16
    mm2TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    mm2TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    mm2TitleLbl.Size = UDim2.new(0, 100, 0, 28)
    mm2TitleLbl.Position = UDim2.new(0, 72, 0, 15)
    mm2TitleLbl.BackgroundTransparency = 1
    mm2TitleLbl.ZIndex = 12
    mm2TitleLbl.Parent = mm2Header
    
    local mm2Subtitle = Instance.new("TextLabel")
    mm2Subtitle.Text = "MM2"
    mm2Subtitle.Font = FONT_REG
    mm2Subtitle.TextSize = 13
    mm2Subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    mm2Subtitle.TextTransparency = 0.55
    mm2Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    mm2Subtitle.Size = UDim2.new(0, 60, 0, 20)
    mm2Subtitle.Position = UDim2.new(0, 176, 0, 15)
    mm2Subtitle.BackgroundTransparency = 1
    mm2Subtitle.ZIndex = 12
    mm2Subtitle.Parent = mm2Header
    
    -- Back Button
    local backBtn = Instance.new("TextButton")
    backBtn.Text = "←"
    backBtn.Font = FONT_BLACK
    backBtn.TextSize = 20
    backBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    backBtn.TextTransparency = 0.4
    backBtn.Size = UDim2.new(0, 40, 0, 40)
    backBtn.Position = UDim2.new(1, -50, 0, 7)
    backBtn.BackgroundTransparency = 1
    backBtn.ZIndex = 12
    backBtn.Parent = mm2Header
    attachRipple(backBtn)
    
    backBtn.MouseButton1Click:Connect(function()
        playSound(SFX.Off)
        mm2Menu.frame.Visible = false
        UI.main.Visible = true
    end)
    
    -- MM2 Sidebar
    mm2Menu.sidebar = Instance.new("Frame")
    mm2Menu.sidebar.Size = UDim2.new(0, 170, 1, -18)
    mm2Menu.sidebar.Position = UDim2.new(0, 18, 0, 72)
    mm2Menu.sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mm2Menu.sidebar.BackgroundTransparency = 0.965
    mm2Menu.sidebar.BorderSizePixel = 0
    mm2Menu.sidebar.ZIndex = 11
    mm2Menu.sidebar.Parent = mm2Menu.frame
    
    local mm2SideCorner = Instance.new("UICorner")
    mm2SideCorner.CornerRadius = UDim.new(0, 12)
    mm2SideCorner.Parent = mm2Menu.sidebar
    
    local mm2SideStroke = Instance.new("UIStroke")
    mm2SideStroke.Color = Color3.fromRGB(255, 255, 255)
    mm2SideStroke.Transparency = 0.92
    mm2SideStroke.Thickness = 1
    mm2SideStroke.Parent = mm2Menu.sidebar
    
    -- MM2 Tabs
    local mm2Tabs = {"autofarm", "drones"}
    local mm2TabLabels = {"AutoFarm", "Drones"}
    mm2Menu.tabButtons = {}
    mm2Menu.tabFrames = {}
    
    for i, name in ipairs(mm2Tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -28, 0, 46)
        btn.Position = UDim2.new(0, 14, 0, 12 + (i - 1) * 54)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.ZIndex = 12
        btn.AutoButtonColor = false
        btn.Name = name .. "Btn"
        btn.Parent = mm2Menu.sidebar
        attachRipple(btn)
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bg.BackgroundTransparency = 1
        bg.BorderSizePixel = 0
        bg.ZIndex = 12
        bg.Parent = btn
        
        local bgc = Instance.new("UICorner")
        bgc.CornerRadius = UDim.new(0, 9)
        bgc.Parent = bg
        
        local bgs = Instance.new("UIStroke")
        bgs.Color = Color3.fromRGB(255, 255, 255)
        bgs.Transparency = 1
        bgs.Thickness = 1.2
        bgs.Parent = bg
        
        local txt = Instance.new("TextLabel")
        txt.Text = mm2TabLabels[i]
        txt.Font = FONT_REG
        txt.TextSize = 15
        txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        txt.TextTransparency = 0.45
        txt.Size = UDim2.new(1, -20, 1, 0)
        txt.Position = UDim2.new(0, 46, 0, 0)
        txt.TextXAlignment = Enum.TextXAlignment.Left
        txt.BackgroundTransparency = 1
        txt.ZIndex = 13
        txt.Parent = bg
        
        local function setActive(active)
            if active then
                bg.BackgroundTransparency = 0.86
                bgs.Transparency = 0.65
                txt.TextTransparency = 0
                txt.Font = FONT_BOLD
            else
                bg.BackgroundTransparency = 1
                bgs.Transparency = 1
                txt.TextTransparency = 0.45
                txt.Font = FONT_REG
            end
        end
        
        btn.MouseButton1Click:Connect(function()
            for j, tBtn in ipairs(mm2Menu.tabButtons) do
                tBtn.set(j == i)
                mm2Menu.tabFrames[j].Visible = (j == i)
            end
            playSound(SFX.On)
        end)
        
        mm2Menu.tabButtons[i] = {btn = btn, bg = bg, txt = txt, set = setActive}
        
        local frame = Instance.new("ScrollingFrame")
        frame.Size = UDim2.new(1, -220, 1, -18)
        frame.Position = UDim2.new(0, 202, 0, 72)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.ScrollBarThickness = 4
        frame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
        frame.CanvasSize = UDim2.new(0, 0, 0, 0)
        frame.Visible = (i == 1)
        frame.ZIndex = 11
        frame.Parent = mm2Menu.frame
        
        local cp = Instance.new("UIPadding")
        cp.PaddingLeft = UDim.new(0, 24)
        cp.PaddingRight = UDim.new(0, 24)
        cp.PaddingTop = UDim.new(0, 20)
        cp.PaddingBottom = UDim.new(0, 20)
        cp.Parent = frame
        
        local layout = Instance.new("UIGridLayout")
        layout.CellSize = UDim2.new(0.48, 0, 0, 64)
        layout.CellPadding = UDim2.new(0.04, 0, 0, 16)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = frame
        
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 40)
        end)
        
        mm2Menu.tabFrames[i] = frame
    end
    
    mm2Menu.tabButtons[1].set(true)
    
    function openMM2Menu()
        UI.main.Visible = false
        mm2Menu.frame.Visible = true
    end
    
    -- Connect the click event AFTER defining openMM2Menu
    mm2Card.MouseButton1Click:Connect(function()
        playSound(SFX.On)
        openMM2Menu()
    end)
    
    -- ==== MM2 AUTOFARM LOGIC ====
    local MM2 = {}
    MM2.conn = nil
    MM2.running = false
    MM2.busy = false
    MM2.cachedCoins = {}
    MM2.cacheRefresh = 0
    MM2.targetCoin = nil
    MM2.touchedCoins = setmetatable({}, {__mode = "k"})
    
    local COIN_SCAN_INTERVAL = 0.5
    local SEARCH_RADIUS = 2000
    local OVERLAP_RADIUS = 6
    local TWEEN_WALKSPEED = 25
    
    local function getMainGui()
        local pg = player:FindFirstChild("PlayerGui")
        if not pg then return nil end
        return pg:FindFirstChild("MainGUI")
    end
    
    local function isBagFull()
        local gui = getMainGui()
        if not gui then return false end
        local game_ = gui:FindFirstChild("Game")
        if not game_ then return false end
        local coinBags = game_:FindFirstChild("CoinBags")
        if not coinBags then return false end
        local container = coinBags:FindFirstChild("Container")
        if not container then return false end
        local token = container:FindFirstChild("SnowToken") or container:FindFirstChildWhichIsA("Frame")
        if not token then return false end
        local fullIcon = token:FindFirstChild("FullBagIcon")
        if fullIcon and fullIcon.Visible then return true end
        return false
    end
    
    local function getMap()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name == "Base" then
                return v.Parent
            end
        end
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "Spawns" and v.Parent and v.Parent.Name ~= "Lobby" then
                return v.Parent
            end
        end
        return nil
    end
    
    local function isInGame()
        local gui = getMainGui()
        if gui then
            local game_ = gui:FindFirstChild("Game")
            if game_ then
                local timer = game_:FindFirstChild("Timer")
                if timer and timer.Visible then return true end
            end
        end
        if getMap() then return true end
        return false
    end
    
    local function getCoinContainer()
        local map = getMap()
        if map then
            local cc = map:FindFirstChild("CoinContainer")
            if cc then return cc end
        end
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "CoinContainer" then return v end
        end
        return nil
    end
    
    local function collectCoin(coin)
        if not coin then return false end
        if MM2.touchedCoins[coin] then return false end
        MM2.touchedCoins[coin] = true
        if MM2.targetCoin == coin then MM2.targetCoin = nil end
        State.AutoMonetStats = (State.AutoMonetStats or 0) + 1
    end
    
    local function scanCoins(playerPos)
        table.clear(MM2.cachedCoins)
        local container = getCoinContainer()
        if not container then return end
        
        local px, pz = playerPos.X, playerPos.Z
        local radiusSq = SEARCH_RADIUS * SEARCH_RADIUS
        local seen = {}
        
        for _, desc in ipairs(container:GetDescendants()) do 
            if desc:IsA("TouchTransmitter") then 
                local coin = desc.Parent
                if coin and coin:IsA("BasePart") and not MM2.touchedCoins[coin] then 
                    seen[coin] = true
                    local cp = coin.Position
                    local dx, dz = cp.X - px, cp.Z - pz
                    local dSq = dx * dx + dz * dz
                    if dSq <= radiusSq then
                        table.insert(MM2.cachedCoins, {part = coin, pos = cp, distSq = dSq})
                    end
                end 
            end 
        end
        
        table.sort(MM2.cachedCoins, function(a, b) return a.distSq < b.distSq end)
        MM2.cacheRefresh = tick() 
    end
    
    local function moveToSmooth(targetPos, speed)
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local startPos = root.Position
        local totalDist = (targetPos - startPos).Magnitude
        if totalDist < 0.1 then return end
        
        local startTime = tick()
        local estimatedDuration = math.max(totalDist / speed, 0.3)
        local done = false
        local conn
        
        conn = RunService.Heartbeat:Connect(function(dt) 
            if done then return end
            if ScriptUnloaded or not MM2.running or not State.AutoMonetEnabled then
                done = true
                if conn then conn:Disconnect() end
                return
            end
            if not root.Parent then
                done = true
                if conn then conn:Disconnect() end
                return
            end
            
            local elapsed = tick() - startTime
            local alpha = math.min(elapsed / estimatedDuration, 1)
            local smooth = alpha * alpha * (3 - 2 * alpha)
            local newPos = startPos:Lerp(targetPos, smooth)
            
            root.CFrame = CFrame.new(newPos)
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            
            if alpha >= 1 then
                done = true
                if conn then conn:Disconnect() end
            end
        end) 
        
        while not done do task.wait() end 
    end
    
    function MM2.start()
        if MM2.running then return end
        MM2.running = true
        MM2.busy = false
        MM2.targetCoin = nil
        MM2.cacheRefresh = 0
        table.clear(MM2.cachedCoins)
        table.clear(MM2.touchedCoins)
        
        local char = player.Character
        if not char then MM2.running = false; return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then MM2.running = false; return end
        
        local lastScan = 0
        MM2.conn = RunService.Heartbeat:Connect(function(dt) 
            if not MM2.running or not State.AutoMonetEnabled or MM2.busy then return end
            
            local ch = player.Character
            if not ch then return end
            local mHum = ch:FindFirstChildOfClass("Humanoid")
            local mRoot = ch:FindFirstChild("HumanoidRootPart")
            if not mHum or not mHum.Parent or not mRoot or not mRoot.Parent then return end
            if mHum.Health <= 0 then return end
            if not isInGame() then return end
            if isBagFull() then return end
            
            local now = tick()
            if now - MM2.cacheRefresh > COIN_SCAN_INTERVAL then
                scanCoins(mRoot.Position)
            end
            
            if #MM2.cachedCoins == 0 and not MM2.targetCoin then return end
            
            if not MM2.targetCoin then 
                for _, entry in ipairs(MM2.cachedCoins) do 
                    local coin = entry.part
                    local cpos = entry.pos
                    if coin and coin.Parent and cpos then
                        MM2.targetCoin = coin
                        break
                    end
                end
            end
            
            if MM2.targetCoin and MM2.targetCoin.Parent then 
                local targetPos = MM2.targetCoin.Position
                MM2.busy = true
                moveToSmooth(targetPos, TWEEN_WALKSPEED)
                MM2.busy = false
                MM2.targetCoin = nil
                task.wait(0.3)
                return
            end
            
            mRoot.AssemblyLinearVelocity = Vector3.zero
            mRoot.AssemblyAngularVelocity = Vector3.zero
        end) 
    end
    
    function MM2.stop()
        MM2.running = false
        MM2.busy = false
        if MM2.conn then MM2.conn:Disconnect(); MM2.conn = nil end
        MM2.targetCoin = nil
        table.clear(MM2.cachedCoins)
        table.clear(MM2.touchedCoins)
    end
    
    -- Create AutoMonet Card in MM2 Menu
    createCard("AutoMonet", "Auto-collect coins. LMB — toggle.", "AutoMonetEnabled",
    function(s)
        if s then MM2.start() else MM2.stop() end
    end,
    nil,
    mm2Menu.tabFrames[1])
    
    -- ==== DRONES TAB CONTENT ====
    local droneCard = Instance.new("Frame")
    droneCard.Size = UDim2.new(0.48, 0, 0, 120)
    droneCard.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    droneCard.BackgroundTransparency = 0.96
    droneCard.BorderSizePixel = 0
    droneCard.ZIndex = 12
    droneCard.Parent = mm2Menu.tabFrames[2]
    
    local droneCo = Instance.new("UICorner")
    droneCo.CornerRadius = UDim.new(0, 10)
    droneCo.Parent = droneCard
    
    local droneSt = Instance.new("UIStroke")
    droneSt.Color = Color3.fromRGB(255, 255, 255)
    droneSt.Transparency = 0.91
    droneSt.Thickness = 1
    droneSt.Parent = droneCard
    
    local droneTitle = Instance.new("TextLabel")
    droneTitle.Text = "Shahed-136"
    droneTitle.Font = FONT_BOLD
    droneTitle.TextSize = 14
    droneTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    droneTitle.TextTransparency = 0.3
    droneTitle.Size = UDim2.new(1, -20, 0, 20)
    droneTitle.Position = UDim2.new(0, 18, 0, 14)
    droneTitle.TextXAlignment = Enum.TextXAlignment.Left
    droneTitle.BackgroundTransparency = 1
    droneTitle.ZIndex = 13
    droneTitle.Parent = droneCard
    
    local droneDesc = Instance.new("TextLabel")
    droneDesc.Text = "Kamikaze drone. Works as Sheriff/Murderer only."
    droneDesc.Font = FONT_REG
    droneDesc.TextSize = 10
    droneDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
    droneDesc.TextTransparency = 0.7
    droneDesc.Size = UDim2.new(1, -20, 0, 40)
    droneDesc.Position = UDim2.new(0, 18, 0, 38)
    droneDesc.TextXAlignment = Enum.TextXAlignment.Left
    droneDesc.TextYAlignment = Enum.TextYAlignment.Top
    droneDesc.TextWrapped = true
    droneDesc.BackgroundTransparency = 1
    droneDesc.ZIndex = 13
    droneDesc.Parent = droneCard
    
    local droneBtn = Instance.new("TextButton")
    droneBtn.Size = UDim2.new(1, -36, 0, 32)
    droneBtn.Position = UDim2.new(0, 18, 1, -42)
    droneBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    droneBtn.BackgroundTransparency = 0.1
    droneBtn.BorderSizePixel = 0
    droneBtn.Text = "LAUNCH DRONE"
    droneBtn.Font = FONT_BOLD
    droneBtn.TextSize = 12
    droneBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
    droneBtn.AutoButtonColor = false
    droneBtn.ZIndex = 13
    droneBtn.Parent = droneCard
    attachRipple(droneBtn)
    
    local droneBtnCorner = Instance.new("UICorner")
    droneBtnCorner.CornerRadius = UDim.new(0, 8)
    droneBtnCorner.Parent = droneBtn
    
    droneBtn.MouseButton1Click:Connect(function()
        if Shahed.active then
            stopDrone()
            droneBtn.Text = "LAUNCH DRONE"
            droneBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        else
            startDrone("Sheriff")
            droneBtn.Text = "STOP DRONE"
            droneBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        end
        playSound(SFX.On)
    end)
    
    -- ViewportFrame Preview for Shahed
    local droneVP = Instance.new("ViewportFrame")
    droneVP.Size = UDim2.new(1, -36, 0, 60)
    droneVP.Position = UDim2.new(0, 18, 0, 78)
    droneVP.BackgroundTransparency = 1
    droneVP.BorderSizePixel = 0
    droneVP.ZIndex = 13
    droneVP.Parent = droneCard
    
    local droneVPCam = Instance.new("Camera")
    droneVPCam.FieldOfView = 30
    droneVP.CurrentCamera = droneVPCam
    
    local droneVPLight = Instance.new("PointLight")
    droneVPLight.Brightness = 2
    droneVPLight.Range = 20
    droneVPLight.Color = Color3.fromRGB(255, 255, 255)
    droneVPLight.Shadows = false
    droneVPLight.Parent = droneVP
    
    -- Create Preview Model
    local previewShahed = createShahedModel()
    previewShahed.Parent = droneVP
    droneVPCam.CFrame = CFrame.new(Vector3.new(0, 2, 8), Vector3.new(0, 0, 0))
    
    -- Rotate Preview Animation
    local droneRotConn
    droneRotConn = RunService.RenderStepped:Connect(function(dt)
        if not droneVP or not droneVP.Parent then
            droneRotConn:Disconnect()
            return
        end
        droneVPCam.CFrame = droneVPCam.CFrame * CFrame.Angles(0, dt * 0.5, 0)
    end)
end

-- ==== COSMETICS TAB ====
local cosmeticsFrame = UI.tabFrames[5]
if cosmeticsFrame then
    local oldLayout = cosmeticsFrame:FindFirstChildOfClass("UIGridLayout")
    if oldLayout then oldLayout:Destroy() end
    
    local subTabContainer = Instance.new("Frame")
    subTabContainer.Size = UDim2.new(1, 0, 0, 50)
    subTabContainer.Position = UDim2.new(0, 0, 0, 0)
    subTabContainer.BackgroundTransparency = 1
    subTabContainer.ZIndex = 12
    subTabContainer.Parent = cosmeticsFrame
    
    local subTabList = Instance.new("UIListLayout")
    subTabList.FillDirection = Enum.FillDirection.Horizontal
    subTabList.SortOrder = Enum.SortOrder.LayoutOrder
    subTabList.Padding = UDim.new(0, 8)
    subTabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    subTabList.VerticalAlignment = Enum.VerticalAlignment.Center
    subTabList.Parent = subTabContainer
    
    local contentArea = Instance.new("ScrollingFrame")
    contentArea.Name = "CosmeticContent"
    contentArea.Size = UDim2.new(1, -24, 1, -60)
    contentArea.Position = UDim2.new(0, 12, 0, 60)
    contentArea.BackgroundTransparency = 1
    contentArea.BorderSizePixel = 0
    contentArea.ScrollBarThickness = 4
    contentArea.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    contentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentArea.ZIndex = 11
    contentArea.Parent = cosmeticsFrame
    
    local contentList = Instance.new("UIListLayout")
    contentList.Name = "CosmeticList"
    contentList.Padding = UDim.new(0, 16)
    contentList.SortOrder = Enum.SortOrder.LayoutOrder
    contentList.Parent = contentArea
    
    contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentArea.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
    end)
end

local function createSubTab(name, order, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.96
    btn.Text = name
    btn.Font = FONT_BOLD
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextTransparency = 0.5
    btn.AutoButtonColor = false
    btn.LayoutOrder = order
    btn.ZIndex = 12
    btn.Parent = parent
    attachRipple(btn)
    
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 9)
    bc.Parent = btn
    
    return btn
end

local subTabs = {}
local currentSubTab = nil

local function switchSubTab(type)
    if currentSubTab == type then return end
    currentSubTab = type
    
    for tName, btn in pairs(subTabs) do
        local isActive = (tName == type)
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundTransparency = isActive and 0.2 or 0.96,
            TextTransparency = isActive and 0 or 0.5
        }):Play()
    end
    
    local contentArea = UI.tabFrames[5]:FindFirstChild("CosmeticContent")
    if not contentArea then return end
    
    local list = contentArea:FindFirstChild("CosmeticList")
    if list then list:ClearAllChildren() end
    
    if type == "body" then
        populateBody(list)
    elseif type == "wings" then
        populateWings(list)
    elseif type == "hats" then
        populateHats(list)
    elseif type == "pets" then
        populatePets(list)
    elseif type == "animations" then
        populateAnimations(list)
    end
end

do
    local container = UI.tabFrames[5]:FindFirstChildOfClass("Frame")
    if container then
        subTabs.body = createSubTab("Body", 1, container)
        subTabs.wings = createSubTab("Wings", 2, container)
        subTabs.hats = createSubTab("Hats", 3, container)
        subTabs.pets = createSubTab("Pets", 4, container)
        subTabs.animations = createSubTab("Animations", 5, container)
        
        subTabs.body.MouseButton1Click:Connect(function() switchSubTab("body") end)
        subTabs.wings.MouseButton1Click:Connect(function() switchSubTab("wings") end)
        subTabs.hats.MouseButton1Click:Connect(function() switchSubTab("hats") end)
        subTabs.pets.MouseButton1Click:Connect(function() switchSubTab("pets") end)
        subTabs.animations.MouseButton1Click:Connect(function() switchSubTab("animations") end)
    end
end

-- Cosmetic Populate Functions
local function populateBody(list)
    createCard("Korblox Style", "Removes right leg visually.", "KorbloxEnabled", function(s) toggleKorblox(s) end, nil, list)
    createCard("Ghost Legs", "Hide both legs completely.", "GhostLegsEnabled", function(s) toggleGhostLegs(s) end, nil, list)
end

local function populateWings(list)
    createCard("Angel Wings", "Classic white feathered wings.", "WingsEnabled", function(s)
        if s then applyWings() else 
            if WG.model then WG.model:Destroy(); WG.model = nil end 
        end
    end, nil, list)
end

local function populateHats(list)
    createCard("China Hat", "Traditional conical hat.", "ChinaHatEnabled", function(s)
        if s then applyChinaHat() else 
            if CH.model then CH.model:Destroy(); CH.model = nil end 
        end
    end, nil, list)
end

local function populatePets(list)
    createCard("Companion", "Floating cube companion.", "CompanionEnabled", function(s)
        if s then applyCompanion() else 
            if CMP.model then CMP.model:Destroy(); CMP.model = nil end 
        end
    end, nil, list)
    createCard("Kagune", "Tokyo Ghoul style tentacles.", "KaguneEnabled", function(s)
        if s then applyKagune() else 
            if KG.model then KG.model:Destroy(); KG.model = nil end 
        end
    end, nil, list)
end

local function populateAnimations(list)
    createCard("No Animations", "Disables all character animations.", "AnimationPackEnabled", function(s)
        if Core.AnimPack then Core.AnimPack.apply(s) end
    end, nil, list)
end

-- Initialize default cosmetic view
task.spawn(function()
    task.wait(0.5)
    switchSubTab("wings")
end)

-- ==== GLOBAL EMOTES ====
local EmoteMenu = {gui = nil, buttons = {}, currentTrack = nil, visible = false, expanded = false}
local EMOTES = {
    {name = "Dance", id = "507771019"},
    {name = "Cheer", id = "507770677"},
    {name = "Hello", id = "507770239"},
    {name = "Point", id = "507770453"},
    {name = "Laugh", id = "507770818"},
    {name = "Sit", id = "2506281703"}
}

local function playEmote(emoteId, emoteName)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = hum
    end
    if EmoteMenu.currentTrack then
        pcall(function() EmoteMenu.currentTrack:Stop() end)
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. emoteId
    local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
    if ok and track then
        track.Priority = Enum.AnimationPriority.Action4
        track.Looped = (emoteName == "Sit")
        track:Play()
        EmoteMenu.currentTrack = track
    end
end

local function createEmoteMenu()
    if EmoteMenu.gui and EmoteMenu.gui.Parent then return end
    
    EmoteMenu.gui = Instance.new("ScreenGui")
    EmoteMenu.gui.Name = "WannaEmoteMenu"
    EmoteMenu.gui.ResetOnSpawn = false
    EmoteMenu.gui.IgnoreGuiInset = true
    EmoteMenu.gui.DisplayOrder = 90
    EmoteMenu.gui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Name = "EmoteFrame"
    frame.Size = UDim2.new(0, 180, 0, 60)
    frame.Position = UDim2.new(1, -200, 0.5, -30)
    frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.ZIndex = 90
    frame.Parent = EmoteMenu.gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.85
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Text = "EMOTES"
    title.Font = FONT_BOLD
    title.TextSize = 12
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Size = UDim2.new(1, 0, 0, 18)
    title.Position = UDim2.new(0, 0, 0, 4)
    title.BackgroundTransparency = 1
    title.ZIndex = 91
    title.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Text = "v"
    toggleBtn.Font = FONT_BOLD
    toggleBtn.TextSize = 12
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Size = UDim2.new(0, 20, 0, 20)
    toggleBtn.Position = UDim2.new(1, -22, 0, 2)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.ZIndex = 92
    toggleBtn.Parent = frame
    attachRipple(toggleBtn)
    
    local body = Instance.new("ScrollingFrame")
    body.Name = "EmoteBody"
    body.Size = UDim2.new(1, -8, 0, 170)
    body.Position = UDim2.new(0, 4, 0, 24)
    body.BackgroundTransparency = 1
    body.BorderSizePixel = 0
    body.ScrollBarThickness = 4
    body.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    body.CanvasSize = UDim2.new(0, 0, 0, 0)
    body.Visible = false
    body.ZIndex = 91
    body.Parent = frame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 4)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = body
    
    for i, emote in ipairs(EMOTES) do
        local btn = Instance.new("TextButton")
        btn.Name = "Emote_" .. emote.name
        btn.Size = UDim2.new(1, -4, 0, 28)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0.96
        btn.Text = emote.name
        btn.Font = FONT_REG
        btn.TextSize = 12
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.AutoButtonColor = false
        btn.LayoutOrder = i
        btn.ZIndex = 92
        btn.Parent = body
        attachRipple(btn)
        
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 10)
        bc.Parent = btn
        
        local bs = Instance.new("UIStroke")
        bs.Color = Color3.fromRGB(255, 255, 255)
        bs.Transparency = 0.9
        bs.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            playEmote(emote.id, emote.name)
            playSound(SFX.On)
        end)
        
        table.insert(EmoteMenu.buttons, btn)
    end
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        body.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 6)
    end)
    
    toggleBtn.MouseButton1Click:Connect(function()
        EmoteMenu.expanded = not EmoteMenu.expanded
        if EmoteMenu.expanded then
            toggleBtn.Text = "^"
            body.Visible = true
            TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 180, 0, 210)
            }):Play()
        else
            toggleBtn.Text = "v"
            TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 180, 0, 60)
            }):Play()
            task.delay(0.25, function() body.Visible = false end)
        end
        playSound(SFX.On)
    end)
    
    EmoteMenu.frame = frame
    EmoteMenu.body = body
    EmoteMenu.toggleBtn = toggleBtn
    EmoteMenu.visible = true
end

task.spawn(function()
    task.wait(1)
    createEmoteMenu()
end)

-- ==== TOGGLE MENU SYSTEM ====
local function toggleMenu()
    if ScriptUnloaded then return end
    State.MenuOpen = not State.MenuOpen
    
    if State.MenuOpen then
        playSound(SFX.MenuOpen)
        UI.main.Visible = true
        UI.main.Size = UDim2.new(0, 0, 0, 0)
        UI.main.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(UI.main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 720, 0, 480),
            Position = UDim2.new(0.5, -360, 0.5, -240)
        }):Play()
        TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = 24}):Play()
        dimOverlay.Visible = true
        dimOverlay.BackgroundTransparency = 1
        TweenService:Create(dimOverlay, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()
    else
        playSound(SFX.MenuClose)
        TweenService:Create(UI.main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        TweenService:Create(blur, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = 0}):Play()
        TweenService:Create(dimOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        for _, w in pairs(WINS) do
            if w.frame then w.frame.Visible = false end
        end
        State.OpenSettings = nil
        task.wait(0.35)
        if not ScriptUnloaded then
            UI.main.Visible = false
            dimOverlay.Visible = false
        end
    end
end

addConnection(UserInputService.InputBegan:Connect(function(input, gp)
    if ScriptUnloaded or gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleMenu()
    end
end))

-- Draggable Header for Main Menu
local dragH = Instance.new("Frame")
dragH.Size = UDim2.new(1, 0, 0, 54)
dragH.BackgroundTransparency = 1
dragH.ZIndex = 15
dragH.Parent = UI.main

local dragging, dragStart, startPos = false, nil, nil
dragH.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = UI.main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        UI.main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("wannacry client — Part 2 loaded!")
print("Features: New Icons, Ripple Effects, Search Cursor, MM2 Hub, Emotes")