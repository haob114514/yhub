--[[
    ═══════════════════════════════════════════════════════════
      ER 致命猴子  ·  WindUI 樱花主题版
      UI 框架 : WindUI (Footagesus)  https://github.com/Footagesus/WindUI
      主题    : SakuraNight / Sakura / SakuraLight（樱花三套）
      原作者  : Kela_er        界面重构 : WindUI Sakura Edition
    ═══════════════════════════════════════════════════════════
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local LoadStartTime = tick()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

for _, gui in ipairs(PlayerGui:GetChildren()) do
    if gui:IsA("ScreenGui") and gui.Name:find("ERHub_") then
        gui:Destroy()
    end
end

--═══════════════════════════════════════════════════════════
--  WindUI 载入（多镜像回退）
--═══════════════════════════════════════════════════════════
local WindUI
do
    local mirrors = {
        "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua",
        "https://cdn.jsdelivr.net/gh/Footagesus/WindUI@main/dist/main.lua",
        "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
        "https://tree-hub.vercel.app/api/UI/WindUI",
    }
    for _, url in ipairs(mirrors) do
        local ok, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if ok and type(result) == "table" and result.CreateWindow then
            WindUI = result
            break
        end
    end
    if not WindUI then
        warn("[ER] WindUI 载入失败，请检查网络或执行器 HttpGet 权限")
        return
    end
end

--═══════════════════════════════════════════════════════════
--  樱花主题（三套配色，基于内置 Dark 完整继承）
--═══════════════════════════════════════════════════════════
local function buildSakuraTheme(name, overrides)
    local base = {}
    local ok, themes = pcall(function() return WindUI:GetThemes() end)
    if ok and themes and themes.Dark then
        for k, v in pairs(themes.Dark) do
            base[k] = v
        end
    else
        base = {
            Dialog = Color3.fromHex("#1a1a1a"),
            Toggle = Color3.fromHex("#33C759"),
            Slider = Color3.fromHex("#0091FF"),
            Checkbox = Color3.fromHex("#0091FF"),
            PanelBackground = Color3.fromHex("#FFFFFF"),
            PanelBackgroundTransparency = 0.95,
            SliderIcon = Color3.fromHex("#908F95"),
            Primary = Color3.fromHex("#0091FF"),
            LabelBackground = Color3.fromHex("#000000"),
            LabelBackgroundTransparency = 0.83,
            ElementBackground = Color3.fromHex("#2A2A2C"),
            ElementBackgroundTransparency = 0,
        }
    end
    base.Name = name
    for k, v in pairs(overrides) do
        base[k] = v
    end
    pcall(function() WindUI:AddTheme(base) end)
    return base
end

-- 夜樱：深紫酒底 + 樱粉高光
buildSakuraTheme("SakuraNight", {
    Accent = Color3.fromHex("#FF8FB1"),
    Background = Color3.fromHex("#1B1116"),
    ElementBackground = Color3.fromHex("#2A1C23"),
    Dialog = Color3.fromHex("#241820"),
    Outline = Color3.fromHex("#FFB7C5"),
    Text = Color3.fromHex("#FFF1F5"),
    Placeholder = Color3.fromHex("#A98592"),
    Button = Color3.fromHex("#3B2630"),
    Icon = Color3.fromHex("#FFB7C5"),
    Toggle = Color3.fromHex("#FF8FB1"),
    Slider = Color3.fromHex("#FF8FB1"),
    Checkbox = Color3.fromHex("#FF8FB1"),
    Primary = Color3.fromHex("#FF8FB1"),
    SliderIcon = Color3.fromHex("#FFC2D4"),
})

-- 樱花：玫瑰褐底 + 柔樱粉
buildSakuraTheme("Sakura", {
    Accent = Color3.fromHex("#FFB7C5"),
    Background = Color3.fromHex("#2B1A22"),
    ElementBackground = Color3.fromHex("#3A2530"),
    Dialog = Color3.fromHex("#33202A"),
    Outline = Color3.fromHex("#FF9EB8"),
    Text = Color3.fromHex("#FFF6F8"),
    Placeholder = Color3.fromHex("#C9A0AE"),
    Button = Color3.fromHex("#4B2F3A"),
    Icon = Color3.fromHex("#FFC9D6"),
    Toggle = Color3.fromHex("#FF9EB8"),
    Slider = Color3.fromHex("#FF9EB8"),
    Checkbox = Color3.fromHex("#FF9EB8"),
    Primary = Color3.fromHex("#FF9EB8"),
    SliderIcon = Color3.fromHex("#FFD1DC"),
})

-- 樱白：奶油粉白底（浅色主题）
buildSakuraTheme("SakuraLight", {
    Accent = Color3.fromHex("#F06292"),
    Background = Color3.fromHex("#FFF1F5"),
    ElementBackground = Color3.fromHex("#FFFFFF"),
    Dialog = Color3.fromHex("#FFE7EE"),
    Outline = Color3.fromHex("#F8BBD0"),
    Text = Color3.fromHex("#5A3542"),
    Placeholder = Color3.fromHex("#C9A3AF"),
    Button = Color3.fromHex("#FFD9E3"),
    Icon = Color3.fromHex("#D81B60"),
    Toggle = Color3.fromHex("#EC407A"),
    Slider = Color3.fromHex("#EC407A"),
    Checkbox = Color3.fromHex("#EC407A"),
    Primary = Color3.fromHex("#EC407A"),
    SliderIcon = Color3.fromHex("#F48FB1"),
    LabelBackground = Color3.fromHex("#FFFFFF"),
    LabelBackgroundTransparency = 0.6,
})

--═══════════════════════════════════════════════════════════
--  樱花飘落特效（可在 UI 设置里关闭）
--═══════════════════════════════════════════════════════════
local SakuraFX = (function()
    local gui = Instance.new("ScreenGui")
    gui.Name = "ERHub_SakuraFX"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 2
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local running = false
    local petals = {}
    local PETAL_COLORS = {
        Color3.fromHex("#FFD1DC"),
        Color3.fromHex("#FFB7C5"),
        Color3.fromHex("#FF9EB8"),
        Color3.fromHex("#FFE4EC"),
    }

    local function makePetal()
        local p = Instance.new("Frame")
        p.Name = "SakuraPetal"
        p.Size = UDim2.fromOffset(math.random(5, 9), math.random(7, 12))
        p.BackgroundColor3 = PETAL_COLORS[math.random(1, #PETAL_COLORS)]
        p.BackgroundTransparency = 0.25
        p.BorderSizePixel = 0
        p.Rotation = math.random(0, 360)
        p.Parent = gui
        local c = Instance.new("UICorner", p)
        c.CornerRadius = UDim.new(1, 0)
        return p
    end

    local function drift(petal)
        if not running then return end
        local vp = Camera.ViewportSize
        local startX = math.random(-60, math.floor(vp.X) + 60)
        local sway = math.random(-90, 90)
        local duration = math.random(90, 170) / 10
        petal.Position = UDim2.fromOffset(startX, -20)
        petal.Rotation = math.random(0, 360)
        local moveInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local rotateInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local move = TweenService:Create(petal, moveInfo, {
            Position = UDim2.fromOffset(startX + sway, vp.Y + 30),
        })
        local rotate = TweenService:Create(petal, rotateInfo, {
            Rotation = petal.Rotation + math.random(180, 540),
        })
        move:Play()
        rotate:Play()
        move.Completed:Connect(function()
            if running then
                drift(petal)
            else
                petal:Destroy()
            end
        end)
    end

    local api = {}

    function api.Start()
        if running then return end
        running = true
        if not gui.Parent then gui.Parent = PlayerGui end
        for i = 1, 12 do
            local petal = makePetal()
            petals[i] = petal
            task.delay(math.random(0, 60) / 10, function()
                if petal.Parent then drift(petal) end
            end)
        end
    end

    function api.Stop()
        running = false
        for _, petal in ipairs(petals) do
            if petal and petal.Parent then petal:Destroy() end
        end
        petals = {}
        gui.Parent = nil
    end

    function api.SetEnabled(state)
        if state then api.Start() else api.Stop() end
    end

    api.SetEnabled(true)
    return api
end)()

--═══════════════════════════════════════════════════════════
--  主窗口
--═══════════════════════════════════════════════════════════
-- 重复执行脚本时先销毁上一份窗口，避免叠窗
if _G.__ERHubSakuraWindow then
    pcall(function() _G.__ERHubSakuraWindow:Destroy() end)
    _G.__ERHubSakuraWindow = nil
end

-- 确认主题已注册，否则回退内置 Dark，避免 CreateWindow 取到 nil 主题
local startTheme = "SakuraNight"
do
    local ok, themes = pcall(function() return WindUI:GetThemes() end)
    if not (ok and themes and themes.SakuraNight) then
        startTheme = "Dark"
    end
end

local Window = WindUI:CreateWindow({
    Title = "y定制脚本｜致命猴子",
    Icon = "flower-2",
    Author = "By y",
    Folder = "ERHubSakura",
    Size = UDim2.fromOffset(620, 470),
    MinSize = Vector2.new(480, 320),
    MaxSize = Vector2.new(1120, 720),
    Theme = startTheme,
    Transparent = false,
    Acrylic = false,
    Resizable = true,
    AutoScale = true,
    SideBarWidth = 172,
    ToggleKey = Enum.KeyCode.RightShift,
    OpenButton = {
        Title = "y定制脚本",
        Icon = "flower-2",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new(Color3.fromHex("#FF8FB1"), Color3.fromHex("#FFC2D4")),
    },
    User = { Enabled = false },
})

if not Window then
    warn("[ER] WindUI 已存在另一个窗口实例，本次执行已取消")
    return
end

pcall(function() Window:Tag({ Title = "WindUI · 樱花" }) end)
_G.__ERHubSakuraWindow = Window

local function notify(title, content, duration)
    pcall(function()
        WindUI:Notify({
            Title = title,
            Content = content,
            Duration = duration or 3,
        })
    end)
end

local function playSound(id, volume)
    local s = Instance.new("Sound", SoundService)
    s.SoundId = id
    s.Volume = volume or 0.5
    s:Play()
    task.delay(3, function() s:Destroy() end)
end

local AUTHOR_NAME = "kela_er1"

local monsterConfig = {
    { name = "Gus", parentPath = "GusMonster", childName = "Gus" },
    { name = "Kus", parentPath = "KusMonster", childName = "Kus" },
    { name = "Scar", parentPath = "Sandman/Ashy", childName = "Scar" },
    { name = "SandMan", parentPath = "Sandman/Ashy", childName = "SandMan" },
    { name = "Lurker", parentPath = "Sandman/Ashy", childName = "Lurker" },
    { name = "BloodMan", parentPath = "BloodmanMonster", childName = "BloodMan" },
    { name = "Ashy", parentPath = "Sandman/Ashy", childName = "Ashy" },
    { name = "Lost", parentPath = "LostMonster", childName = "Lost" },
    { name = "Dus", parentPath = "DusMonster", childName = "Dus" },
    { name = "SandGuy", parentPath = "Monsters", childName = "SandGuy" },
    { name = "Noxar", parentPath = "Monsters", childName = "Noxar" },
    { name = "Meat", parentPath = "Monsters", childName = "Meat" },
    { name = "Fearful", parentPath = "Monsters", childName = "Fearful" },
    { name = "Billy", parentPath = "Monsters", childName = "Billy" },
    { name = "Stalker", parentPath = "Stalker", childName = "Stalker" },
    { name = "John", parentPath = "Monsters", childName = "John" },
}

local espSettings = {
    enabled = false,
    highlightEnabled = true,
    nameEnabled = true,
    distanceEnabled = true,
    maxDistance = 500,
    highlightColor = Color3.fromRGB(255, 0, 0),
    outlineColor = Color3.fromRGB(255, 255, 255),
    nameColor = Color3.fromRGB(255, 255, 255),
    distanceColor = Color3.fromRGB(255, 235, 59),
    textSize = 14,
    fillTransparency = 0.5,
}

local monsterToggles = {}
for _, m in ipairs(monsterConfig) do
    monsterToggles[m.name] = true
end

local function resolveParent(parentPath)
    local ok, obj = pcall(function() return Workspace:FindFirstChild(parentPath, true) end)
    if ok and obj then return obj end
    if parentPath:find("/") then
        local current = Workspace
        for _, part in ipairs(string.split(parentPath, "/")) do
            current = current:FindFirstChild(part, true)
            if not current then return nil end
        end
        return current
    end
    return nil
end

local function getMonsterModel(monster)
    local parent = resolveParent(monster.parentPath)
    if not parent then return nil end
    local child = parent:FindFirstChild(monster.childName, true)
    if child and child:IsA("Model") then return child end
    if parent:IsA("Model") and parent.Name == monster.childName then return parent end
    if child then return child end
    return nil
end

local function getMonsterPart(model)
    if not model or not model:IsA("Model") then return nil end
    return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model.PrimaryPart
end

local espObjects = {}

local function clearMonsterESP(name)
    local cache = espObjects[name]
    if cache then
        if cache.highlight and cache.highlight.Parent then cache.highlight:Destroy() end
        if cache.billboard and cache.billboard.Parent then cache.billboard:Destroy() end
        espObjects[name] = nil
    end
end

local function clearAllESP()
    for name in pairs(espObjects) do
        clearMonsterESP(name)
    end
end

local function createHighlight(model, name)
    local hl = Instance.new("Highlight")
    hl.Name = "ESPHighlight_" .. name
    hl.Adornee = model
    hl.FillColor = espSettings.highlightColor
    hl.OutlineColor = espSettings.outlineColor
    hl.FillTransparency = espSettings.fillTransparency
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = model
    return hl
end

local function createBillboard(model, name)
    local head = model:FindFirstChild("Head") or getMonsterPart(model)
    if not head then return nil, nil end
    local bb = Instance.new("BillboardGui")
    bb.Name = "ESPBoard_" .. name
    bb.Adornee = head
    bb.Size = UDim2.new(0, 200, 0, 44)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.LightInfluence = 0
    bb.MaxDistance = espSettings.maxDistance * 10
    bb.Parent = head
    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(1, 0, 0, 22)
    nl.BackgroundTransparency = 1
    nl.Text = name
    nl.TextColor3 = espSettings.nameColor
    nl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nl.TextStrokeTransparency = 0
    nl.Font = Enum.Font.GothamBold
    nl.TextSize = espSettings.textSize
    nl.Visible = espSettings.nameEnabled
    nl.Parent = bb
    local dl = Instance.new("TextLabel")
    dl.Size = UDim2.new(1, 0, 0, 18)
    dl.Position = UDim2.new(0, 0, 0, 22)
    dl.BackgroundTransparency = 1
    dl.Text = "0m"
    dl.TextColor3 = espSettings.distanceColor
    dl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    dl.TextStrokeTransparency = 0
    dl.Font = Enum.Font.GothamSemibold
    dl.TextSize = espSettings.textSize - 2
    dl.Visible = espSettings.distanceEnabled
    dl.Parent = bb
    return bb, { nameLabel = nl, distLabel = dl }
end

local function updateMonsterESP(monster)
    local name = monster.name
    local model = getMonsterModel(monster)
    if not model then clearMonsterESP(name) return end
    if not espSettings.enabled or not monsterToggles[name] then
        clearMonsterESP(name)
        return
    end
    local part = getMonsterPart(model)
    if not part then
        clearMonsterESP(name)
        return
    end
    local distance = (Camera.CFrame.Position - part.Position).Magnitude
    if distance > espSettings.maxDistance then
        clearMonsterESP(name)
        return
    end
    local cache = espObjects[name]
    if not cache then
        cache = {}
        espObjects[name] = cache
    end
    if espSettings.highlightEnabled then
        if not cache.highlight or not cache.highlight.Parent then
            cache.highlight = createHighlight(model, name)
        else
            cache.highlight.FillColor = espSettings.highlightColor
            cache.highlight.OutlineColor = espSettings.outlineColor
            cache.highlight.FillTransparency = espSettings.fillTransparency
        end
    elseif cache.highlight then
        cache.highlight:Destroy()
        cache.highlight = nil
    end
    if espSettings.nameEnabled or espSettings.distanceEnabled then
        if not cache.billboard or not cache.billboard.Parent then
            cache.billboard, cache.labels = createBillboard(model, name)
        end
        if cache.labels then
            local nl, dl = cache.labels.nameLabel, cache.labels.distLabel
            if nl then
                nl.Text = name
                nl.TextColor3 = espSettings.nameColor
                nl.TextSize = espSettings.textSize
                nl.Visible = espSettings.nameEnabled
            end
            if dl then
                dl.Text = string.format("%.0f m", distance)
                dl.TextColor3 = espSettings.distanceColor
                dl.Visible = espSettings.distanceEnabled
            end
        end
    elseif cache.billboard then
        cache.billboard:Destroy()
        cache.billboard = nil
    end
end

local function updateAllESP()
    for _, m in ipairs(monsterConfig) do
        updateMonsterESP(m)
    end
end

local playerEspSettings = {
    enabled = false,
    highlightEnabled = true,
    nameEnabled = true,
    distanceEnabled = true,
    maxDistance = 1000,
    highlightColor = Color3.fromRGB(0, 255, 127),
    outlineColor = Color3.fromRGB(255, 255, 255),
    nameColor = Color3.fromRGB(0, 255, 127),
    distanceColor = Color3.fromRGB(255, 235, 59),
    textSize = 14,
    fillTransparency = 0.5,
    showSelf = false,
}

local playerEspObjects = {}

local function clearPlayerESP(plr)
    local cache = playerEspObjects[plr]
    if cache then
        if cache.highlight and cache.highlight.Parent then cache.highlight:Destroy() end
        if cache.billboard and cache.billboard.Parent then cache.billboard:Destroy() end
        playerEspObjects[plr] = nil
    end
end

local function clearAllPlayerESP()
    for plr in pairs(playerEspObjects) do
        clearPlayerESP(plr)
    end
end

local function createPlayerHighlight(char, plrName)
    local hl = Instance.new("Highlight")
    hl.Name = "PlayerESP_HL_" .. plrName
    hl.Adornee = char
    hl.FillColor = playerEspSettings.highlightColor
    hl.OutlineColor = playerEspSettings.outlineColor
    hl.FillTransparency = playerEspSettings.fillTransparency
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char
    return hl
end

local function createPlayerBillboard(char, plrName)
    local head = char:FindFirstChild("Head")
    if not head then return nil, nil end
    local bb = Instance.new("BillboardGui")
    bb.Name = "PlayerESP_Board_" .. plrName
    bb.Adornee = head
    bb.Size = UDim2.new(0, 200, 0, 44)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.LightInfluence = 0
    bb.MaxDistance = playerEspSettings.maxDistance * 10
    bb.Parent = head
    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(1, 0, 0, 22)
    nl.BackgroundTransparency = 1
    nl.Text = plrName
    nl.TextColor3 = playerEspSettings.nameColor
    nl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nl.TextStrokeTransparency = 0
    nl.Font = Enum.Font.GothamBold
    nl.TextSize = playerEspSettings.textSize
    nl.Visible = playerEspSettings.nameEnabled
    nl.Parent = bb
    local dl = Instance.new("TextLabel")
    dl.Size = UDim2.new(1, 0, 0, 18)
    dl.Position = UDim2.new(0, 0, 0, 22)
    dl.BackgroundTransparency = 1
    dl.Text = "0m"
    dl.TextColor3 = playerEspSettings.distanceColor
    dl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    dl.TextStrokeTransparency = 0
    dl.Font = Enum.Font.GothamSemibold
    dl.TextSize = playerEspSettings.textSize - 2
    dl.Visible = playerEspSettings.distanceEnabled
    dl.Parent = bb
    return bb, { nameLbl = nl, distLbl = dl }
end

local function updateSinglePlayerESP(plr)
    if plr == LocalPlayer and not playerEspSettings.showSelf then
        clearPlayerESP(plr)
        return
    end
    local char = plr.Character
    if not char or not char:IsA("Model") then
        clearPlayerESP(plr)
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    if not hrp then
        clearPlayerESP(plr)
        return
    end
    local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
    if distance > playerEspSettings.maxDistance then
        clearPlayerESP(plr)
        return
    end
    local cache = playerEspObjects[plr]
    if not cache then
        cache = {}
        playerEspObjects[plr] = cache
    end
    if playerEspSettings.highlightEnabled then
        if not cache.highlight or not cache.highlight.Parent then
            cache.highlight = createPlayerHighlight(char, plr.Name)
        else
            cache.highlight.FillColor = playerEspSettings.highlightColor
            cache.highlight.OutlineColor = playerEspSettings.outlineColor
            cache.highlight.FillTransparency = playerEspSettings.fillTransparency
        end
    elseif cache.highlight then
        cache.highlight:Destroy()
        cache.highlight = nil
    end
    if playerEspSettings.nameEnabled or playerEspSettings.distanceEnabled then
        if not cache.billboard or not cache.billboard.Parent then
            cache.billboard, cache.labels = createPlayerBillboard(char, plr.Name)
        end
        if cache.labels then
            local nl, dl = cache.labels.nameLbl, cache.labels.distLbl
            if nl then
                nl.Text = plr.Name
                nl.TextColor3 = playerEspSettings.nameColor
                nl.TextSize = playerEspSettings.textSize
                nl.Visible = playerEspSettings.nameEnabled
            end
            if dl then
                dl.Text = string.format("%.0f m", distance)
                dl.TextColor3 = playerEspSettings.distanceColor
                dl.Visible = playerEspSettings.distanceEnabled
            end
        end
    elseif cache.billboard then
        cache.billboard:Destroy()
        cache.billboard = nil
        cache.labels = nil
    end
end

local function updateAllPlayerESP()
    if not playerEspSettings.enabled then
        clearAllPlayerESP()
        return
    end
    local all = Players:GetPlayers()
    for plr in pairs(playerEspObjects) do
        if not table.find(all, plr) then
            clearPlayerESP(plr)
        end
    end
    for _, plr in ipairs(all) do
        updateSinglePlayerESP(plr)
    end
end

local authorEspObjects = {}

local function clearAuthorESP(plr)
    if authorEspObjects[plr] then
        for _, o in ipairs(authorEspObjects[plr]) do
            if o and o.Parent then o:Destroy() end
        end
        authorEspObjects[plr] = nil
    end
end

local function isAuthorPlayer(plr)
    return plr and string.lower(plr.Name) == string.lower(AUTHOR_NAME)
end

local authorAccum = 0
RunService.Heartbeat:Connect(function(dt)
    authorAccum = authorAccum + dt
    if authorAccum < 0.25 then return end
    authorAccum = 0
    pcall(function()
        for plr in pairs(authorEspObjects) do
            if not plr.Parent or not isAuthorPlayer(plr) then
                clearAuthorESP(plr)
            end
        end
        for _, plr in ipairs(Players:GetPlayers()) do
            if isAuthorPlayer(plr) and plr ~= LocalPlayer then
                local char = plr.Character
                if char and char:IsA("Model") then
                    local hrp = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
                    local head = char:FindFirstChild("Head")
                    if hrp and head then
                        if not authorEspObjects[plr] then
                            authorEspObjects[plr] = {}
                        end
                        local hl = char:FindFirstChild("AuthorESP_HL_" .. plr.Name)
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.Name = "AuthorESP_HL_" .. plr.Name
                            hl.Adornee = char
                            hl.FillColor = Color3.fromRGB(255, 215, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.FillTransparency = 0.45
                            hl.OutlineTransparency = 0
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            hl.Parent = char
                            table.insert(authorEspObjects[plr], hl)
                        end
                        local bb = head:FindFirstChild("AuthorESP_Board_" .. plr.Name)
                        local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
                        if not bb then
                            bb = Instance.new("BillboardGui")
                            bb.Name = "AuthorESP_Board_" .. plr.Name
                            bb.Adornee = head
                            bb.Size = UDim2.new(0, 220, 0, 60)
                            bb.StudsOffset = Vector3.new(0, 3, 0)
                            bb.AlwaysOnTop = true
                            bb.LightInfluence = 0
                            bb.Parent = head
                            local ttl = Instance.new("TextLabel")
                            ttl.Size = UDim2.new(1, 0, 0, 26)
                            ttl.BackgroundTransparency = 1
                            ttl.Text = "ER脚本作者"
                            ttl.TextColor3 = Color3.fromRGB(255, 215, 0)
                            ttl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            ttl.TextStrokeTransparency = 0
                            ttl.Font = Enum.Font.GothamBold
                            ttl.TextSize = 20
                            ttl.Parent = bb
                            local sub = Instance.new("TextLabel")
                            sub.Size = UDim2.new(1, 0, 0, 18)
                            sub.Position = UDim2.new(0, 0, 0, 26)
                            sub.BackgroundTransparency = 1
                            sub.Text = plr.Name
                            sub.TextColor3 = Color3.fromRGB(255, 255, 255)
                            sub.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            sub.TextStrokeTransparency = 0
                            sub.Font = Enum.Font.GothamSemibold
                            sub.TextSize = 14
                            sub.Parent = bb
                            local dist = Instance.new("TextLabel")
                            dist.Name = "DistLabel"
                            dist.Size = UDim2.new(1, 0, 0, 16)
                            dist.Position = UDim2.new(0, 0, 0, 44)
                            dist.BackgroundTransparency = 1
                            dist.Text = "0m"
                            dist.TextColor3 = Color3.fromRGB(255, 235, 59)
                            dist.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            dist.TextStrokeTransparency = 0
                            dist.Font = Enum.Font.GothamSemibold
                            dist.TextSize = 12
                            dist.Parent = bb
                            table.insert(authorEspObjects[plr], bb)
                        else
                            local dist = bb:FindFirstChild("DistLabel")
                            if dist then
                                dist.Text = string.format("%.0f m", distance)
                            end
                        end
                    end
                else
                    clearAuthorESP(plr)
                end
            end
        end
    end)
end)

Players.PlayerRemoving:Connect(function(plr)
    clearPlayerESP(plr)
    clearAuthorESP(plr)
end)

local espAccum, pAccum = 0, 0
RunService.Heartbeat:Connect(function(dt)
    if espSettings.enabled then
        espAccum = espAccum + dt
        if espAccum >= 0.1 then
            espAccum = 0
            updateAllESP()
        end
    end
    if playerEspSettings.enabled then
        pAccum = pAccum + dt
        if pAccum >= 0.1 then
            pAccum = 0
            updateAllPlayerESP()
        end
    end
end)

local jumpscareActive = false
local jumpscareObjectNames = {
    "ScarJumpscare","SandmanJumpscare","LurkerKill","LostJumpscare","KusJumpscare","GusJumpscare","DusJumpscare","BloodManKill","AshyJumpscare",
    "SandGuyJumpscare","NoxarJumpscare","MeatJumpscare","FearfulJumpscare","BillyJumpscare","StalkerJumpscare","JohnJumpscare"
}
local jumpscareScriptNames = {
    "PlayScarJumpscareAnimLocal","PlaySawRunnerJumpscareAnimLocal","PlaySandmanJumpscareAnimLocal","PlayLurkerJumpscareAnimLocal","PlayLostJumpscareAnimLocal","PlayKusJumpscareAnimLocal","PlayGusJumpscareAnimLocal","PlayDusJumpscareAnimLocal","PlayBloodManJumpscareAnimLocal","PlayAshyJumpscareAnimLocal",
    "PlaySandGuyJumpscareAnimLocal","PlayNoxarJumpscareAnimLocal","PlayMeatJumpscareAnimLocal","PlayFearfulJumpscareAnimLocal","PlayBillyJumpscareAnimLocal","PlayStalkerJumpscareAnimLocal","PlayJohnJumpscareAnimLocal"
}

local function purgeJumpscare()
    local jumpscares = Workspace:FindFirstChild("Jumpscares")
    if jumpscares then
        for _, n in ipairs(jumpscareObjectNames) do
            local obj = jumpscares:FindFirstChild(n)
            if obj then
                pcall(function() obj:Destroy() end)
            end
        end
        for _, obj in ipairs(jumpscares:GetChildren()) do
            local nm = obj.Name
            if nm:match("Jumpscare") or nm:match("Kill") or nm:match("Scare") then
                pcall(function() obj:Destroy() end)
            end
        end
    end
    local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    if playerScripts then
        for _, obj in ipairs(playerScripts:GetChildren()) do
            if table.find(jumpscareScriptNames, obj.Name) then
                pcall(function()
                    if obj:IsA("LocalScript") or obj:IsA("Script") then
                        obj.Enabled = false
                    end
                    obj:Destroy()
                end)
            end
        end
    end
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetChildren()) do
            local nm = gui.Name
            if nm:match("Jumpscare") or nm:match("Scare") or nm:match("JumpScare") then
                pcall(function() gui:Destroy() end)
            end
        end
    end
end

local function setJumpscareBlock(state)
    if state then
        if jumpscareActive then return end
        jumpscareActive = true
        purgeJumpscare()
        task.spawn(function()
            while jumpscareActive do
                purgeJumpscare()
                task.wait(0.3)
            end
        end)
    else
        jumpscareActive = false
    end
end

local playerSettings = {
    walkSpeed = 40,
    jumpPower = 60,
    gravity = 196,
    godMode = false
}

local function getHum()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function applySpeed()
    local hum = getHum()
    if hum then
        pcall(function() hum.WalkSpeed = playerSettings.walkSpeed end)
    end
end

local function applyJump()
    local hum = getHum()
    if hum then
        pcall(function()
            hum.UseJumpPower = true
            hum.JumpPower = playerSettings.jumpPower
        end)
        pcall(function() hum.JumpHeight = playerSettings.jumpPower / 7 end)
    end
end

local infJumpConn = nil
local function setInfJump(state)
    if state then
        if infJumpConn then return end
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            local hum = getHum()
            if hum then
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end)
    elseif infJumpConn then
        infJumpConn:Disconnect()
        infJumpConn = nil
    end
end

local function applyGravity()
    pcall(function() Workspace.Gravity = playerSettings.gravity end)
end

local fastInteractEnabled = false
local fastInteractConns = {}
local fastInteractLoopId = 0

local function makeFast(prompt)
    if prompt:IsA("ProximityPrompt") then
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false
    end
end

local function fastScanAll()
    for _, v in ipairs(Workspace:GetDescendants()) do
        makeFast(v)
    end
end

local function setFastInteract(state)
    fastInteractEnabled = state
    if state then
        fastInteractLoopId = fastInteractLoopId + 1
        local myId = fastInteractLoopId
        fastScanAll()
        table.insert(fastInteractConns, Workspace.DescendantAdded:Connect(makeFast))
        table.insert(fastInteractConns, LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if fastInteractEnabled and myId == fastInteractLoopId then
                fastScanAll()
            end
        end))
        task.spawn(function()
            while fastInteractEnabled and myId == fastInteractLoopId do
                task.wait(5)
                if fastInteractEnabled and myId == fastInteractLoopId then
                    fastScanAll()
                end
            end
        end)
    else
        for _, conn in ipairs(fastInteractConns) do
            pcall(function() conn:Disconnect() end)
        end
        fastInteractConns = {}
    end
end

local keepThirdPerson = true
local function ApplyCamera()
    if keepThirdPerson then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        LocalPlayer.CameraMinZoomDistance = 0.5
        LocalPlayer.CameraMaxZoomDistance = 128
    else
        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        LocalPlayer.CameraMinZoomDistance = 0.5
        LocalPlayer.CameraMaxZoomDistance = 0.5
    end
end

task.spawn(function()
    task.wait(1)
    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        ApplyCamera()
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    ApplyCamera()
    applySpeed()
    applyJump()
    if playerSettings.godMode then
        local hum = getHum()
        if hum then
            pcall(function() hum.BreakJointsOnDeath = false end)
        end
    end
end)

if LocalPlayer.Character then
    ApplyCamera()
end

task.spawn(function()
    task.wait(0.5)
    applySpeed()
    applyJump()
end)

local assistSettings = {
    brightnessEnabled = false,
    brightnessLevel = 2
}

local brightnessPresets = {
    [1] = { brightness = 3, clockTime = 14, fogEnd = 100000, ambient = Color3.fromRGB(150, 150, 150), outdoorAmbient = Color3.fromRGB(150, 150, 150) },
    [2] = { brightness = 6, clockTime = 12, fogEnd = 1000000, ambient = Color3.fromRGB(200, 200, 200), outdoorAmbient = Color3.fromRGB(200, 200, 200) },
    [3] = { brightness = 20, clockTime = 12, fogEnd = 10000000, ambient = Color3.fromRGB(255, 255, 255), outdoorAmbient = Color3.fromRGB(255, 255, 255) },
}

local lightingOriginal = {}

local function applyBrightness()
    local preset = brightnessPresets[assistSettings.brightnessLevel]
    if not preset then return end
    if not next(lightingOriginal) then
        pcall(function()
            lightingOriginal.Brightness = Lighting.Brightness
            lightingOriginal.ClockTime = Lighting.ClockTime
            lightingOriginal.FogEnd = Lighting.FogEnd
            lightingOriginal.Ambient = Lighting.Ambient
            lightingOriginal.OutdoorAmbient = Lighting.OutdoorAmbient
            lightingOriginal.GlobalShadows = Lighting.GlobalShadows
        end)
    end
    pcall(function() Lighting.Brightness = preset.brightness end)
    pcall(function() Lighting.ClockTime = preset.clockTime end)
    pcall(function() Lighting.FogEnd = preset.fogEnd end)
    pcall(function() Lighting.Ambient = preset.ambient end)
    pcall(function() Lighting.OutdoorAmbient = preset.outdoorAmbient end)
    pcall(function() Lighting.GlobalShadows = false end)
end

local function restoreBrightness()
    if not next(lightingOriginal) then return end
    pcall(function() Lighting.Brightness = lightingOriginal.Brightness end)
    pcall(function() Lighting.ClockTime = lightingOriginal.ClockTime end)
    pcall(function() Lighting.FogEnd = lightingOriginal.FogEnd end)
    pcall(function() Lighting.Ambient = lightingOriginal.Ambient end)
    pcall(function() Lighting.OutdoorAmbient = lightingOriginal.OutdoorAmbient end)
    pcall(function() Lighting.GlobalShadows = lightingOriginal.GlobalShadows end)
    lightingOriginal = {}
end

local function fireRespawn()
    local evt = ReplicatedStorage:FindFirstChild("RequestRespawn") or ReplicatedStorage:WaitForChild("RequestRespawn", 3)
    if not evt then
        notify("致命猴子", "未找到 RequestRespawn", 3)
        return false
    end
    return pcall(function()
        if evt:IsA("RemoteEvent") then
            evt:FireServer()
        elseif evt:IsA("RemoteFunction") then
            evt:InvokeServer()
        elseif evt:IsA("BindableEvent") then
            evt:Fire()
        end
    end)
end

local function clickGameRespawnButton()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return false end
    local target = nil
    local ok = pcall(function()
        for _, obj in ipairs(playerGui:GetDescendants()) do
            if obj:IsA("GuiButton") and obj.Visible then
                local nm = string.lower(obj.Name)
                local txt = ""
                if obj:IsA("TextButton") then
                    txt = string.lower(obj.Text or "")
                end
                if nm:find("respawn") or nm:find("revive") or nm:find("rebirth") or txt:find("复活") or txt:find("重生") or txt:find("respawn") or txt:find("revive") then
                    target = obj
                    break
                end
            end
        end
    end)
    if ok and target then
        local fired = pcall(function()
            target.MouseButton1Click:Fire()
            target.Activated:Fire()
        end)
        return fired
    end
    return false
end

local function tryRespawn()
    if clickGameRespawnButton() then return true end
    return fireRespawn()
end

local autoRespawnConn = nil
local function setAutoRespawn(state)
    if state then
        if autoRespawnConn then return end
        autoRespawnConn = LocalPlayer.CharacterAdded:Connect(function(char)
            local hum = char:WaitForChild("Humanoid", 5)
            if not hum then return end
            hum.Died:Connect(function()
                task.wait(0.5)
                fireRespawn()
            end)
        end)
    elseif autoRespawnConn then
        autoRespawnConn:Disconnect()
        autoRespawnConn = nil
    end
end

local ColorTables = {
    red = Color3.fromRGB(255, 0, 0),
    green = Color3.fromRGB(0, 255, 0),
    blue = Color3.fromRGB(0, 0, 255),
    yellow = Color3.fromRGB(255, 255, 0),
    purple = Color3.fromRGB(128, 0, 255),
    cyan = Color3.fromRGB(0, 255, 255),
    white = Color3.fromRGB(255, 255, 255),
    black = Color3.fromRGB(0, 0, 0),
    orange = Color3.fromRGB(255, 150, 60),
    sgreen = Color3.fromRGB(0, 255, 127),
}

local safeZoneActive = false
local safeZoneConns = {}

local function destroySafeZones()
    pcall(function()
        local targets = {}
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("MeshPart") then
                if v.Name == "safe" or v.Name == "SafeZone" then
                    table.insert(targets, v)
                end
            elseif v:IsA("Folder") and (v.Name == "SafeZone" or v.Name == "AntiVoid") then
                table.insert(targets, v)
            end
        end
        for _, v in ipairs(targets) do
            pcall(function() v:Destroy() end)
        end
    end)
end

local function safeZoneOnAdded(d)
    task.defer(function()
        if not d or not d.Parent then return end
        if (d:IsA("BasePart") or d:IsA("MeshPart")) and (d.Name == "safe" or d.Name == "SafeZone") then
            pcall(function() d:Destroy() end)
        elseif d:IsA("Folder") and (d.Name == "SafeZone" or d.Name == "AntiVoid") then
            pcall(function() d:Destroy() end)
        end
    end)
end

local function setSafeZoneBlock(state)
    if state then
        if safeZoneActive then return end
        safeZoneActive = true
        destroySafeZones()
        table.insert(safeZoneConns, Workspace.DescendantAdded:Connect(safeZoneOnAdded))
        task.spawn(function()
            while safeZoneActive do
                task.wait(1)
                if not safeZoneActive then break end
                destroySafeZones()
            end
        end)
    else
        safeZoneActive = false
        for _, c in ipairs(safeZoneConns) do
            pcall(function() c:Disconnect() end)
        end
        safeZoneConns = {}
    end
end

local antiSlipActive = false
local antiSlipConn = nil

local function antiSlipStep()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not humanoidRootPart or humanoid.Health <= 0 then return end
    local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
    local moveDirection = humanoid.MoveDirection
    local walkSpeed = humanoid.WalkSpeed
    if walkSpeed <= 0 or walkSpeed > 200 then return end
    if moveDirection.Magnitude < 0.05 then
        if math.abs(assemblyLinearVelocity.X) > 0.01 or math.abs(assemblyLinearVelocity.Z) > 0.01 then
            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, assemblyLinearVelocity.Y, 0)
        end
    else
        local target = moveDirection.Unit * walkSpeed
        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(target.X, assemblyLinearVelocity.Y, target.Z)
    end
end

local function setAntiSlip(state)
    antiSlipActive = state
    if state then
        if antiSlipConn then return end
        antiSlipConn = RunService.Heartbeat:Connect(antiSlipStep)
    else
        if antiSlipConn then
            antiSlipConn:Disconnect()
            antiSlipConn = nil
        end
    end
end

local antiRagdollEnabled = false
local antiRagdollActiveChars = {}
local antiRagdollPlayerConns = {}
local antiRagdollPlayerAddedConn = nil

local AntiRagdoll = {}
local RAGDOLL_MOTORS = {
    Neck = "UpperTorso",
    Waist = "LowerTorso",
    Root = "LowerTorso",
    LeftShoulder = "LeftUpperArm",
    LeftElbow = "LeftLowerArm",
    LeftWrist = "LeftHand",
    RightShoulder = "RightUpperArm",
    RightElbow = "RightLowerArm",
    RightWrist = "RightHand",
    LeftHip = "LeftUpperLeg",
    LeftKnee = "LeftLowerLeg",
    LeftAnkle = "LeftFoot",
    RightHip = "RightUpperLeg",
    RightKnee = "RightLowerLeg",
    RightAnkle = "RightFoot",
}

local ragdollStates = {
    [Enum.HumanoidStateType.FallingDown] = true,
    [Enum.HumanoidStateType.Ragdoll] = true,
    [Enum.HumanoidStateType.Physics] = true,
}

local function isRagdollConstraint(obj)
    if obj:IsA("BallSocketConstraint") then
        return obj.Name:find("Ragdoll") ~= nil
    end
    if obj:IsA("AnimationConstraint") then
        return obj.Name:find("Ragdoll") ~= nil
    end
    return false
end

local function fixMotors(character)
    for name, parentName in pairs(RAGDOLL_MOTORS) do
        local parent = character:FindFirstChild(parentName)
        if parent then
            local motor = parent:FindFirstChild(name)
            if motor and motor:IsA("Motor6D") and not motor.Enabled then
                motor.Enabled = true
            end
        end
    end
end

local function clearRagdoll(character)
    for _, obj in ipairs(character:GetDescendants()) do
        if isRagdollConstraint(obj) then
            pcall(function() obj:Destroy() end)
        end
    end
end

local function unstick(humanoid)
    if ragdollStates[humanoid:GetState()] then
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
    if humanoid.PlatformStand then
        humanoid.PlatformStand = false
    end
end

function AntiRagdoll.restore(character)
    if not character or not character.Parent then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    clearRagdoll(character)
    fixMotors(character)
    unstick(humanoid)
end

function AntiRagdoll.protect(character)
    if not character or antiRagdollActiveChars[character] then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        humanoid = character:WaitForChild("Humanoid", 10)
    end
    if not humanoid or not character.Parent then return end
    local conns = {}
    conns[#conns + 1] = character.DescendantAdded:Connect(function(obj)
        if isRagdollConstraint(obj) then
            obj:Destroy()
        elseif obj:IsA("Motor6D") and not obj.Enabled then
            obj.Enabled = true
        end
    end)
    conns[#conns + 1] = humanoid.StateChanged:Connect(function(_, new)
        if ragdollStates[new] then
            task.defer(function()
                if humanoid.Parent and humanoid.Health > 0 then
                    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end)
        end
    end)
    conns[#conns + 1] = humanoid:GetPropertyChangedSignal("PlatformStand"):Connect(function()
        if humanoid.PlatformStand and humanoid.Health > 0 then
            humanoid.PlatformStand = false
        end
    end)
    conns[#conns + 1] = humanoid.Died:Connect(function()
        AntiRagdoll.unprotect(character)
    end)
    antiRagdollActiveChars[character] = conns
    AntiRagdoll.restore(character)
end

function AntiRagdoll.unprotect(character)
    local conns = antiRagdollActiveChars[character]
    if not conns then return end
    antiRagdollActiveChars[character] = nil
    for _, c in ipairs(conns) do
        if c.Connected then c:Disconnect() end
    end
end

local function setupAntiRagdollPlayer(player)
    if antiRagdollPlayerConns[player] then return end
    local conns = {}
    conns[#conns + 1] = player.CharacterAdded:Connect(function(char)
        if antiRagdollEnabled then
            task.spawn(function() AntiRagdoll.protect(char) end)
        end
    end)
    conns[#conns + 1] = player.CharacterRemoving:Connect(function(char)
        AntiRagdoll.unprotect(char)
    end)
    antiRagdollPlayerConns[player] = conns
    if player.Character and antiRagdollEnabled then
        task.spawn(function() AntiRagdoll.protect(player.Character) end)
    end
end

local function clearAntiRagdollPlayer(player)
    local conns = antiRagdollPlayerConns[player]
    if conns then
        for _, c in ipairs(conns) do
            if c.Connected then c:Disconnect() end
        end
        antiRagdollPlayerConns[player] = nil
    end
    if player.Character then
        AntiRagdoll.unprotect(player.Character)
    end
end

local function setAntiRagdoll(state)
    antiRagdollEnabled = state
    if state then
        if antiRagdollPlayerAddedConn then return end
        _G.AntiRagdoll = AntiRagdoll
        for _, p in ipairs(Players:GetPlayers()) do
            setupAntiRagdollPlayer(p)
        end
        antiRagdollPlayerAddedConn = Players.PlayerAdded:Connect(setupAntiRagdollPlayer)
    else
        if antiRagdollPlayerAddedConn then
            antiRagdollPlayerAddedConn:Disconnect()
            antiRagdollPlayerAddedConn = nil
        end
        for _, p in ipairs(Players:GetPlayers()) do
            clearAntiRagdollPlayer(p)
        end
        local chars = {}
        for char in pairs(antiRagdollActiveChars) do
            table.insert(chars, char)
        end
        for _, char in ipairs(chars) do
            AntiRagdoll.unprotect(char)
        end
        _G.AntiRagdoll = nil
    end
end

Players.PlayerRemoving:Connect(function(plr)
    clearAntiRagdollPlayer(plr)
end)

local scrapEspSettings = {
    enabled = false,
    highlightEnabled = true,
    nameEnabled = true,
    distanceEnabled = true,
    recyclerEnabled = true,
    maxDistance = 500,
    highlightColor = Color3.fromRGB(0, 255, 100),
    outlineColor = Color3.fromRGB(255, 255, 255),
    nameColor = Color3.fromRGB(0, 255, 100),
    distanceColor = Color3.fromRGB(255, 235, 59),
    textSize = 14,
    fillTransparency = 0.5,
}

local RECYCLER_COLOR = Color3.fromRGB(170, 85, 255)
local SCRAP_NAME_SET = {
    Screw = true, Pipe = true, Bucket = true, Baterry = true, Battery = true,
    Gear = true, Cleaner = true, Emerald = true, Amethyst = true, AmethystCrystal = true,
    Diamond = true, Gold = true, Copper = true, Meat = true,
}

local scrapsFolderCache = nil
local goldsFolderCache = nil

local function getScrapsFolder()
    if scrapsFolderCache and scrapsFolderCache.Parent == Workspace then return scrapsFolderCache end
    scrapsFolderCache = Workspace:FindFirstChild("Scraps")
    return scrapsFolderCache
end

local function getGoldsFolder()
    if goldsFolderCache and goldsFolderCache.Parent == Workspace then return goldsFolderCache end
    goldsFolderCache = Workspace:FindFirstChild("Golds")
    return goldsFolderCache
end

local function getScrapAnchor(obj)
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") or obj:IsA("Tool") then
        return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
    end
    return nil
end

local function getScrapRoot(obj)
    local scraps = getScrapsFolder()
    local golds = getGoldsFolder()
    local root = obj
    local p = obj.Parent
    while p and p ~= Workspace and p ~= scraps and p ~= golds do
        if SCRAP_NAME_SET[p.Name] or p.Name == "ScrapRecycler" then
            return p
        end
        root = p
        p = p.Parent
    end
    return root
end

local function classifyScrap(obj)
    if not (obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("Tool")) then return nil end
    if obj.Name == "ScrapRecycler" then
        if getScrapRoot(obj) ~= obj then return nil end
        return "recycler"
    end
    local kind = nil
    if SCRAP_NAME_SET[obj.Name] then
        kind = "scrap"
    else
        local scraps = getScrapsFolder()
        if scraps and obj ~= scraps and obj:IsDescendantOf(scraps) then
            kind = "scrap"
        end
        if not kind then
            local golds = getGoldsFolder()
            if golds and obj ~= golds and obj:IsDescendantOf(golds) then
                kind = "scrap"
            end
        end
    end
    if not kind then return nil end
    local root = getScrapRoot(obj)
    if root ~= obj then return nil end
    return kind
end

local scrapEspObjects = {}

local function isScrapTargetValid(obj)
    if not obj or not obj.Parent then return false end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and obj:IsDescendantOf(plr.Character) then return false end
        local bp = plr:FindFirstChild("Backpack")
        if bp and obj:IsDescendantOf(bp) then return false end
    end
    local anchor = getScrapAnchor(obj)
    if not anchor then return false end
    if anchor.Transparency >= 0.99 then return false end
    if anchor.Position.Y < -500 then return false end
    return true
end

local function clearScrapESP(obj)
    local cache = scrapEspObjects[obj]
    if not cache then return end
    if cache.ancestryConn then
        pcall(function() cache.ancestryConn:Disconnect() end)
        cache.ancestryConn = nil
    end
    if cache.highlight then
        pcall(function() cache.highlight:Destroy() end)
        cache.highlight = nil
    end
    if cache.billboard then
        pcall(function() cache.billboard:Destroy() end)
        cache.billboard = nil
    end
    cache.labels = nil
    scrapEspObjects[obj] = nil
end

local function clearAllScrapESP()
    for obj in pairs(scrapEspObjects) do
        clearScrapESP(obj)
    end
end

local function updateSingleScrapESP(obj)
    local cache = scrapEspObjects[obj]
    local kind = classifyScrap(obj)
    if not scrapEspSettings.enabled or not kind then
        if cache then clearScrapESP(obj) end
        return
    end
    if kind == "recycler" and not scrapEspSettings.recyclerEnabled then
        if cache then clearScrapESP(obj) end
        return
    end
    if not isScrapTargetValid(obj) then
        if cache then clearScrapESP(obj) end
        return
    end
    local anchor = getScrapAnchor(obj)
    if not anchor then
        if cache then clearScrapESP(obj) end
        return
    end
    local distance = (Camera.CFrame.Position - anchor.Position).Magnitude
    if distance > scrapEspSettings.maxDistance then
        if cache then clearScrapESP(obj) end
        return
    end
    if not cache then
        cache = { kind = kind }
        scrapEspObjects[obj] = cache
        cache.ancestryConn = obj.AncestryChanged:Connect(function()
            pcall(updateSingleScrapESP, obj)
        end)
    end
    cache.kind = kind
    if scrapEspSettings.highlightEnabled then
        local fillColor = (kind == "recycler") and RECYCLER_COLOR or scrapEspSettings.highlightColor
        if not cache.highlight or not cache.highlight.Parent then
            local hl = Instance.new("Highlight")
            hl.Name = "ScrapESP_HL"
            hl.Adornee = obj
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.OutlineTransparency = 0
            hl.Parent = obj
            cache.highlight = hl
        end
        cache.highlight.FillColor = fillColor
        cache.highlight.OutlineColor = scrapEspSettings.outlineColor
        cache.highlight.FillTransparency = scrapEspSettings.fillTransparency
    elseif cache.highlight then
        pcall(function() cache.highlight:Destroy() end)
        cache.highlight = nil
    end
    if scrapEspSettings.nameEnabled or scrapEspSettings.distanceEnabled then
        if not cache.billboard or not cache.billboard.Parent then
            local bb = Instance.new("BillboardGui")
            bb.Name = "ScrapESP_Board"
            bb.Adornee = anchor
            bb.Size = UDim2.new(0, 200, 0, 44)
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.AlwaysOnTop = true
            bb.LightInfluence = 0
            bb.MaxDistance = scrapEspSettings.maxDistance * 10
            bb.Parent = anchor
            local nl = Instance.new("TextLabel")
            nl.Name = "NameLabel"
            nl.Size = UDim2.new(1, 0, 0, 22)
            nl.BackgroundTransparency = 1
            nl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nl.TextStrokeTransparency = 0
            nl.Font = Enum.Font.GothamBold
            nl.Parent = bb
            local dl = Instance.new("TextLabel")
            dl.Name = "DistLabel"
            dl.Size = UDim2.new(1, 0, 0, 18)
            dl.Position = UDim2.new(0, 0, 0, 22)
            dl.BackgroundTransparency = 1
            dl.Text = "0m"
            dl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            dl.TextStrokeTransparency = 0
            dl.Font = Enum.Font.GothamSemibold
            dl.Parent = bb
            cache.billboard = bb
            cache.labels = { name = nl, dist = dl }
        end
        local nl = cache.labels and cache.labels.name
        local dl = cache.labels and cache.labels.dist
        if nl then
            nl.Text = (kind == "recycler") and "废品回收机" or obj.Name
            nl.TextColor3 = (kind == "recycler") and RECYCLER_COLOR or scrapEspSettings.nameColor
            nl.TextSize = scrapEspSettings.textSize
            nl.Visible = scrapEspSettings.nameEnabled
        end
        if dl then
            dl.Text = string.format("%.0f m", distance)
            dl.TextColor3 = scrapEspSettings.distanceColor
            dl.TextSize = math.max(scrapEspSettings.textSize - 2, 8)
            dl.Visible = scrapEspSettings.distanceEnabled
        end
    elseif cache.billboard then
        pcall(function() cache.billboard:Destroy() end)
        cache.billboard = nil
        cache.labels = nil
    end
end

local function updateAllScrapESP()
    for obj in pairs(scrapEspObjects) do
        pcall(updateSingleScrapESP, obj)
    end
end

local function scanAllScraps()
    pcall(function()
        for _, d in ipairs(Workspace:GetDescendants()) do
            if classifyScrap(d) then
                updateSingleScrapESP(d)
            end
        end
    end)
end

Workspace.DescendantAdded:Connect(function(d)
    if not scrapEspSettings.enabled then return end
    task.defer(function()
        if classifyScrap(d) then
            pcall(updateSingleScrapESP, d)
        else
            local root = getScrapRoot(d)
            if root and classifyScrap(root) then
                pcall(updateSingleScrapESP, root)
            end
        end
    end)
end)

local scrapValidateAccum, scrapScanAccum = 0, 0
RunService.Heartbeat:Connect(function(dt)
    if not scrapEspSettings.enabled then
        if next(scrapEspObjects) then clearAllScrapESP() end
        return
    end
    scrapValidateAccum = scrapValidateAccum + dt
    scrapScanAccum = scrapScanAccum + dt
    if scrapValidateAccum >= 0.3 then
        scrapValidateAccum = 0
        updateAllScrapESP()
    end
    if scrapScanAccum >= 2 then
        scrapScanAccum = 0
        scanAllScraps()
    end
end)

--═══════════════════════════════════════════════════════════
--  Tab：公告
--══════════════════════════════════════════════════════════

--═══════════════════════════════════════════════════════════
--  Tab：怪物透视
--═══════════════════════════════════════════════════════════
local TabMonster = Window:Tab({ Title = "怪物透视", Icon = "eye" })

TabMonster:Section({ Title = "总开关", Icon = "power" })
TabMonster:Toggle({
    Title = "ESP 总开关",
    Desc = "统一控制所有怪物的透视绘制",
    Icon = "eye",
    Value = false,
    Callback = function(state)
        espSettings.enabled = state
        if not state then clearAllESP() end
        notify("致命猴子", state and "怪物透视已开启" or "怪物透视已关闭", 3)
    end,
})

TabMonster:Section({ Title = "显示选项", Icon = "sliders-horizontal" })
TabMonster:Toggle({
    Title = "怪物高亮",
    Desc = "为怪物模型添加轮廓填充",
    Value = true,
    Callback = function(v) espSettings.highlightEnabled = v end,
})
TabMonster:Toggle({
    Title = "怪物名字",
    Value = true,
    Callback = function(v) espSettings.nameEnabled = v end,
})
TabMonster:Toggle({
    Title = "距离显示",
    Value = true,
    Callback = function(v) espSettings.distanceEnabled = v end,
})

TabMonster:Section({ Title = "参数调节", Icon = "settings" })
TabMonster:Slider({
    Title = "最大显示距离",
    Desc = "超出该距离的怪物不绘制",
    Value = { Min = 50, Max = 2000, Default = 500 },
    Step = 10,
    Callback = function(v) espSettings.maxDistance = v end,
})
TabMonster:Slider({
    Title = "填充透明度",
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(v) espSettings.fillTransparency = v / 100 end,
})
TabMonster:Slider({
    Title = "文字大小",
    Value = { Min = 10, Max = 24, Default = 14 },
    Callback = function(v) espSettings.textSize = v end,
})

TabMonster:Section({ Title = "怪物单独开关", Icon = "list" })
for _, m in ipairs(monsterConfig) do
    TabMonster:Toggle({
        Title = m.name,
        Value = true,
        Callback = function(v) monsterToggles[m.name] = v end,
    })
end

--═══════════════════════════════════════════════════════════
--  Tab：颜色设置
--═══════════════════════════════════════════════════════════
local TabColor = Window:Tab({ Title = "颜色设置", Icon = "palette" })

TabColor:Section({ Title = "怪物 ESP 颜色", Icon = "palette" })
local pickerMonsterFill = TabColor:Colorpicker({
    Title = "高亮填充颜色",
    Desc = "怪物高亮的内部填充色",
    Default = espSettings.highlightColor,
    Callback = function(color) espSettings.highlightColor = color end,
})
local pickerMonsterOutline = TabColor:Colorpicker({
    Title = "高亮描边颜色",
    Default = espSettings.outlineColor,
    Callback = function(color) espSettings.outlineColor = color end,
})
local pickerMonsterName = TabColor:Colorpicker({
    Title = "怪物名字颜色",
    Default = espSettings.nameColor,
    Callback = function(color) espSettings.nameColor = color end,
})
local pickerMonsterDist = TabColor:Colorpicker({
    Title = "距离文字颜色",
    Default = espSettings.distanceColor,
    Callback = function(color) espSettings.distanceColor = color end,
})

TabColor:Section({ Title = "樱花推荐配色", Icon = "flower-2" })
TabColor:Button({
    Title = "应用樱花粉配色",
    Desc = "填充 #FFB7C5 / 描边 #FFFFFF",
    Icon = "cherry",
    IconAlign = "Left",
    Color = Color3.fromHex("#F06292"),
    Callback = function()
        local fill = Color3.fromHex("#FFB7C5")
        local outline = Color3.fromHex("#FFFFFF")
        local nameColor = Color3.fromHex("#FFD1DC")
        local distColor = Color3.fromHex("#FFE4EC")
        espSettings.highlightColor = fill
        espSettings.outlineColor = outline
        espSettings.nameColor = nameColor
        espSettings.distanceColor = distColor
        pcall(function()
            pickerMonsterFill:Set(fill)
            pickerMonsterOutline:Set(outline)
            pickerMonsterName:Set(nameColor)
            pickerMonsterDist:Set(distColor)
        end)
        notify("致命猴子", "已应用樱花粉配色", 3)
    end,
})

--═══════════════════════════════════════════════════════════
--  Tab：玩家透视
--═══════════════════════════════════════════════════════════
local TabPlayerESP = Window:Tab({ Title = "玩家透视", Icon = "users" })

TabPlayerESP:Section({ Title = "总开关", Icon = "power" })
TabPlayerESP:Toggle({
    Title = "玩家透视总开关",
    Desc = "绘制其他玩家的高亮与信息",
    Icon = "users",
    Value = false,
    Callback = function(state)
        playerEspSettings.enabled = state
        if not state then clearAllPlayerESP() end
        notify("致命猴子", state and "玩家透视已开启" or "玩家透视已关闭", 3)
    end,
})

TabPlayerESP:Section({ Title = "显示选项", Icon = "sliders-horizontal" })
TabPlayerESP:Toggle({
    Title = "玩家高亮",
    Value = true,
    Callback = function(v) playerEspSettings.highlightEnabled = v end,
})
TabPlayerESP:Toggle({
    Title = "玩家名字",
    Value = true,
    Callback = function(v) playerEspSettings.nameEnabled = v end,
})
TabPlayerESP:Toggle({
    Title = "距离显示",
    Value = true,
    Callback = function(v) playerEspSettings.distanceEnabled = v end,
})
TabPlayerESP:Toggle({
    Title = "显示自己",
    Value = false,
    Callback = function(v) playerEspSettings.showSelf = v end,
})

TabPlayerESP:Section({ Title = "参数调节", Icon = "settings" })
TabPlayerESP:Slider({
    Title = "最大显示距离",
    Value = { Min = 50, Max = 3000, Default = 1000 },
    Step = 10,
    Callback = function(v) playerEspSettings.maxDistance = v end,
})
TabPlayerESP:Slider({
    Title = "填充透明度",
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(v) playerEspSettings.fillTransparency = v / 100 end,
})
TabPlayerESP:Slider({
    Title = "文字大小",
    Value = { Min = 10, Max = 24, Default = 14 },
    Callback = function(v) playerEspSettings.textSize = v end,
})

TabPlayerESP:Section({ Title = "颜色设置", Icon = "palette" })
TabPlayerESP:Colorpicker({
    Title = "高亮填充颜色",
    Default = playerEspSettings.highlightColor,
    Callback = function(color) playerEspSettings.highlightColor = color end,
})
TabPlayerESP:Colorpicker({
    Title = "玩家名字颜色",
    Default = playerEspSettings.nameColor,
    Callback = function(color) playerEspSettings.nameColor = color end,
})

--═══════════════════════════════════════════════════════════
--  Tab：变卖物透视
--═══════════════════════════════════════════════════════════
local TabScrap = Window:Tab({ Title = "变卖物透视", Icon = "gem" })

TabScrap:Section({ Title = "总开关", Icon = "power" })
TabScrap:Toggle({
    Title = "变卖物透视总开关",
    Desc = "高亮场景中的可变卖物资与回收机",
    Icon = "gem",
    Value = false,
    Callback = function(state)
        scrapEspSettings.enabled = state
        if not state then
            clearAllScrapESP()
            notify("致命猴子", "变卖物透视已关闭", 3)
        else
            scanAllScraps()
            notify("致命猴子", "变卖物透视已开启", 3)
        end
    end,
})
TabScrap:Toggle({
    Title = "显示回收机",
    Value = true,
    Callback = function(v)
        scrapEspSettings.recyclerEnabled = v
        updateAllScrapESP()
    end,
})

TabScrap:Section({ Title = "显示选项", Icon = "sliders-horizontal" })
TabScrap:Toggle({
    Title = "变卖物高亮",
    Value = true,
    Callback = function(v)
        scrapEspSettings.highlightEnabled = v
        updateAllScrapESP()
    end,
})
TabScrap:Toggle({
    Title = "变卖物名字",
    Value = true,
    Callback = function(v)
        scrapEspSettings.nameEnabled = v
        updateAllScrapESP()
    end,
})
TabScrap:Toggle({
    Title = "距离显示",
    Value = true,
    Callback = function(v)
        scrapEspSettings.distanceEnabled = v
        updateAllScrapESP()
    end,
})

TabScrap:Section({ Title = "参数调节", Icon = "settings" })
TabScrap:Slider({
    Title = "最大显示距离",
    Value = { Min = 50, Max = 2000, Default = 500 },
    Step = 10,
    Callback = function(v) scrapEspSettings.maxDistance = v end,
})
TabScrap:Slider({
    Title = "填充透明度",
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(v)
        scrapEspSettings.fillTransparency = v / 100
        updateAllScrapESP()
    end,
})
TabScrap:Slider({
    Title = "文字大小",
    Value = { Min = 10, Max = 24, Default = 14 },
    Callback = function(v)
        scrapEspSettings.textSize = v
        updateAllScrapESP()
    end,
})

TabScrap:Section({ Title = "颜色设置", Icon = "palette" })
TabScrap:Colorpicker({
    Title = "高亮填充颜色",
    Default = scrapEspSettings.highlightColor,
    Callback = function(color)
        scrapEspSettings.highlightColor = color
        updateAllScrapESP()
    end,
})
TabScrap:Colorpicker({
    Title = "名字颜色",
    Default = scrapEspSettings.nameColor,
    Callback = function(color)
        scrapEspSettings.nameColor = color
        updateAllScrapESP()
    end,
})

--═══════════════════════════════════════════════════════════
--  Tab：玩家功能
--═══════════════════════════════════════════════════════════
local TabPlayer = Window:Tab({ Title = "玩家功能", Icon = "footprints" })

TabPlayer:Section({ Title = "怪物突脸", Icon = "skull" })
TabPlayer:Toggle({
    Title = "删除怪物突脸",
    Desc = "持续清理 Jumpscare 特效与本地动画脚本",
    Value = false,
    Callback = function(state)
        setJumpscareBlock(state)
        notify("致命猴子", state and "突脸已删除" or "突脸删除已关闭", 3)
    end,
})

TabPlayer:Section({ Title = "秒交互", Icon = "zap" })
TabPlayer:Toggle({
    Title = "秒交互",
    Desc = "所有 ProximityPrompt 立即触发、无视距离与视线",
    Value = false,
    Callback = function(v)
        setFastInteract(v)
        notify("致命猴子", v and "秒交互已开启" or "秒交互已关闭", 3)
    end,
})

TabPlayer:Section({ Title = "速度", Icon = "activity" })
TabPlayer:Slider({
    Title = "行走速度",
    Value = { Min = 40, Max = 500, Default = 40 },
    Step = 5,
    Callback = function(v)
        playerSettings.walkSpeed = v
        applySpeed()
    end,
})
TabPlayer:Dropdown({
    Title = "速度预设",
    Values = { "默认(40)", "快速(50)", "极速(150)", "光速(300)", "超光速(500)" },
    Value = "默认(40)",
    Callback = function(sel)
        local presets = {
            ["默认(40)"] = 40,
            ["快速(50)"] = 50,
            ["极速(150)"] = 150,
            ["光速(300)"] = 300,
            ["超光速(500)"] = 500,
        }
        playerSettings.walkSpeed = presets[sel] or 40
        applySpeed()
    end,
})

TabPlayer:Section({ Title = "跳跃控制", Icon = "move-up" })
TabPlayer:Slider({
    Title = "跳跃力",
    Value = { Min = 60, Max = 500, Default = 60 },
    Step = 5,
    Callback = function(v)
        playerSettings.jumpPower = v
        applyJump()
    end,
})
TabPlayer:Toggle({
    Title = "无限跳跃",
    Value = false,
    Callback = function(v) setInfJump(v) end,
})

TabPlayer:Section({ Title = "重力调节", Icon = "orbit" })
TabPlayer:Slider({
    Title = "重力",
    Value = { Min = 0, Max = 400, Default = 196 },
    Step = 2,
    Callback = function(v)
        playerSettings.gravity = v
        applyGravity()
    end,
})

TabPlayer:Section({ Title = "复活", Icon = "heart-pulse" })
TabPlayer:Button({
    Title = "点击复活",
    Desc = "尝试触发游戏内复活按钮 / RequestRespawn",
    Icon = "rotate-ccw",
    IconAlign = "Left",
    Callback = function()
        local ok = tryRespawn()
        notify("致命猴子", ok and "已点击复活" or "复活失败", 3)
    end,
})
TabPlayer:Toggle({
    Title = "快速复活",
    Value = false,
    Callback = function(v) setAutoRespawn(v) end,
})

TabPlayer:Section({ Title = "视角与防摔", Icon = "camera" })
TabPlayer:Toggle({
    Title = "第三人称",
    Desc = "关闭后锁定第一人称",
    Value = true,
    Callback = function(state)
        keepThirdPerson = state
        ApplyCamera()
        notify("致命猴子", state and "第三人称已开启" or "第三人称已关闭", 3)
    end,
})
TabPlayer:Toggle({
    Title = "防摔倒",
    Desc = "拦截 Ragdoll 状态并强制起身",
    Value = false,
    Callback = function(state)
        setAntiRagdoll(state)
        notify("致命猴子", state and "防摔倒已开启" or "防摔倒已关闭", 3)
    end,
})

--═══════════════════════════════════════════════════════════
--  Tab：其他功能
--═══════════════════════════════════════════════════════════
local TabAssist = Window:Tab({ Title = "其他功能", Icon = "sparkles" })

TabAssist:Section({ Title = "亮度提升", Icon = "sun" })
TabAssist:Toggle({
    Title = "亮度提升",
    Desc = "提亮场景、关闭雾效与全局阴影",
    Value = false,
    Callback = function(state)
        assistSettings.brightnessEnabled = state
        if state then applyBrightness() else restoreBrightness() end
        notify("致命猴子", state and "亮度提升已开启" or "亮度提升已关闭", 3)
    end,
})
TabAssist:Dropdown({
    Title = "亮度等级",
    Values = { "微亮", "中亮", "超亮" },
    Value = "中亮",
    Callback = function(sel)
        local levels = { ["微亮"] = 1, ["中亮"] = 2, ["超亮"] = 3 }
        assistSettings.brightnessLevel = levels[sel] or 2
        if assistSettings.brightnessEnabled then applyBrightness() end
    end,
})

TabAssist:Section({ Title = "监控", Icon = "monitor" })
TabAssist:Button({
    Title = "看监控（坐在凳子上）",
    Desc = "加载外部监控脚本",
    Icon = "video",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/xrN4PmHf/raw"))()
        end)
        notify("致命猴子", "看监控已执行，请坐在凳子上", 3)
    end,
})

