local repo = "https://raw.githubusercontent.com/ATLASTEAM01/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({ Title = "Y Hub | BY:y", Footer = "电脑按右shift打开ui", Center = true, AutoShow = true })

-- ========================= UI快捷键设置 =========================
local UIKeybind
if Library.SetToggleKey then
    Library:SetToggleKey(Enum.KeyCode.RightShift)
else
    UIKeybind = Enum.KeyCode.RightShift
    InputService = InputService or game:GetService("UserInputService")
    InputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == UIKeybind then
            if Library.Toggle then
                Library:Toggle()
            elseif Window.Toggle then
                Window:Toggle()
            end
        end
    end)
end

local Tabs = {
    Main = Window:AddTab("战斗", "crosshair"),
    Move = Window:AddTab("移动", "bolt"),
    Visual = Window:AddTab("视觉", "eye"),
    Misc = Window:AddTab("其他", "settings"),
    UI = Window:AddTab("UI设置", "cog"),
}

local PlayerService = game:GetService("Players")
local InputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LightingService = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = PlayerService.LocalPlayer

-- ========================= 飞行模块（完全修复） =========================
local FlightSettings = { fly = false, flyspeed = 50 }
local CharacterModel, Humanoid, BodyVelocity, BodyAngularVelocity, IsFlying = nil, nil, nil, nil, false
local MovementKeys = { W = false, S = false, A = false, D = false, Space = false, LeftShift = false, Moving = false }
local FlightConnection = nil

local function LocalFunction(vel) return vel.Unit * FlightSettings.flyspeed end

local function FlightHeartbeat(dt)
    if not IsFlying then
        if FlightConnection then
            FlightConnection:Disconnect()
            FlightConnection = nil
        end
        return
    end
    if not (CharacterModel and CharacterModel.PrimaryPart) then return end
    local pos = CharacterModel.PrimaryPart.Position
    local cf = CurrentCamera.CFrame
    local x,y,z = cf:toEulerAnglesXYZ()
    CharacterModel:SetPrimaryPartCFrame(CFrame.new(pos.x,pos.y,pos.z) * CFrame.Angles(x,y,z))
    if MovementKeys.W or MovementKeys.S or MovementKeys.A or MovementKeys.D or MovementKeys.Space or MovementKeys.LeftShift then
        local newVec = Vector3.new()
        if MovementKeys.W then newVec = newVec + LocalFunction(cf.LookVector) end
        if MovementKeys.S then newVec = newVec - LocalFunction(cf.LookVector) end
        if MovementKeys.A then newVec = newVec - LocalFunction(cf.RightVector) end
        if MovementKeys.D then newVec = newVec + LocalFunction(cf.RightVector) end
        if MovementKeys.Space then newVec = newVec + Vector3.new(0, FlightSettings.flyspeed, 0) end
        if MovementKeys.LeftShift then newVec = newVec - Vector3.new(0, FlightSettings.flyspeed, 0) end
        CharacterModel:TranslateBy(newVec * dt)
    end
end

local function FlyFunction()
    if LocalPlayer.Character and LocalPlayer.Character.Head and not IsFlying then
        CharacterModel = LocalPlayer.Character
        Humanoid = CharacterModel.Humanoid
        Humanoid.PlatformStand = true
        BodyVelocity = Instance.new("BodyVelocity")
        BodyAngularVelocity = Instance.new("BodyAngularVelocity")
        BodyVelocity.P = 1000
        BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
        BodyVelocity.Velocity = Vector3.new(0,0,0)
        BodyAngularVelocity.P = 1000
        BodyAngularVelocity.MaxTorque = Vector3.new(10000, 10000, 10000)
        BodyAngularVelocity.AngularVelocity = Vector3.new(0,0,0)
        BodyVelocity.Parent = CharacterModel.Head
        BodyAngularVelocity.Parent = CharacterModel.Head
        IsFlying = true
        if not FlightConnection then
            FlightConnection = RunService.Heartbeat:Connect(FlightHeartbeat)
        end
        Humanoid.Died:Connect(function() IsFlying = false end)
    end
end

-- 增强修复：彻底停止飞行并重置角色
local function StopFlyingFunction()
    -- 1. 删除自身创建的速度组件
    if BodyVelocity then BodyVelocity:Destroy() BodyVelocity = nil end
    if BodyAngularVelocity then BodyAngularVelocity:Destroy() BodyAngularVelocity = nil end

    -- 2. 处理当前角色
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function()
                hum.PlatformStand = false
                hum.WalkSpeed = 16          -- 恢复默认走路速度
                hum.JumpPower = 50          -- 恢复默认跳跃力度
                hum.AutoRotate = true       -- 允许自动转向
            end)
        end
        -- 删除所有残留的 Body 约束（包括其他脚本可能创建的）
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BodyVelocity") or part:IsA("BodyAngularVelocity") or part:IsA("BodyGyro") then
                pcall(function() part:Destroy() end)
            end
        end
        -- 额外清理：重置根部位的速度
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.Velocity = Vector3.new(0,0,0)
            root.RotVelocity = Vector3.new(0,0,0)
        end
    end

    IsFlying = false
    if FlightConnection then
        FlightConnection:Disconnect()
        FlightConnection = nil
    end

    -- 3. 延迟再重置一次，确保所有物理更新完成
    task.spawn(function()
        task.wait(0.1)
        local char2 = LocalPlayer.Character
        if char2 then
            local hum2 = char2:FindFirstChildOfClass("Humanoid")
            if hum2 then
                pcall(function()
                    hum2.PlatformStand = false
                    hum2.WalkSpeed = 16
                    hum2.JumpPower = 50
                end)
            end
            for _, part in pairs(char2:GetDescendants()) do
                if part:IsA("BodyVelocity") or part:IsA("BodyAngularVelocity") or part:IsA("BodyGyro") then
                    pcall(function() part:Destroy() end)
                end
            end
            local root2 = char2:FindFirstChild("HumanoidRootPart")
            if root2 then
                root2.Velocity = Vector3.new(0,0,0)
                root2.RotVelocity = Vector3.new(0,0,0)
            end
        end
    end)
end

-- 角色重生时重置飞行状态
LocalPlayer.CharacterAdded:Connect(function()
    if IsFlying then StopFlyingFunction() end
    IsFlying = false
    if FlightConnection then
        FlightConnection:Disconnect()
        FlightConnection = nil
    end
end)

InputService.InputBegan:Connect(function(key, gp)
    if not gp then
        for k,v in pairs(MovementKeys) do
            if k ~= "Moving" and key.KeyCode == Enum.KeyCode[k] then
                MovementKeys[k] = true
                MovementKeys.Moving = true
            end
        end
    end
end)
InputService.InputEnded:Connect(function(key, gp)
    if not gp then
        local any = false
        for k,v in pairs(MovementKeys) do
            if k ~= "Moving" then
                if key.KeyCode == Enum.KeyCode[k] then
                    MovementKeys[k] = false
                end
                if MovementKeys[k] then any = true end
            end
        end
        MovementKeys.Moving = any
    end
end)

-- ========================= Hitbox、Triggerbot、Autofarm、Weapon Mods =========================
local BooleanFlag = false
local ConfigTable = {}
local IntegerValue = 21
local SmallIntegerValue = 6
local GameMode = "Team-Based"
local UnknownValue = nil
local PartNames = {"UpperTorso","Head","HumanoidRootPart"}

local function SavePart(player, part)
    if not ConfigTable[player] then ConfigTable[player] = {} end
    if not ConfigTable[player][part.Name] then
        ConfigTable[player][part.Name] = {
            CanCollide = part.CanCollide,
            Transparency = part.Transparency,
            Size = part.Size
        }
    end
end

local function RestorePart(player)
    if ConfigTable[player] then
        local char = player.Character
        if char then
            for name, data in pairs(ConfigTable[player]) do
                local part = char:FindFirstChild(name)
                if part and part:IsA("BasePart") then
                    part.CanCollide = data.CanCollide
                    part.Transparency = data.Transparency
                    part.Size = data.Size
                end
            end
        end
        ConfigTable[player] = nil
    end
end

local function FindPart(player, name)
    if not player.Character then return nil end
    for _, part in ipairs(player.Character:GetChildren()) do
        if part:IsA("BasePart") and part.Name:lower():match(name:lower()) then
            return part
        end
    end
    return nil
end

local function IsValidTarget(player)
    if player and player.Team and LocalPlayer.Team then
        return (GameMode == "FFA" or GameMode == "Everyone") or (player.Team ~= LocalPlayer.Team)
    end
    return false
end

local function IsEnemy(player)
    local root = player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        return IsValidTarget(player)
    end
    return false
end

local function UpdateHitboxes()
    local active = {}
    for _, plr in ipairs(PlayerService:GetPlayers()) do
        if plr ~= LocalPlayer then
            active[plr] = true
            if IsEnemy(plr) then
                for _, name in ipairs(PartNames) do
                    local part = plr.Character and (plr.Character:FindFirstChild(name) or FindPart(plr, name))
                    if part and part:IsA("BasePart") then
                        SavePart(plr, part)
                        part.CanCollide = false
                        part.Transparency = 1 - SmallIntegerValue/10
                        part.Size = Vector3.new(IntegerValue, IntegerValue, IntegerValue)
                    end
                end
            elseif ConfigTable[plr] then
                RestorePart(plr)
            end
        end
    end
    for plr in pairs(ConfigTable) do
        if not active[plr] then
            RestorePart(plr)
        end
    end
end

local HitboxTickTimer = 0
local function HitboxTick(dt)
    HitboxTickTimer = HitboxTickTimer + dt
    if HitboxTickTimer >= 0.1 then
        HitboxTickTimer = 0
        UpdateHitboxes()
    end
end

PlayerService.PlayerRemoving:Connect(function(plr)
    ConfigTable[plr] = nil
end)

-- ======= 锁头 =======
local Flag1 = false
local LockOnTarget = "Enemies"
local EnemyCharacter = nil
local NullValue = nil
local DistanceValue = 200
local SmoothLock = false
local TimeValue = 0.2

