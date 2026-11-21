if _G.__AURA then
    pcall(function()
        for _, c in ipairs(_G.__AURA.conns or {}) do c:Disconnect() end
        _G.__AURA.loop = false
    end)
end
if _G.__INJ then
    pcall(function()
        for _, c in ipairs(_G.__INJ.conns or {}) do c:Disconnect() end
    end)
end
if _G.__MULTI then
    if _G.__MULTI.gui then
        pcall(function() _G.__MULTI.gui:Destroy() end)
    end
    _G.__MULTI.storeLoop = false
end
if _G.__ESP_GEN then _G.__ESP_GEN.alive = false end
if _G.__FLY_GUI then pcall(function() _G.__FLY_GUI:Destroy() end) end

_G.__AURA = { conns = {}, loop = true }
_G.__INJ = { conns = {} }
_G.__MULTI = { conns = {}, gui = nil, storeLoop = true }
_G.__ESP_GEN = { alive = true }
_G.__FLY_GUI = nil

-- ==================== 服务与常量 ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

local SCRIPT_NAME = "y定制版"

local function Log(msg)
    print("[" .. SCRIPT_NAME .. "] " .. tostring(msg))
end

-- ==================== WindUI 主题 ====================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

WindUI:AddTheme({
    Name = "Sakura",
    Accent = Color3.fromRGB(255, 183, 197),
    AccentGradient = ColorSequence.new(
        Color3.fromRGB(255, 183, 197),
        Color3.fromRGB(255, 105, 180)
    ),
    Background = Color3.fromRGB(20, 16, 22),
    Outline = Color3.fromRGB(255, 192, 203),
    Text = Color3.fromRGB(255, 240, 245),
    PlaceholderText = Color3.fromRGB(180, 140, 160)
})

WindUI:SetTheme("Sakura")

local Window = WindUI:CreateWindow({
    Title = "在大型超市过夜 · y定制版🌸",
    Subtitle = "v5 · 移速修复",
    Icon = "rbxassetid://4483362458",
    Author = "由 y 制作",
    Folder = "EvaSupermarketConfig",
    Background = "https://i.postimg.cc/YSXkgNck/zhe-feng-bi-zhi-dong-shan-xiao-hong-er-ci-yuan.jpg",
    Size = UDim2.fromOffset(620, 460),
    Transparent = true,
    Theme = "Sakura",
})

Window:EditOpenButton({
    Title = "打开UI",
    Icon = "menu",
    CornerRadius = UDim.new(0, 10),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(255, 183, 197), Color3.fromRGB(255, 105, 180))
})

local function Notify(title, content, dur)
    pcall(function()
        WindUI:Notify({ Title = title, Content = content, Duration = dur or 3 })
    end)
end

local MainTab = Window:Tab({ Title = "主页", Icon = "house" })
local AuraTab = Window:Tab({ Title = "战斗", Icon = "zap" })
local StoreTab = Window:Tab({ Title = "商店搬运", Icon = "shopping-cart" })
local QuestTab = Window:Tab({ Title = "方块任务", Icon = "package" })
local SpawnTab = Window:Tab({ Title = "物品", Icon = "box" })
local ESPTab = Window:Tab({ Title = "透视ESP", Icon = "eye" })
local FlyTab = Window:Tab({ Title = "移动", Icon = "plane" })
local InteractTab = Window:Tab({ Title = "互动", Icon = "hand" })

-- ==================== 全局状态 ====================
local SavedBaseCFrame = nil
local FlySpeed = 50
local Flying = false

-- 人物移动相关状态
local MOVE = {
    walkOn = false,     -- 自定义移速开关
    walkSpeed = 32,     -- 目标移速
    baseWalk = nil,     -- 开启前的原始移速，关闭时还原
    pushMode = false,   -- 强制推进模式（WalkSpeed 被游戏锁死时使用）
    reverts = 0,        -- 移速被游戏连续改回的次数
    revertAt = 0,       -- 上次被改回的时间
    infJump = false,    -- 无限跳跃开关
    jumpPower = 85,     -- 跳跃力量
    baseJump = nil,     -- 原始跳跃力量
    baseUsePower = nil, -- 原始 UseJumpPower 设置
}

-- UI 控件引用（飞行/移速/跳跃共用，便于状态同步）
local flyToggle, btnToggle, walkToggle, jumpToggle, jumpSlider, pushToggle

local AURA = {
    breakOn = false,
    killOn = false,
    breakRadius = 25,
    killRadius = 100,
    tickWait = 0.08,
    maxTargetsPerTick = 30,
    skipPlayers = true,
    useNil = true,
    hits = 0,
    kills = 0,
    targets = 0,
    enemies = 0,
    toolName = "无",
}

local STORE = {
    dropPosition = Vector3.new(0, 0, 0),
    skipRadius = 8,
    autoBringPos = false,
    bringLock = false,
    pickupTimeout = 0.5,
    turbo = false,
}

-- 显示名 -> 游戏内对象名
local FoodList = {
    { Name = "可乐", Id = "Cola" },
    { Name = "汉堡", Id = "Burger" },
    { Name = "热狗", Id = "Hotdog" },
    { Name = "火腿", Id = "Ham" },
}
local MedList = {
    { Name = "医疗包", Id = "Medkit" },
    { Name = "绷带", Id = "Bandage" },
}
local WeaponList = {
    { Name = "武士刀", Id = "Katana" },
    { Name = "手枪", Id = "Pistol" },
    { Name = "霰弹枪", Id = "Shotgun" },
}

local function NamesOf(list)
    local out = {}
    for i, item in ipairs(list) do out[i] = item.Name end
    return out
end

local function IdOf(list, name)
    for _, item in ipairs(list) do
        if item.Name == name then return item.Id end
    end
    return name
end

local SelectedFood, SelectedMed, SelectedWeapon = "可乐", "医疗包", "武士刀"

-- ==================== AURA 核心逻辑 ====================

local function DamageRemote()
    local r = ReplicatedStorage:FindFirstChild("Remotes")
    local w = r and r:FindFirstChild("Weapon")
    return w and w:FindFirstChild("Damage")
end

local function GetEquippedTool()
    local char = LP.Character
    if not char then return nil end
    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Tool") then return c end
    end
    return nil
end

local function IsPlayerCharacter(inst)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and (inst == p.Character or inst:IsDescendantOf(p.Character)) then
            return true
        end
    end
    return false
end

local function ScanBreakTargets(origin, radius)
    local targets, seen = {}, {}
    local ok, parts = pcall(function()
        return workspace:GetPartBoundsInRadius(origin, radius)
    end)
    if not ok or not parts then parts = {} end
    local char = LP.Character

    for _, part in ipairs(parts) do
        if part and part.Parent and not part:IsA("Terrain") then
            local skip = false
            if char and (part == char or part:IsDescendantOf(char)) then skip = true end
            if not skip and AURA.skipPlayers and IsPlayerCharacter(part) then skip = true end
            if not skip then
                local model = part:FindFirstAncestorOfClass("Model") or part
                if not model:FindFirstChildOfClass("Humanoid") and not seen[model] then
                    seen[model] = true
                    table.insert(targets, { inst = model, pos = part.Position })
                end
            end
        end
    end
    return targets
end