TabAssist:Section({ Title = "无敌", Icon = "shield" })
TabAssist:Button({
    Title = "无敌",
    Desc = "BloodMan / ApeMonster 无效",
    Icon = "shield-check",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/tE2g9f2v/raw"))()
        end)
        notify("致命猴子", "无敌脚本已执行", 3)
    end,
})

--═══════════════════════════════════════════════════════════
--  Tab：其他脚本
--═══════════════════════════════════════════════════════════
local TabTools = Window:Tab({ Title = "其他脚本", Icon = "package" })

TabTools:Section({ Title = "外置脚本", Icon = "wind" })
TabTools:Button({
    Title = "茉莉璐 Script [推荐]",
    Icon = "star",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/M0Li1u/GhostlyPilot--/refs/heads/main/LETHAL-APE.lua"))()
        end)
        notify("致命猴子", "茉莉璐 Script 已执行", 3)
    end,
})
TabTools:Button({
    Title = "飞行脚本",
    Icon = "plane",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/sgSR0W9o/raw"))()
        end)
        notify("致命猴子", "飞行脚本已执行", 3)
    end,
})
TabTools:Button({
    Title = "刷钱脚本",
    Icon = "coins",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/3Kw0rzcA/raw"))()
        end)
        notify("致命猴子", "刷钱脚本已执行", 3)
    end,
})
TabTools:Button({
    Title = "彩虹猴子（每个人都可以看见）",
    Icon = "rainbow",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/7JSnvWQL"))()
        end)
        notify("致命猴子", "彩虹猴子脚本已执行", 3)
    end,
})
TabTools:Button({
    Title = "致命猿 BKU 脚本（推荐）",
    Icon = "swords",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/BKU%20SCRIPT.LUA"))()
        end)
        notify("致命猴子", "致命猿 BKU 脚本已执行", 3)
    end,
})
TabTools:Button({
    Title = "ER BTM",
    Icon = "gamepad-2",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/YY2gA86S/raw"))()
        end)
        notify("致命猴子", "ER BTM 脚本已执行", 3)
    end,
})

