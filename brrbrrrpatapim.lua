--// Zarizz Item Checker Mobile Edition 📱 - ULTRA ENHANCED
local player = game.Players.LocalPlayer
local itemFolder = player:WaitForChild("Backpack")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Enhanced Rarity System with Multi-level Detection
local rarityTable = {
    MYTHIC = {
        items = {"Bombini Gussini","Frigo Camelo","Bombardilo Watermelondrilo","Bombardiro Crocodilo"},
        colors = {
            primary = Color3.fromRGB(180, 60, 220),
            secondary = Color3.fromRGB(255, 100, 255),
            glow = Color3.fromRGB(220, 80, 240)
        }
    },
    GODLY = {
        items = {"Giraffa Celeste","Matteo","Odin Din Din Dun","Tralalelo Tralala","Cocotanko Giraffanto"},
        colors = {
            primary = Color3.fromRGB(255, 180, 40),
            secondary = Color3.fromRGB(255, 220, 100),
            glow = Color3.fromRGB(255, 200, 60)
        }
    },
    SECRET = {
        items = {"Vacca Saturno Saturnita","Garamararam","Los Tralaleritos","Los Mr Carrotitos","Crazylone Pizalone"},
        colors = {
            primary = Color3.fromRGB(70, 200, 255),
            secondary = Color3.fromRGB(100, 230, 255),
            glow = Color3.fromRGB(120, 240, 255)
        }
    }
}

-- Advanced Color System with Themes
local themes = {
    DARK = {
        background = Color3.fromRGB(10, 10, 15),
        surface = Color3.fromRGB(20, 20, 28),
        accent = Color3.fromRGB(35, 35, 48),
        text = Color3.fromRGB(240, 240, 240),
        secondaryText = Color3.fromRGB(180, 180, 200)
    },
    BLUE = {
        background = Color3.fromRGB(15, 20, 35),
        surface = Color3.fromRGB(25, 35, 55),
        accent = Color3.fromRGB(45, 60, 90),
        text = Color3.fromRGB(230, 235, 255),
        secondaryText = Color3.fromRGB(170, 180, 220)
    },
    PURPLE = {
        background = Color3.fromRGB(20, 15, 35),
        surface = Color3.fromRGB(35, 25, 55),
        accent = Color3.fromRGB(60, 45, 90),
        text = Color3.fromRGB(240, 230, 255),
        secondaryText = Color3.fromRGB(190, 170, 220)
    }
}

local currentTheme = "DARK"
local colors = themes[currentTheme]

-- Advanced GUI System
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ZarizzMobileCheckerUltra"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Memory Management System
local connections = {}
local animationConnections = {}
local tweenInstances = {}

local function safeDisconnect(connectionList)
    for _, conn in ipairs(connectionList) do
        if conn then
            conn:Disconnect()
        end
    end
end

local function safeDestroy(instance)
    if instance and instance.Parent then
        instance:Destroy()
    end
end

local function cleanup()
    safeDisconnect(connections)
    safeDisconnect(animationConnections)
    
    for _, tween in ipairs(tweenInstances) do
        if tween then
            tween:Cancel()
        end
    end
    
    if screenGui then
        screenGui:Destroy()
    end
end

-- Auto-cleanup system
table.insert(connections, player.AncestryChanged:Connect(function()
    if not player.Parent then
        cleanup()
    end
end))

-- Validate system
if not itemFolder then
    warn("Backpack folder not found!")
    cleanup()
    return
end

-- Advanced Main Container with Glass Morphism Effect
local mainContainer = Instance.new("Frame", screenGui)
mainContainer.Size = UDim2.new(0.95, 0, 0.85, 0)
mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
mainContainer.BackgroundColor3 = colors.background
mainContainer.BackgroundTransparency = 0.1
mainContainer.BorderSizePixel = 0

-- Glass morphism effect
local blurEffect = Instance.new("BlurEffect", mainContainer)
blurEffect.Size = 8

local UICorner = Instance.new("UICorner", mainContainer)
UICorner.CornerRadius = UDim.new(0, 20)