local function ScanNilTargets(origin, radius, seen)
    if not AURA.useNil or not getnilinstances then return {} end
    local out = {}
    local ok, list = pcall(getnilinstances)
    if not ok or not list then return out end
    for _, obj in ipairs(list) do
        if obj and obj:IsA("Model") and obj.Name == "Model" and not seen[obj] then
            local pos
            if obj.PrimaryPart then
                pos = obj.PrimaryPart.Position
            else
                for _, d in ipairs(obj:GetDescendants()) do
                    if d:IsA("BasePart") then pos = d.Position; break end
                end
            end
            if pos and (pos - origin).Magnitude <= radius then
                table.insert(out, { inst = obj, pos = pos })
            end
        end
    end
    return out
end

local function ScanEnemies(origin, radius)
    local out = {}
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return out end
    for _, desc in ipairs(enemies:GetDescendants()) do
        if desc:IsA("Humanoid") and desc.Health > 0 then
            local model = desc.Parent
            if model then
                local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
                if hrp then
                    local pos = hrp.Position
                    if radius <= 0 or (pos - origin).Magnitude <= radius then
                        table.insert(out, { humanoid = desc, pos = pos })
                    end
                end
            end
        end
    end
    return out
end

local function AuraTick()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local tool = GetEquippedTool()
    if not tool then
        AURA.toolName = "无武器"
        return
    end
    AURA.toolName = tool.Name

    local dmg = DamageRemote()
    if not dmg then return end
    local origin = hrp.Position

    if AURA.breakOn then
        local targets = ScanBreakTargets(origin, AURA.breakRadius)
        local seen = {}
        for _, t in ipairs(targets) do seen[t.inst] = true end
        for _, t in ipairs(ScanNilTargets(origin, AURA.breakRadius, seen)) do
            table.insert(targets, t)
        end
        AURA.targets = #targets

        local fired = 0
        for _, t in ipairs(targets) do
            if not AURA.breakOn then break end
            if fired >= AURA.maxTargetsPerTick then break end
            pcall(function() dmg:FireServer(t.inst, tool.Name, t.pos) end)
            fired = fired + 1
        end
        AURA.hits = AURA.hits + fired
    end

    if AURA.killOn then
        local enemies = ScanEnemies(origin, AURA.killRadius)
        AURA.enemies = #enemies
        local killed = 0
        for _, e in ipairs(enemies) do
            if not AURA.killOn then break end
            pcall(function() dmg:FireServer(e.humanoid, tool.Name, e.pos) end)
            killed = killed + 1
        end
        AURA.kills = AURA.kills + killed
    end
end

local AuraHandle = _G.__AURA
task.spawn(function()
    while AuraHandle.loop do
        if AURA.breakOn or AURA.killOn then
            pcall(AuraTick)
            task.wait(AURA.tickWait)
        else
            task.wait(0.15)
        end
    end
end)

-- ==================== 商店搬运核心逻辑 ====================

local function GetRemote(...)
    local node = ReplicatedStorage:FindFirstChild("Remotes")
    if not node then return nil end
    for _, n in ipairs({ ... }) do
        node = node:FindFirstChild(n)
        if not node then return nil end
    end
    return node
end

local function GetUtilFolder()
    local m = workspace:FindFirstChild("Map")
    return m and m:FindFirstChild("Util")
end

local function GetItemsFolder()
    local u = GetUtilFolder()
    return u and u:FindFirstChild("Items")
end

local function GetItemWorldPos(it)
    if it:IsA("BasePart") then return it.Position end
    if it:IsA("Model") then
        local pp = it.PrimaryPart or it:FindFirstChildWhichIsA("BasePart")
        return pp and pp.Position
    end
    if it:IsA("Tool") then
        local h = it:FindFirstChild("Handle")
        if h and h:IsA("BasePart") then return h.Position end
    end
    local bp = it:FindFirstChildWhichIsA("BasePart", true)
    return bp and bp.Position
end

local function IsNearDrop(it)
    if STORE.skipRadius <= 0 then return false end
    local p = GetItemWorldPos(it)
    if not p then return false end
    return (p - STORE.dropPosition).Magnitude <= STORE.skipRadius
end

local function SnapshotTools()
    local s = {}
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") then s[t] = true end
        end
    end
    local ch = LP.Character
    if ch then
        for _, t in ipairs(ch:GetChildren()) do
            if t:IsA("Tool") then s[t] = true end
        end
    end
    return s
end

local function ScanForNew(oldSet, name)
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") and not oldSet[t] and (name == nil or t.Name == name) then return t end
        end
    end
    local ch = LP.Character
    if ch then
        for _, t in ipairs(ch:GetChildren()) do
            if t:IsA("Tool") and not oldSet[t] and (name == nil or t.Name == name) then return t end
        end
    end
    return nil
end

local function WaitForNewTool(oldSet, name, timeout)
    timeout = timeout or STORE.pickupTimeout
    local found = ScanForNew(oldSet, name)
    if found then return found end

    local result
    local listen = {}
    local function hook(container)
        if not container then return end
        table.insert(listen, container.ChildAdded:Connect(function(c)
            if result then return end
            if c:IsA("Tool") and not oldSet[c] and (name == nil or c.Name == name) then
                result = c
            end
        end))
    end
    hook(LP:FindFirstChild("Backpack"))
    hook(LP.Character)

    local t0 = os.clock()
    while not result and os.clock() - t0 < timeout do
        task.wait()
        if not result then
            found = ScanForNew(oldSet, name)
            if found then result = found end
        end
    end
    for _, c in ipairs(listen) do c:Disconnect() end
    return result
end

local function FullDrop(tool, pos)
    local equip = GetRemote("Item", "Equipped")
    local act = GetRemote("Item", "Activated")
    local drop = GetRemote("RequestDropItem")
    if not drop then return false end
    if equip then pcall(function() equip:FireServer(tool, nil) end) end
    if act then pcall(function() act:FireServer(tool, nil) end) end
    if equip then pcall(function() equip:FireServer(tool, nil) end) end
    if not STORE.turbo then task.wait() end
    pcall(function() drop:FireServer(tool, pos) end)
    return true
end

local function PickupEquipDropOne(worldItem, pos)
    local pick = GetRemote("RequestPickupItem")
    if not pick then return false end
    local before = SnapshotTools()
    local name = worldItem.Name
    pcall(function() pick:FireServer(worldItem) end)
    local tool = WaitForNewTool(before, name, STORE.pickupTimeout)
        or WaitForNewTool(before, nil, 0.25)
    if not tool then return false end
    FullDrop(tool, pos)
    return true
end

local function BringItemsToPosition(onProgress)
    if STORE.bringLock then return 0, 0, 0, "正在运行" end
    STORE.bringLock = true

    local f = GetItemsFolder()
    if not f then
        STORE.bringLock = false
        return 0, 0, 0, "未找到物品文件夹"
    end
    local items = f:GetChildren()
    local total = #items
    if total == 0 then
        STORE.bringLock = false
        return 0, 0, 0, "文件夹为空"
    end

    local dropped, skipped, failed = 0, 0, 0
    for i = 1, total do
        local it = items[i]
        if it and it.Parent == f then
            if IsNearDrop(it) then
                skipped = skipped + 1
            else
                if PickupEquipDropOne(it, STORE.dropPosition) then
                    dropped = dropped + 1
                else
                    failed = failed + 1
                end
            end
        end
        if onProgress and (i % 5 == 0 or i == total) then
            onProgress(i, total, dropped, skipped, failed)
        end
        task.wait()
    end

    STORE.bringLock = false
    return dropped, skipped, failed, nil
