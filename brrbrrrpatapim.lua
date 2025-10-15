--// Zarizz Item Checker Mobile Edition 📱 - ENHANCED
local player = game.Players.LocalPlayer
local itemFolder = player:WaitForChild("Backpack")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Rarity & Mutasi
local rarityTable = {
    MYTHIC = {"Bombini Gussini","Frigo Camelo","Bombardilo Watermelondrilo","Bombardiro Crocodilo"},
    GODLY = {"Giraffa Celeste","Matteo","Odin Din Din Dun","Tralalelo Tralala","Cocotanko Giraffanto"},
    SECRET = {"Vacca Saturno Saturnita","Garamararam","Los Tralaleritos","Los Mr Carrotitos","Crazylone Pizalone"}
}

-- Color Scheme
local colors = {
    background = Color3.fromRGB(10, 10, 15),
    surface = Color3.fromRGB(20, 20, 28),
    accent = Color3.fromRGB(35, 35, 48),
    text = Color3.fromRGB(240, 240, 240),
    mythic = Color3.fromRGB(180, 60, 220),
    godly = Color3.fromRGB(255, 180, 40),
    secret = Color3.fromRGB(70, 200, 255),
    secret_glow = Color3.fromRGB(100, 230, 255),
    unknown = Color3.fromRGB(100, 100, 120)
}

-- GUI Mobile Optimized
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ZarizzMobileChecker"
screenGui.ResetOnSpawn = false

-- Memory management
local connections = {}
local animationConnections = {}

local function cleanup()
    for _, conn in ipairs(connections) do
        conn:Disconnect()
    end
    for _, conn in ipairs(animationConnections) do
        conn:Disconnect()
    end
    if screenGui then
        screenGui:Destroy()
    end
end

-- Auto-cleanup on player leave
table.insert(connections, player.AncestryChanged:Connect(function()
    if not player.Parent then
        cleanup()
    end
end))

-- Validate item folder
if not itemFolder then
    warn("❌ Backpack folder not found!")
    cleanup()
    return
end

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0.9, 0, 0.8, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = colors.background
frame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 12)

-- Title Bar
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = colors.surface
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(0.8, 0, 1, 0)
title.Position = UDim2.new(0.1, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = colors.text
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Text = "Zarizz ITEM CHECKER"

-- Mythic Glow Effect
local mythGlow = Instance.new("UIGradient", title)
mythGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, colors.mythic),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 255)),
    ColorSequenceKeypoint.new(1, colors.mythic)
})
mythGlow.Rotation = 45

-- Close Button
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.TextColor3 = colors.text
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Text = "X"
closeBtn.BorderSizePixel = 0

local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 6)

-- Quick Stats
local statsFrame = Instance.new("Frame", frame)
statsFrame.Size = UDim2.new(1, -20, 0, 80)
statsFrame.Position = UDim2.new(0, 10, 0, 45)
statsFrame.BackgroundTransparency = 1

local statsGrid = Instance.new("UIGridLayout", statsFrame)
statsGrid.CellSize = UDim2.new(0.333, -5, 0.5, -5)
statsGrid.CellPadding = UDim2.new(0, 5, 0, 5)

-- Enhanced SECRET effects functions
local function createSecretPulseAnimation(label, frame)
    local connection
    local pulseSpeed = 2
    local originalColor = colors.secret
    
    connection = RunService.Heartbeat:Connect(function()
        if not label or not label.Parent then
            connection:Disconnect()
            return
        end
        
        local pulse = (math.sin(tick() * pulseSpeed) + 1) / 2 -- 0 to 1
        local glowIntensity = 0.3 + pulse * 0.7
        
        -- Pulsing text color
        label.TextColor3 = originalColor:Lerp(colors.secret_glow, pulse)
        
        -- Pulsing background for the frame
        if frame then
            frame.BackgroundColor3 = colors.surface:Lerp(Color3.fromRGB(30, 40, 60), pulse * 0.3)
        end
    end)
    table.insert(animationConnections, connection)