local UIStroke = Instance.new("UIStroke", mainContainer)
UIStroke.Color = Color3.fromRGB(60, 60, 80)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.7

-- Enhanced Title Bar with Gradient
local titleBar = Instance.new("Frame", mainContainer)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = colors.surface
titleBar.BorderSizePixel = 0

local titleGradient = Instance.new("UIGradient", titleBar)
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, colors.surface),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 42))
})

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0.15, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = colors.text
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.Text = "ZARIZZ ITEM CHECKER ULTRA"
title.TextXAlignment = Enum.TextXAlignment.Center

-- Animated Title Effect
local function createTitleAnimation()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not title then return end
        
        local time = tick()
        local pulse = (math.sin(time * 3) + 1) / 2
        title.TextColor3 = rarityTable.MYTHIC.colors.primary:Lerp(
            rarityTable.MYTHIC.colors.secondary, 
            pulse
        )
        
        -- Subtle scale animation
        title.Size = UDim2.new(0.7 + math.sin(time * 2) * 0.02, 0, 1, 0)
    end)
    table.insert(animationConnections, connection)
end

createTitleAnimation()

-- Control Buttons Container
local controlButtons = Instance.new("Frame", titleBar)
controlButtons.Size = UDim2.new(0.3, 0, 1, 0)
controlButtons.Position = UDim2.new(0.7, 0, 0, 0)
controlButtons.BackgroundTransparency = 1

local buttonsLayout = Instance.new("UIGridLayout", controlButtons)
buttonsLayout.CellSize = UDim2.new(0.33, 0, 1, 0)
buttonsLayout.CellPadding = UDim2.new(0, 2, 0, 0)

-- Enhanced Control Buttons
local function createControlButton(icon, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = color
    button.TextColor3 = colors.text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Text = icon
    button.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.8
    
    return button
end

local minimizeBtn = createControlButton("_", Color3.fromRGB(80, 80, 100))
local themeBtn = createControlButton("T", Color3.fromRGB(80, 80, 100))
local closeBtn = createControlButton("X", Color3.fromRGB(200, 60, 60))

minimizeBtn.Parent = controlButtons
themeBtn.Parent = controlButtons
closeBtn.Parent = controlButtons

-- Advanced Stats Dashboard
local statsDashboard = Instance.new("Frame", mainContainer)
statsDashboard.Size = UDim2.new(1, -20, 0, 100)
statsDashboard.Position = UDim2.new(0, 10, 0, 55)
statsDashboard.BackgroundTransparency = 1

local statsScroll = Instance.new("ScrollingFrame", statsDashboard)
statsScroll.Size = UDim2.new(1, 0, 1, 0)
statsScroll.BackgroundTransparency = 1
statsScroll.ScrollBarThickness = 4
statsScroll.ScrollBarImageColor3 = colors.accent
statsScroll.AutomaticCanvasSize = Enum.AutomaticSize.X

local statsList = Instance.new("UIListLayout", statsScroll)
statsList.FillDirection = Enum.FillDirection.Horizontal
statsList.Padding = UDim.new(0, 10)
statsList.SortOrder = Enum.SortOrder.LayoutOrder

-- Enhanced Stat Card with Progress Bars
local function createAdvancedStatCard(rarity, count, total, colorConfig)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 120, 1, 0)
    card.BackgroundColor3 = colors.surface
    card.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", card)
    corner.CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = colorConfig.primary
    stroke.Thickness = 2
    
    -- Rarity Icon and Name
    local header = Instance.new("Frame", card)
    header.Size = UDim2.new(1, 0, 0.4, 0)
    header.BackgroundTransparency = 1
    
    local rarityIcon = Instance.new("TextLabel", header)
    rarityIcon.Size = UDim2.new(0.3, 0, 1, 0)
    rarityIcon.BackgroundTransparency = 1
    rarityIcon.Text = getRarityIcon(rarity)
    rarityIcon.TextColor3 = colorConfig.primary
    rarityIcon.Font = Enum.Font.GothamBlack
    rarityIcon.TextSize = 16
    
    local rarityName = Instance.new("TextLabel", header)
    rarityName.Size = UDim2.new(0.7, 0, 1, 0)
    rarityName.Position = UDim2.new(0.3, 0, 0, 0)
    rarityName.BackgroundTransparency = 1
    rarityName.TextColor3 = colors.text
    rarityName.Font = Enum.Font.GothamBold
    rarityName.TextSize = 12
    rarityName.Text = rarity
    rarityName.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Count Display
    local countFrame = Instance.new("Frame", card)
    countFrame.Size = UDim2.new(1, 0, 0.3, 0)
    countFrame.Position = UDim2.new(0, 0, 0.4, 0)
    countFrame.BackgroundTransparency = 1
    
    local countText = Instance.new("TextLabel", countFrame)
    countText.Size = UDim2.new(1, 0, 1, 0)
    countText.BackgroundTransparency = 1
    countText.TextColor3 = colorConfig.glow
    countText.Font = Enum.Font.GothamBlack
    countText.TextSize = 20
    countText.Text = tostring(count)
    
    -- Progress Bar
    local progressFrame = Instance.new("Frame", card)
    progressFrame.Size = UDim2.new(1, -10, 0, 6)
    progressFrame.Position = UDim2.new(0, 5, 0.75, 0)
    progressFrame.BackgroundColor3 = colors.accent
    progressFrame.BorderSizePixel = 0
    
    local progressCorner = Instance.new("UICorner", progressFrame)
    progressCorner.CornerRadius = UDim.new(1, 0)
    
    local progressBar = Instance.new("Frame", progressFrame)
    progressBar.Size = UDim2.new(math.min(count / math.max(total, 1), 1), 0, 1, 0)
    progressBar.BackgroundColor3 = colorConfig.primary
    progressBar.BorderSizePixel = 0
    
    local barCorner = Instance.new("UICorner", progressBar)
    barCorner.CornerRadius = UDim.new(1, 0)
    
    -- Add specific effects based on rarity
    if rarity == "MYTHIC" then
        createMythicPulseAnimation(card, colorConfig)
    elseif rarity == "SECRET" then
        createSecretHologramEffect(card, colorConfig)
    elseif rarity == "GODLY" then
        createGodlyShineEffect(card, colorConfig)
    end
    
    return card