end

local function PickAllItems()
    local f = GetItemsFolder()
    if not f then return 0, 0, 0 end
    local items = f:GetChildren()
    local pick = GetRemote("RequestPickupItem")
    if not pick then return 0, #items, 0 end

    local picked, skipped = 0, 0
    for _, it in ipairs(items) do
        if IsNearDrop(it) then
            skipped = skipped + 1
        else
            pcall(function() pick:FireServer(it) end)
            picked = picked + 1
            task.wait()
        end
    end
    return picked, #items, skipped
end

local function DropAllBackpack(pos)
    local bp = LP:FindFirstChild("Backpack")
    if not bp then return 0 end
    local tools = {}
    for _, t in ipairs(bp:GetChildren()) do
        if t:IsA("Tool") then table.insert(tools, t) end
    end
    local n = 0
    for _, t in ipairs(tools) do
        if FullDrop(t, pos) then n = n + 1 end
        task.wait()
    end
    return n
end

local function DropAllAtFeet()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    local pos = hrp.Position
    local n = DropAllBackpack(pos)
    local dropObj = GetRemote("DropObject")
    if dropObj then pcall(function() dropObj:InvokeServer(CFrame.new(pos)) end) end
    return n
end

local function RunUnlocker()
    local logs = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return { "地图：未找到" } end

    local util = map:FindFirstChild("Util")
    if util then
        for _, name in ipairs({ "BuildingBlocked", "CharactersBlockedCG", "PlayerBlockedOnly" }) do
            local obj = util:FindFirstChild(name)
            if obj then
                pcall(function() obj:Destroy() end)
                table.insert(logs, name .. "：已移除")
            else
                table.insert(logs, name .. "：不存在")
            end
        end
    end

    local visuals = map:FindFirstChild("Visuals")
    if visuals then
        local fp = visuals:FindFirstChild("FurniturePlot")
        if fp then
            local folder = fp:FindFirstChild("Folder")
            if folder then
                pcall(function() folder:Destroy() end)
                table.insert(logs, "家具区限制：已移除")
            else
                table.insert(logs, "家具区限制：不存在")
            end
        end
    end
    return logs
end

-- 自动搬运循环
local StoreHandle = _G.__MULTI
task.spawn(function()
    while StoreHandle.storeLoop do
        task.wait(0.5)
        if STORE.autoBringPos and not STORE.bringLock then
            pcall(function() BringItemsToPosition() end)
        end
    end
end)