--──── 工具获取器（原独立小窗改为 WindUI 原生按钮）────
local ToolGrabber = (function()
    local ITEMS = {
        { label = "获取手电筒", names = { "Flashlight", "FlashLight", "Torch" }, keywords = { "flashlight", "flash light", "torch", "手电筒" } },
        { label = "获取雷达", names = { "Radar" }, keywords = { "radar", "雷达" } },
    }

    local function getBackpack()
        local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
        if not bp then bp = LocalPlayer:WaitForChild("Backpack", 5) end
        return bp
    end

    local function hasItem(names)
        local bp = getBackpack()
        local char = LocalPlayer.Character
        for _, n in ipairs(names) do
            if bp and bp:FindFirstChild(n) then return true end
            if char and char:FindFirstChild(n) then return true end
        end
        return false
    end

    local function findToolSource(names)
        local roots = { Workspace, ReplicatedStorage, getBackpack(), LocalPlayer:FindFirstChild("StarterGear") }
        for _, root in ipairs(roots) do
            if root then
                for _, n in ipairs(names) do
                    local obj = root:FindFirstChild(n, true)
                    if obj and obj:IsA("Tool") then return obj end
                end
            end
        end
        return nil
    end

    local function tryPrompts(keywords)
        for _, d in ipairs(Workspace:GetDescendants()) do
            if d:IsA("ProximityPrompt") and d.Parent then
                local name = string.lower(d.Parent.Name)
                for _, k in ipairs(keywords) do
                    if string.find(name, k, 1, true) then
                        d.MaxActivationDistance = 1e6
                        d.HoldDuration = 0
                        d.RequiresLineOfSight = false
                        pcall(function()
                            d:InputHoldBegin()
                            task.wait(0.06)
                            d:InputHoldEnd()
                        end)
                        break
                    end
                end
            end
        end
    end

    local function grab(item)
        if hasItem(item.names) then return false, "背包里已经有了" end
        tryPrompts(item.keywords)
        task.wait(0.5)
        if hasItem(item.names) then return true, "已获取 " .. item.names[1] end
        local src = findToolSource(item.names)
        if src then
            local bp = getBackpack()
            if bp then
                local clone = src:Clone()
                clone.Parent = bp
                return true, "已获取 " .. clone.Name .. "（本地）"
            end
        end
        return false, "没找到该物品"
    end

    local busy = false
    local function run(item)
        if busy then return end
        busy = true
        notify("工具获取器", "正在获取 " .. item.names[1] .. " ...", 3)
        task.spawn(function()
            local ok, msg = grab(item)
            notify("工具获取器", msg, 3)
            busy = false
        end)
    end

    return { ITEMS = ITEMS, Run = run }
end)()