end

-- Advanced Item Grid System
local contentArea = Instance.new("Frame", mainContainer)
contentArea.Size = UDim2.new(1, -20, 1, -170)
contentArea.Position = UDim2.new(0, 10, 0, 160)
contentArea.BackgroundTransparency = 1

-- Search and Filter System
local searchSystem = Instance.new("Frame", mainContainer)
searchSystem.Size = UDim2.new(1, -20, 0, 40)
searchSystem.Position = UDim2.new(0, 10, 0, 120)
searchSystem.BackgroundTransparency = 1

local searchBox = Instance.new("TextBox", searchSystem)
searchBox.Size = UDim2.new(0.7, 0, 1, 0)
searchBox.BackgroundColor3 = colors.surface
searchBox.TextColor3 = colors.text
searchBox.PlaceholderColor3 = colors.secondaryText
searchBox.PlaceholderText = "Search items..."
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 14
searchBox.ClearTextOnFocus = false

local searchCorner = Instance.new("UICorner", searchBox)
searchCorner.CornerRadius = UDim.new(0, 10)

local searchPadding = Instance.new("UIPadding", searchBox)
searchPadding.PaddingLeft = UDim.new(0, 15)

-- Sort Dropdown
local sortButton = Instance.new("TextButton", searchSystem)
sortButton.Size = UDim2.new(0.28, -5, 1, 0)
sortButton.Position = UDim2.new(0.72, 5, 0, 0)
sortButton.BackgroundColor3 = colors.accent
sortButton.TextColor3 = colors.text
sortButton.Font = Enum.Font.Gotham
sortButton.TextSize = 12
sortButton.Text = "Sort: Rarity ▼"
sortButton.BorderSizePixel = 0

local sortCorner = Instance.new("UICorner", sortButton)
sortCorner.CornerRadius = UDim.new(0, 10)