end

local function createSecretOrbitEffect(itemFrame)
    -- Create orbiting particles around the item frame
    local orbitContainer = Instance.new("Frame", itemFrame)
    orbitContainer.Size = UDim2.new(1, 10, 1, 10)
    orbitContainer.Position = UDim2.new(-0.05, 0, -0.05, 0)
    orbitContainer.BackgroundTransparency = 1
    orbitContainer.ClipsDescendants = false
    
    local particles = {}
    local particleCount = 4
    
    for i = 1, particleCount do
        local particle = Instance.new("Frame", orbitContainer)
        particle.Size = UDim2.new(0, 4, 0, 4)
        particle.BackgroundColor3 = colors.secret_glow
        particle.BorderSizePixel = 0
        particle.ZIndex = -1
        
        local corner = Instance.new("UICorner", particle)
        corner.CornerRadius = UDim.new(1, 0)
        
        particles[i] = particle
    end
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not orbitContainer or not orbitContainer.Parent then
            connection:Disconnect()
            return
        end
        
        local time = tick()
        local radius = 15
        local center = Vector2.new(orbitContainer.AbsoluteSize.X / 2, orbitContainer.AbsoluteSize.Y / 2)
        
        for i, particle in ipairs(particles) do
            local angle = time * 3 + (i / particleCount) * (2 * math.pi)
            local x = center.x + radius * math.cos(angle) - 2
            local y = center.y + radius * math.sin(angle) - 2
            
            particle.Position = UDim2.new(0, x, 0, y)
            
            -- Size pulsing
            local sizePulse = 0.8 + 0.4 * math.sin(time * 4 + i)
            particle.Size = UDim2.new(0, 4 * sizePulse, 0, 4 * sizePulse)
        end
    end)
    table.insert(animationConnections, connection)
end

local function createSecretShineEffect(itemFrame)
    local shine = Instance.new("Frame", itemFrame)
    shine.Size = UDim2.new(0.3, 0, 2, 0)
    shine.BackgroundColor3 = Color3.new(1, 1, 1)
    shine.BorderSizePixel = 0
    shine.Position = UDim2.new(-0.3, 0, -0.5, 0)
    shine.Rotation = 45
    shine.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local gradient = Instance.new("UIGradient", shine)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
    })
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.3, 0.8),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(0.7, 0.8),
        NumberSequenceKeypoint.new(1, 1)
    })
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not shine or not shine.Parent then
            connection:Disconnect()
            return
        end
        
        local time = tick()
        local slide = (math.sin(time * 0.5) + 1) / 2 -- 0 to 1
        shine.Position = UDim2.new(slide * 1.6 - 0.3, 0, -0.5, 0)
    end)
    table.insert(animationConnections, connection)
    
    return shine
end

-- Optimized animation system
local function createRainbowAnimation(label)
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not label or not label.Parent then
            connection:Disconnect()
            return
        end
        label.TextColor3 = Color3.fromHSV((tick() * 2) % 1, 0.8, 1)
    end)
    table.insert(animationConnections, connection)
end

local function addButtonEffect(button)
    local originalColor = button.BackgroundColor3
    
    table.insert(connections, button.MouseButton1Down:Connect(function()
        button.BackgroundColor3 = originalColor:Lerp(Color3.new(0, 0, 0), 0.3)
    end))
    
    table.insert(connections, button.MouseButton1Up:Connect(function()
        button.BackgroundColor3 = originalColor
    end))
    
    table.insert(connections, button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
    end))
end