TabTools:Section({ Title = "工具获取器", Icon = "wrench" })
TabTools:Button({
    Title = "获取手电筒",
    Desc = "自动触发交互提示，失败则尝试本地复制",
    Icon = "flashlight",
    IconAlign = "Left",
    Callback = function() ToolGrabber.Run(ToolGrabber.ITEMS[1]) end,
})
TabTools:Button({
    Title = "获取雷达",
    Desc = "自动触发交互提示，失败则尝试本地复制",
    Icon = "radar",
    IconAlign = "Left",
    Callback = function() ToolGrabber.Run(ToolGrabber.ITEMS[2]) end,
})

--═══════════════════════════════════════════════════════════
--  Tab：控制 NPC
--═══════════════════════════════════════════════════════════
local TabNPC = Window:Tab({ Title = "控制NPC", Icon = "bot" })

TabNPC:Section({ Title = "NPC 绑定", Icon = "link" })
TabNPC:Button({
    Title = "固定在 NPC 脚底下",
    Icon = "anchor",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/IqnYy8x3/raw"))()
        end)
        notify("致命猴子", "固定 NPC 脚本已执行", 3)
    end,
})
TabNPC:Button({
    Title = "反 NPC",
    Icon = "ban",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/VP1WCpZ8/raw"))()
        end)
        notify("致命猴子", "反 NPC 脚本已执行", 3)
    end,
})