-- Advanced Item Container with Tabs
local itemTabs = Instance.new("Frame", contentArea)
itemTabs.Size = UDim2.new(1, 0, 0, 30)
itemTabs.BackgroundTransparency = 1

local tabsList = Instance.new("UIListLayout", itemTabs)
tabsList.FillDirection = Enum.FillDirection.Horizontal
tabsList.Padding = UDim.new(0, 5)

local function createTabButton(text, isActive)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0, 80, 1, 0)
    tab.BackgroundColor3 = isActive and colors.accent or colors.surface
    tab.TextColor3 = colors.text
    tab.Font = Enum.Font.Gotham
    tab.TextSize = 12
    tab.Text = text
    tab.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", tab)
    corner.CornerRadius = UDim.new(0, 8)
    
    return tab
end

local allTab = createTabButton("All Items", true)
local mythicTab = createTabButton("Mythic")
local godlyTab = createTabButton("Godly")
local secretTab = createTabButton("Secret")

allTab.Parent = itemTabs
mythicTab.Parent = itemTabs
godlyTab.Parent = itemTabs
secretTab.Parent = itemTabs

local itemsContainer = Instance.new("ScrollingFrame", contentArea)
itemsContainer.Size = UDim2.new(1, 0, 1, -35)
itemsContainer.Position = UDim2.new(0, 0, 0, 35)
itemsContainer.BackgroundTransparency = 1
itemsContainer.ScrollBarThickness = 6
itemsContainer.ScrollBarImageColor3 = colors.accent
itemsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y

local itemsGrid = Instance.new("UIGridLayout", itemsContainer)
itemsGrid.CellSize = UDim2.new(0.5, -5, 0, 80)
itemsGrid.CellPadding = UDim2.new(0, 5, 0, 5)
itemsGrid.SortOrder = Enum.SortOrder.LayoutOrder

-- Enhanced Utility Functions
local function getRarityIcon(rarity)
    local icons = {
        MYTHIC = "M",
        GODLY = "G", 
        SECRET = "S"
    }
    return icons[rarity] or "I"
end

local function getRarity(itemName)
    for rarity, data in pairs(rarityTable) do
        for _, item in ipairs(data.items) do
            if item == itemName then
                return rarity
            end
        end
    end
    return "COMMON"
end

local function createMythicPulseAnimation(frame, colors)
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not frame then
            connection:Disconnect()
            return
        end
        
        local pulse = (math.sin(tick() * 3) + 1) / 2
        frame.UIStroke.Color = colors.primary:Lerp(colors.glow, pulse)
    end)
    table.insert(animationConnections, connection)
end

local function createSecretHologramEffect(frame, colors)
    local hologram = Instance.new("Frame", frame)
    hologram.Size = UDim2.new(1, 0, 1, 0)
    hologram.BackgroundColor3 = colors.primary
    hologram.BackgroundTransparency = 0.9
    hologram.BorderSizePixel = 0
    hologram.ZIndex = -1
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not hologram then
            connection:Disconnect()
            return
        end
        
        local scan = (math.sin(tick() * 2) + 1) / 2
        hologram.BackgroundTransparency = 0.7 + scan * 0.2
    end)
    table.insert(animationConnections, connection)
end

local function createGodlyShineEffect(frame, colors)
    local shine = Instance.new("Frame", frame)
    shine.Size = UDim2.new(0.5, 0, 2, 0)
    shine.BackgroundColor3 = Color3.new(1, 1, 1)
    shine.BackgroundTransparency = 0.8
    shine.Rotation = 45
    shine.BorderSizePixel = 0
    shine.ZIndex = 2
    
    local gradient = Instance.new("UIGradient", shine)
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 1)
    })
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not shine then
            connection:Disconnect()
            return
        end
        
        local slide = (tick() * 0.5) % 1
        shine.Position = UDim2.new(slide * 2 - 0.5, 0, -0.5, 0)
    end)
    table.insert(animationConnections, connection)
end