local function createStatCard(rarity, count, color)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 1, 0)
    card.BackgroundColor3 = colors.surface
    card.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", card)
    corner.CornerRadius = UDim.new(0, 8)
    
    local rarityLabel = Instance.new("TextLabel", card)
    rarityLabel.Size = UDim2.new(1, 0, 0.4, 0)
    rarityLabel.Position = UDim2.new(0, 5, 0, 0)
    rarityLabel.BackgroundTransparency = 1
    rarityLabel.TextColor3 = color
    rarityLabel.Font = Enum.Font.GothamBold
    rarityLabel.TextSize = 12
    rarityLabel.Text = rarity
    rarityLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Special Effects
    if rarity == "MYTHIC" then
        local glow = Instance.new("UIGradient", rarityLabel)
        glow.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 255)),
            ColorSequenceKeypoint.new(1, color)
        })
    elseif rarity == "GODLY" then
        createRainbowAnimation(rarityLabel)
    elseif rarity == "SECRET" then
        -- Enhanced SECRET stat card effect
        createSecretPulseAnimation(rarityLabel, card)
        
        local stroke = Instance.new("UIStroke", card)
        stroke.Color = colors.secret
        stroke.Thickness = 2
        stroke.Transparency = 0.5
    end
    
    local countLabel = Instance.new("TextLabel", card)
    countLabel.Size = UDim2.new(1, 0, 0.6, 0)
    countLabel.Position = UDim2.new(0, 5, 0.4, 0)
    countLabel.BackgroundTransparency = 1
    countLabel.TextColor3 = colors.text
    countLabel.Font = Enum.Font.GothamBlack
    countLabel.TextSize = 18
    countLabel.Text = tostring(count)
    countLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    return card
end

-- Action Buttons Container
local buttonsFrame = Instance.new("Frame", frame)
buttonsFrame.Size = UDim2.new(1, -20, 0, 35)
buttonsFrame.Position = UDim2.new(0, 10, 0, 130)
buttonsFrame.BackgroundTransparency = 1

local buttonsGrid = Instance.new("UIGridLayout", buttonsFrame)
buttonsGrid.CellSize = UDim2.new(0.5, -5, 1, 0)
buttonsGrid.CellPadding = UDim2.new(0, 5, 0, 0)

-- Copy Button
local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(1, 0, 1, 0)
copyBtn.BackgroundColor3 = colors.accent
copyBtn.TextColor3 = colors.text
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
copyBtn.Text = "📋 COPY STOCK"
copyBtn.BorderSizePixel = 0

local copyCorner = Instance.new("UICorner", copyBtn)
copyCorner.CornerRadius = UDim.new(0, 8)

-- Refresh Button
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 1, 0)
refreshBtn.BackgroundColor3 = colors.accent
refreshBtn.TextColor3 = colors.text
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextSize = 14
refreshBtn.Text = "🔄 REFRESH"
refreshBtn.BorderSizePixel = 0

local refreshCorner = Instance.new("UICorner", refreshBtn)
refreshCorner.CornerRadius = UDim.new(0, 8)

-- Items Grid
local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Size = UDim2.new(1, -20, 1, -180)
scrollFrame.Position = UDim2.new(0, 10, 0, 170)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = colors.accent

local grid = Instance.new("UIGridLayout", scrollFrame)
grid.CellSize = UDim2.new(0.5, -5, 0, 60)
grid.CellPadding = UDim2.new(0, 5, 0, 5)

-- Search Functionality
local searchBox = Instance.new("TextBox", frame)
searchBox.Size = UDim2.new(1, -20, 0, 35)
searchBox.Position = UDim2.new(0, 10, 0, 90)
searchBox.BackgroundColor3 = colors.surface
searchBox.TextColor3 = colors.text
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBox.PlaceholderText = "🔍 Search items..."
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 14
searchBox.Text = ""
searchBox.ClearTextOnFocus = false

local searchCorner = Instance.new("UICorner", searchBox)
searchCorner.CornerRadius = UDim.new(0, 8)

local searchPadding = Instance.new("UIPadding", searchBox)
searchPadding.PaddingLeft = UDim.new(0, 10)