-- 启动时把掉落点初始化到角色位置
task.spawn(function()
    while not (LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")) do
        task.wait(0.5)
    end
    if STORE.dropPosition.Magnitude == 0 then
        STORE.dropPosition = LP.Character.HumanoidRootPart.Position
    end
end)

-- ==================== 飞行系统 ====================

local FlyScreenGui = Instance.new("ScreenGui")
FlyScreenGui.Name = "EvaFlyGui"
FlyScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    pcall(function() syn.protect_gui(FlyScreenGui) end)
end
if not pcall(function() FlyScreenGui.Parent = CoreGui end) then
    FlyScreenGui.Parent = LP:WaitForChild("PlayerGui")
end

_G.__FLY_GUI = FlyScreenGui

local FlyButton = Instance.new("TextButton")
FlyButton.Name = "FlyToggleButton"
FlyButton.Size = UDim2.new(0, 60, 0, 60)
FlyButton.Position = UDim2.new(0.8, 0, 0.5, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(35, 25, 35)
FlyButton.Text = "飞行"
FlyButton.TextSize = 20
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.TextColor3 = Color3.fromRGB(255, 240, 245)
FlyButton.AutoButtonColor = false
FlyButton.Visible = false
FlyButton.Active = true
FlyButton.Draggable = true
FlyButton.Parent = FlyScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = FlyButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(255, 183, 197)
ButtonStroke.Thickness = 2
ButtonStroke.Parent = FlyButton

-- ===== 手机端：上升 / 下降 长按按钮 =====
local MobileUp, MobileDown = false, false
local flyUpBtn, flyDownBtn
local flyBtnPref = false   -- 用户在菜单里对“显示悬浮按钮”的偏好

local function RefreshFlyButtons()
    -- 触屏设备飞行时强制显示，保证随时能降落
    FlyButton.Visible = flyBtnPref or (Flying and UIS.TouchEnabled)
    local show = Flying and (flyBtnPref or UIS.TouchEnabled)
    if flyUpBtn then flyUpBtn.Visible = show end
    if flyDownBtn then flyDownBtn.Visible = show end
end

local function CreateHoldButton(key, text, yOffset)
    local b = Instance.new("TextButton")
    b.Name = "FlyHold_" .. key
    b.Size = UDim2.new(0, 56, 0, 56)
    b.Position = UDim2.new(0.8, 0, 0.5, yOffset)
    b.BackgroundColor3 = Color3.fromRGB(35, 25, 35)
    b.BackgroundTransparency = 0.1
    b.Text = text
    b.TextSize = 22
    b.Font = Enum.Font.SourceSansBold
    b.TextColor3 = Color3.fromRGB(255, 240, 245)
    b.AutoButtonColor = false
    b.Visible = false
    b.Active = true
    b.Parent = FlyScreenGui

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = b

    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(255, 183, 197)
    st.Thickness = 2
    st.Parent = b

    local function set(on)
        if key == "up" then MobileUp = on else MobileDown = on end
        b.BackgroundColor3 = on and Color3.fromRGB(255, 105, 180) or Color3.fromRGB(35, 25, 35)
    end

    b.InputBegan:Connect(function(input)
        local t = input.UserInputType
        if t == Enum.UserInputType.Touch or t == Enum.UserInputType.MouseButton1 then
            set(true)
        end
    end)
    b.InputEnded:Connect(function(input)
        local t = input.UserInputType
        if t == Enum.UserInputType.Touch or t == Enum.UserInputType.MouseButton1 then
            set(false)
        end
    end)
    b.MouseButton1Down:Connect(function() set(true) end)
    b.MouseButton1Up:Connect(function() set(false) end)
    return b
end

flyUpBtn = CreateHoldButton("up", "↑", -70)
flyDownBtn = CreateHoldButton("down", "↓", 70)

local bodyVel, bodyGyro
local flyGen = 0       -- 飞行代次，避免旧协程误清理新飞行
local uiSyncing = false -- 防止 Set() 触发回调造成递归
local flyAutoRotate = nil

local function SyncFlyUI(on)
    if uiSyncing then return end
    if flyToggle then
        uiSyncing = true
        pcall(function() flyToggle:Set(on) end)
        uiSyncing = false
    end
    if FlyButton then FlyButton.Text = on and "降落" or "飞行" end
    pcall(RefreshFlyButtons)
end

local function StopFlying()
    flyGen = flyGen + 1
    Flying = false
    if bodyVel then pcall(function() bodyVel:Destroy() end); bodyVel = nil end
    if bodyGyro then pcall(function() bodyGyro:Destroy() end); bodyGyro = nil end
    ButtonStroke.Color = Color3.fromRGB(255, 105, 180)
    MobileUp, MobileDown = false, false
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum and flyAutoRotate ~= nil then
        pcall(function() hum.AutoRotate = flyAutoRotate end)
    end
    flyAutoRotate = nil
    SyncFlyUI(false)
end

local function StartFlying()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        Flying = false
        SyncFlyUI(false)
        Notify("无法起飞", "角色尚未加载完成", 2)
        return false
    end

    StopFlying()
    flyGen = flyGen + 1
    local myGen = flyGen
    Flying = true
    ButtonStroke.Color = Color3.fromRGB(255, 183, 197)
    SyncFlyUI(true)

    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        flyAutoRotate = hum.AutoRotate
        pcall(function() hum.AutoRotate = false end)
    end

    bodyVel = Instance.new("BodyVelocity")
    bodyVel.Name = "EvaFlyVel"
    bodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVel.Velocity = Vector3.zero
    bodyVel.Parent = hrp

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.Name = "EvaFlyGyro"
    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bodyGyro.P = 8000
    bodyGyro.D = 60
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp

    task.spawn(function()
        while Flying and flyGen == myGen and char and char.Parent do
            if not bodyVel or not bodyGyro then break end
            local cur = char:FindFirstChild("HumanoidRootPart")
            if not cur then break end
            if bodyVel.Parent ~= cur then bodyVel.Parent = cur end
            if bodyGyro.Parent ~= cur then bodyGyro.Parent = cur end

            local cam = workspace.CurrentCamera
            if cam then
                -- 机身只跟随相机水平朝向，避免俯仰/翻滚导致视角抖动
                local look = cam.CFrame.LookVector
                local flat = Vector3.new(look.X, 0, look.Z)
                if flat.Magnitude > 0.01 then
                    bodyGyro.CFrame = CFrame.lookAt(cur.Position, cur.Position + flat.Unit)
                end

                -- 关键修复：只有方向输入才移动；没有输入就原地悬停
                local move = Vector3.zero
                if not UIS:GetFocusedTextBox() then
                    local right = cam.CFrame.RightVector
                    if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + look end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - look end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + right end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - right end
                end

                -- 手机 / 手柄：没有键盘，直接读角色摇杆方向（世界坐标，天然跟随视角）
                if move.Magnitude < 0.05 then
                    local hum = cur.Parent and cur.Parent:FindFirstChildOfClass("Humanoid")
                    local md = hum and hum.MoveDirection or Vector3.zero
                    if md.Magnitude > 0.05 then
                        local flatMd = Vector3.new(md.X, 0, md.Z)
                        if flatMd.Magnitude > 0.01 then move = flatMd.Unit end
                    end
                end
                if move.Magnitude > 0 then move = move.Unit end

                -- 垂直方向：键盘 空格 / Shift，手机 屏幕 ↑ ↓
                local vert = 0
                if not UIS:GetFocusedTextBox() then
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then vert = vert + 1 end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftShift)
                        or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                        vert = vert - 1
                    end
                end
                if MobileUp and not MobileDown then vert = vert + 1 end
                if MobileDown and not MobileUp then vert = vert - 1 end

                bodyVel.Velocity = move * FlySpeed + Vector3.new(0, vert * FlySpeed, 0)
            else
                bodyVel.Velocity = Vector3.zero
            end

            task.wait()
        end
        if flyGen == myGen then StopFlying() end
    end)
    return true
end

local function ToggleFly()
    if Flying then
        StopFlying()
    else
        StartFlying()
    end
end

FlyButton.MouseButton1Click:Connect(ToggleFly)

-- ==================== 人物移速 & 无限跳跃 ====================

local function GetHumanoid()
    local char = LP.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local RunService = game:GetService("RunService")

local function ApplyWalkSpeed()
    local hum = GetHumanoid()
    if not hum then return end
    if not MOVE.baseWalk then MOVE.baseWalk = hum.WalkSpeed end
    if hum.WalkSpeed ~= MOVE.walkSpeed then
        pcall(function() hum.WalkSpeed = MOVE.walkSpeed end)
    end
end

-- ===== 强制推进：WalkSpeed 被游戏每帧重置时的兜底方案 =====
local pushVel = nil

local function DestroyPush()
    if pushVel then pcall(function() pushVel:Destroy() end) end
    pushVel = nil
end

local function EnsurePush()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        DestroyPush()
        return nil
    end
    if pushVel and pushVel.Parent ~= hrp then DestroyPush() end
    if not pushVel then
        pushVel = Instance.new("BodyVelocity")
        pushVel.Name = "EvaSpeedVel"
        -- 竖直方向不给力，保留重力 / 跳跃
        pushVel.MaxForce = Vector3.new(1e6, 0, 1e6)
        pushVel.Velocity = Vector3.zero
        pushVel.Parent = hrp
    end
    return pushVel
end

local function SetWalk(on)
    MOVE.walkOn = on
    local hum = GetHumanoid()
    if on then
        if hum and not MOVE.baseWalk then MOVE.baseWalk = hum.WalkSpeed end
        MOVE.reverts = 0
        if MOVE.pushMode then EnsurePush() else ApplyWalkSpeed() end
    else
        DestroyPush()
        if hum then
            pcall(function() hum.WalkSpeed = MOVE.baseWalk or 16 end)
        end
        MOVE.baseWalk = nil
    end
end

-- 每帧保活：比 0.3 秒轮询快得多，能压过大多数“每秒重置移速”的游戏脚本
RunService.Heartbeat:Connect(function()
    if not MOVE.walkOn then
        if pushVel then DestroyPush() end
        return
    end

    -- 飞行中由飞行系统接管速度，避免两个速度源打架
    if Flying then
        if pushVel then DestroyPush() end
        return
    end

    local hum = GetHumanoid()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then
        DestroyPush()
        return
    end

    if MOVE.pushMode then
        local v = EnsurePush()
        if not v then return end
        local md = hum.MoveDirection
        local dir = Vector3.new(md.X, 0, md.Z)
        if dir.Magnitude > 0.05 then dir = dir.Unit else dir = Vector3.zero end
        -- 减去角色自身 WalkSpeed 的贡献，避免叠加成双倍速度
        local base = math.clamp(hum.WalkSpeed, 0, MOVE.walkSpeed)
        v.Velocity = dir * math.max(0, MOVE.walkSpeed - base)
    else
        if pushVel then DestroyPush() end
        if hum.WalkSpeed ~= MOVE.walkSpeed then
            pcall(function() hum.WalkSpeed = MOVE.walkSpeed end)
            local now = os.clock()
            -- 只有“帧帧都被改回”才算锁死，避免每秒重置一次的游戏误判
            if now - MOVE.revertAt <= 0.15 then
                MOVE.reverts = MOVE.reverts + 1
            else
                MOVE.reverts = 1
            end
            MOVE.revertAt = now
            if MOVE.reverts >= 40 then
                MOVE.pushMode = true
                MOVE.reverts = 0
                if pushToggle then
                    local bak = uiSyncing
                    uiSyncing = true
                    pcall(function() pushToggle:Set(true) end)
                    uiSyncing = bak
                end
                Notify("移速已切换", "游戏持续重置 WalkSpeed，已自动启用强制推进模式", 5)
            end
        elseif MOVE.reverts > 0 and os.clock() - MOVE.revertAt > 2 then
            MOVE.reverts = 0
        end
    end
end)

local function ApplyJumpPower()
    local hum = GetHumanoid()
    if not hum then return end
    pcall(function()
        hum.UseJumpPower = true
        hum.JumpPower = MOVE.jumpPower
    end)
end

local function DoJump()
    if not MOVE.infJump or Flying then return end
    local hum = GetHumanoid()
    if not hum or hum.Health <= 0 then return end
    pcall(function()
        hum.UseJumpPower = true
        hum.JumpPower = MOVE.jumpPower
        if hum.FloorMaterial ~= Enum.Material.Air then hum.Jump = true end
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end)
end

UIS.JumpRequest:Connect(function()
    if MOVE.infJump and not Flying then DoJump() end
end)

-- 长按空格也能持续跳（跳跃请求只在按下瞬间触发）
task.spawn(function()
    while true do
        task.wait(0.12)
        if MOVE.infJump and not Flying
            and not UIS:GetFocusedTextBox()
            and UIS:IsKeyDown(Enum.KeyCode.Space) then
            DoJump()
        end
    end
end)

-- 跳跃力量保活（部分游戏会周期性重置）
task.spawn(function()
    while true do
        task.wait(0.3)
        if MOVE.infJump then pcall(ApplyJumpPower) end
    end
end)

-- 复活 / 换角色后重新应用
LP.CharacterAdded:Connect(function()
    StopFlying()
    DestroyPush()
    task.wait(0.6)
    MOVE.baseWalk = nil
    MOVE.reverts = 0
    if MOVE.walkOn then
        if MOVE.pushMode then EnsurePush() else pcall(ApplyWalkSpeed) end
    end
    if MOVE.infJump then pcall(ApplyJumpPower) end
end)

-- 一键诊断：先按 WalkSpeed 走，1 秒内被改回太多次则切推进模式
local function AutoFixWalk()
    if not MOVE.walkOn then SetWalk(true) end
    if walkToggle then
        local bak = uiSyncing
        uiSyncing = true
        pcall(function() walkToggle:Set(true) end)
        uiSyncing = bak
    end
    MOVE.reverts = 0
    MOVE.revertAt = 0
    task.wait(1)
    if MOVE.reverts >= 10 then
        MOVE.pushMode = true
        if pushToggle then
            local bak = uiSyncing
            uiSyncing = true
            pcall(function() pushToggle:Set(true) end)
            uiSyncing = bak
        end
        EnsurePush()
        Notify("移速修复", "检测到游戏锁死 WalkSpeed，已启用强制推进模式", 5)
    else
        MOVE.pushMode = false
        DestroyPush()
        ApplyWalkSpeed()
        Notify("移速修复", string.format("WalkSpeed 正常生效：%d", MOVE.walkSpeed), 4)
    end
end

-- ==================== 快速互动 ====================

local INTERACT = {
    on = false,
    radius = 12,
    tickWait = 0.3,
    useClick = true,
    near = 0,
    fires = 0,
}

local lastFire = setmetatable({}, { __mode = "k" })

local function PromptPart(obj)
    local p = obj.Parent
    if not p then return nil end
    if p:IsA("BasePart") then return p end
    if p:IsA("Attachment") then
        local host = p.Parent
        if host and host:IsA("BasePart") then return host end
    end
    local ok, bp = pcall(function() return p:FindFirstChildWhichIsA("BasePart", true) end)
    if ok then return bp end
    return nil
end

-- 全图扫描一次并缓存，避免手机上每帧遍历 workspace 卡顿
local interactCache, interactAt = {}, 0

local function ScanAllInteract()
    local out = {}
    local ok, list = pcall(function() return workspace:GetDescendants() end)
    if not ok or not list then return out end
    for _, obj in ipairs(list) do
        local isPrompt = obj:IsA("ProximityPrompt")
        local isClick = INTERACT.useClick and obj:IsA("ClickDetector")
        if isPrompt or isClick then
            local part = PromptPart(obj)
            if part then
                table.insert(out, { inst = obj, part = part })
            end
        end
    end
    return out
end

local function GetNearbyInteract(origin, radius)
    if os.clock() - interactAt > 1 then
        interactCache = ScanAllInteract()
        interactAt = os.clock()
    end
    local out = {}
    for _, t in ipairs(interactCache) do
        if t.inst.Parent and t.part.Parent then
            if (t.part.Position - origin).Magnitude <= radius then
                table.insert(out, t)
            end
        end
    end
    return out
end

local function FireInteract(list, force)
    local n = 0
    local now = os.clock()
    for _, t in ipairs(list) do
        local last = lastFire[t.inst] or 0
        if force or (now - last >= 0.25) then
            lastFire[t.inst] = now
            local ok = pcall(function()
                if t.inst:IsA("ProximityPrompt") then
                    if fireproximityprompt then fireproximityprompt(t.inst) end
                else
                    if fireclickdetector then fireclickdetector(t.inst) end
                end
            end)
            if ok then n = n + 1 end
        end
    end
    return n
end

local function InteractTick()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local list = GetNearbyInteract(hrp.Position, INTERACT.radius)
    INTERACT.near = #list
    INTERACT.fires = INTERACT.fires + FireInteract(list)
end

task.spawn(function()
    while true do
        task.wait(INTERACT.tickWait)
        if INTERACT.on then pcall(InteractTick) end
    end
end)

-- ==================== 智能拾取 ====================

local function IsLobbyItem(obj)
    local parent = obj.Parent
    while parent and parent ~= workspace do
        local pname = string.lower(parent.Name)
        if string.find(pname, "shop") or string.find(pname, "lobby")
            or string.find(pname, "display") or string.find(pname, "buy")
            or string.find(pname, "show") then
            return true
        end
        parent = parent.Parent
    end
    return false
end

local function SmartPickup(itemName, displayName)
    displayName = displayName or itemName
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart
    local targetObj, minDistance = nil, math.huge

    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name) == string.lower(itemName) then
            if not IsLobbyItem(obj) then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part and not obj:IsDescendantOf(char) then
                    local dist = (hrp.Position - part.Position).Magnitude
                    if dist < minDistance then
                        minDistance = dist
                        targetObj = obj
                    end
                end
            end
        end
    end

    if targetObj then
        local part = targetObj:IsA("BasePart") and targetObj or targetObj:FindFirstChildWhichIsA("BasePart")
        if part then part.CFrame = hrp.CFrame end
        task.wait(0.05)

        local prompt = targetObj:FindFirstChildWhichIsA("ProximityPrompt", true)
        if prompt then
            fireproximityprompt(prompt)
        elseif part then
            firetouchinterest(hrp, part, 0)
            task.wait(0.05)
            firetouchinterest(hrp, part, 1)
        end
        Notify("拾取成功", "已拾取：" .. displayName, 3)
    else
        Notify("未找到", "场景中不存在：" .. displayName, 3)
    end