local function createSecretParticleEffect(card, colors)
    -- Simple particle effect implementation
    local particles = Instance.new("Frame", card)
    particles.Size = UDim2.new(1, 0, 1, 0)
    particles.BackgroundTransparency = 1
    particles.ZIndex = -1
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not particles then
            connection:Disconnect()
            return
        end
        
        -- Create floating dots
        for i = 1, 3 do
            local dot = Instance.new("Frame", particles)
            dot.Size = UDim2.new(0, 2, 0, 2)
            dot.BackgroundColor3 = colors.primary
            dot.BorderSizePixel = 0
            dot.ZIndex = -1
            
            local corner = Instance.new("UICorner", dot)
            corner.CornerRadius = UDim.new(1, 0)
            
            -- Animate dot
            spawn(function()
                local startPos = UDim2.new(math.random(), 0, math.random(), 0)
                dot.Position = startPos
                
                for t = 0, 1, 0.02 do
                    if not dot then break end
                    dot.Position = UDim2.new(
                        startPos.X.Scale + math.sin(t * 10) * 0.1,
                        0,
                        startPos.Y.Scale - t,
                        0
                    )
                    dot.BackgroundTransparency = t
                    wait(0.03)
                end
                dot:Destroy()
            end)
        end
    end)
    table.insert(animationConnections, connection)
end

local function createMythicAuraEffect(card, colors)
    local aura = Instance.new("Frame", card)
    aura.Size = UDim2.new(1.2, 0, 1.2, 0)
    aura.Position = UDim2.new(-0.1, 0, -0.1, 0)
    aura.BackgroundColor3 = colors.primary
    aura.BackgroundTransparency = 0.9
    aura.BorderSizePixel = 0
    aura.ZIndex = -2
    
    local corner = Instance.new("UICorner", aura)
    corner.CornerRadius = UDim.new(0, 16)
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not aura then
            connection:Disconnect()
            return
        end
        
        local pulse = (math.sin(tick() * 2) + 1) / 2
        aura.BackgroundTransparency = 0.8 + pulse * 0.1
        aura.Size = UDim2.new(1.2 + math.sin(tick() * 3) * 0.05, 0, 1.2 + math.sin(tick() * 3) * 0.05, 0)
        aura.Position = UDim2.new(-0.1 - math.sin(tick() * 3) * 0.025, 0, -0.1 - math.sin(tick() * 3) * 0.025, 0)
    end)
    table.insert(animationConnections, connection)
end

-- Advanced Item Card System
local function createAdvancedItemCard(itemName, rarity)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 80)
    card.BackgroundColor3 = colors.surface
    card.BorderSizePixel = 0
    card.Name = itemName
    card.ClipsDescendants = true
    
    local corner = Instance.new("UICorner", card)
    corner.CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = rarityTable[rarity] and rarityTable[rarity].colors.primary or Color3.fromRGB(100, 100, 100)
    stroke.Thickness = 2
    
    -- Item Icon Background
    local iconBg = Instance.new("Frame", card)
    iconBg.Size = UDim2.new(0, 50, 0, 50)
    iconBg.Position = UDim2.new(0, 10, 0.5, -25)
    iconBg.BackgroundColor3 = rarityTable[rarity] and rarityTable[rarity].colors.primary or Color3.fromRGB(100, 100, 100)
    iconBg.BackgroundTransparency = 0.2
    
    local iconCorner = Instance.new("UICorner", iconBg)
    iconCorner.CornerRadius = UDim.new(0, 10)
    
    local rarityIcon = Instance.new("TextLabel", iconBg)
    rarityIcon.Size = UDim2.new(1, 0, 1, 0)
    rarityIcon.BackgroundTransparency = 1
    rarityIcon.Text = getRarityIcon(rarity)
    rarityIcon.TextColor3 = Color3.new(1, 1, 1)
    rarityIcon.Font = Enum.Font.GothamBlack
    rarityIcon.TextSize = 20
    
    -- Item Info
    local infoFrame = Instance.new("Frame", card)
    infoFrame.Size = UDim2.new(1, -75, 1, -10)
    infoFrame.Position = UDim2.new(0, 65, 0, 5)
    infoFrame.BackgroundTransparency = 1
    
    local itemNameLabel = Instance.new("TextLabel", infoFrame)
    itemNameLabel.Size = UDim2.new(1, 0, 0.6, 0)
    itemNameLabel.BackgroundTransparency = 1
    itemNameLabel.TextColor3 = colors.text
    itemNameLabel.Font = Enum.Font.GothamBold
    itemNameLabel.TextSize = 12
    itemNameLabel.TextWrapped = true
    itemNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    itemNameLabel.Text = itemName
    
    local rarityLabel = Instance.new("TextLabel", infoFrame)
    rarityLabel.Size = UDim2.new(1, 0, 0.4, 0)
    rarityLabel.Position = UDim2.new(0, 0, 0.6, 0)
    rarityLabel.BackgroundTransparency = 1
    rarityLabel.TextColor3 = rarityTable[rarity] and rarityTable[rarity].colors.primary or Color3.fromRGB(150, 150, 150)
    rarityLabel.Font = Enum.Font.Gotham
    rarityLabel.TextSize = 10
    rarityLabel.TextXAlignment = Enum.TextXAlignment.Left
    rarityLabel.Text = rarity:upper()
    
    -- Interactive Effects
    local hoverEffect = Instance.new("Frame", card)
    hoverEffect.Size = UDim2.new(1, 0, 1, 0)
    hoverEffect.BackgroundColor3 = Color3.new(1, 1, 1)
    hoverEffect.BackgroundTransparency = 0.95
    hoverEffect.Visible = false
    hoverEffect.BorderSizePixel = 0
    
    -- Add rarity-specific effects
    if rarity == "SECRET" then
        createSecretParticleEffect(card, rarityTable[rarity].colors)
    elseif rarity == "MYTHIC" then
        createMythicAuraEffect(card, rarityTable[rarity].colors)
    end
    
    return card