-- Functions
local function getRarity(itemName)
    for rarity, list in pairs(rarityTable) do
        for _, name in ipairs(list) do
            if itemName:find(name) then return rarity end
        end
    end
    return "UNKNOWN"
end

local function safeSetClipboard(text)
    local success, err = pcall(function()
        setclipboard(text)
    end)
    if not success then
        -- Fallback for mobile devices or restricted environments
        print("📋 Clipboard not available. Stock list printed to console:")
        print(text)
        return false
    end
    return true
end

local function generateStockText()
    local lines = {}
    
    table.insert(lines, " PVB STOCK LIST")
    table.insert(lines, "")
    
    -- Mythic Section
    table.insert(lines, " MYTHIC TOTAL ["..rarityCounter.MYTHIC.."]")
    for _, item in ipairs(itemsByRarity.MYTHIC) do
        table.insert(lines, "• "..item)
    end
    table.insert(lines, "")
    
    -- Godly Section  
    table.insert(lines, " GODLY TOTAL ["..rarityCounter.GODLY.."]")
    for _, item in ipairs(itemsByRarity.GODLY) do
        table.insert(lines, "• "..item)
    end
    table.insert(lines, "")
    
    -- Secret Section
    table.insert(lines, " SECRET TOTAL ["..rarityCounter.SECRET.."]")
    for _, item in ipairs(itemsByRarity.SECRET) do
        table.insert(lines, "• "..item)
    end
    table.insert(lines, "")
    
    table.insert(lines, " TOTAL ITEMS ["..(rarityCounter.MYTHIC + rarityCounter.GODLY + rarityCounter.SECRET).."]")
    
    return table.concat(lines, "\n")
end

local function createItemFrame(itemName, rarity)
    local itemFrame = Instance.new("Frame")
    itemFrame.Size = UDim2.new(1, 0, 0, 60)
    itemFrame.BackgroundColor3 = colors.surface
    itemFrame.BorderSizePixel = 0
    itemFrame.Name = itemName -- For search functionality
    
    local corner = Instance.new("UICorner", itemFrame)
    corner.CornerRadius = UDim.new(0, 8)
    
    -- Rarity indicator
    local rarityBar = Instance.new("Frame", itemFrame)
    rarityBar.Size = UDim2.new(1, 0, 0, 3)
    rarityBar.BackgroundColor3 = colors[rarity:lower()]
    rarityBar.BorderSizePixel = 0
    
    -- Item name with effects
    local nameLabel = Instance.new("TextLabel", itemFrame)
    nameLabel.Size = UDim2.new(1, -10, 1, -5)
    nameLabel.Position = UDim2.new(0, 5, 0, 3)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = colors.text
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 12
    nameLabel.TextWrapped = true
    nameLabel.Text = itemName
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.ClipsDescendants = true
    
    -- Apply text effects based on rarity
    if rarity == "MYTHIC" then
        local glow = Instance.new("UIGradient", nameLabel)
        glow.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, colors.mythic),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 150, 255)),
            ColorSequenceKeypoint.new(1, colors.mythic)
        })
    elseif rarity == "GODLY" then
        createRainbowAnimation(nameLabel)
    elseif rarity == "SECRET" then
        -- ENHANCED SECRET EFFECTS
        createSecretPulseAnimation(nameLabel, itemFrame)
        createSecretOrbitEffect(itemFrame)
        createSecretShineEffect(itemFrame)
        
        -- Add a subtle inner glow
        local innerGlow = Instance.new("UIStroke", itemFrame)
        innerGlow.Color = colors.secret
        innerGlow.Thickness = 2
        innerGlow.Transparency = 0.7
    end
    
    return itemFrame
end

local function filterItems(searchTerm)
    for _, itemFrame in ipairs(scrollFrame:GetChildren()) do
        if itemFrame:IsA("Frame") and itemFrame.Name then
            local matchesSearch = searchTerm == "" or 
                                itemFrame.Name:lower():find(searchTerm:lower())
            itemFrame.Visible = matchesSearch
        end
    end