end

-- ==================== 透视核心逻辑 ====================

local ESP = { Monsters = false, Bosses = false, Running = false }

local function ClearESPFor(obj)
    local hl = obj:FindFirstChild("FixedESP_HL")
    if hl then hl:Destroy() end
    local bb = obj:FindFirstChild("FixedESP_BB")
    if bb then bb:Destroy() end
end

local function ClearAllESP()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:FindFirstChild("FixedESP_HL") or obj:FindFirstChild("FixedESP_BB") then
            ClearESPFor(obj)
        end
    end
end

local function IsMonster(model)
    if not model:IsA("Model") then return false end
    if not model:FindFirstChildOfClass("Humanoid") then return false end
    if Players:GetPlayerFromCharacter(model) then return false end
    local lname = string.lower(model.Name)
    if string.find(lname, "npc") or string.find(lname, "shop") then return false end
    return true
end

local function IsBossModel(model)
    return string.find(string.lower(model.Name), "boss") ~= nil
end

local function CreateFixedESP(model, color, isBoss)
    local text = isBoss and "首领" or model.Name
    local existing = model:FindFirstChild("FixedESP_HL")

    if existing then
        existing.FillColor = color
        local bb = model:FindFirstChild("FixedESP_BB")
        local label = bb and bb:FindFirstChildOfClass("TextLabel")
        if label then
            label.Text = text
            label.TextColor3 = color
        end
        return
    end

    local hl = Instance.new("Highlight")
    hl.Name = "FixedESP_HL"
    hl.FillColor = color
    hl.FillTransparency = 0.6
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.OutlineTransparency = 0.2
    hl.Parent = model

    local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
    if not hrp then return end

    local bb = Instance.new("BillboardGui")
    bb.Name = "FixedESP_BB"
    bb.Adornee = hrp
    bb.Size = UDim2.new(0, 150, 0, 30)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = text
    label.TextColor3 = color
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 15
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = bb

    bb.Parent = model