end

-- Theme Cycling System
local function cycleTheme()
    local themeOrder = {"DARK", "BLUE", "PURPLE"}
    local currentIndex = table.find(themeOrder, currentTheme) or 1
    local nextIndex = currentIndex % #themeOrder + 1
    currentTheme = themeOrder[nextIndex]
    colors = themes[currentTheme]
    
    -- Update all colors
    mainContainer.BackgroundColor3 = colors.background
    titleBar.BackgroundColor3 = colors.surface
    title.TextColor3 = colors.text
    searchBox.BackgroundColor3 = colors.surface
    searchBox.TextColor3 = colors.text
    searchBox.PlaceholderColor3 = colors.secondaryText
    sortButton.BackgroundColor3 = colors.accent
    sortButton.TextColor3 = colors.text
    
    -- Update stats scrollbar
    statsScroll.ScrollBarImageColor3 = colors.accent
    
    -- Update items scrollbar
    itemsContainer.ScrollBarImageColor3 = colors.accent
end

-- Minimize System
local isMinimized = false
local originalSize = mainContainer.Size
local minimizedSize = UDim2.new(0.3, 0, 0, 50)

local function toggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        mainContainer.Size = minimizedSize
        contentArea.Visible = false
        statsDashboard.Visible = false
        searchSystem.Visible = false
        title.Text = "ZIC"
    else
        mainContainer.Size = originalSize
        contentArea.Visible = true
        statsDashboard.Visible = true
        searchSystem.Visible = true
        title.Text = "ZARIZZ ITEM CHECKER ULTRA"
    end
end

-- Sort System
local currentSort = "RARITY"
local function showSortOptions()
    currentSort = currentSort == "RARITY" and "NAME" or "RARITY"
    sortButton.Text = "Sort: " .. currentSort .. " ▼"
    -- Implement actual sorting logic here
end

-- Filter System
local function filterItems(searchText)
    for _, child in ipairs(itemsContainer:GetChildren()) do
        if child:IsA("Frame") and child.Name then
            local showItem = string.lower(child.Name):find(string.lower(searchText)) ~= nil
            child.Visible = showItem
        end
    end
end