local function IsLockTarget(player)
    if player and player ~= LocalPlayer and player.Team and LocalPlayer.Team then
        return LockOnTarget == "Everyone" or player.Team ~= LocalPlayer.Team
    end
    return false
end

local function GetClosestTarget()
    local char = LocalPlayer.Character
    if not (char and char:FindFirstChild("Head")) then return nil end
    local headPos = char.Head.Position
    local bestDist = math.huge
    local best = nil
    for _, plr in ipairs(PlayerService:GetPlayers()) do
        if IsLockTarget(plr) and plr.Character and plr.Character:FindFirstChild("Head") and not plr.Character:FindFirstChild("ForceField") then
            local h = plr.Character.Head
            local dist = (h.Position - headPos).Magnitude
            if dist < bestDist and dist <= DistanceValue then
                local dir = (h.Position - headPos).Unit * DistanceValue
                local params = RaycastParams.new()
                params.FilterType = Enum.RaycastFilterType.Blacklist
                params.FilterDescendantsInstances = {char}
                local hit = Workspace:Raycast(headPos, dir, params)
                if hit and hit.Instance and hit.Instance:IsDescendantOf(plr.Character) then
                    best = plr
                    bestDist = dist
                end
            end
        end
    end
    return best
end

local function UpdateLock()
    if not (EnemyCharacter and EnemyCharacter.Character and EnemyCharacter.Character:FindFirstChild("Head")) then
        EnemyCharacter = GetClosestTarget()
    end
    if EnemyCharacter and EnemyCharacter.Character and EnemyCharacter.Character:FindFirstChild("Head") then
        local eHead = EnemyCharacter.Character.Head
        local lChar = LocalPlayer.Character
        if not (lChar and lChar:FindFirstChild("Head")) then return end
        local lHead = lChar.Head
        local dir = (eHead.Position - lHead.Position).Unit * DistanceValue
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = {lChar}
        local hit = Workspace:Raycast(lHead.Position, dir, params)
        if hit and hit.Instance and hit.Instance:IsDescendantOf(EnemyCharacter.Character) then
            if SmoothLock then
                local cf = CFrame.new(CurrentCamera.CFrame.Position, eHead.Position)
                CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(cf, TimeValue)
            else
                CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, eHead.Position)
            end
        else
            EnemyCharacter = nil
        end
    else
        EnemyCharacter = nil
    end
end

-- ======= Triggerbot =======
getgenv().triggerb = false
local GameType = "Team-Based"
local BoolHealth = true
local Flag2 = false
local RaycastParams3 = RaycastParams.new()
RaycastParams3.FilterType = Enum.RaycastFilterType.Blacklist
local TriggerConnection = nil

local function IsTriggerTarget(player)
    if player and player.Team and LocalPlayer.Team then
        if GameType == "FFA" then return true
        elseif GameType == "Everyone" then return player ~= LocalPlayer
        elseif GameType == "Team-Based" then return player.Team ~= LocalPlayer.Team
        end
    end
    return false
end

local function SetupHealthCheck()
    local hum = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
    if hum then
        BoolHealth = hum.Health > 0
        hum.HealthChanged:Connect(function(h)
            BoolHealth = h > 0
            if not BoolHealth and Flag2 then
                Flag2 = false
                mouse1release()
            end
        end)
    end
end
LocalPlayer.CharacterAdded:Connect(SetupHealthCheck)
SetupHealthCheck()

local function TriggerRenderStep()
    if not (getgenv().triggerb and BoolHealth) then
        if Flag2 then
            Flag2 = false
            mouse1release()
        end
        return
    end
    local char = LocalPlayer.Character
    if char then
        RaycastParams3.FilterDescendantsInstances = {char}
        local center = CurrentCamera.ViewportSize / 2
        local ray = CurrentCamera:ViewportPointToRay(center.X, center.Y)
        local hit = Workspace:Raycast(ray.Origin, ray.Direction * 5000, RaycastParams3)
        local should = false
        if hit and hit.Instance then
            local model = hit.Instance:FindFirstAncestorOfClass("Model")
            if model and model:FindFirstChild("Humanoid") then
                local plr = PlayerService:GetPlayerFromCharacter(model)
                should = plr and IsTriggerTarget(plr) and not model:FindFirstChild("ForceField")
            end
        end
        if should then
            if not Flag2 then
                Flag2 = true
                mouse1press()
            end
        elseif Flag2 then
            Flag2 = false
            mouse1release()
        end
    end
end

local function SetTriggerEnabled(state)
    getgenv().triggerb = state
    if state then
        if not TriggerConnection then
            TriggerConnection = RunService.RenderStepped:Connect(TriggerRenderStep)
        end
    else
        if Flag2 then
            Flag2 = false
            mouse1release()
        end
        if TriggerConnection then
            TriggerConnection:Disconnect()
            TriggerConnection = nil
        end
    end
end

-- ======= Autofarm / Ragebot =======
getgenv().AutoFarm = false
local farmConnection = nil
local farmPressed = false

local function IsFarmTarget(player)
    if player and player ~= LocalPlayer and player:IsA("Player") and PlayerService:FindFirstChild(player.Name) then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("ForceField") then
            if player:FindFirstChild("Status") and player.Status.Alive.Value then
                if player.Team and LocalPlayer.Team and player.Team ~= LocalPlayer.Team and player.Team.Name ~= "Spectator" then
                    return true
                end
            end
        end
    end
    return false
end

local function GetClosestFarmTarget()
    local bestDist = math.huge
    local best = nil
    for _, plr in pairs(PlayerService:GetPlayers()) do
        if IsFarmTarget(plr) then
            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if dist < bestDist then
                best = plr
                bestDist = dist
            end
        end
    end
    return best
end

local function StartFarm()
    ReplicatedStorage.wkspc.TimeScale.Value = 12
    farmConnection = RunService.Stepped:Connect(function()
        if getgenv().AutoFarm then
            if ReplicatedStorage.wkspc.Status.RoundOver.Value == true then
                if farmPressed then mouse1release() farmPressed = false end
                return
            end
            if not (LocalPlayer:FindFirstChild("Status") and LocalPlayer.Status.Alive.Value) then
                if farmPressed then mouse1release() farmPressed = false end
                return
            end
            local target = GetClosestFarmTarget()
            if target then
                local root = target.Character.HumanoidRootPart
                local pos = root.Position - root.CFrame.LookVector * 2 + Vector3.new(0,2,0)
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                if target.Character:FindFirstChild("Head") then
                    CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, target.Character.Head.Position)
                end
                if not farmPressed then
                    mouse1press()
                    farmPressed = true
                end
            elseif farmPressed then
                mouse1release()
                farmPressed = false
            end
        else
            if farmConnection then farmConnection:Disconnect() farmConnection = nil end
            if farmPressed then mouse1release() farmPressed = false end
        end
    end)
end

-- ======= Weapon Mods =======
local WeaponConfig = {
    FireRate = {}, ReloadTime = {}, EReloadTime = {},
    Auto = {}, Spread = {}, Recoil = {}
}
local infAmmoV2 = false

-- ======= 移动相关 =======
local WalkSpeedConfig = { WalkSpeed = 16 }
local SpeedEnabled = false
local SpeedMethod = "Velocity"
local InfJumpEnabled = false
local AntiAimEnabled = false
local AntiAimSpinSpeed = 10
local antiAimGyro = nil
local NoClipEnabled = false
local CollectDebris = false
local DebrisFilter = "Both"

-- ======= 物品ESP =======
local ESPData = {}
local function CreateESP(instance, text)
    local bill = Instance.new("BillboardGui")
    local label = Instance.new("TextLabel")
    bill.Name = "dontask"
    bill.Parent = instance
    bill.AlwaysOnTop = true
    bill.Size = UDim2.new(0,50,0,50)
    bill.StudsOffset = Vector3.new(0,2,0)
    label.Parent = bill
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1,0,1,0)
    label.Text = text
    label.TextColor3 = Color3.new(1,0,0)
    label.TextScaled = false
    return bill
end

local ESPEnabledNames = {}
local ESPConn = nil

local function ESPDescendantAdded(obj)
    if not obj:IsA("TouchTransmitter") then return end
    local label = ESPEnabledNames[obj.Parent.Name]
    if label and not obj.Parent:FindFirstChild("dontask") then
        ESPData[obj.Parent] = CreateESP(obj.Parent, label)
    end
end

local function ToggleESP(enable, name, label)
    if enable then
        local n = 0
        for _, obj in ipairs(Workspace:GetDescendants()) do
            n = n + 1
            if n % 500 == 0 then task.wait() end
            if obj:IsA("TouchTransmitter") and obj.Parent.Name == name then
                if not obj.Parent:FindFirstChild("dontask") then
                    ESPData[obj.Parent] = CreateESP(obj.Parent, label)
                end
            end
        end
        ESPEnabledNames[name] = label
        if not ESPConn then
            ESPConn = Workspace.DescendantAdded:Connect(ESPDescendantAdded)
        end
    else
        ESPEnabledNames[name] = nil
        for obj, bill in pairs(ESPData) do
            if bill and bill:FindFirstChild("TextLabel") and bill.TextLabel.Text == label then
                bill:Destroy()
                ESPData[obj] = nil
            end
        end
        if next(ESPEnabledNames) == nil and ESPConn then
            ESPConn:Disconnect()
            ESPConn = nil
        end
    end
end

-- ======= 视觉备份 =======
local LightingBackup = {
    Ambient = LightingService.Ambient,
    ColorShift_Top = LightingService.ColorShift_Top,
    ColorShift_Bottom = LightingService.ColorShift_Bottom,
    FogEnd = LightingService.FogEnd,
    GlobalShadows = LightingService.GlobalShadows,
    Brightness = LightingService.Brightness
}
local TerrainBackup = {
    WaterWaveSize = Workspace.Terrain.WaterWaveSize,
    WaterWaveSpeed = Workspace.Terrain.WaterWaveSpeed,
    WaterReflectance = Workspace.Terrain.WaterReflectance,
    WaterTransparency = Workspace.Terrain.WaterTransparency
}
local MaterialBackup = {}
local EffectBackup = {}

