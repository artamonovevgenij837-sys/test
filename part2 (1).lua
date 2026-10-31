-- wannacry client v1.0 — Part 2 (Roblox Native GUI)
-- Requires Part 1 to be injected first!
-- Features: Real ScreenGui, Tabs, Cards, MM2 Hub, Emotes

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

-- ==== RIPPLE EFFECT HELPER (ROBLOX VERSION) ====
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
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
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

local function attachRipple(guiObj)
    guiObj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local absPos = guiObj.AbsolutePosition
            local mouseLoc = UserInputService:GetMouseLocation()
            local relX = mouseLoc.X - absPos.X
            local relY = mouseLoc.Y - absPos.Y
            
            relX = math.clamp(relX, 0, guiObj.AbsoluteSize.X)
            relY = math.clamp(relY, 0, guiObj.AbsoluteSize.Y)
            
            createRippleEffect(guiObj, relX, relY)
        end
    end)
end

-- ==== UI SETUP (SCREENGUI) ====
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

-- Logo W
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
title.LetterSpacing = 2
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
subtitle.LetterSpacing = 2
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
    
    attachRipple(btn)
    
    -- Tab Background
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
    
    -- Draw Procedural Icon
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

-- Search Icon
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
local function createCard(title, desc, parent, lmb, rmb)
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
    tl.LetterSpacing = 1
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
    placesTitle.LetterSpacing = 1
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
    
    mm2Card.MouseButton1Click:Connect(function()
        playSound(SFX.On)
        openMM2Menu()
    end)
end

-- ==== MM2 SUBMENU ====
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

local mm2Title = Instance.new("TextLabel")
mm2Title.Text = "wannacry"
mm2Title.Font = FONT_BLACK
mm2Title.TextSize = 16
mm2Title.LetterSpacing = 1
mm2Title.TextColor3 = Color3.fromRGB(255, 255, 255)
mm2Title.TextXAlignment = Enum.TextXAlignment.Left
mm2Title.Size = UDim2.new(0, 100, 0, 28)
mm2Title.Position = UDim2.new(0, 72, 0, 15)
mm2Title.BackgroundTransparency = 1
mm2Title.ZIndex = 12
mm2Title.Parent = mm2Header

local mm2Subtitle = Instance.new("TextLabel")
mm2Subtitle.Text = "MM2"
mm2Subtitle.Font = FONT_REG
mm2Subtitle.TextSize = 13
mm2Subtitle.LetterSpacing = 1
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
        if s then applyWings() else if WG.model then WG.model:Destroy(); WG.model = nil end end 
    end, nil, list)
end

local function populateHats(list)
    createCard("China Hat", "Traditional conical hat.", "ChinaHatEnabled", function(s) 
        if s then applyChinaHat() else if CH.model then CH.model:Destroy(); CH.model = nil end end 
    end, nil, list)
end

local function populatePets(list)
    createCard("Companion", "Floating cube companion.", "CompanionEnabled", function(s) 
        if s then applyCompanion() else if CMP.model then CMP.model:Destroy(); CMP.model = nil end end 
    end, nil, list)
    createCard("Kagune", "Tokyo Ghoul style tentacles.", "KaguneEnabled", function(s) 
        if s then applyKagune() else if KG.model then KG.model:Destroy(); KG.model = nil end end 
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