end

local ESPGen = _G.__ESP_GEN

local function RunESPLoop()
    if ESP.Running then return end
    ESP.Running = true
    task.spawn(function()
        while ESPGen.alive and (ESP.Monsters or ESP.Bosses) do
            for _, obj in pairs(workspace:GetDescendants()) do
                if IsMonster(obj) then
                    local boss = IsBossModel(obj)
                    local want = (boss and ESP.Bosses) or ((not boss) and ESP.Monsters)
                    if want then
                        CreateFixedESP(obj, boss and Color3.fromRGB(255, 70, 90) or Color3.fromRGB(255, 105, 180), boss)
                    else
                        ClearESPFor(obj)
                    end
                end
            end
            task.wait(1)
        end
        ESP.Running = false
        ClearAllESP()
    end)
end

-- ==================== 光照 ====================

local function SetLighting(on)
    if on then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
    end
end

-- ==================== UI：主页 ====================

MainTab:Section({ Title = "光照" })

MainTab:Toggle({
    Title = "夜视（全亮模式）",
    Value = false,
    Callback = function(Value)
        _G.Fullbright = Value
        if Value then
            task.spawn(function()
                while _G.Fullbright do
                    SetLighting(true)
                    task.wait(0.5)
                end
            end)
        else
            SetLighting(false)
        end
    end,
})

MainTab:Section({ Title = "存档点" })

MainTab:Button({
    Title = "设置存档点",
    Callback = function()
        local char = LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            SavedBaseCFrame = char.HumanoidRootPart.CFrame
            Notify("保存成功", "存档点已记录", 3)
        else
            Notify("保存失败", "角色尚未加载完成", 3)
        end
    end,
})

MainTab:Button({
    Title = "传送回存档点",
    Callback = function()
        local char = LP.Character
        if SavedBaseCFrame and char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = SavedBaseCFrame
        else
            Notify("无法传送", "请先点击“设置存档点”", 3)
        end
    end,
})


-- ==================== UI：光环 ====================

local auraStatus
local function RefreshAuraStatus()
    local text = string.format("武器：%s ｜ 目标：%d ｜ 敌人：%d ｜ 命中：%d ｜ 击杀：%d",
        AURA.toolName or "无", AURA.targets, AURA.enemies, AURA.hits, AURA.kills)
    if auraStatus then
        pcall(function()
            if auraStatus.ParagraphFrame then
                auraStatus.ParagraphFrame:SetTitle(text)
            elseif auraStatus.SetTitle then
                auraStatus:SetTitle(text)
            end
        end)
    end
    return text
end

AuraTab:Section({ Title = "光环开关" })

local breakToggle, killToggle

breakToggle = AuraTab:Toggle({
    Title = "破坏光环（自动击碎周围物体）",
    Value = false,
    Callback = function(Value)
        AURA.breakOn = Value
        Log("破坏光环 " .. (Value and "开" or "关"))
    end,
})

killToggle = AuraTab:Toggle({
    Title = "杀戮光环",
    Value = false,
    Callback = function(Value)
        AURA.killOn = Value
        Log("击杀光环 " .. (Value and "开" or "关"))
    end,
})

AuraTab:Button({
    Title = "全部开启",
    Callback = function()
        AURA.breakOn = true
        AURA.killOn = true
        pcall(function() breakToggle:Set(true) end)
        pcall(function() killToggle:Set(true) end)
        Notify("已开启", "破坏光环与击杀光环同时运行", 3)
    end,
})

AuraTab:Button({
    Title = "全部停止",
    Callback = function()
        AURA.breakOn = false
        AURA.killOn = false
        pcall(function() breakToggle:Set(false) end)
        pcall(function() killToggle:Set(false) end)
        Notify("已停止", "两个光环已关闭", 2)
    end,
})

AuraTab:Section({ Title = "参数调节" })

local sliderTick, sliderTargets

AuraTab:Slider({
    Title = "破坏半径",
    Step = 5,
    Value = { Min = 0, Max = 200, Default = 25 },
    Callback = function(Value) AURA.breakRadius = Value end,
})

AuraTab:Slider({
    Title = "击杀半径（0 = 全图）",
    Step = 10,
    Value = { Min = 0, Max = 500, Default = 100 },
    Callback = function(Value) AURA.killRadius = Value end,
})

sliderTick = AuraTab:Slider({
    Title = "循环间隔（毫秒）",
    Step = 10,
    Value = { Min = 20, Max = 500, Default = 80 },
    Callback = function(Value) AURA.tickWait = Value / 1000 end,
})

sliderTargets = AuraTab:Slider({
    Title = "每次最多目标数",
    Step = 5,
    Value = { Min = 1, Max = 100, Default = 30 },
    Callback = function(Value) AURA.maxTargetsPerTick = math.floor(Value) end,
})

AuraTab:Toggle({
    Title = "跳过其他玩家",
    Value = true,
    Callback = function(Value) AURA.skipPlayers = Value end,
})

AuraTab:Toggle({
    Title = "扫描未复制物体（更彻底，可能略卡）",
    Value = true,
    Callback = function(Value) AURA.useNil = Value end,
})

AuraTab:Section({ Title = "预设方案" })

local function ApplyPreset(intervalMs, targets, name)
    AURA.tickWait = intervalMs / 1000
    AURA.maxTargetsPerTick = targets
    pcall(function() sliderTick:Set(intervalMs) end)
    pcall(function() sliderTargets:Set(targets) end)
    Notify("已切换", string.format("%s：间隔 %dms，每次 %d 目标", name, intervalMs, targets), 3)
end

AuraTab:Button({
    Title = "快速（间隔 30ms / 50 目标）",
    Callback = function() ApplyPreset(30, 50, "快速预设") end,
})

AuraTab:Button({
    Title = "均衡（间隔 80ms / 30 目标）",
    Callback = function() ApplyPreset(80, 30, "均衡预设") end,
})

AuraTab:Button({
    Title = "安全（间隔 150ms / 15 目标）",
    Callback = function() ApplyPreset(150, 15, "安全预设") end,
})

AuraTab:Section({ Title = "运行状态" })

auraStatus = AuraTab:Paragraph({
    Title = "武器：无 ｜ 目标：0 ｜ 敌人：0 ｜ 命中：0 ｜ 击杀：0",
    Desc = "状态每 0.6 秒自动刷新；也可点击下方按钮立即查看。",
})

AuraTab:Button({
    Title = "立即刷新状态",
    Callback = function()
        Notify("当前状态", RefreshAuraStatus(), 4)
    end,
})