end

local function scanItems()
    -- Clear existing items
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Clear animation connections
    for _, conn in ipairs(animationConnections) do
        conn:Disconnect()
    end
    animationConnections = {}
    
    -- Scan items & collect data
    rarityCounter = {MYTHIC = 0, GODLY = 0, SECRET = 0}
    itemsByRarity = {MYTHIC = {}, GODLY = {}, SECRET = {}}

    for _, item in ipairs(itemFolder:GetChildren()) do
        local name = item.Name
        local rarity = getRarity(name)
        
        if rarity ~= "UNKNOWN" then
            rarityCounter[rarity] = rarityCounter[rarity] + 1
            table.insert(itemsByRarity[rarity], name)
        end
    end
    
    -- Update stat cards
    for _, child in ipairs(statsFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    createStatCard("MYTHIC", rarityCounter.MYTHIC, colors.mythic).Parent = statsFrame
    createStatCard("GODLY", rarityCounter.GODLY, colors.godly).Parent = statsFrame
    createStatCard("SECRET", rarityCounter.SECRET, colors.secret).Parent = statsFrame
    
    -- Create item frames
    for rarity, items in pairs(itemsByRarity) do
        for _, itemName in ipairs(items) do
            local itemFrame = createItemFrame(itemName, rarity)
            itemFrame.Parent = scrollFrame
        end
    end
    
    -- Auto-resize scroll
    local itemCount = rarityCounter.MYTHIC + rarityCounter.GODLY + rarityCounter.SECRET
    local rows = math.ceil(itemCount / 2)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(rows * 65, scrollFrame.AbsoluteSize.Y))
    
    return itemCount
end

-- Initial scan
local rarityCounter, itemsByRarity
local totalItems = scanItems()

-- Parent buttons after functions are defined
copyBtn.Parent = buttonsFrame
refreshBtn.Parent = buttonsFrame

-- Add button effects
addButtonEffect(copyBtn)
addButtonEffect(refreshBtn)
addButtonEffect(closeBtn)

-- Copy Button Action
table.insert(connections, copyBtn.MouseButton1Click:Connect(function()
    local stockText = generateStockText()
    
    local success = safeSetClipboard(stockText)
    
    -- Visual feedback
    local originalText = copyBtn.Text
    copyBtn.Text = success and "✅ COPIED!" or "📋 PRINTED!"
    
    wait(1.5)
    copyBtn.Text = originalText
    
    print(" Stock List " .. (success and "Copied to Clipboard!" or "Printed to Console!"))
    if not success then
        print("\n" .. stockText)
    end
end))

-- Refresh Button Action
table.insert(connections, refreshBtn.MouseButton1Click:Connect(function()
    local originalText = refreshBtn.Text
    refreshBtn.Text = "⏳ SCANNING..."
    
    local newCount = scanItems()
    
    refreshBtn.Text = "✅ UPDATED!"
    wait(1)
    refreshBtn.Text = originalText
    
    print("🔄 Inventory Rescanned! Found " .. newCount .. " rare items.")
end))

-- Search Functionality
table.insert(connections, searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    filterItems(searchBox.Text)
end))

-- Close functionality
table.insert(connections, closeBtn.MouseButton1Click:Connect(cleanup))

-- Mobile optimization
scrollFrame.ScrollingEnabled = true
frame.Active = true
frame.Draggable = true

print("📱 Zarizz Mobile Checker Loaded!")
print("✨ Mythic:", rarityCounter.MYTHIC)
print("🌟 Godly:", rarityCounter.GODLY)  
print("💎 Secret:", rarityCounter.SECRET)
print("📦 Total:", totalItems)
print("🔍 Search feature enabled")
print("🔄 Refresh feature enabled")
print("✨ Enhanced SECRET effects activated!")

return screenGui