TabNPC:Section({ Title = "控制修复", Icon = "wrench" })
TabNPC:Button({
    Title = "防 NPC 乱动",
    Desc = "拦截 MoveTo / WalkTo，避免被控 NPC 自行移动",
    Icon = "lock",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            local PlayersS = game:GetService("Players")
            local WorkspaceS = game:GetService("Workspace")
            local LocalPlayerS = PlayersS.LocalPlayer

            getgenv().DisableWalkTo = true

            local origNamecall
            local inNamecall = false
            local controlledHumanoids = {}

            local function isPlayerCharacter(model)
                if not model then return false end
                if model == LocalPlayerS.Character then return true end
                for _, p in ipairs(PlayersS:GetPlayers()) do
                    if p ~= LocalPlayerS and p.Character == model then
                        return true
                    end
                end
                return false
            end

            local function updateControlledHumanoids()
                table.clear(controlledHumanoids)
                local charHum = LocalPlayerS.Character and LocalPlayerS.Character:FindFirstChildOfClass("Humanoid")
                if charHum then
                    controlledHumanoids[charHum] = true
                end
                local cam = WorkspaceS.CurrentCamera
                local subject = cam and cam.CameraSubject
                if subject then
                    local hum = (subject.ClassName == "Humanoid") and subject or (subject:IsA("Model") and subject:FindFirstChildOfClass("Humanoid"))
                    if not hum and subject.Parent then
                        hum = subject.Parent:FindFirstChildOfClass("Humanoid")
                    end
                    if hum and hum.Parent and not isPlayerCharacter(hum.Parent) then
                        controlledHumanoids[hum] = true
                    end
                end
            end

            task.spawn(function()
                while true do
                    updateControlledHumanoids()
                    task.wait(1)
                end
            end)

            origNamecall = hookmetamethod(game, "__namecall", function(...)
                if not getgenv().DisableWalkTo or inNamecall then
                    return origNamecall(...)
                end
                inNamecall = true
                local method = getnamecallmethod()
                local self = (...)
                inNamecall = false
                if method == "MoveTo" then
                    if controlledHumanoids[self] then
                        return
                    end
                    if typeof(self) == "Instance" and self:IsA("Model") then
                        local hum = self:FindFirstChildOfClass("Humanoid")
                        if hum and controlledHumanoids[hum] then
                            return
                        end
                    end
                end
                return origNamecall(...)
            end)

            local walkToResetting = {}
            local walkToHooked = {}

            local function hookWalkTo(humanoid)
                if walkToHooked[humanoid] then return end
                walkToHooked[humanoid] = true
                walkToResetting[humanoid] = false

                humanoid:GetPropertyChangedSignal("WalkToPoint"):Connect(function()
                    if not getgenv().DisableWalkTo or walkToResetting[humanoid] then return end
                    if not controlledHumanoids[humanoid] then return end
                    walkToResetting[humanoid] = true
                    task.defer(function()
                        if humanoid.Parent then
                            local root = humanoid.RootPart or (humanoid.Parent and humanoid.Parent:FindFirstChild("HumanoidRootPart"))
                            humanoid.WalkToPoint = root and root.Position or Vector3.new()
                            humanoid.WalkToPart = nil
                        end
                        walkToResetting[humanoid] = false
                    end)
                end)

                humanoid:GetPropertyChangedSignal("WalkToPart"):Connect(function()
                    if not getgenv().DisableWalkTo or walkToResetting[humanoid] then return end
                    if not controlledHumanoids[humanoid] then return end
                    walkToResetting[humanoid] = true
                    task.defer(function()
                        if humanoid.Parent then
                            humanoid.WalkToPart = nil
                        end
                        walkToResetting[humanoid] = false
                    end)
                end)
            end

            task.spawn(function()
                while true do
                    for hum in pairs(controlledHumanoids) do
                        if hum.Parent then
                            hookWalkTo(hum)
                        end
                    end
                    task.wait(1)
                end
            end)
        end)
        notify("致命猴子", "防 NPC 乱动已执行", 3)
    end,
})
TabNPC:Button({
    Title = "修复控制 NPC 黑屏",
    Desc = "清理全屏遮罩与后处理，恢复光照",
    Icon = "sun-medium",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            local PlayerGuiF = LocalPlayer:WaitForChild("PlayerGui")
            local CameraF = Workspace.CurrentCamera
            local SKIP = { "joystick", "thumbstick", "control", "move", "mobile", "button", "touch", "pad", "input", "walk", "sprint", "jump" }

            local function isSkipped(obj)
                local name = string.lower(obj.Name)
                for _, k in ipairs(SKIP) do
                    if name:find(k) then return true end
                end
                local p = obj.Parent
                while p and p ~= PlayerGuiF do
                    local pn = string.lower(p.Name)
                    for _, k in ipairs(SKIP) do
                        if pn:find(k) then return true end
                    end
                    p = p.Parent
                end
                return false
            end

            local function clearLighting()
                for _, v in ipairs(Lighting:GetDescendants()) do
                    if v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
                        v:Destroy()
                    end
                end
                Lighting.Ambient = Color3.fromRGB(140, 140, 140)
                Lighting.OutdoorAmbient = Color3.fromRGB(140, 140, 140)
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 1e6
                Lighting.FogStart = 0
            end

            local function clearGUI()
                local vp = CameraF.ViewportSize
                for _, obj in ipairs(PlayerGuiF:GetDescendants()) do
                    if obj:IsA("GuiObject") and obj.Visible and not isSkipped(obj) then
                        local sz = obj.AbsoluteSize
                        local fullscreen = sz.X >= vp.X * 0.9 and sz.Y >= vp.Y * 0.9
                        if fullscreen then
                            if obj.BackgroundTransparency < 1 and obj.BackgroundColor3.R < 0.2 and obj.BackgroundColor3.G < 0.2 and obj.BackgroundColor3.B < 0.2 then
                                obj.BackgroundTransparency = 1
                            end
                            if obj:IsA("ImageLabel") and obj.ImageTransparency < 1 then
                                obj.ImageTransparency = 1
                            end
                        end
                    end
                end
            end

            clearLighting()
            clearGUI()

            if not _G._GusiFixConn then
                local pending = false
                _G._GusiFixConn = PlayerGuiF.DescendantAdded:Connect(function()
                    if pending then return end
                    pending = true
                    task.delay(0.2, function()
                        pending = false
                        clearGUI()
                    end)
                end)
            end
        end)
        notify("致命猴子", "修复控制 NPC 黑屏已执行", 3)
    end,
})