-- ======= 皮肤 =======
local ArmMaterial = "Plastic"
local ArmColor = Color3.fromRGB(50,50,50)
local ArmSkinEnabled = false
local GunMaterial = "Plastic"
local GunColor = Color3.fromRGB(50,50,50)
local GunSkinEnabled = false
local RainbowWave = false
local RainbowPulse = false
local waveCount = 1
local pulseVal = 0
function zigzag(x) return math.acos(math.cos(x*math.pi))/math.pi end

local NameSpoofEnabled = false
local NameBackup = {}

-- ========================= FOV 吸附自瞄 =========================
local AimState = {
    enabled = false,
    wallAim = false,
    aimDead = false,
    onlySelected = false,
    enemyOnly = false,
    fovRadius = 150,
    maxDistance = 300,
    smooth = 0.18,
    aimPart = "Head",
    selected = nil,
    teamCheck = true,
    unknownAsEnemy = false,
    showFov = false,
}
local AimCurrentTarget = nil
local AimFovCircle = nil
local AimConnection = nil
local AimVisCache = {}

local function Aim_char(plr) return plr and plr.Character end
local function Aim_hum(plr)
    local c = Aim_char(plr)
    return c and c:FindFirstChildOfClass("Humanoid")
end
local function Aim_root(plr)
    local c = Aim_char(plr)
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function Aim_isAlive(plr)
    local h = Aim_hum(plr)
    return h and h.Health > 0
end

local function Aim_isEnemy(plr)
    if not plr or plr == LocalPlayer then return false end
    if not AimState.teamCheck then return true end
    if LocalPlayer.Team ~= nil and plr.Team ~= nil then
        return LocalPlayer.Team ~= plr.Team
    end
    if LocalPlayer.TeamColor ~= nil and plr.TeamColor ~= nil then
        return LocalPlayer.TeamColor ~= plr.TeamColor
    end
    local attrKeys = { "Team", "Faction", "Side", "Camp", "Group", "Squad", "Role", "Clan" }
    for _, key in ipairs(attrKeys) do
        local mine = LocalPlayer:GetAttribute(key)
        local theirs = plr:GetAttribute(key)
        if mine ~= nil and theirs ~= nil and tostring(mine) ~= "" and tostring(theirs) ~= "" then
            return tostring(mine) ~= tostring(theirs)
        end
    end
    return AimState.unknownAsEnemy
end

local function Aim_getTargetPart(plr)
    local c = Aim_char(plr)
    if not c then return nil end
    local part = c:FindFirstChild(AimState.aimPart)
    if not part then
        part = c:FindFirstChild("Head") or c:FindFirstChild("UpperTorso") or
               c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso")
    end
    if part and part:IsA("BasePart") and part.Name ~= "Handle" then return part end
    return nil
end

local function Aim_isVisible(plr)
    local cam = workspace.CurrentCamera
    if not cam then return true end
    local c = Aim_char(plr)
    if not c then return true end
    local head = c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart")
    if not head then return true end
    local origin = cam.CFrame.Position
    local dir = head.Position - origin
    if dir.Magnitude <= 0.1 then return true end
    local cached = AimVisCache[plr]
    if cached and (os.clock() - cached.t) < 0.1 then
        return cached.visible
    end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local excl = {}
    local myC = LocalPlayer.Character
    if myC then table.insert(excl, myC) end
    table.insert(excl, c)
    params.FilterDescendantsInstances = excl
    local hit = workspace:Raycast(origin, dir, params)
    local visible = not (hit and hit.Instance)
    AimVisCache[plr] = { visible = visible, t = os.clock() }
    return visible
end

local function Aim_findPlayerByName(name)
    name = tostring(name or "")
    for _, plr in ipairs(PlayerService:GetPlayers()) do
        if plr.Name == name or plr.DisplayName == name then return plr end
    end
    for _, plr in ipairs(PlayerService:GetPlayers()) do
        if string.lower(plr.Name):find(string.lower(name), 1, true) or
           string.lower(plr.DisplayName):find(string.lower(name), 1, true) then
            return plr
        end
    end
    return nil
end

local function Aim_getBestTarget()
    local cam = workspace.CurrentCamera
    if not cam then return nil, nil end
    local vp = cam.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)
    local myRoot = Aim_root(LocalPlayer)
    if not myRoot then return nil, nil end

    local best = nil
    for _, plr in ipairs(PlayerService:GetPlayers()) do
        if plr == LocalPlayer then continue end
        if not (AimState.aimDead or Aim_isAlive(plr)) then continue end
        if AimState.onlySelected and AimState.selected and plr ~= AimState.selected then continue end
        if AimState.enemyOnly and not Aim_isEnemy(plr) then continue end

        local part = Aim_getTargetPart(plr)
        if not part then continue end

        local pos, onScreen = cam:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local screenDist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
        if screenDist > AimState.fovRadius then continue end

        local worldDist = (part.Position - myRoot.Position).Magnitude
        if worldDist > AimState.maxDistance then continue end

        local visible = Aim_isVisible(plr)
        if not (visible or AimState.wallAim) then continue end

        if not best then
            best = { plr = plr, part = part, screenDist = screenDist, worldDist = worldDist, visible = visible }
        else
            if worldDist < best.worldDist - 0.5 then
                best = { plr = plr, part = part, screenDist = screenDist, worldDist = worldDist, visible = visible }
            elseif math.abs(worldDist - best.worldDist) <= 0.5 then
                if screenDist < best.screenDist then
                    best = { plr = plr, part = part, screenDist = screenDist, worldDist = worldDist, visible = visible }
                end
            end
        end
    end
    if best then return best.plr, best.part end
    return nil, nil
end

local function Aim_updateFovCircle()
    if AimState.showFov then
        if not AimFovCircle or not AimFovCircle.Parent then
            local gui = Instance.new("ScreenGui")
            gui.Name = "AimFovGui"
            gui.ResetOnSpawn = false
            gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
            AimFovCircle = Instance.new("Frame")
            AimFovCircle.Name = "FovCircle"
            AimFovCircle.Size = UDim2.fromOffset(AimState.fovRadius * 2, AimState.fovRadius * 2)
            AimFovCircle.Position = UDim2.new(0.5, -AimState.fovRadius, 0.5, -AimState.fovRadius)
            AimFovCircle.BackgroundTransparency = 1
            AimFovCircle.BorderSizePixel = 0
            AimFovCircle.Parent = gui
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = AimFovCircle
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(255, 45, 72)
            stroke.Transparency = 0.2
            stroke.Thickness = 2
            stroke.Parent = AimFovCircle
        end
        AimFovCircle.Size = UDim2.fromOffset(AimState.fovRadius * 2, AimState.fovRadius * 2)
        AimFovCircle.Position = UDim2.new(0.5, -AimState.fovRadius, 0.5, -AimState.fovRadius)
        AimFovCircle.Visible = true
    else
        if AimFovCircle then AimFovCircle.Visible = false end
    end
end

local function Aim_onRenderStep(dt)
    if not AimState.enabled then
        AimCurrentTarget = nil
        return
    end

    local targetPlr, targetPart = Aim_getBestTarget()
    if targetPlr and targetPart then
        AimCurrentTarget = targetPlr
        local cam = workspace.CurrentCamera
        if cam then
            local currentCF = cam.CFrame
            local goal = CFrame.lookAt(currentCF.Position, targetPart.Position)
            local smooth = math.clamp(AimState.smooth, 0.03, 0.75)
            cam.CFrame = currentCF:Lerp(goal, smooth)
        end
    else
        AimCurrentTarget = nil
    end
end

local function Aim_start()
    if not AimConnection then
        AimConnection = RunService:BindToRenderStep("AimRenderStep", Enum.RenderPriority.Camera.Value + 1, Aim_onRenderStep)
    end
end

local function Aim_stop()
    if AimConnection then
        RunService:UnbindFromRenderStep("AimRenderStep")
        AimConnection = nil
    end
    AimCurrentTarget = nil
    table.clear(AimVisCache)
end

local function Aim_setEnabled(enabled)
    AimState.enabled = enabled
    if enabled then Aim_start() else Aim_stop() end
    Aim_updateFovCircle()
end