AuraTab:Button({
    Title = "重置统计数据",
    Callback = function()
        AURA.hits, AURA.kills, AURA.targets, AURA.enemies = 0, 0, 0, 0
        Notify("已重置", "命中 / 击杀 / 目标统计归零", 2)
    end,
})

task.spawn(function()
    while true do
        task.wait(0.6)
        pcall(RefreshAuraStatus)
    end
end)

-- ==================== UI：商店搬运 ====================

local posInput
local syncingPos = false

local function PosText()
    return string.format("%.1f, %.1f, %.1f", STORE.dropPosition.X, STORE.dropPosition.Y, STORE.dropPosition.Z)
end

local function SyncPosInput()
    if posInput and not syncingPos then
        syncingPos = true
        pcall(function()
            if posInput.Set then
                posInput:Set(PosText())
            elseif posInput.SetValue then
                posInput:SetValue(PosText())
            end
        end)
        syncingPos = false
    end
end

StoreTab:Section({ Title = " 掉落点" })

posInput = StoreTab:Input({
    Title = "掉落点坐标（X, Y, Z）",
    Value = PosText(),
    Placeholder = "例如：120.5, 3.0, -88.2",
    Callback = function(text)
        if syncingPos then return end
        local x, y, z = text:match("([%-%d%.]+)%s*,%s*([%-%d%.]+)%s*,%s*([%-%d%.]+)")
        if x then
            STORE.dropPosition = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
        end
        SyncPosInput()
    end,
})

StoreTab:Button({
    Title = "把当前位置设为掉落点",
    Callback = function()
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            STORE.dropPosition = hrp.Position
            SyncPosInput()
            Notify("已更新", "掉落点：" .. PosText(), 3)
        else
            Notify("失败", "角色尚未加载", 3)
        end
    end,
})

StoreTab:Slider({
    Title = "跳过半径（已在此范围内的物体不重复搬）",
    Step = 1,
    Value = { Min = 0, Max = 50, Default = 8 },
    Callback = function(Value) STORE.skipRadius = math.floor(Value) end,
})

StoreTab:Section({ Title = " 批量操作" })

StoreTab:Button({
    Title = "把所有场景物品搬到掉落点",
    Callback = function()
        task.spawn(function()
            local d, s, f, err = BringItemsToPosition()
            if err then
                Notify("搬运失败", err, 4)
            else
                Notify("搬运完成", string.format("成功 %d ｜ 跳过 %d ｜ 失败 %d", d, s, f), 5)
            end
        end)
    end,
})

StoreTab:Button({
    Title = "把场景物品收进背包",
    Callback = function()
        task.spawn(function()
            local p, t, s = PickAllItems()
            Notify("收物完成", string.format("拾取 %d / 共 %d ｜ 跳过 %d", p, t, s), 4)
        end)
    end,
})

StoreTab:Button({
    Title = "把背包物品丢到掉落点",
    Callback = function()
        task.spawn(function()
            local n = DropAllBackpack(STORE.dropPosition)
            Notify("丢弃完成", string.format("已丢出 %d 件", n), 3)
        end)
    end,
})

StoreTab:Button({
    Title = "把背包物品丢在脚下",
    Callback = function()
        task.spawn(function()
            local n = DropAllAtFeet()
            Notify("丢弃完成", string.format("已在脚下丢出 %d 件", n), 3)
        end)
    end,
})

StoreTab:Section({ Title = "解锁" })

StoreTab:Button({
    Title = "解除建筑限制（解锁器）",
    Callback = function()
        local logs = RunUnlocker()
        for _, line in ipairs(logs) do Log(line) end
        Notify("解锁完成", table.concat(logs, "\n"), 5)
    end,
})

StoreTab:Section({ Title = " 自动" })

StoreTab:Toggle({
    Title = "循环获取物品到掉落点（每 0.5 秒）",
    Value = false,
    Callback = function(Value)
        STORE.autoBringPos = Value
        Log("自动搬运 " .. (Value and "开" or "关"))
    end,
})

StoreTab:Toggle({
    Title = "极速模式",
    Value = false,
    Callback = function(Value) STORE.turbo = Value end,
})

StoreTab:Section({ Title = "诊断" })