TabNPC:Section({ Title = "控制 NPC 汉化", Icon = "languages" })
TabNPC:Button({
    Title = "控制 NPC 汉化",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/2dU621nr"))()
        end)
        notify("致命猴子", "控制 NPC 汉化脚本已执行", 3)
    end,
})

TabNPC:Section({ Title = "安全阻拦", Icon = "shield" })
TabNPC:Toggle({
    Title = "删除安全阻拦",
    Value = false,
    Callback = function(state)
        setSafeZoneBlock(state)
        notify("致命猴子", state and "删除安全阻拦已开启" or "删除安全阻拦已关闭", 3)
    end,
})

TabNPC:Section({ Title = "防滑", Icon = "footprints" })
TabNPC:Toggle({
    Title = "防脚滑",
    Value = false,
    Callback = function(state)
        setAntiSlip(state)
        notify("致命猴子", state and "防脚滑已开启" or "防脚滑已关闭", 3)
    end,
})

TabNPC:Section({ Title = "删除对象", Icon = "trash-2" })
TabNPC:Button({
    Title = "删除古巴商店卷帘门",
    Icon = "door-closed",
    IconAlign = "Left",
    Callback = function()
        local deleted = false
        pcall(function()
            local obj = Workspace:FindFirstChild("Shoper")
            if obj then
                obj:Destroy()
                deleted = true
            end
        end)
        notify("致命猴子", deleted and "古巴商店卷帘门 已删除" or "未找到 Shoper", 3)
    end,
})
TabNPC:Button({
    Title = "删除出生点空气墙",
    Icon = "brick-wall",
    IconAlign = "Left",
    Callback = function()
        local deleted = false
        pcall(function()
            local mt = Workspace:FindFirstChild("MonsterTeleport")
            if mt then
                local obj = mt:FindFirstChild("AntiMonstro")
                if obj then
                    obj:Destroy()
                    deleted = true
                end
            end
        end)
        notify("致命猴子", deleted and "出生点空气墙已删除" or "未找到 AntiMonstro", 3)
    end,
})