-- ========================= 玩家绘制模块 =========================
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local Camera = workspace.CurrentCamera

    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local state = {
        enemyEsp = false,
        friendEsp = false,
        teamCheck = true,
        unknownAsEnemy = false,
        nameTags = false,
        friendWhitelist = {},
    }

    local function safeDestroy(x)
        if x then pcall(function() x:Destroy() end) end
    end

    local function char(plr)
        return plr and plr.Character
    end

    local function hum(plr)
        local c = char(plr)
        return c and c:FindFirstChildOfClass("Humanoid")
    end

    local function root(plr)
        local c = char(plr)
        return c and c:FindFirstChild("HumanoidRootPart")
    end

    local function isAlive(plr)
        local h = hum(plr)
        return h and h.Health > 0
    end

    local function isEnemy(plr)
        if not plr or plr == LocalPlayer then return false end
        if state.friendWhitelist[plr.Name] or state.friendWhitelist[plr.DisplayName] then
            return false
        end
        if not state.teamCheck then return true end
        if LocalPlayer.Team ~= nil and plr.Team ~= nil then
            return LocalPlayer.Team ~= plr.Team
        end
        if LocalPlayer.TeamColor ~= nil and plr.TeamColor ~= nil then
            return LocalPlayer.TeamColor ~= plr.TeamColor
        end
        local attrKeys = {
            "Team", "Faction", "Side", "Camp", "Group", "Squad", "Role",
            "Clan", "Alliance", "Guild", "FactionName", "Affiliation", "Party",
            "Color", "Index", "Allegiance", "Division", "Squadron"
        }
        for _, key in ipairs(attrKeys) do
            local mine = LocalPlayer:GetAttribute(key)
            local theirs = plr:GetAttribute(key)
            if mine ~= nil and theirs ~= nil and tostring(mine) ~= "" and tostring(theirs) ~= "" then
                return tostring(mine) ~= tostring(theirs)
            end
        end
        return state.unknownAsEnemy
    end

    local function isCharacterVisible(plr)
        local cam = Workspace.CurrentCamera
        if not cam then return true end
        local c = char(plr)
        if not c then return true end
        local head = c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart")
        if not head then return true end
        local origin = cam.CFrame.Position
        local dir = head.Position - origin
        if dir.Magnitude <= 0.1 then return true end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        local excl = {}
        local myC = LocalPlayer.Character
        if myC then table.insert(excl, myC) end
        table.insert(excl, c)
        params.FilterDescendantsInstances = excl
        local ok, hit = pcall(Workspace.Raycast, Workspace, origin, dir, params)
        if not ok then return true end
        return not (hit and hit.Instance)
    end

    local espStore = {}
    local tagStore = {}
    local lastHpCache = {}
    local avatarCache = {}

    local tagNames = {
        ZPvpNameTag = true,
        PvpNameTag = true,
        PvpFlowNameTag = true,
        PlayerESPNameTag = true,
    }
    local highlightNames = {
        ZPvpTeamHighlight = true,
        PvpTeamHighlight = true,
        PlayerESP = true,
    }

    local function destroyPlayerTags(plr)
        local c = char(plr)
        if c then
            for _, obj in ipairs(c:GetDescendants()) do
                if tagNames[obj.Name] and obj:IsA("BillboardGui") then
                    safeDestroy(obj)
                end
            end
        end
        safeDestroy(tagStore[plr])
        tagStore[plr] = nil
        lastHpCache[plr] = nil
    end

    local function destroyPlayerHighlights(plr)
        local c = char(plr)
        if c then
            for _, obj in ipairs(c:GetDescendants()) do
                if highlightNames[obj.Name] and obj:IsA("Highlight") then
                    safeDestroy(obj)
                end
            end
        end
        safeDestroy(espStore[plr])
        espStore[plr] = nil
    end

    local function updateEspFor(plr)
        local c = char(plr)
        local h = hum(plr)
        local enemy = isEnemy(plr)
        local headPart = c and c:FindFirstChild("Head")

        local shouldEsp = c and h and h.Health > 0 and ((enemy and state.enemyEsp) or ((not enemy) and state.friendEsp))
        local shouldNameTag = state.nameTags and headPart and h and h.Health > 0

        if not shouldEsp and not shouldNameTag then
            destroyPlayerHighlights(plr)
            destroyPlayerTags(plr)
            return
        end

        local visible = true
        if shouldEsp then
            visible = isCharacterVisible(plr)
        end

        local espColor, outlineColor
        if enemy then
            espColor = visible and Color3.fromRGB(52, 152, 255) or Color3.fromRGB(255, 45, 72)
            outlineColor = visible and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 160, 160)
        else
            espColor = visible and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(39, 174, 96)
            outlineColor = visible and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 255, 200)
        end

        if shouldEsp then
            if not espStore[plr] or espStore[plr].Parent ~= c then
                destroyPlayerHighlights(plr)
                local hi = Instance.new("Highlight")
                hi.Name = "ZPvpTeamHighlight"
                hi.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hi.FillTransparency = enemy and 0.62 or 0.50
                hi.OutlineTransparency = 0
                hi.Parent = c
                espStore[plr] = hi
            end
            espStore[plr].FillColor = espColor
            espStore[plr].OutlineColor = outlineColor
        else
            destroyPlayerHighlights(plr)
        end

        if shouldNameTag then
            if not tagStore[plr] or tagStore[plr].Parent ~= headPart then
                destroyPlayerTags(plr)

                local bill = Instance.new("BillboardGui")
                bill.Name = "ZPvpNameTag"
                bill.Adornee = headPart
                bill.AlwaysOnTop = true
                bill.StudsOffset = Vector3.new(0, 3.2, 0)
                bill.Size = UDim2.fromOffset(150, 56)
                bill.Parent = headPart

                local tag = Instance.new("Frame")
                tag.Name = "Tag"
                tag.Size = UDim2.fromScale(1, 1)
                tag.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
                tag.BackgroundTransparency = 0.35
                tag.BorderSizePixel = 0
                tag.Parent = bill
                Instance.new("UICorner", tag).CornerRadius = UDim.new(0, 9)

                local glassSheen = Instance.new("UIGradient")
                glassSheen.Name = "GlassSheen"
                glassSheen.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255), 0.8),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255), 1),
                })
                glassSheen.Parent = tag

                local stroke = Instance.new("UIStroke")
                stroke.Name = "Stroke"
                stroke.Color = Color3.fromRGB(255, 255, 255)
                stroke.Transparency = 0.35
                stroke.Thickness = 1
                stroke.Parent = tag

                local avatar = Instance.new("ImageLabel")
                avatar.Name = "Avatar"
                avatar.Position = UDim2.fromOffset(5, 5)
                avatar.Size = UDim2.fromOffset(20, 20)
                avatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                avatar.BackgroundTransparency = 0.8
                avatar.BorderSizePixel = 0
                avatar.ScaleType = Enum.ScaleType.Fit
                avatar.Parent = tag
                Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
                local avatarStroke = Instance.new("UIStroke")
                avatarStroke.Color = Color3.fromRGB(255, 255, 255)
                avatarStroke.Transparency = 0.4
                avatarStroke.Thickness = 1
                avatarStroke.Parent = avatar

                local function applyAvatar(img)
                    if avatar and avatar.Parent and type(img) == "string" and img ~= "" then
                        avatar.Image = img
                    end
                end
                local cachedUrl = avatarCache[plr]
                if type(cachedUrl) == "string" and cachedUrl ~= "" then
                    applyAvatar(cachedUrl)
                else
                    task.spawn(function()
                        local url = ""
                        for _ = 1, 5 do
                            local ok, got = pcall(function()
                                return game:GetService("Thumbnails"):GetPlayerThumbnail(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                            end)
                            if ok and type(got) == "string" and got ~= "" then
                                url = got
                                break
                            end
                            task.wait(1)
                        end
                        if url == "" then
                            url = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
                        end
                        avatarCache[plr] = url
                        applyAvatar(url)
                    end)
                end

                local name = Instance.new("TextLabel")
                name.Name = "Name"
                name.Position = UDim2.fromOffset(30, 6)
                name.Size = UDim2.new(1, -36, 0, 12)
                name.BackgroundTransparency = 1
                name.BorderSizePixel = 0
                name.Font = Enum.Font.GothamBold
                name.TextSize = 10
                name.TextColor3 = Color3.fromRGB(255, 255, 255)
                name.TextStrokeTransparency = 0.5
                name.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                name.TextXAlignment = Enum.TextXAlignment.Left
                name.Parent = tag

                local barBg = Instance.new("Frame")
                barBg.Name = "BarBg"
                barBg.Position = UDim2.fromOffset(6, 33)
                barBg.Size = UDim2.new(1, -12, 0, 2)
                barBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                barBg.BackgroundTransparency = 0.75
                barBg.BorderSizePixel = 0
                barBg.Parent = tag
                Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

                local barFill = Instance.new("Frame")
                barFill.Name = "BarFill"
                barFill.Size = UDim2.fromScale(1, 1)
                barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                barFill.BorderSizePixel = 0
                barFill.Parent = barBg
                Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

                local hp = Instance.new("TextLabel")
                hp.Name = "Hp"
                hp.Position = UDim2.fromOffset(0, 38)
                hp.Size = UDim2.new(1, 0, 0, 10)
                hp.BackgroundTransparency = 1
                hp.BorderSizePixel = 0
                hp.Font = Enum.Font.GothamBold
                hp.TextSize = 8
                hp.TextColor3 = Color3.fromRGB(215, 215, 215)
                hp.TextStrokeTransparency = 0.6
                hp.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                hp.TextXAlignment = Enum.TextXAlignment.Center
                hp.Parent = tag

                tagStore[plr] = bill

                local currentHP = math.floor(h.Health)
                local maxHp = h.MaxHealth > 0 and h.MaxHealth or 100
                name.Text = plr.Name
                hp.Text = currentHP .. " / " .. math.floor(maxHp)
                local ratio = math.clamp(currentHP / maxHp, 0, 1)
                barFill.Size = UDim2.fromScale(ratio, 1)
                lastHpCache[plr] = currentHP
            else
                local tag = tagStore[plr]:FindFirstChild("Tag")
                if tag then
                    local currentHP = math.floor(h.Health)
                    if lastHpCache[plr] ~= currentHP then
                        local name = tag:FindFirstChild("Name")
                        local hp = tag:FindFirstChild("Hp")
                        local barBg = tag:FindFirstChild("BarBg")
                        local barFill = barBg and barBg:FindFirstChild("BarFill")
                        local maxHp = h.MaxHealth > 0 and h.MaxHealth or 100
                        if name then name.Text = plr.Name end
                        if hp then hp.Text = currentHP .. " / " .. math.floor(maxHp) end
                        if barFill then
                            local ratio = math.clamp(currentHP / maxHp, 0, 1)
                            barFill.Size = UDim2.fromScale(ratio, 1)
                        end
                        lastHpCache[plr] = currentHP
                    end
                end
            end
        else
            destroyPlayerTags(plr)
        end
    end

    local function clearVisuals()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                destroyPlayerTags(plr)
                destroyPlayerHighlights(plr)
            end
        end
        table.clear(lastHpCache)
    end

    local espUpdateTimer = 0
    local function onRenderStep(deltaTime)
        local needUpdate = state.enemyEsp or state.friendEsp or state.nameTags
        if needUpdate then
            espUpdateTimer = espUpdateTimer + deltaTime
            if espUpdateTimer >= 0.2 then
                espUpdateTimer = 0
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        pcall(updateEspFor, plr)
                    end
                end
            end
        else
            espUpdateTimer = espUpdateTimer + deltaTime
            if espUpdateTimer >= 0.5 then
                espUpdateTimer = 0
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        destroyPlayerHighlights(plr)
                        destroyPlayerTags(plr)
                    end
                end
                table.clear(lastHpCache)
            end
        end
    end

    RunService:BindToRenderStep("DrawPlayerEspStep", Enum.RenderPriority.Camera.Value + 1, onRenderStep)

    Players.PlayerAdded:Connect(function(plr) end)
    Players.PlayerRemoving:Connect(function(plr)
        destroyPlayerTags(plr)
        destroyPlayerHighlights(plr)
        lastHpCache[plr] = nil
    end)
    LocalPlayer.CharacterAdded:Connect(function() end)

    getgenv().DrawPlayer = {
        setEnemyEsp = function(v) state.enemyEsp = v end,
        setFriendEsp = function(v) state.friendEsp = v end,
        setTeamCheck = function(v) state.teamCheck = v end,
        setUnknownAsEnemy = function(v) state.unknownAsEnemy = v end,
        setNameTags = function(v)
            state.nameTags = v
            if not v then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then destroyPlayerTags(plr) end
                end
                table.clear(lastHpCache)
            end
        end,
        addFriendWhitelist = function(name)
            state.friendWhitelist[name] = true
        end,
        clearWhitelist = function()
            table.clear(state.friendWhitelist)
        end,
        getState = function() return state end,
    }
end

-- ========================= UI 构建 =========================
local MainGroup = Tabs.Main:AddLeftGroupbox("战斗基础")

MainGroup:AddToggle("HitboxToggle", { Text = "开启 Hitbox 扩大", Default = BooleanFlag }):AddKeyPicker("HitboxKey", { Default = "RightAlt", SyncToggleState = true, Mode = "Toggle" })
Toggles.HitboxToggle:OnChanged(function(state)
    task.spawn(function()
        BooleanFlag = state
        if state then
            if not UnknownValue then UnknownValue = RunService.Heartbeat:Connect(HitboxTick) end
        else
            if UnknownValue then UnknownValue:Disconnect() UnknownValue = nil end
            for plr in pairs(ConfigTable) do RestorePart(plr) end
        end
    end)
end)

MainGroup:AddSlider("HitboxSize", { Text = "Hitbox 大小", Min = 1, Max = 30, Default = IntegerValue, Rounding = 1 })
Options.HitboxSize:OnChanged(function(v)
    task.spawn(function()
        IntegerValue = v
        if BooleanFlag then UpdateHitboxes() end
    end)
end)

MainGroup:AddSlider("HitboxAlpha", { Text = "Hitbox 透明度 (0=透明，10=可见)", Min = 0, Max = 10, Default = SmallIntegerValue, Rounding = 1 })
Options.HitboxAlpha:OnChanged(function(v)
    task.spawn(function()
        SmallIntegerValue = v
        if BooleanFlag then UpdateHitboxes() end
    end)
end)

MainGroup:AddDropdown("GameMode", { Text = "目标队伍", Values = {"混战模式","团队模式","Everyone"}, Default = GameMode })
Options.GameMode:OnChanged(function(v)
    task.spawn(function() GameMode = v end)
end)

MainGroup:AddToggle("LockToggle", { Text = "开启强锁头（旧）", Default = Flag1 }):AddKeyPicker("LockKey", { Default = "RightAlt", SyncToggleState = true, Mode = "Toggle" })
Toggles.LockToggle:OnChanged(function(state)
    task.spawn(function()
        Flag1 = state
        if state then
            if not NullValue then NullValue = RunService.RenderStepped:Connect(UpdateLock) end
        else
            if NullValue then NullValue:Disconnect() NullValue = nil end
            EnemyCharacter = nil
        end
    end)
end)

MainGroup:AddDropdown("LockTarget", { Text = "锁头目标", Values = {"Enemies","Everyone"}, Default = LockOnTarget })
Options.LockTarget:OnChanged(function(v)
    task.spawn(function() LockOnTarget = v; EnemyCharacter = nil end)
end)

-- ===== FOV 自瞄 =====
local AimGroup = Tabs.Main:AddRightGroupbox("FOV 吸附自瞄")
AimGroup:AddToggle("AimEnable", { Text = "开启 FOV 吸附", Default = AimState.enabled })
Toggles.AimEnable:OnChanged(function(state)
    task.spawn(function() Aim_setEnabled(state) end)
end)

AimGroup:AddToggle("AimWall", { Text = "穿透也允许吸附", Default = AimState.wallAim })
Toggles.AimWall:OnChanged(function(state)
    task.spawn(function() AimState.wallAim = state end)
end)

AimGroup:AddToggle("AimDead", { Text = "死亡目标也允许吸附", Default = AimState.aimDead })
Toggles.AimDead:OnChanged(function(state)
    task.spawn(function() AimState.aimDead = state end)
end)

AimGroup:AddToggle("AimOnlySelected", { Text = "只吸附所选玩家", Default = AimState.onlySelected })
Toggles.AimOnlySelected:OnChanged(function(state)
    task.spawn(function() AimState.onlySelected = state end)
end)

AimGroup:AddToggle("AimEnemyOnly", { Text = "只锁敌人", Default = AimState.enemyOnly })
Toggles.AimEnemyOnly:OnChanged(function(state)
    task.spawn(function() AimState.enemyOnly = state end)
end)

AimGroup:AddSlider("AimFovRadius", { Text = "FOV 半径", Min = 50, Max = 460, Default = AimState.fovRadius, Rounding = 1 })
Options.AimFovRadius:OnChanged(function(v)
    task.spawn(function()
        AimState.fovRadius = v
        Aim_updateFovCircle()
    end)
end)

AimGroup:AddSlider("AimMaxDist", { Text = "最大吸附距离", Min = 20, Max = 2000, Default = AimState.maxDistance, Rounding = 1 })
Options.AimMaxDist:OnChanged(function(v)
    task.spawn(function() AimState.maxDistance = v end)
end)

AimGroup:AddSlider("AimSmooth", { Text = "平滑度 (3~75)", Min = 3, Max = 75, Default = math.floor(AimState.smooth * 100), Rounding = 1 })
Options.AimSmooth:OnChanged(function(v)
    task.spawn(function() AimState.smooth = math.clamp(v / 100, 0.03, 0.75) end)
end)

AimGroup:AddDropdown("AimPart", { Text = "吸附部位", Values = {"Head","UpperTorso","HumanoidRootPart","LowerTorso","Torso"}, Default = AimState.aimPart })
Options.AimPart:OnChanged(function(v)
    task.spawn(function() AimState.aimPart = v end)
end)

AimGroup:AddInput("AimPlayerName", { Text = "输入玩家名（模糊匹配）", Placeholder = "输入名称...", Default = "" })
Options.AimPlayerName:OnChanged(function(text)
    _G._AimInputText = text
end)

AimGroup:AddButton("选择玩家", function()
    task.spawn(function()
        local name = _G._AimInputText or ""
        local plr = Aim_findPlayerByName(name)
        if plr then
            AimState.selected = plr
            Library:Notify("自瞄", "已选择: " .. plr.Name, 2)
        else
            Library:Notify("自瞄", "未找到玩家", 3)
        end
    end)
end)

AimGroup:AddButton("取消选择", function()
    task.spawn(function()
        AimState.selected = nil
        Library:Notify("自瞄", "已取消选择", 2)
    end)
end)

AimGroup:AddToggle("AimShowFov", { Text = "显示 FOV 圆圈（调试）", Default = AimState.showFov })
Toggles.AimShowFov:OnChanged(function(state)
    task.spawn(function()
        AimState.showFov = state
        Aim_updateFovCircle()
    end)
end)

-- Triggerbot & Autofarm
MainGroup:AddToggle("TriggerToggle", { Text = "开启自动开枪 (Triggerbot)", Default = getgenv().triggerb }):AddKeyPicker("TriggerKey", { Default = "RightAlt", SyncToggleState = true, Mode = "Toggle" })
Toggles.TriggerToggle:OnChanged(function(state)
    task.spawn(function() SetTriggerEnabled(state) end)
end)

MainGroup:AddDropdown("TriggerMode", { Text = "Triggerbot 队伍", Values = {"混战模式","团队模式","所有模式"}, Default = GameType })
Options.TriggerMode:OnChanged(function(v)
    task.spawn(function() GameType = v end)
end)

MainGroup:AddToggle("FarmToggle", { Text = "开启 Ragebot / 自动刷 (高风险)", Default = getgenv().AutoFarm }):AddKeyPicker("FarmKey", { Default = "RightAlt", SyncToggleState = true, Mode = "Toggle" })
Toggles.FarmToggle:OnChanged(function(state)
    task.spawn(function()
        getgenv().AutoFarm = state
        if state then
            task.wait(0.5)
            if LocalPlayer.Character then StartFarm() end
        else
            if farmConnection then
                farmConnection:Disconnect()
                farmConnection = nil
            end
            if farmPressed then
                mouse1release()
                farmPressed = false
            end
            ReplicatedStorage.wkspc.CurrentCurse.Value = ""
            ReplicatedStorage.wkspc.TimeScale.Value = 1
        end
    end)
end)

-- 武器修改
local WeaponGroup = Tabs.Main:AddRightGroupbox("武器修改")
WeaponGroup:AddToggle("InfAmmo1", { Text = "无限弹药1 (诅咒)", Default = false })
Toggles.InfAmmo1:OnChanged(function(state)
    task.spawn(function()
        ReplicatedStorage.wkspc.CurrentCurse.Value = state and "Infinite Ammo" or ""
    end)
end)

local InfAmmoConnection = nil
local function InfAmmoStep()
    if not infAmmoV2 then return end
    pcall(function()
        local gui = LocalPlayer.PlayerGui
        if gui and gui.GUI and gui.GUI.Client and gui.GUI.Client.Variables then
            gui.GUI.Client.Variables.ammocount.Value = 99
            gui.GUI.Client.Variables.ammocount2.Value = 99
        end
    end)
end

WeaponGroup:AddToggle("InfAmmo2", { Text = "无限弹药2 (本地)", Default = false })
Toggles.InfAmmo2:OnChanged(function(state)
    task.spawn(function()
        infAmmoV2 = state
        if state then
            if not InfAmmoConnection then
                InfAmmoConnection = RunService.Stepped:Connect(InfAmmoStep)
            end
        else
            if InfAmmoConnection then
                InfAmmoConnection:Disconnect()
                InfAmmoConnection = nil
            end
        end
    end)
end)

WeaponGroup:AddToggle("InstantReload", { Text = "瞬间换弹", Default = false })
Toggles.InstantReload:OnChanged(function(state)
    task.spawn(function()
        for _, weapon in pairs(ReplicatedStorage.Weapons:GetChildren()) do
            if weapon:FindFirstChild("ReloadTime") then
                if state then
                    if not WeaponConfig.ReloadTime[weapon] then WeaponConfig.ReloadTime[weapon] = weapon.ReloadTime.Value end
                    weapon.ReloadTime.Value = 0.01
                elseif WeaponConfig.ReloadTime[weapon] then
                    weapon.ReloadTime.Value = WeaponConfig.ReloadTime[weapon]
                end
            end
            if weapon:FindFirstChild("EReloadTime") then
                if state then
                    if not WeaponConfig.EReloadTime[weapon] then WeaponConfig.EReloadTime[weapon] = weapon.EReloadTime.Value end
                    weapon.EReloadTime.Value = 0.01
                elseif WeaponConfig.EReloadTime[weapon] then
                    weapon.EReloadTime.Value = WeaponConfig.EReloadTime[weapon]
                end
            end
        end
    end)
end)

WeaponGroup:AddToggle("FastFire", { Text = "快速射击", Default = false })
Toggles.FastFire:OnChanged(function(state)
    task.spawn(function()
        for _, obj in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if obj.Name == "FireRate" or obj.Name == "BFireRate" then
                if state then
                    if not WeaponConfig.FireRate[obj] then WeaponConfig.FireRate[obj] = obj.Value end
                    obj.Value = 0.02
                elseif WeaponConfig.FireRate[obj] then
                    obj.Value = WeaponConfig.FireRate[obj]
                end
            end
        end
    end)
end)

WeaponGroup:AddToggle("FullAuto", { Text = "强制全自动", Default = false })
Toggles.FullAuto:OnChanged(function(state)
    task.spawn(function()
        for _, obj in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if obj.Name == "Auto" or obj.Name == "AutoFire" or obj.Name == "Automatic" or obj.Name == "AutoShoot" or obj.Name == "AutoGun" then
                if state then
                    if not WeaponConfig.Auto[obj] then WeaponConfig.Auto[obj] = obj.Value end
                    obj.Value = true
                elseif WeaponConfig.Auto[obj] then
                    obj.Value = WeaponConfig.Auto[obj]
                end
            end
        end
    end)
end)

WeaponGroup:AddToggle("NoSpread", { Text = "无散布", Default = false })
Toggles.NoSpread:OnChanged(function(state)
    task.spawn(function()
        for _, obj in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if obj.Name == "MaxSpread" or obj.Name == "Spread" or obj.Name == "SpreadControl" then
                if state then
                    if not WeaponConfig.Spread[obj] then WeaponConfig.Spread[obj] = obj.Value end
                    obj.Value = 0
                elseif WeaponConfig.Spread[obj] then
                    obj.Value = WeaponConfig.Spread[obj]
                end
            end
        end
    end)
end)

WeaponGroup:AddToggle("NoRecoil", { Text = "无后座", Default = false })
Toggles.NoRecoil:OnChanged(function(state)
    task.spawn(function()
        for _, obj in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if obj.Name == "RecoilControl" or obj.Name == "Recoil" then
                if state then
                    if not WeaponConfig.Recoil[obj] then WeaponConfig.Recoil[obj] = obj.Value end
                    obj.Value = 0
                elseif WeaponConfig.Recoil[obj] then
                    obj.Value = WeaponConfig.Recoil[obj]
                end
            end
        end
    end)
end)

-- ========================= 移动 Tab =========================
local MoveGroup = Tabs.Move:AddLeftGroupbox("移动控制")
MoveGroup:AddToggle("FlyToggle", { Text = "飞行", Default = false }):AddKeyPicker("FlyKey", { Default = "RightAlt", SyncToggleState = true, Mode = "Toggle" })
Toggles.FlyToggle:OnChanged(function(state)
    task.spawn(function()
        if state then
            FlyFunction()
        else
            StopFlyingFunction()
        end
    end)
end)

MoveGroup:AddSlider("FlySpeed", { Text = "飞行速度", Min = 1, Max = 500, Default = FlightSettings.flyspeed, Rounding = 1 })
Options.FlySpeed:OnChanged(function(v)
    task.spawn(function() FlightSettings.flyspeed = v end)
end)

-- 优化速度：仅在移动时生效
local SpeedConnection = nil
local function SpeedStep(dt)
    if not SpeedEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and root and hum.MoveDirection.Magnitude > 0.1 then
        if SpeedMethod == "Velocity" then
            root.Velocity = Vector3.new(
                hum.MoveDirection.X * WalkSpeedConfig.WalkSpeed,
                root.Velocity.Y,
                hum.MoveDirection.Z * WalkSpeedConfig.WalkSpeed
            )
        elseif SpeedMethod == "CFrame" then
            root.CFrame = root.CFrame + hum.MoveDirection * WalkSpeedConfig.WalkSpeed * dt
        end
    end
end

MoveGroup:AddToggle("SpeedToggle", { Text = "自定义移动速度", Default = SpeedEnabled })
Toggles.SpeedToggle:OnChanged(function(state)
    task.spawn(function()
        SpeedEnabled = state
        if state then
            if not SpeedConnection then
                SpeedConnection = RunService.Stepped:Connect(SpeedStep)
            end
        else
            if SpeedConnection then
                SpeedConnection:Disconnect()
                SpeedConnection = nil
            end
        end
    end)
end)

MoveGroup:AddDropdown("SpeedMethod", { Text = "速度方式", Values = {"Velocity","CFrame"}, Default = SpeedMethod })
Options.SpeedMethod:OnChanged(function(v)
    task.spawn(function() SpeedMethod = v end)
end)

MoveGroup:AddSlider("WalkSpeed", { Text = "移动速度", Min = 16, Max = 500, Default = WalkSpeedConfig.WalkSpeed, Rounding = 1 })
Options.WalkSpeed:OnChanged(function(v)
    task.spawn(function() WalkSpeedConfig.WalkSpeed = v end)
end)

MoveGroup:AddToggle("InfJumpToggle", { Text = "无限跳跃", Default = InfJumpEnabled })
Toggles.InfJumpToggle:OnChanged(function(state)
    task.spawn(function()
        InfJumpEnabled = state
        if state then
            InputService.JumpRequest:Connect(function()
                if InfJumpEnabled then
                    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:ChangeState("Jumping") end
                end
            end)
        end
    end)
end)

MoveGroup:AddToggle("AntiAimToggle", { Text = "反自瞄", Default = AntiAimEnabled })
Toggles.AntiAimToggle:OnChanged(function(state)
    task.spawn(function()
        AntiAimEnabled = state
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if state and root then
            local bv = Instance.new("BodyAngularVelocity")
            bv.Name = "AntiAimSpin"
            bv.AngularVelocity = Vector3.new(0, AntiAimSpinSpeed, 0)
            bv.MaxTorque = Vector3.new(0, math.huge, 0)
            bv.P = 500000
            bv.Parent = root
            antiAimGyro = Instance.new("BodyGyro")
            antiAimGyro.Name = "AntiAimGyro"
            antiAimGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            antiAimGyro.CFrame = root.CFrame
            antiAimGyro.P = 3000
            antiAimGyro.Parent = root
        elseif root then
            local spin = root:FindFirstChild("AntiAimSpin")
            if spin then spin:Destroy() end
            if antiAimGyro then antiAimGyro:Destroy() antiAimGyro = nil end
        end
    end)
end)

MoveGroup:AddSlider("SpinSpeed", { Text = "旋转速度", Min = 10, Max = 100, Default = AntiAimSpinSpeed, Rounding = 1 })
Options.SpinSpeed:OnChanged(function(v)
    task.spawn(function()
        AntiAimSpinSpeed = v
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local spin = root:FindFirstChild("AntiAimSpin")
            if spin then spin.AngularVelocity = Vector3.new(0, v, 0) end
        end
    end)
end)

-- 穿墙
local NoClipHeartbeat = nil
local noClipTimer = 0
local noClipCharConn = nil
local noClipAddedConn = nil

local function ApplyNoclip(enable)
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = not enable end
        end
    end
end

local function NoClipTick(dt)
    if not NoClipEnabled then return end
    noClipTimer = noClipTimer + dt
    if noClipTimer >= 0.25 then
        noClipTimer = 0
        ApplyNoclip(true)
    end
end

local function ConnectNoClip()
    local char = LocalPlayer.Character
    if char and not noClipCharConn then
        noClipCharConn = char.DescendantAdded:Connect(function(part)
            if NoClipEnabled and part:IsA("BasePart") then part.CanCollide = false end
        end)
    end
    if not NoClipHeartbeat then
        NoClipHeartbeat = RunService.Heartbeat:Connect(NoClipTick)
    end
end

local function DisconnectNoClip()
    if noClipCharConn then
        noClipCharConn:Disconnect()
        noClipCharConn = nil
    end
    if NoClipHeartbeat then
        NoClipHeartbeat:Disconnect()
        NoClipHeartbeat = nil
    end
    ApplyNoclip(false)
end

MoveGroup:AddToggle("NoClipToggle", { Text = "穿墙 (Noclip)", Default = NoClipEnabled })
Toggles.NoClipToggle:OnChanged(function(state)
    task.spawn(function()
        NoClipEnabled = state
        if state then
            ConnectNoClip()
            if not noClipAddedConn then
                noClipAddedConn = LocalPlayer.CharacterAdded:Connect(function()
                    if NoClipEnabled then
                        task.wait(0.15)
                        ConnectNoClip()
                    end
                end)
            end
        else
            DisconnectNoClip()
            if noClipAddedConn then
                noClipAddedConn:Disconnect()
                noClipAddedConn = nil
            end
        end
    end)
end)

MoveGroup:AddToggle("CollectDebrisToggle", { Text = "物品传送", Default = CollectDebris })
Toggles.CollectDebrisToggle:OnChanged(function(state)
    task.spawn(function()
        CollectDebris = state
        if state then
            task.spawn(function()
                while CollectDebris do
                    pcall(function()
                        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            for _, item in pairs(Workspace.Debris:GetChildren()) do
                                local name = item.Name
                                if DebrisFilter == "Both" or (DebrisFilter == "DeadHP" and name == "DeadHP") or (DebrisFilter == "DeadAmmo" and name == "DeadAmmo") then
                                    item.CFrame = root.CFrame * CFrame.new(0,0.2,0)
                                end
                            end
                        end
                    end)
                    task.wait(0.3)
                end
            end)
        end
    end)
end)

MoveGroup:AddDropdown("DebrisFilter", { Text = "物品筛选", Values = {"补血箱","弹药箱","全部"}, Default = "全部" })
Options.DebrisFilter:OnChanged(function(v)
    task.spawn(function()
        if v == "补血箱" then DebrisFilter = "DeadHP"
        elseif v == "弹药箱" then DebrisFilter = "DeadAmmo"
        else DebrisFilter = "Both" end
    end)
end)

-- ========================= 视觉 Tab =========================
local VisualGroup = Tabs.Visual:AddLeftGroupbox("视觉")

VisualGroup:AddToggle("AmmoESP", { Text = "弹药 ESP", Default = false })
Toggles.AmmoESP:OnChanged(function(state)
    task.spawn(function() ToggleESP(state, "DeadAmmo", "弹药箱") end)
end)

VisualGroup:AddToggle("HealthESP", { Text = "生命 ESP", Default = false })
Toggles.HealthESP:OnChanged(function(state)
    task.spawn(function() ToggleESP(state, "DeadHP", "补血箱") end)
end)

VisualGroup:AddToggle("FullBright", { Text = "全局光亮", Default = false })
Toggles.FullBright:OnChanged(function(state)
    task.spawn(function()
        if state then
            LightingService.Ambient = Color3.new(1,1,1)
            LightingService.ColorShift_Top = Color3.new(1,1,1)
            LightingService.ColorShift_Bottom = Color3.new(1,1,1)
        else
            LightingService.Ambient = LightingBackup.Ambient
            LightingService.ColorShift_Top = LightingBackup.ColorShift_Top
            LightingService.ColorShift_Bottom = LightingBackup.ColorShift_Bottom
        end
    end)
end)

VisualGroup:AddToggle("NoFog", { Text = "无雾", Default = false })
Toggles.NoFog:OnChanged(function(state)
    task.spawn(function() LightingService.FogEnd = state and 1000000 or LightingBackup.FogEnd end)
end)

VisualGroup:AddToggle("NoShadows", { Text = "无阴影", Default = false })
Toggles.NoShadows:OnChanged(function(state)
    task.spawn(function() LightingService.GlobalShadows = not state end)
end)

VisualGroup:AddToggle("XRay", { Text = "X射线透视", Default = false })
Toggles.XRay:OnChanged(function(state)
    task.spawn(function()
        local n = 0
        for _, obj in pairs(Workspace:GetDescendants()) do
            n = n + 1
            if n % 500 == 0 then task.wait() end
            if obj:IsA("BasePart") then
                if state then
                    if not obj:FindFirstChild("OriginalTransparency") then
                        local nv = Instance.new("NumberValue")
                        nv.Name = "OriginalTransparency"
                        nv.Value = obj.Transparency
                        nv.Parent = obj
                    end
                    obj.Transparency = 0.5
                else
                    if obj:FindFirstChild("OriginalTransparency") then
                        obj.Transparency = obj.OriginalTransparency.Value
                        obj.OriginalTransparency:Destroy()
                    end
                end
            end
        end
    end)
end)

VisualGroup:AddToggle("LowLatency", { Text = "低延迟", Default = false })
Toggles.LowLatency:OnChanged(function(state)
    task.spawn(function()
        if state then
            local n = 0
            for _, obj in pairs(Workspace:GetDescendants()) do
                n = n + 1
                if n % 500 == 0 then task.wait() end
                if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
                    MaterialBackup[obj] = obj.Material
                    obj.Material = Enum.Material.SmoothPlastic
                end
            end
        else
            local n = 0
            for obj, mat in pairs(MaterialBackup) do
                n = n + 1
                if n % 500 == 0 then task.wait() end
                if obj and obj:IsA("BasePart") then obj.Material = mat end
            end
            MaterialBackup = {}
        end
    end)
end)

VisualGroup:AddToggle("FPSBoost", { Text = "提高FPS", Default = false })
Toggles.FPSBoost:OnChanged(function(state)
    task.spawn(function()
        if state then
            local terrain = Workspace.Terrain
            TerrainBackup.WaterWaveSize = terrain.WaterWaveSize
            TerrainBackup.WaterWaveSpeed = terrain.WaterWaveSpeed
            TerrainBackup.WaterReflectance = terrain.WaterReflectance
            TerrainBackup.WaterTransparency = terrain.WaterTransparency
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 0
            LightingService.GlobalShadows = false
            LightingService.FogEnd = 387420489
            LightingService.Brightness = 0
            settings().Rendering.QualityLevel = "Level01"
            local n = 0
            for _, obj in pairs(game:GetDescendants()) do
                n = n + 1
                if n % 500 == 0 then task.wait() end
                if obj:IsA("Part") or obj:IsA("Union") or obj:IsA("CornerWedgePart") or obj:IsA("TrussPart") or obj:IsA("MeshPart") then
                    MaterialBackup[obj] = obj.Material
                    obj.Material = "Plastic"
                    obj.Reflectance = 0
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj.Lifetime = NumberRange.new(0)
                elseif obj:IsA("Explosion") then
                    obj.BlastPressure = 1
                    obj.BlastRadius = 1
                elseif obj:IsA("Fire") or obj:IsA("SpotLight") or obj:IsA("Smoke") then
                    obj.Enabled = false
                end
            end
            for _, effect in pairs(LightingService:GetChildren()) do
                if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or effect:IsA("DepthOfFieldEffect") then
                    EffectBackup[effect] = effect.Enabled
                    effect.Enabled = false
                end
            end
        else
            local terrain = Workspace.Terrain
            terrain.WaterWaveSize = TerrainBackup.WaterWaveSize
            terrain.WaterWaveSpeed = TerrainBackup.WaterWaveSpeed
            terrain.WaterReflectance = TerrainBackup.WaterReflectance
            terrain.WaterTransparency = TerrainBackup.WaterTransparency
            LightingService.GlobalShadows = LightingBackup.GlobalShadows
            LightingService.FogEnd = LightingBackup.FogEnd
            LightingService.Brightness = LightingBackup.Brightness
            settings().Rendering.QualityLevel = "Automatic"
            local n = 0
            for obj, mat in pairs(MaterialBackup) do
                n = n + 1
                if n % 500 == 0 then task.wait() end
                if obj and obj:IsA("BasePart") then
                    obj.Material = mat
                    obj.Reflectance = 0
                end
            end
            MaterialBackup = {}
            for effect, en in pairs(EffectBackup) do
                if effect then effect.Enabled = en end
            end
            EffectBackup = {}
        end
    end)
end)

-- ===== 玩家绘制 =====
local PlayerEspGroup = Tabs.Visual:AddRightGroupbox("玩家绘制")
PlayerEspGroup:AddToggle("DrawEnemyEsp", { Text = "启用敌人ESP (高亮)", Default = false })
Toggles.DrawEnemyEsp:OnChanged(function(state)
    task.spawn(function() getgenv().DrawPlayer.setEnemyEsp(state) end)
end)

PlayerEspGroup:AddToggle("DrawFriendEsp", { Text = "启用队友ESP (高亮)", Default = false })
Toggles.DrawFriendEsp:OnChanged(function(state)
    task.spawn(function() getgenv().DrawPlayer.setFriendEsp(state) end)
end)

PlayerEspGroup:AddToggle("DrawNameTags", { Text = "显示身份牌 (名字/血量/头像)", Default = false })
Toggles.DrawNameTags:OnChanged(function(state)
    task.spawn(function() getgenv().DrawPlayer.setNameTags(state) end)
end)

PlayerEspGroup:AddToggle("DrawTeamCheck", { Text = "阵营检测", Default = true })
Toggles.DrawTeamCheck:OnChanged(function(state)
    task.spawn(function() getgenv().DrawPlayer.setTeamCheck(state) end)
end)

PlayerEspGroup:AddToggle("DrawUnknownEnemy", { Text = "未知阵营视为敌人", Default = false })
Toggles.DrawUnknownEnemy:OnChanged(function(state)
    task.spawn(function() getgenv().DrawPlayer.setUnknownAsEnemy(state) end)
end)

-- 皮肤
local SkinGroup = Tabs.Visual:AddRightGroupbox("皮肤")
SkinGroup:AddDropdown("ArmMaterial", { Text = "手臂材质", Values = {"Plastic","ForceField","Wood","Grass"}, Default = ArmMaterial })
Options.ArmMaterial:OnChanged(function(v)
    task.spawn(function() ArmMaterial = v end)
end)

SkinGroup:AddInput("ArmColor", { Text = "手臂颜色 (R,G,B)", Placeholder = "50,50,50", Default = "50,50,50" })
Options.ArmColor:OnChanged(function(text)
    local r,g,b = text:match("(%d+),%s*(%d+),%s*(%d+)")
    if r and g and b then ArmColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
end)

SkinGroup:AddToggle("ArmSkinToggle", { Text = "启用手臂皮肤", Default = ArmSkinEnabled })
Toggles.ArmSkinToggle:OnChanged(function(state)
    task.spawn(function()
        ArmSkinEnabled = state
        if state then
            task.spawn(function()
                while ArmSkinEnabled do
                    local arms = workspace.Camera:FindFirstChild("Arms")
                    if arms then
                        for _, obj in pairs(arms:GetDescendants()) do
                            if obj.Name == "Right Arm" or obj.Name == "Left Arm" then
                                if obj:IsA("BasePart") then
                                    obj.Material = Enum.Material[ArmMaterial]
                                    obj.Color = ArmColor
                                end
                            elseif obj:IsA("SpecialMesh") then
                                if obj.TextureId == "" then
                                    obj.TextureId = "rbxassetid://0"
                                    obj.VertexColor = Vector3.new(ArmColor.R, ArmColor.G, ArmColor.B)
                                end
                            elseif obj.Name == "L" or obj.Name == "R" then
                                obj:Destroy()
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end)
end)

SkinGroup:AddDropdown("GunMaterial", { Text = "武器材质", Values = {"Plastic","ForceField","Wood","Grass"}, Default = GunMaterial })
Options.GunMaterial:OnChanged(function(v)
    task.spawn(function() GunMaterial = v end)
end)

SkinGroup:AddInput("GunColor", { Text = "武器颜色 (R,G,B)", Placeholder = "50,50,50", Default = "50,50,50" })
Options.GunColor:OnChanged(function(text)
    local r,g,b = text:match("(%d+),%s*(%d+),%s*(%d+)")
    if r and g and b then GunColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
end)

SkinGroup:AddToggle("GunSkinToggle", { Text = "启用武器皮肤", Default = GunSkinEnabled })
Toggles.GunSkinToggle:OnChanged(function(state)
    task.spawn(function()
        GunSkinEnabled = state
        if state then
            task.spawn(function()
                while GunSkinEnabled do
                    local arms = workspace.Camera:FindFirstChild("Arms")
                    if arms then
                        for _, obj in pairs(arms:GetDescendants()) do
                            if obj:IsA("MeshPart") then
                                obj.Material = Enum.Material[GunMaterial]
                                obj.Color = GunColor
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end)
end)

local RainbowConnection = nil
local function RainbowStep()
    if not (RainbowWave or RainbowPulse) then return end
    local arms = workspace.Camera:FindFirstChild("Arms")
    if not arms then return end
    for _, obj in pairs(arms:GetDescendants()) do
        if obj:IsA("MeshPart") then
            if RainbowWave then
                obj.Color = Color3.fromHSV(zigzag(waveCount), 1, 1)
                waveCount = waveCount + 0.0001
            elseif RainbowPulse then
                pulseVal = (pulseVal + 0.1) % 1
                obj.Color = Color3.fromHSV(pulseVal, 1, 1)
            end
        end
    end
end

local function UpdateRainbowConnection()
    local on = RainbowWave or RainbowPulse
    if on and not RainbowConnection then
        RainbowConnection = RunService.RenderStepped:Connect(RainbowStep)
    elseif not on and RainbowConnection then
        RainbowConnection:Disconnect()
        RainbowConnection = nil
    end
end

SkinGroup:AddToggle("RainbowWave", { Text = "彩虹效果（波浪）", Default = RainbowWave })
Toggles.RainbowWave:OnChanged(function(state)
    task.spawn(function() RainbowWave = state; UpdateRainbowConnection() end)
end)

SkinGroup:AddToggle("RainbowPulse", { Text = "彩虹效果（脉冲）", Default = RainbowPulse })
Toggles.RainbowPulse:OnChanged(function(state)
    task.spawn(function() RainbowPulse = state; UpdateRainbowConnection() end)
end)

-- ========================= 其他 Tab =========================
local MiscGroup = Tabs.Misc:AddLeftGroupbox("杂项工具")
MiscGroup:AddToggle("FakeStats", { Text = "伪造等级（客户端）", Default = false })
Toggles.FakeStats:OnChanged(function(state)
    task.spawn(function()
        local stats = LocalPlayer.CareerStatsCache
        if state then
            if not NameBackup.Score then NameBackup.Score = stats.Score.Value end
            if not NameBackup.Kills then NameBackup.Kills = stats.Kills.Value end
            stats.Score.Value = 1
            stats.Kills.Value = 1
        else
            if NameBackup.Score then stats.Score.Value = NameBackup.Score end
            if NameBackup.Kills then stats.Kills.Value = NameBackup.Kills end
        end
    end)
end)

MiscGroup:AddToggle("FakeName", { Text = "伪造名称（客户端）", Default = false })
Toggles.FakeName:OnChanged(function(state)
    task.spawn(function()
        NameSpoofEnabled = state
        if state then
            task.spawn(function()
                while NameSpoofEnabled do
                    pcall(function()
                        local gui = LocalPlayer.PlayerGui
                        if gui:FindFirstChild("Menew_Main") and gui.Menew_Main:FindFirstChild("Container") and gui.Menew_Main.Container:FindFirstChild("PlrName") then
                            gui.Menew_Main.Container.PlrName.Text = "Twistzz"
                        end
                        if gui:FindFirstChild("GUI_Scorecard") and gui.GUI_Scorecard:FindFirstChild("Scorecard") and gui.GUI_Scorecard.Scorecard:FindFirstChild("PlayerCard") and gui.GUI_Scorecard.Scorecard.PlayerCard:FindFirstChild("Username") then
                            gui.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = "Twistzz Development"
                        end
                        for i=1,6 do
                            if workspace.KillFeed:FindFirstChild(tostring(i)) then
                                workspace.KillFeed[tostring(i)].Killer.Value = "Twistzz User"
                            end
                        end
                    end)
                    task.wait(0.2)
                end
            end)
        end
    end)
end)

local function AddBadgeToggle(name, label)
    MiscGroup:AddToggle("Badge"..name, { Text = "显示 " .. label .. " 徽章", Default = false })
    Toggles["Badge"..name]:OnChanged(function(state)
        task.spawn(function()
            if state then
                if not LocalPlayer:FindFirstChild(name) then Instance.new("IntValue", LocalPlayer).Name = name end
            else
                if LocalPlayer:FindFirstChild(name) then LocalPlayer[name]:Destroy() end
            end
        end)
    end)
end
AddBadgeToggle("IsChad", "Chad")
AddBadgeToggle("VIP", "VIP")
AddBadgeToggle("OldVIP", "Old VIP")
AddBadgeToggle("Romin", "Romin")
AddBadgeToggle("IsAdmin", "Admin")

MiscGroup:AddButton("ServerHop", { Text = "服务器跳转", Callback = function()
    task.spawn(function()
        local placeId = game.PlaceId
        local data = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in ipairs(data.data) do
            if server.playing < server.maxPlayers then
                TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                break
            end
        end
    end)
end })

MiscGroup:AddButton("Rejoin", { Text = "重新加入", Callback = function()
    task.spawn(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
end })

MiscGroup:AddInput("TimeScale", { Text = "游戏速度 (客户端)", Placeholder = "1", Default = "1" })
Options.TimeScale:OnChanged(function(text)
    task.spawn(function()
        local val = tonumber(text)
        if val then ReplicatedStorage.wkspc.TimeScale.Value = val end
    end)
end)

-- ===== 重置角色控制按钮 =====
MiscGroup:AddButton("重置角色控制", function()
    task.spawn(function()
        StopFlyingFunction()
        if farmConnection then
            farmConnection:Disconnect()
            farmConnection = nil
        end
        if farmPressed then
            mouse1release()
            farmPressed = false
        end
        if SpeedConnection then
            SpeedConnection:Disconnect()
            SpeedConnection = nil
        end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.WalkSpeed = 16
                hum.JumpPower = 50
            end
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BodyVelocity") or part:IsA("BodyAngularVelocity") or part:IsA("BodyGyro") then
                    part:Destroy()
                end
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.new(0,0,0)
                root.RotVelocity = Vector3.new(0,0,0)
            end
        end
        Library:Notify("重置", "角色控制已恢复", 2)
    end)
end)

-- ========================= UI Tab（主题） =========================
ThemeManager:SetLibrary(Library)
ThemeManager:ApplyToTab(Tabs.UI)
local uiGroup = Tabs.UI:AddLeftGroupbox("主题设置")
uiGroup:AddLabel("使用下方按钮切换主题")

Library:Notify("兵工厂", "功能已加载，请查看各标签页", 4)

-- ========================= 悬浮窗 =========================
task.spawn(function()
    task.wait(0.8)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FloatingMenu"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 60, 0, 60)
    frame.Position = UDim2.new(0, 16, 0, 120)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BackgroundTransparency = 0.25
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    frame.Draggable = true
    frame.Active = true
    frame.Selectable = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.35
    stroke.Thickness = 1
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "⚙"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 30
    label.TextScaled = true
    label.Parent = frame

    local function toggleMainWindow()
        if Window then
            if Window.Toggle then
                Window:Toggle()
            elseif Window.SetVisible then
                Window:SetVisible(not Window.Visible)
            end
        end
    end

    local isDragging = false
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
            local startPos = input.Position
            frame.InputChanged:Connect(function(changed)
                if changed.UserInputType == input.UserInputType then
                    if (changed.Position - startPos).Magnitude > 10 then
                        isDragging = true
                    end
                end
            end)
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            task.wait(0.05)
            if not isDragging then
                toggleMainWindow()
            end
        end
    end)
end)

-- ========================= 电脑端快捷键：右Shift =========================
InputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if Window then
            if Window.Toggle then
                Window:Toggle()
            elseif Window.SetVisible then
                Window:SetVisible(not Window.Visible)
            end
        end
    end
end)