-- Stats Dashboard Update
local function updateStatsDashboard(analytics)
    -- Clear previous stats
    for _, child in ipairs(statsScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local totalItems = analytics.totalItems
    
    -- Create stat cards for each rarity
    for rarity, data in pairs(rarityTable) do
        local count = analytics.rarityDistribution[rarity] or 0
        local statCard = createAdvancedStatCard(rarity, count, totalItems, data.colors)
        statCard.Parent = statsScroll
    end
    
    -- Total items card
    local totalCard = Instance.new("Frame", statsScroll)
    totalCard.Size = UDim2.new(0, 120, 1, 0)
    totalCard.BackgroundColor3 = colors.surface
    totalCard.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", totalCard)
    corner.CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke", totalCard)
    stroke.Color = colors.accent
    stroke.Thickness = 2
    
    local totalIcon = Instance.new("TextLabel", totalCard)
    totalIcon.Size = UDim2.new(0.3, 0, 0.4, 0)
    totalIcon.BackgroundTransparency = 1
    totalIcon.Text = "T"
    totalIcon.TextColor3 = colors.text
    totalIcon.Font = Enum.Font.GothamBlack
    totalIcon.TextSize = 16
    
    local totalText = Instance.new("TextLabel", totalCard)
    totalText.Size = UDim2.new(1, 0, 0.4, 0)
    totalText.Position = UDim2.new(0, 0, 0.4, 0)
    totalText.BackgroundTransparency = 1
    totalText.TextColor3 = colors.text
    totalText.Font = Enum.Font.GothamBlack
    totalText.TextSize = 20
    totalText.Text = tostring(totalItems)
    
    local totalLabel = Instance.new("TextLabel", totalCard)
    totalLabel.Size = UDim2.new(1, 0, 0.2, 0)
    totalLabel.Position = UDim2.new(0, 0, 0.8, 0)
    totalLabel.BackgroundTransparency = 1
    totalLabel.TextColor3 = colors.secondaryText
    totalLabel.Font = Enum.Font.Gotham
    totalLabel.TextSize = 10
    totalLabel.Text = "TOTAL ITEMS"
end

-- Enhanced Scanning System with Analytics
local function advancedScanItems()
    -- Clear previous items and animations
    safeDisconnect(animationConnections)
    for _, child in ipairs(itemsContainer:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Advanced analytics
    local analytics = {
        totalItems = 0,
        rarityDistribution = {},
        uniqueItems = {},
        lastUpdated = os.time()
    }
    
    -- Scan items
    for _, item in ipairs(itemFolder:GetChildren()) do
        local name = item.Name
        local rarity = getRarity(name)
        
        analytics.totalItems = analytics.totalItems + 1
        analytics.rarityDistribution[rarity] = (analytics.rarityDistribution[rarity] or 0) + 1
        
        if not analytics.uniqueItems[name] then
            analytics.uniqueItems[name] = true
            local itemCard = createAdvancedItemCard(name, rarity)
            itemCard.Parent = itemsContainer
        end
    end
    
    -- Update stats dashboard
    updateStatsDashboard(analytics)
    
    return analytics
end

-- Initialize System
local analyticsData = advancedScanItems()

-- Connect Advanced Controls
table.insert(connections, themeBtn.MouseButton1Click:Connect(cycleTheme))
table.insert(connections, minimizeBtn.MouseButton1Click:Connect(toggleMinimize))
table.insert(connections, sortButton.MouseButton1Click:Connect(showSortOptions))
table.insert(connections, searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    filterItems(searchBox.Text)
end))
table.insert(connections, closeBtn.MouseButton1Click:Connect(cleanup))

-- Auto-refresh system
table.insert(connections, itemFolder.ChildAdded:Connect(function()
    wait(0.5) -- Small delay to ensure item is fully loaded
    advancedScanItems()
end))

table.insert(connections, itemFolder.ChildRemoved:Connect(function()
    advancedScanItems()
end))

-- Final Initialization
print("Zarizz Ultra Enhanced Checker Loaded!")
print("Total Items:", analyticsData.totalItems)
print("Advanced Analytics Enabled")
print("Enhanced Visual Effects Activated")
print("Theme System Ready")
print("Advanced Search & Filter System Online")

return screenGui
