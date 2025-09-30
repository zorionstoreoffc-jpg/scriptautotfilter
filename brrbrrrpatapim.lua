--// Zarizz Item Checker Mobile Edition 📱
local player = game.Players.LocalPlayer
local itemFolder = player:WaitForChild("Backpack")

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
    unknown = Color3.fromRGB(100, 100, 120)
}

-- GUI Mobile Optimized
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ZarizzMobileChecker"

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
        -- Rainbow Animation
        spawn(function()
            while card.Parent do
                for i = 0, 1, 0.05 do
                    if not card.Parent then break end
                    rarityLabel.TextColor3 = Color3.fromHSV(i, 1, 1)
                    wait(0.1)
                end
            end
        end)
    elseif rarity == "SECRET" then
        local stroke = Instance.new("UIStroke", rarityLabel)
        stroke.Color = Color3.new(0, 0, 0)
        stroke.Thickness = 1.5
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

-- Copy Button
local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(1, -20, 0, 35)
copyBtn.Position = UDim2.new(0, 10, 0, 130)
copyBtn.BackgroundColor3 = colors.accent
copyBtn.TextColor3 = colors.text
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
copyBtn.Text = "📋 COPY STOCK LIST"
copyBtn.BorderSizePixel = 0

local copyCorner = Instance.new("UICorner", copyBtn)
copyCorner.CornerRadius = UDim.new(0, 8)

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

-- Fungsi
local function getRarity(itemName)
    for rarity, list in pairs(rarityTable) do
        for _, name in ipairs(list) do
            if itemName:find(name) then return rarity end
        end
    end
    return "UNKNOWN"
end

-- Scan items & collect data
local rarityCounter = {MYTHIC = 0, GODLY = 0, SECRET = 0}
local itemsByRarity = {MYTHIC = {}, GODLY = {}, SECRET = {}}

for _, item in ipairs(itemFolder:GetChildren()) do
    local name = item.Name
    local rarity = getRarity(name)
    
    if rarity ~= "UNKNOWN" then
        rarityCounter[rarity] = rarityCounter[rarity] + 1
        table.insert(itemsByRarity[rarity], name)
    end
end

-- Create stat cards
createStatCard("MYTHIC", rarityCounter.MYTHIC, colors.mythic).Parent = statsFrame
createStatCard("GODLY", rarityCounter.GODLY, colors.godly).Parent = statsFrame
createStatCard("SECRET", rarityCounter.SECRET, colors.secret).Parent = statsFrame

-- Create item frames
for rarity, items in pairs(itemsByRarity) do
    for _, itemName in ipairs(items) do
        local itemFrame = Instance.new("Frame", scrollFrame)
        itemFrame.Size = UDim2.new(1, 0, 0, 60)
        itemFrame.BackgroundColor3 = colors.surface
        itemFrame.BorderSizePixel = 0
        
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
        
        -- Apply text effects based on rarity
        if rarity == "MYTHIC" then
            local glow = Instance.new("UIGradient", nameLabel)
            glow.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, colors.mythic),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 150, 255)),
                ColorSequenceKeypoint.new(1, colors.mythic)
            })
        elseif rarity == "GODLY" then
            spawn(function()
                while nameLabel.Parent do
                    for i = 0, 1, 0.03 do
                        if not nameLabel.Parent then break end
                        nameLabel.TextColor3 = Color3.fromHSV(i, 0.8, 1)
                        wait(0.1)
                    end
                end
            end)
        elseif rarity == "SECRET" then
            local stroke = Instance.new("UIStroke", nameLabel)
            stroke.Color = Color3.new(1, 1, 1)
            stroke.Thickness = 1
            stroke.Transparency = 0.3
        end
    end
end

-- Copy Function
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

-- Copy Button Action
copyBtn.MouseButton1Click:Connect(function()
    local stockText = generateStockText()
    
    -- Set clipboard (using setclipboard if available, otherwise show in output)
    pcall(function()
        setclipboard(stockText)
    end)
    
    -- Visual feedback
    local originalText = copyBtn.Text
    copyBtn.Text = "✅ COPIED!"
    
    wait(1.5)
    copyBtn.Text = originalText
    
    print(" Stock List Copied to Clipboard!")
    print("\n" .. stockText)
end)

-- Auto-resize scroll
local itemCount = rarityCounter.MYTHIC + rarityCounter.GODLY + rarityCounter.SECRET
local rows = math.ceil(itemCount / 2)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, rows * 65)

-- Close functionality
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Mobile optimization
scrollFrame.ScrollingEnabled = true
frame.Active = true
frame.Draggable = true

print("📱 Zarizz Mobile Checker Loaded!")
print("✨ Mythic:", rarityCounter.MYTHIC)
print("🌟 Godly:", rarityCounter.GODLY)  
print("💎 Secret:", rarityCounter.SECRET)
print("📦 Total:", rarityCounter.MYTHIC + rarityCounter.GODLY + rarityCounter.SECRET)