StoreTab:Button({
    Title = "输出诊断信息到控制台（F9）",
    Callback = function()
        local f = GetItemsFolder()
        Log("=== 诊断信息 ===")
        Log("场景物品数量：" .. (f and #f:GetChildren() or "未找到"))
        Log("拾取远程：" .. (GetRemote("RequestPickupItem") and "正常" or "缺失"))
        Log("丢弃远程：" .. (GetRemote("RequestDropItem") and "正常" or "缺失"))
        Log("装备远程：" .. (GetRemote("Item", "Equipped") and "正常" or "缺失"))
        Log("掉落点：" .. PosText())
        Notify("诊断已输出", "按 F9 打开控制台查看详情", 4)
    end,
})

-- ==================== UI：方块任务 ====================

QuestTab:Section({ Title = "收集方块（通关用）" })

QuestTab:Button({
    Title = "吸取全部 3 个方块",
    Callback = function()
        SmartPickup("GreenCube", "绿色方块")
        task.wait(0.2)
        SmartPickup("BlueCube", "蓝色方块")
        task.wait(0.2)
        SmartPickup("RedCube", "红色方块")
    end,
})

QuestTab:Button({
    Title = "吸取绿色方块",
    Callback = function() SmartPickup("GreenCube", "绿色方块") end,
})

QuestTab:Button({
    Title = "吸取蓝色方块",
    Callback = function() SmartPickup("BlueCube", "蓝色方块") end,
})

QuestTab:Button({
    Title = "吸取红色方块",
    Callback = function() SmartPickup("RedCube", "红色方块") end,
})

pcall(function()
    QuestTab:Section({ Title = "使用提示" })
    QuestTab:Paragraph({
        Title = "若某个方块已进入背包，对应按钮会提示“未找到”，属正常现象。",
        Desc = "游戏内对象名仅供参考：绿色方块 GreenCube、蓝色方块 BlueCube、红色方块 RedCube。",
    })
end)

-- ==================== UI：物品 ====================

SpawnTab:Section({ Title = "医疗物品" })
SpawnTab:Dropdown({
    Title = "选择医疗物品",
    Values = NamesOf(MedList),
    Value = "医疗包",
    Callback = function(Option) SelectedMed = Option end,
})
SpawnTab:Button({
    Title = "吸取 1 个医疗物品",
    Callback = function() SmartPickup(IdOf(MedList, SelectedMed), SelectedMed) end,
})

SpawnTab:Section({ Title = "食物" })
SpawnTab:Dropdown({
    Title = "选择食物",
    Values = NamesOf(FoodList),
    Value = "可乐",
    Callback = function(Option) SelectedFood = Option end,
})
SpawnTab:Button({
    Title = "吸取 1 个食物",
    Callback = function() SmartPickup(IdOf(FoodList, SelectedFood), SelectedFood) end,
})

SpawnTab:Section({ Title = "武器" })
SpawnTab:Dropdown({
    Title = "选择武器",
    Values = NamesOf(WeaponList),
    Value = "武士刀",
    Callback = function(Option) SelectedWeapon = Option end,
})
SpawnTab:Button({
    Title = "吸取 1 件武器",
    Callback = function() SmartPickup(IdOf(WeaponList, SelectedWeapon), SelectedWeapon) end,
})

-- ==================== UI：透视 ====================

ESPTab:Section({ Title = "视觉特效" })

ESPTab:Toggle({
    Title = "怪物 / 敌人透视高亮",
    Value = false,
    Callback = function(Value)
        ESP.Monsters = Value
        if Value then RunESPLoop() end
    end,
})

ESPTab:Toggle({
    Title = "首领透视高亮",
    Value = false,
    Callback = function(Value)
        ESP.Bosses = Value
        if Value then RunESPLoop() end
    end,
})

ESPTab:Button({
    Title = "清除全部透视高亮",
    Callback = function()
        ESP.Monsters = false
        ESP.Bosses = false
        ClearAllESP()
        Notify("已清除", "所有透视高亮已移除", 2)
    end,
})

-- ==================== UI：移动 / 飞行 ====================

FlyTab:Section({ Title = "飞行" })

flyToggle = FlyTab:Toggle({
    Title = "开启飞行（WASD 移动 / 空格上升 / Shift 下降）",
    Value = false,
    Callback = function(Value)
        if uiSyncing then return end
        if Value then
            if not StartFlying() then
                pcall(function() flyToggle:Set(false) end)
            end
        else
            StopFlying()
        end
    end,
})

btnToggle = FlyTab:Toggle({
    Title = "显示屏幕悬浮按钮",
    Value = false,
    Callback = function(Value)
        if uiSyncing then return end
        flyBtnPref = Value
        if not Value and Flying then StopFlying() end
        pcall(RefreshFlyButtons)
    end,
})

FlyTab:Slider({
    Title = "飞行速度",
    Step = 5,
    Value = { Min = 10, Max = 400, Default = 50 },
    Callback = function(Value) FlySpeed = Value end,
})

FlyTab:Button({
    Title = "立即切换飞行（不用悬浮按钮）",
    Callback = function()
        ToggleFly()
        Notify("飞行", Flying and "已开启" or "已关闭", 2)
    end,
})

FlyTab:Paragraph({
    Title = "不按方向键时角色原地悬停，不会再自动向前飞。",
    Desc = "电脑：W / A / S / D 沿视角平移，空格上升，左 Shift 或左 Ctrl 下降。手机：直接推游戏自带摇杆移动，屏幕上的 ↑ ↓ 按钮控制升降（飞行时会自动出现）。",
})

FlyTab:Section({ Title = "人物移速" })

walkToggle = FlyTab:Toggle({
    Title = "开启自定义移速",
    Value = false,
    Callback = function(Value) SetWalk(Value) end,
})

FlyTab:Slider({
    Title = "移速数值",
    Step = 1,
    Value = { Min = 8, Max = 300, Default = 32 },
    Callback = function(Value)
        MOVE.walkSpeed = math.floor(Value)
        if MOVE.walkOn and not MOVE.pushMode then pcall(ApplyWalkSpeed) end
    end,
})

pushToggle = FlyTab:Toggle({
    Title = "强制推进模式（游戏锁死移速时打开）",
    Value = false,
    Callback = function(Value)
        MOVE.pushMode = Value
        if Value then
            if MOVE.walkOn then EnsurePush() end
            Notify("强制推进", "改用物理推进实现移速，不再依赖 WalkSpeed", 4)
        else
            DestroyPush()
            if MOVE.walkOn then ApplyWalkSpeed() end
        end
    end,
})

FlyTab:Button({
    Title = "一键修复移速（自动判断用哪种方式）",
    Callback = function()
        task.spawn(function() pcall(AutoFixWalk) end)
    end,
})

FlyTab:Paragraph({
    Title = "移速无效时先点“一键修复”，仍不行就打开强制推进模式。",
    Desc = "脚本每帧都会重新写 WalkSpeed；若游戏在服务端锁死，则自动改用物理推进（不影响跳跃和重力）。推进模式下速度 = 移速数值 - 角色自身速度，不会变成双倍。",
})

FlyTab:Section({ Title = "无限跳跃" })

jumpToggle = FlyTab:Toggle({
    Title = "开启无限跳跃",
    Value = false,
    Callback = function(Value)
        MOVE.infJump = Value
        local hum = GetHumanoid()
        if Value then
            if hum then
                MOVE.baseJump = hum.JumpPower
                MOVE.baseUsePower = hum.UseJumpPower
            end
            ApplyJumpPower()
        else
            if hum and MOVE.baseJump then
                pcall(function()
                    hum.JumpPower = MOVE.baseJump
                    if MOVE.baseUsePower ~= nil then
                        hum.UseJumpPower = MOVE.baseUsePower
                    end
                end)
            end
            MOVE.baseJump = nil
            MOVE.baseUsePower = nil
        end
    end,
})

jumpSlider = FlyTab:Slider({
    Title = "跳跃力量",
    Step = 5,
    Value = { Min = 50, Max = 500, Default = 85 },
    Callback = function(Value)
        MOVE.jumpPower = math.floor(Value)
        if MOVE.infJump then ApplyJumpPower() end
    end,
})

FlyTab:Paragraph({
    Title = "开启后可在空中连续起跳，按住空格也会一直跳。",
    Desc = "跳跃力量越大跳得越高，建议 50 ~ 200；数值过高可能被服务器判定异常。",
})

-- ==================== UI：快速互动 ====================

InteractTab:Section({ Title = "快速互动" })

InteractTab:Toggle({
    Title = "自动快速互动（附近的门 / 按钮 / 拾取点）",
    Value = false,
    Callback = function(Value)
        INTERACT.on = Value
        Log("快速互动 " .. (Value and "开" or "关"))
    end,
})

InteractTab:Slider({
    Title = "互动半径",
    Step = 1,
    Value = { Min = 3, Max = 50, Default = 12 },
    Callback = function(Value) INTERACT.radius = math.floor(Value) end,
})

InteractTab:Slider({
    Title = "触发间隔（毫秒）",
    Step = 50,
    Value = { Min = 100, Max = 1000, Default = 300 },
    Callback = function(Value) INTERACT.tickWait = Value / 1000 end,
})

InteractTab:Toggle({
    Title = "同时触发 ClickDetector（老式按钮 / 门）",
    Value = true,
    Callback = function(Value)
        INTERACT.useClick = Value
        interactAt = 0
    end,
})

InteractTab:Button({
    Title = "立即互动一次",
    Callback = function()
        local char = LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            Notify("失败", "角色尚未加载", 2)
            return
        end
        interactAt = 0
        local list = GetNearbyInteract(hrp.Position, INTERACT.radius)
        local n = FireInteract(list, true)
        Notify("快速互动", string.format("半径 %d 内触发 %d 个互动对象", INTERACT.radius, n), 3)
    end,
})

InteractTab:Button({
    Title = "重置互动统计",
    Callback = function()
        INTERACT.fires = 0
        Notify("已重置", "累计触发次数归零", 2)
    end,
})

InteractTab:Paragraph({
    Title = "覆盖游戏里的门、电梯、按钮、拾取点和 NPC 对话提示。",
    Desc = "同一对象 0.25 秒内只触发一次，防止刷屏；扫描结果缓存 1 秒，手机端也不会明显掉帧。",
})

-- ==================== 快捷键 ====================

pcall(function() Window:SetToggleKey(Enum.KeyCode.RightShift) end)

Log("已加载 " .. SCRIPT_NAME)
Notify("加载完成", "已就绪，右 Shift 开关菜单", 4)