--═══════════════════════════════════════════════════════════
--  Tab：UI 设置（樱花主题）
--═══════════════════════════════════════════════════════════
local TabUI = Window:Tab({ Title = "UI设置", Icon = "settings" })

TabUI:Section({ Title = "樱花主题", Icon = "flower-2" })
TabUI:Dropdown({
    Title = "主题配色",
    Desc = "三套樱花配色随时切换",
    Values = { "夜樱（深色）", "樱花（柔粉）", "樱白（浅色）" },
    Value = "夜樱（深色）",
    Callback = function(sel)
        local map = {
            ["夜樱（深色）"] = "SakuraNight",
            ["樱花（柔粉）"] = "Sakura",
            ["樱白（浅色）"] = "SakuraLight",
        }
        local themeName = map[sel]
        if themeName then
            pcall(function() WindUI:SetTheme(themeName) end)
            notify("UI 设置", "已切换主题：" .. sel, 2)
        end
    end,
})
TabUI:Toggle({
    Title = "樱花飘落特效",
    Desc = "屏幕上的花瓣粒子，关闭可提升帧率",
    Value = true,
    Callback = function(state) SakuraFX.SetEnabled(state) end,
})

TabUI:Section({ Title = "窗口", Icon = "app-window" })
TabUI:Toggle({
    Title = "毛玻璃效果",
    Desc = "开启后窗口呈现亚克力磨砂质感",
    Value = false,
    Callback = function(state)
        pcall(function() WindUI:ToggleAcrylic(state) end)
    end,
})
TabUI:Toggle({
    Title = "窗口透明模式",
    Value = false,
    Callback = function(state)
        pcall(function() Window:ToggleTransparency(state) end)
    end,
})
pcall(function()
    TabUI:Keybind({
        Title = "显隐快捷键",
        Value = Enum.KeyCode.RightShift,
        Callback = function(v)
            local key = (typeof(v) == "EnumItem") and v or Enum.KeyCode[v]
            if key then
                pcall(function() Window:SetToggleKey(key) end)
                notify("UI 设置", "快捷键已设为 " .. key.Name, 2)
            end
        end,
    })
end)
TabUI:Button({
    Title = "窗口居中",
    Icon = "move",
    IconAlign = "Left",
    Callback = function()
        pcall(function() Window:SetToTheCenter() end)
    end,
})
TabUI:Button({
    Title = "重新打开窗口",
    Icon = "rotate-ccw",
    IconAlign = "Left",
    Callback = function()
        pcall(function() Window:Open() end)
    end,
})

TabUI:Section({ Title = "说明", Icon = "info" })
TabUI:Paragraph({
    Title = "WindUI 樱花版",
    Desc = "界面由 WindUI 驱动，支持拖拽、缩放、搜索与快捷键。主题切换只影响界面，不影响游戏内 ESP 颜色。",
})

--═══════════════════════════════════════════════════════════
--  启动
--═══════════════════════════════════════════════════════════
pcall(function() TabMonster:Select() end)

task.spawn(function()
    playSound("rbxassetid://6042053626", 0.4)
    local loadTime = math.floor((tick() - LoadStartTime) * 1000)
    notify("y定制 樱花", "UI 已加载，用时 " .. loadTime .. " ms，RightShift 可呼出窗口", 4)
end)
