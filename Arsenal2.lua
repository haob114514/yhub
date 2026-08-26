-- ========== 使用 WindUI 替代 Fluent ==========
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
pcall(function() WindUI:SetTheme("Midnight") end)
WindUI:SetFont("rbxasset://fonts/families/FredokaOne.json")
-- ============================================

game:GetService("StarterGui")
local PlayerService = game:GetService("Players")
local InputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
game:GetService("TweenService")
local LightingService = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = PlayerService.LocalPlayer
local UserSettings = UserSettings()

-- ===== 清理旧 UI =====
pcall(function()
    local oldGui = LocalPlayer.PlayerGui:FindFirstChild("ArsenalUI")
    if oldGui then oldGui:Destroy() end
end)

-- ===== 创建 WindUI 窗口 =====
local Window = WindUI:CreateWindow({
    Title = "Arsenal Y-HUB",
    Author = "by y & 蓝鲸鱼",
    Folder = "ArsenalUI",
    NewElements = true,
    HideSearchBar = false,
    Transparent = true,
    Background = "https://i.postimg.cc/7LGCqjqt/UI-bei-jing.jpg",
    BackgroundImageTransparency = 0.3,
    BackgroundColor = Color3.fromRGB(10, 10, 20),
    OpenButton = {
        Title = "打开 Arsenal 脚本",
        CornerRadius = UDim.new(0, 10),
        StrokeThickness = 12,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Scale = 1.2,
        Position = UDim2.new(0.5, -50, 0, 20),
        Color = ColorSequence.new(
            Color3.fromRGB(255, 100, 50),
            Color3.fromRGB(200, 50, 200)
        )
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
        TagOffset = 56,
    },
})
Window:SetToggleKey(Enum.KeyCode.RightShift)

-- ===== 创建 Sections 和 Tabs =====
local Sections = {
    Main = Window:Section({ Title = "战斗", Box = false, Opened = true }),
    Gun = Window:Section({ Title = "武器", Box = false, Opened = true }),
    Player = Window:Section({ Title = "移动", Box = false, Opened = true }),
    Visuals = Window:Section({ Title = "视觉", Box = false, Opened = true }),
    World = Window:Section({ Title = "世界", Box = false, Opened = true }),
    Skins = Window:Section({ Title = "皮肤", Box = false, Opened = true }),
    Extra = Window:Section({ Title = "杂项", Box = false, Opened = true }),
    Settings = Window:Section({ Title = "设置", Box = false, Opened = true }),
}

local Tabs = {
    MainTab = Sections.Main:Tab({ Title = "战斗", Icon = "swords", IconColor = Color3.fromRGB(255, 80, 80), Border = true }),
    GunTab = Sections.Gun:Tab({ Title = "武器", Icon = "crosshair", IconColor = Color3.fromRGB(255, 200, 50), Border = true }),
    PlayerTab = Sections.Player:Tab({ Title = "移动", Icon = "user", IconColor = Color3.fromRGB(50, 200, 255), Border = true }),
    VisualsTab = Sections.Visuals:Tab({ Title = "视觉", Icon = "eye", IconColor = Color3.fromRGB(100, 200, 100), Border = true }),
    WorldTab = Sections.World:Tab({ Title = "世界", Icon = "globe", IconColor = Color3.fromRGB(100, 150, 255), Border = true }),
    SkinsTab = Sections.Skins:Tab({ Title = "皮肤", Icon = "palette", IconColor = Color3.fromRGB(255, 150, 200), Border = true }),
    ExtraTab = Sections.Extra:Tab({ Title = "杂项", Icon = "puzzle", IconColor = Color3.fromRGB(200, 150, 100), Border = true }),
    SettingsTab = Sections.Settings:Tab({ Title = "设置", Icon = "settings", IconColor = Color3.fromRGB(150, 150, 200), Border = true }),
}

-- ===== 原功能保留 =====

-- 飞行设置
local FlightSettings = {
    fly = false,
    flyspeed = 50
}
local CharacterModel = nil
local Humanoid = nil
local BodyVelocity = nil
local BodyAngularVelocity = nil
local Camera = nil
local IsFlying = false
local MovementKeys = {
    W = false,
    S = false,
    A = false,
    D = false,
    Space = false,
    LeftShift = false,
    Moving = false
}

local function FlyFunction()
    if LocalPlayer.Character and (LocalPlayer.Character.Head and not IsFlying) then
        CharacterModel = LocalPlayer.Character
        Humanoid = CharacterModel.Humanoid
        Humanoid.PlatformStand = true
        Camera = Workspace:WaitForChild("Camera")
        BodyVelocity = Instance.new("BodyVelocity")
        BodyAngularVelocity = Instance.new("BodyAngularVelocity")
        local VelocityObject = BodyVelocity
        local VelocityObject1 = BodyVelocity
        local VelocityObject2 = BodyVelocity
        local ZeroVector = Vector3.new(0, 0, 0)
        local MaxForceVector = Vector3.new(10000, 10000, 10000)
        VelocityObject2.P = 1000
        VelocityObject1.MaxForce = MaxForceVector
        VelocityObject.Velocity = ZeroVector
        local AngularVelocityObject = BodyAngularVelocity
        local AngularVelocityObject1 = BodyAngularVelocity
        local AngularVelocityObject2 = BodyAngularVelocity
        local ZeroVector1 = Vector3.new(0, 0, 0)
        local MaxTorqueVector = Vector3.new(10000, 10000, 10000)
        AngularVelocityObject2.P = 1000
        AngularVelocityObject1.MaxTorque = MaxTorqueVector
        AngularVelocityObject.AngularVelocity = ZeroVector1
        BodyVelocity.Parent = CharacterModel.Head
        BodyAngularVelocity.Parent = CharacterModel.Head
        IsFlying = true
        Humanoid.Died:connect(function()
            IsFlying = false
        end)
    end
end

local function StopFlyingFunction()
    if LocalPlayer.Character and IsFlying then
        Humanoid.PlatformStand = false
        if BodyVelocity then
            BodyVelocity:Destroy()
        end
        if BodyAngularVelocity then
            BodyAngularVelocity:Destroy()
        end
        IsFlying = false
    end
end

InputService.InputBegan:connect(function(Parameter1, Parameter2)
    if not Parameter2 then
        local KeyPair, KeyPair1, KeyPair2 = pairs(MovementKeys)
        while true do
            local UnknownVariable
            KeyPair2, UnknownVariable = KeyPair(KeyPair1, KeyPair2)
            if KeyPair2 == nil then
                break
            end
            if KeyPair2 ~= "Moving" and Parameter1.KeyCode == Enum.KeyCode[KeyPair2] then
                MovementKeys[KeyPair2] = true
                MovementKeys.Moving = true
            end
        end
    end
end)

InputService.InputEnded:connect(function(Parameter3, Parameter4)
    if not Parameter4 then
        local KeyPair3, KeyPair4, KeyPair5 = pairs(MovementKeys)
        local BooleanValue = false
        while true do
            local UnknownVariable1
            KeyPair5, UnknownVariable1 = KeyPair3(KeyPair4, KeyPair5)
            if KeyPair5 == nil then
                break
            end
            if KeyPair5 ~= "Moving" then
                if Parameter3.KeyCode == Enum.KeyCode[KeyPair5] then
                    MovementKeys[KeyPair5] = false
                end
                if MovementKeys[KeyPair5] then
                    BooleanValue = true
                end
            end
        end
        MovementKeys.Moving = BooleanValue
    end
end)

local function LocalFunction(Parameter5)
    return Parameter5.Unit * FlightSettings.flyspeed
end

RunService.Heartbeat:connect(function(Parameter6)
    if IsFlying and (CharacterModel and CharacterModel.PrimaryPart) then
        local PrimaryPartPosition = CharacterModel.PrimaryPart.Position
        local CFrameValue = Camera.CFrame
        local EulerAnglesX, EulerAnglesY, EulerAnglesZ = CFrameValue:toEulerAnglesXYZ()
        CharacterModel:SetPrimaryPartCFrame(CFrame.new(PrimaryPartPosition.x, PrimaryPartPosition.y, PrimaryPartPosition.z) * CFrame.Angles(EulerAnglesX, EulerAnglesY, EulerAnglesZ))
        if MovementKeys.W or (MovementKeys.S or (MovementKeys.A or (MovementKeys.D or (MovementKeys.Space or MovementKeys.LeftShift)))) then
            local NewVector = Vector3.new()
            if MovementKeys.W then
                NewVector = NewVector + LocalFunction(CFrameValue.lookVector)
            end
            if MovementKeys.S then
                NewVector = NewVector - LocalFunction(CFrameValue.lookVector)
            end
            if MovementKeys.A then
                NewVector = NewVector - LocalFunction(CFrameValue.rightVector)
            end
            if MovementKeys.D then
                NewVector = NewVector + LocalFunction(CFrameValue.rightVector)
            end
            if MovementKeys.Space then
                NewVector = NewVector + Vector3.new(0, FlightSettings.flyspeed, 0)
            end
            if MovementKeys.LeftShift then
                NewVector = NewVector - Vector3.new(0, FlightSettings.flyspeed, 0)
            end
            CharacterModel:TranslateBy(NewVector * Parameter6)
        end
    end
end)

-- ===== 原功能变量 =====
local BooleanFlag = false
local ConfigTable = {}
local IntegerValue = 21
local SmallIntegerValue = 6
local GameMode = "团队模式"
local UnknownValue = nil
local PartNames = {
    "UpperTorso",
    "Head",
    "HumanoidRootPart"
}

local function LocalFunction1(Parameter7, Parameter8)
    if not ConfigTable[Parameter7] then
        ConfigTable[Parameter7] = {}
    end
    if not ConfigTable[Parameter7][Parameter8.Name] then
        ConfigTable[Parameter7][Parameter8.Name] = {
            CanCollide = Parameter8.CanCollide,
            Transparency = Parameter8.Transparency,
            Size = Parameter8.Size
        }
    end
end

local function LocalFunction2(Parameter9)
    if ConfigTable[Parameter9] then
        local CharacterModel1 = Parameter9.Character
        if CharacterModel1 then
            local ConfigPair, ConfigPair1, ConfigPair2 = pairs(ConfigTable[Parameter9])
            while true do
                local UnknownVariable2
                ConfigPair2, UnknownVariable2 = ConfigPair(ConfigPair1, ConfigPair2)
                if ConfigPair2 == nil then
                    break
                end
                local ChildPart = CharacterModel1:FindFirstChild(ConfigPair2)
                if ChildPart and ChildPart:IsA("BasePart") then
                    ChildPart.CanCollide = UnknownVariable2.CanCollide
                    ChildPart.Transparency = UnknownVariable2.Transparency
                    ChildPart.Size = UnknownVariable2.Size
                end
            end
        end
        ConfigTable[Parameter9] = nil
    end
end

local function LocalFunction3(Parameter10, Parameter11)
    if not Parameter10.Character then
        return nil
    end
    local ChildrenTable = Parameter10.Character:GetChildren()
    local ChildIndex, ChildIndex1, ChildIndex2 = ipairs(ChildrenTable)
    while true do
        local UnknownVariable3
        ChildIndex2, UnknownVariable3 = ChildIndex(ChildIndex1, ChildIndex2)
        if ChildIndex2 == nil then
            break
        end
        if UnknownVariable3:IsA("BasePart") and UnknownVariable3.Name:lower():match(Parameter11:lower()) then
            return UnknownVariable3
        end
    end
    return nil
end

local function LocalFunction4(Parameter12)
    if Parameter12 and (Parameter12.Team and LocalPlayer.Team) then
        return (GameMode == "自由混战" or GameMode == "所有人") and true or Parameter12.Team ~= LocalPlayer.Team
    else
        return false
    end
end

local function LocalFunction5(Parameter13)
    local HumanoidRootPart = Parameter13 and Parameter13.Character and Parameter13.Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        HumanoidRootPart = LocalFunction4(Parameter13)
    end
    return HumanoidRootPart
end

local function LocalFunction6()
    local PlayerService1 = PlayerService
    local PlayerIndex, PlayerIndex1, PlayerIndex2 = ipairs(PlayerService1:GetPlayers())
    local EmptyTable = {}
    while true do
        local UnknownVariable4
        PlayerIndex2, UnknownVariable4 = PlayerIndex(PlayerIndex1, PlayerIndex2)
        if PlayerIndex2 == nil then
            break
        end
        if UnknownVariable4 ~= LocalPlayer then
            EmptyTable[UnknownVariable4] = true
            if LocalFunction5(UnknownVariable4) then
                local PartNameIndex, PartNameIndex1, PlayerList = ipairs(PartNames)
                while true do
                    local CharacterName
                    PlayerList, CharacterName = PartNameIndex(PartNameIndex1, PlayerList)
                    if PlayerList == nil then
                        break
                    end
                    local CharacterModel = UnknownVariable4.Character:FindFirstChild(CharacterName) or LocalFunction3(UnknownVariable4, CharacterName)
                    if CharacterModel and CharacterModel:IsA("BasePart") then
                        LocalFunction1(UnknownVariable4, CharacterModel)
                        CharacterModel.CanCollide = false
                        CharacterModel.Transparency = 1 - SmallIntegerValue / 10
                        CharacterModel.Size = Vector3.new(IntegerValue, IntegerValue, IntegerValue)
                    end
                end
            elseif ConfigTable[UnknownVariable4] then
                LocalFunction2(UnknownVariable4)
            end
        end
    end
    local TableKey, TableValue, TableIndex = pairs(ConfigTable)
    while true do
        TableIndex = TableKey(TableValue, TableIndex)
        if TableIndex == nil then
            break
        end
        if not EmptyTable[TableIndex] then
            LocalFunction2(TableIndex)
        end
    end
end

PlayerService.PlayerRemoving:Connect(function(Parameter1)
    if ConfigTable[Parameter1] then
        ConfigTable[Parameter1] = nil
    end
end)

-- ===== 锁定变量 =====
local Flag1 = false
local GameModeLock = "敌人"
local EnemyCharacter = nil
local NullValue = nil
local DistanceValue = 200
local BooleanFlagLock = false
local TimeValue = 0.2

local function Function1(FuncParam)
    if FuncParam and (FuncParam ~= LocalPlayer and (FuncParam.Team and LocalPlayer.Team)) then
        return GameModeLock == "所有人" and true or FuncParam.Team ~= LocalPlayer.Team
    else
        return false
    end
end

local function Function2()
    local LocalCharacter = LocalPlayer.Character
    if not (LocalCharacter and LocalCharacter:FindFirstChild("Head")) then
        return nil
    end
    local HeadPosition = LocalCharacter.Head.Position
    local MaxValue = math.huge
    local PlayerService = PlayerService
    local PlayerList1, PlayerItem, PlayerIndex = ipairs(PlayerService:GetPlayers())
    local NullObject = nil
    while true do
        local CharacterModel1
        PlayerIndex, CharacterModel1 = PlayerList1(PlayerItem, PlayerIndex)
        if PlayerIndex == nil then
            break
        end
        if Function1(CharacterModel1) and CharacterModel1.Character and (CharacterModel1.Character:FindFirstChild("Head") and not CharacterModel1.Character:FindFirstChild("ForceField")) then
            local HeadObject = CharacterModel1.Character.Head
            local DistanceMagnitude = (HeadObject.Position - HeadPosition).Magnitude
            if DistanceMagnitude < MaxValue and DistanceMagnitude <= DistanceValue then
                local DirectionVector = (HeadObject.Position - HeadPosition).Unit * DistanceValue
                local RaycastParams1 = RaycastParams.new()
                RaycastParams1.FilterType = Enum.RaycastFilterType.Blacklist
                RaycastParams1.FilterDescendantsInstances = {
                    LocalCharacter
                }
                local RaycastResult = Workspace:Raycast(HeadPosition, DirectionVector, RaycastParams1)
                if RaycastResult and RaycastResult.Instance then
                    if RaycastResult.Instance:IsDescendantOf(CharacterModel1.Character) then
                        NullObject = CharacterModel1
                        MaxValue = DistanceMagnitude
                    end
                end
            end
        end
    end
    return NullObject
end

local function Function3()
    if not (EnemyCharacter and EnemyCharacter.Character and EnemyCharacter.Character:FindFirstChild("Head")) then
        EnemyCharacter = Function2()
    end
    if EnemyCharacter and EnemyCharacter.Character and EnemyCharacter.Character:FindFirstChild("Head") then
        local EnemyHead = EnemyCharacter.Character.Head
        local LocalCharacter1 = LocalPlayer.Character
        if not (LocalCharacter1 and LocalCharacter1:FindFirstChild("Head")) then
            return
        end
        local HeadPosition1 = LocalCharacter1.Head.Position
        local DirectionVector1 = (EnemyHead.Position - HeadPosition1).Unit * DistanceValue
        local RaycastParams2 = RaycastParams.new()
        RaycastParams2.FilterType = Enum.RaycastFilterType.Blacklist
        RaycastParams2.FilterDescendantsInstances = {
            LocalCharacter1
        }
        local RaycastResult1 = Workspace:Raycast(HeadPosition1, DirectionVector1, RaycastParams2)
        if RaycastResult1 and RaycastResult1.Instance and RaycastResult1.Instance:IsDescendantOf(EnemyCharacter.Character) then
            if BooleanFlagLock then
                local CFrameValue = CFrame.new(CurrentCamera.CFrame.Position, EnemyHead.Position)
                CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrameValue, TimeValue)
            else
                CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, EnemyHead.Position)
            end
        else
            EnemyCharacter = nil
        end
    else
        EnemyCharacter = nil
    end
end

-- ===== 扳机变量 =====
getgenv().triggerb = false
local GameType = "团队模式"
local BooleanValue = true
local Flag2 = false
local RaycastParams3 = RaycastParams.new()
RaycastParams3.FilterType = Enum.RaycastFilterType.Blacklist

local function Function4(Param8)
    if Param8 and (Param8.Team and LocalPlayer.Team) then
        if GameType ~= "自由混战" then
            if GameType ~= "所有人" then
                if GameType ~= "团队模式" then
                    return false
                else
                    return Param8.Team ~= LocalPlayer.Team
                end
            else
                return Param8 ~= LocalPlayer
            end
        else
            return true
        end
    else
        return false
    end
end

local function Function5()
    local PlayerObject = LocalPlayer
    local HumanoidObject = (PlayerObject.Character or PlayerObject.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
    if HumanoidObject then
        BooleanValue = HumanoidObject.Health > 0
        HumanoidObject.HealthChanged:Connect(function(Param9)
            BooleanValue = Param9 > 0
            if not BooleanValue and Flag2 then
                Flag2 = false
                mouse1release()
            end
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(Function5)
Function5()

RunService.RenderStepped:Connect(function()
    if getgenv().triggerb and BooleanValue then
        local CharacterModel2 = LocalPlayer.Character
        if CharacterModel2 then
            RaycastParams3.FilterDescendantsInstances = {
                CharacterModel2
            }
            local ViewportCenter = CurrentCamera.ViewportSize / 2
            local RayOrigin = CurrentCamera:ViewportPointToRay(ViewportCenter.X, ViewportCenter.Y)
            local RaycastResult2 = Workspace:Raycast(RayOrigin.Origin, RayOrigin.Direction * 5000, RaycastParams3)
            local Flag3 = false
            if RaycastResult2 and RaycastResult2.Instance then
                local ModelAncestor = RaycastResult2.Instance:FindFirstAncestorOfClass("Model")
                if ModelAncestor and ModelAncestor:FindFirstChild("Humanoid") then
                    local PlayerFromCharacter = PlayerService:GetPlayerFromCharacter(ModelAncestor)
                    Flag3 = PlayerFromCharacter and (Function4(PlayerFromCharacter) and not ModelAncestor:FindFirstChild("ForceField")) and true or Flag3
                end
            end
            if Flag3 then
                if not Flag2 then
                    Flag2 = true
                    mouse1press()
                end
            elseif Flag2 then
                Flag2 = false
                mouse1release()
            end
        end
    else
        if Flag2 then
            Flag2 = false
            mouse1release()
        end
        return
    end
end)

-- ===== 武器配置 =====
local WeaponConfig = {
    FireRate = {},
    ReloadTime = {},
    EReloadTime = {},
    Auto = {},
    Spread = {},
    Recoil = {}
}
local BooleanValue1 = false

-- ===== 速度变量 =====
local WalkSpeedConfig = {
    WalkSpeed = 16
}
local BooleanValueSpeed = false
local VectorTypes = {"速度", "向量", "CFrame"}
local VectorType1 = VectorTypes[1]

local function LocalFunctionSpeed(Parameter4, Parameter5)
    local Character1 = Parameter4.Character
    local MoveDirection1
    if Character1 then
        MoveDirection1 = Character1:FindFirstChildOfClass("Humanoid")
    else
        MoveDirection1 = Character1
    end
    if Character1 then
        Character1 = Character1:FindFirstChild("HumanoidRootPart")
    end
    if MoveDirection1 and Character1 then
        local MoveSpeed1 = MoveDirection1.MoveDirection * WalkSpeedConfig.WalkSpeed
        if VectorType1 ~= "速度" then
            if VectorType1 ~= "向量" then
                if VectorType1 ~= "CFrame" then
                    MoveDirection1.WalkSpeed = WalkSpeedConfig.WalkSpeed
                else
                    Character1.CFrame = Character1.CFrame + MoveDirection1.MoveDirection * WalkSpeedConfig.WalkSpeed * Parameter5 * 0.0001
                end
            else
                Character1.CFrame = Character1.CFrame + MoveSpeed1 * Parameter5 * 0.0001
            end
        else
            Character1.Velocity = Vector3.new(MoveSpeed1.X, Character1.Velocity.Y, MoveSpeed1.Z)
        end
    end
end

RunService.Stepped:Connect(function(Parameter6)
    if BooleanValueSpeed and (LocalPlayer and LocalPlayer.Character) and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalFunctionSpeed(LocalPlayer, Parameter6)
    end
end)

-- ===== 反自瞄变量 =====
local IntegerValueSpin = 10
local NilValueSpin = nil
local BooleanValue2 = false

-- ===== 拾取物变量 =====
local StringOption = "两者"
local BooleanValue3 = false

function managePickups()
    spawn(function()
        while BooleanValue3 and OptionsConfig.CollectDebrisToggle.Value do
            task.wait(0.1)
            pcall(function()
                local Character6 = LocalPlayer.Character
                local HumanoidRootPart1 = Character6 and Character6:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart1 then
                    local DebrisChild1, DebrisChild2, DebrisChild3 = pairs(Workspace.Debris:GetChildren())
                    while true do
                        local UnusedValue7
                        DebrisChild3, UnusedValue7 = DebrisChild1(DebrisChild2, DebrisChild3)
                        if DebrisChild3 == nil then
                            break
                        end
                        if StringOption == "DeadHP" and UnusedValue7.Name == "DeadHP" or (StringOption == "DeadAmmo" and UnusedValue7.Name == "DeadAmmo" or StringOption == "Both" and (UnusedValue7.Name == "DeadHP" or UnusedValue7.Name == "DeadAmmo")) then
                            UnusedValue7.CFrame = HumanoidRootPart1.CFrame * CFrame.new(0, 0.2, 0)
                        end
                    end
                end
            end)
        end
    end)
end

-- ===== 轮廓变量 =====
local ConfigTableCharm = {
    Enabled = false,
    TeamCheck = "敌人",
    InnerColor = Color3.fromRGB(0, 150, 255),
    OutlineColor = Color3.fromRGB(0, 0, 0),
    InnerTransparency = 0.6,
    OutlineTransparency = 0.2
}
local PlayerGui = LocalPlayer
local PlayerGuiInstance = LocalPlayer.WaitForChild(PlayerGui, "PlayerGui")
local EmptyTableCharm = {}
local NilValueCharm = nil

local function LocalFunctionCharmRemove(Parameter10)
    if EmptyTableCharm[Parameter10] then
        local TableValue1, TableValue2, TableValue3 = pairs(EmptyTableCharm[Parameter10])
        while true do
            local UnusedValue8
            TableValue3, UnusedValue8 = TableValue1(TableValue2, TableValue3)
            if TableValue3 == nil then
                break
            end
            if UnusedValue8.fill then
                UnusedValue8.fill:Destroy()
            end
            if UnusedValue8.outline then
                UnusedValue8.outline:Destroy()
            end
        end
        EmptyTableCharm[Parameter10] = nil
    end
end

local function LocalFunctionCharmAdd(Parameter11)
    if Parameter11 and (Parameter11.Character and not EmptyTableCharm[Parameter11]) then
        EmptyTableCharm[Parameter11] = {}
        local CharacterChild1, CharacterChild2, CharacterChild3 = pairs(Parameter11.Character:GetChildren())
        while true do
            local BoxSize
            CharacterChild3, BoxSize = CharacterChild1(CharacterChild2, CharacterChild3)
            if CharacterChild3 == nil then
                break
            end
            if BoxSize:IsA("BasePart") then
                local BoxSize1 = BoxSize.Size
                if BooleanFlag and (ConfigTableCharm[Parameter11] and ConfigTableCharm[Parameter11][BoxSize.Name]) then
                    BoxSize1 = ConfigTableCharm[Parameter11][BoxSize.Name].Size
                end
                local BoxHandleAdornment1 = Instance.new("BoxHandleAdornment")
                local InnerColor = ConfigTableCharm.InnerColor
                local InnerTransparency = ConfigTableCharm.InnerTransparency
                BoxHandleAdornment1.Parent = PlayerGuiInstance
                BoxHandleAdornment1.Transparency = InnerTransparency
                BoxHandleAdornment1.Color3 = InnerColor
                BoxHandleAdornment1.Size = BoxSize1
                BoxHandleAdornment1.ZIndex = 5
                BoxHandleAdornment1.AlwaysOnTop = true
                BoxHandleAdornment1.Adornee = BoxSize
                local BoxHandleAdornment2 = Instance.new("BoxHandleAdornment")
                local BoxSize2 = BoxSize1 + Vector3.new(0.1, 0.1, 0.1)
                local OutlineColor = ConfigTableCharm.OutlineColor
                local OutlineTransparency = ConfigTableCharm.OutlineTransparency
                BoxHandleAdornment2.Parent = PlayerGuiInstance
                BoxHandleAdornment2.Transparency = OutlineTransparency
                BoxHandleAdornment2.Color3 = OutlineColor
                BoxHandleAdornment2.Size = BoxSize2
                BoxHandleAdornment2.ZIndex = 4
                BoxHandleAdornment2.AlwaysOnTop = true
                BoxHandleAdornment2.Adornee = BoxSize
                EmptyTableCharm[Parameter11][BoxSize] = {
                    fill = BoxHandleAdornment1,
                    outline = BoxHandleAdornment2
                }
            end
        end
    end
end

local function LocalFunctionCharmUpdate(Parameter1)
    if EmptyTableCharm[Parameter1] and Parameter1.Character then
        local KeyValue, Key, ObjectSize = pairs(EmptyTableCharm[Parameter1])
        while true do
            local ObjectFill
            ObjectSize, ObjectFill = KeyValue(Key, ObjectSize)
            if ObjectSize == nil then
                break
            end
            if ObjectSize and ObjectSize.Parent == Parameter1.Character then
                local SizeValue = ObjectSize.Size
                if BooleanFlag and (ConfigTableCharm[Parameter1] and ConfigTableCharm[Parameter1][ObjectSize.Name]) then
                    SizeValue = ConfigTableCharm[Parameter1][ObjectSize.Name].Size
                end
                local FillColor = ObjectFill.fill
                local FillTransparency = ObjectFill.fill
                local FillColor3 = ObjectFill.fill
                local InnerColorValue = ConfigTableCharm.InnerColor
                local InnerTransparencyValue = ConfigTableCharm.InnerTransparency
                FillColor3.Size = SizeValue
                FillTransparency.Transparency = InnerTransparencyValue
                FillColor.Color3 = InnerColorValue
                local OutlineColorValue = ObjectFill.outline
                local OutlineTransparencyValue = ObjectFill.outline
                local OutlineThickness = ObjectFill.outline
                local OutlineColor = ConfigTableCharm.OutlineColor
                local OutlineTransparency = ConfigTableCharm.OutlineTransparency
                OutlineThickness.Size = SizeValue + Vector3.new(0.1, 0.1, 0.1)
                OutlineTransparencyValue.Transparency = OutlineTransparency
                OutlineColorValue.Color3 = OutlineColor
            else
                ObjectFill.fill:Destroy()
                ObjectFill.outline:Destroy()
                EmptyTableCharm[Parameter1][ObjectSize] = nil
            end
        end
    else
        LocalFunctionCharmRemove(Parameter1)
    end
end

local function FunctionUtilCharm()
    if ConfigTableCharm.Enabled then
        local TableKey, TableValue, TableIndex = pairs(EmptyTableCharm)
        while true do
            local UnusedVariable
            TableIndex, UnusedVariable = TableKey(TableValue, TableIndex)
            if TableIndex == nil then
                break
            end
            if not (TableIndex and (TableIndex.Parent and TableIndex.Character)) then
                LocalFunctionCharmRemove(TableIndex)
            end
        end
        local PlayerService = PlayerService
        local PlayerList, PlayerIndex, PlayerObject = pairs(PlayerService:GetPlayers())
        while true do
            local PlayerData
            PlayerObject, PlayerData = PlayerList(PlayerIndex, PlayerObject)
            if PlayerObject == nil then
                break
            end
            if PlayerData ~= LocalPlayer then
                if (ConfigTableCharm.TeamCheck == "所有人" or ConfigTableCharm.TeamCheck == "队友" and LocalPlayer.Team == PlayerData.Team) and true or (ConfigTableCharm.TeamCheck == "敌人" and LocalPlayer.Team ~= PlayerData.Team and true or false) then
                    if EmptyTableCharm[PlayerData] then
                        LocalFunctionCharmUpdate(PlayerData)
                    else
                        LocalFunctionCharmAdd(PlayerData)
                    end
                else
                    LocalFunctionCharmRemove(PlayerData)
                end
            end
        end
    end
end

PlayerService.PlayerRemoving:Connect(LocalFunctionCharmRemove)
PlayerService.PlayerAdded:Connect(function(ParameterUtil)
    ParameterUtil.CharacterRemoving:Connect(function()
        LocalFunctionCharmRemove(ParameterUtil)
    end)
end)

-- ===== ESP 变量 =====
local ConfigTableESP = {}
local DontAskTable = "dontask"

local function FunctionUtilESP1(Parameter8, Parameter9)
    local BillboardGui = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")
    BillboardGui.Name = DontAskTable
    BillboardGui.Parent = Parameter8
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Size = UDim2.new(0, 50, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    TextLabel.Parent = BillboardGui
    TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = Parameter9
    TextLabel.TextColor3 = Color3.new(1, 0, 0)
    TextLabel.TextScaled = false
    return BillboardGui
end

local function FunctionUtilESP2(Parameter10, Parameter11)
    if Parameter10:IsA("TouchTransmitter") then
        local ParentObject = Parameter10.Parent
        if not ParentObject:FindFirstChild(DontAskTable) then
            ConfigTableESP[ParentObject] = FunctionUtilESP1(ParentObject, Parameter11)
        end
    end
end

local function FunctionUtilESP3(Parameter12, ParameterUtil1, ParameterUtil2, ParameterUtil3)
    if Parameter12 then
        local WorkspaceObject = Workspace
        local DescendantIndex, DescendantObject, DescendantName = ipairs(WorkspaceObject:GetDescendants())
        while true do
            local UnusedVariable2
            DescendantName, UnusedVariable2 = DescendantIndex(DescendantObject, DescendantName)
            if DescendantName == nil then
                break
            end
            if UnusedVariable2:IsA("TouchTransmitter") and UnusedVariable2.Parent.Name == ParameterUtil1 then
                FunctionUtilESP2(UnusedVariable2, ParameterUtil2)
            end
        end
        game.Workspace.DescendantAdded:Connect(function(Parameter13)
            if OptionsConfig[ParameterUtil3].Value and (Parameter13:IsA("TouchTransmitter") and Parameter13.Parent.Name == ParameterUtil1) then
                FunctionUtilESP2(Parameter13, ParameterUtil2)
            end
        end)
    else
        local ConfigKey, ConfigValue, ConfigIndex = pairs(ConfigTableESP)
        while true do
            local UnusedVariable3
            ConfigIndex, UnusedVariable3 = ConfigKey(ConfigValue, ConfigIndex)
            if ConfigIndex == nil then
                break
            end
            if ConfigIndex and (UnusedVariable3 and (UnusedVariable3:FindFirstChild("TextLabel") and UnusedVariable3.TextLabel.Text == ParameterUtil2)) then
                UnusedVariable3:Destroy()
                ConfigTableESP[ConfigIndex] = nil
            end
        end
    end
end

-- ===== 光照变量 =====
local LightingConfig = {
    Ambient = LightingService.Ambient,
    ColorShift_Top = LightingService.ColorShift_Top,
    ColorShift_Bottom = LightingService.ColorShift_Bottom,
    FogEnd = LightingService.FogEnd,
    GlobalShadows = LightingService.GlobalShadows
}
local BooleanValueXray = false

-- ===== 性能变量 =====
local ConfigTablePerf1 = {}
local ConfigTablePerf2 = {}
local LightingConfigPerf = {
    GlobalShadows = LightingService.GlobalShadows,
    FogEnd = LightingService.FogEnd,
    Brightness = LightingService.Brightness
}
local TerrainConfig = {
    WaterWaveSize = Workspace.Terrain.WaterWaveSize,
    WaterWaveSpeed = Workspace.Terrain.WaterWaveSpeed,
    WaterReflectance = Workspace.Terrain.WaterReflectance,
    WaterTransparency = Workspace.Terrain.WaterTransparency
}
local ConfigTablePerf3 = {}

-- ===== 皮肤变量 =====
local function FunctionParam(FunctionArgument)
    return Vector3.new(FunctionArgument.R, FunctionArgument.G, FunctionArgument.B)
end

local MaterialMap = {
    ["塑料"] = Enum.Material.Plastic,
    ["力场"] = Enum.Material.ForceField,
    ["木头"] = Enum.Material.Wood,
    ["草"] = Enum.Material.Grass
}

local MaterialType = "塑料"
local ColorValue = Color3.new(0.19607843137254902, 0.19607843137254902, 0.19607843137254902)
local BooleanFlagSkinArm = false
local MaterialProperty = "塑料"
local ColorProperty = Color3.new(0.19607843137254902, 0.19607843137254902, 0.19607843137254902)
local FlagValueSkinGun = false
local EnabledFlagRainbow = false
local CountValue = 1
local DisabledFlagRainbow = false
local ZeroValueRainbow = 0
local DecimalValueRainbow = 0.1

function zigzag(ParamValue)
    return math.acos(math.cos(ParamValue * math.pi)) / math.pi
end

-- ===== 资料伪造变量 =====
local ScoreboardData = {
    Score = nil,
    Kills = nil
}
local GameInfo = {
    GUIName = nil,
    KillFeed = {},
    WinnerName = nil,
    ScorecardName = nil
}
local GameFlag = false
local GameProperty = false

local function LocalFunctionSpoof()
    local Username = "Twistzz"
    local UserDisplayName = "Twistzz User"
    local PlayerGui = LocalPlayer.PlayerGui
    if PlayerGui:FindFirstChild("Menew_Main") and (PlayerGui.Menew_Main:FindFirstChild("Container") and PlayerGui.Menew_Main.Container:FindFirstChild("PlrName")) then
        PlayerGui.Menew_Main.Container.PlrName.Text = Username
    end
    if PlayerGui:FindFirstChild("GUI_Scorecard") and PlayerGui.GUI_Scorecard:FindFirstChild("Scorecard") then
        PlayerGui.GUI_Scorecard.Scorecard.Scrolling.Visible = false
        if PlayerGui.GUI_Scorecard.Scorecard:FindFirstChild("PlayerCard") and PlayerGui.GUI_Scorecard.Scorecard.PlayerCard:FindFirstChild("Username") then
            PlayerGui.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = "Twistzz Development"
        end
    end
    for LoopCounter = 1, 6 do
        if Workspace.KillFeed:FindFirstChild(tostring(LoopCounter)) then
            Workspace.KillFeed[tostring(LoopCounter)].Killer.Value = UserDisplayName
        end
    end
    if PlayerGui:FindFirstChild("GUI") and PlayerGui.GUI:FindFirstChild("Winner") then
        PlayerGui.GUI.Winner.Visible = false
    end
end

local function FunctionRestoreSpoof()
    local PlayerGui1 = LocalPlayer.PlayerGui
    if GameInfo.GUIName and PlayerGui1:FindFirstChild("Menew_Main") and (PlayerGui1.Menew_Main:FindFirstChild("Container") and PlayerGui1.Menew_Main.Container:FindFirstChild("PlrName")) then
        PlayerGui1.Menew_Main.Container.PlrName.Text = GameInfo.GUIName
    end
    local KillFeedKey, KillFeedValue, KillFeedObject = pairs(GameInfo.KillFeed)
    while true do
        local TempVariable1
        KillFeedObject, TempVariable1 = KillFeedKey(KillFeedValue, KillFeedObject)
        if KillFeedObject == nil then
            break
        end
        if Workspace.KillFeed:FindFirstChild(tostring(KillFeedObject)) then
            Workspace.KillFeed[tostring(KillFeedObject)].Killer.Value = TempVariable1
        end
    end
    if GameInfo.WinnerName ~= nil and PlayerGui1:FindFirstChild("GUI") and PlayerGui1.GUI:FindFirstChild("Winner") then
        PlayerGui1.GUI.Winner.Visible = GameInfo.WinnerName
    end
    if GameInfo.ScorecardName and PlayerGui1:FindFirstChild("GUI_Scorecard") and (PlayerGui1.GUI_Scorecard:FindFirstChild("Scorecard") and (PlayerGui1.GUI_Scorecard.Scorecard:FindFirstChild("PlayerCard") and PlayerGui1.GUI_Scorecard.Scorecard.PlayerCard:FindFirstChild("Username"))) then
        PlayerGui1.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = GameInfo.ScorecardName
    end
end

local function LocalFunctionTag(Param1, Argument1)
    Tabs.ExtraTab:Toggle({
        Title = "启用" .. Argument1 .. "徽章",
        Default = false,
        Callback = function(state)
            local PlayerObject = LocalPlayer
            if state then
                if not PlayerObject:FindFirstChild(Param1) then
                    Instance.new("IntValue", PlayerObject).Name = Param1
                end
            elseif PlayerObject:FindFirstChild(Param1) then
                PlayerObject[Param1]:Destroy()
            end
        end
    })
end

-- ===== 存储 WindUI 选项引用的表 =====
local Options = {}

-- ============================================================
-- ===== 构建 UI - 战斗 Tab =====
-- ============================================================
Tabs.MainTab:Paragraph({ Title = "命中框", Desc = "扩大敌人命中框" })

Tabs.MainTab:Toggle({
    Title = "启用命中框扩展",
    Default = false,
    Callback = function(state)
        BooleanFlag = state
        if BooleanFlag then
            if not (UnknownValue and UnknownValue.Connected) then
                UnknownValue = RunService.Heartbeat:Connect(LocalFunction6)
            end
        else
            if UnknownValue then
                UnknownValue:Disconnect()
                UnknownValue = nil
            end
            local TableItem, TableProperty, TableAttribute = pairs(ConfigTable)
            while true do
                TableAttribute = TableItem(TableProperty, TableAttribute)
                if TableAttribute == nil then
                    break
                end
                LocalFunction2(TableAttribute)
            end
        end
    end
})

Tabs.MainTab:Slider({
    Title = "命中框大小",
    Value = { Min = 1, Max = 30, Default = 21 },
    Step = 1,
    Callback = function(val)
        IntegerValue = val
    end
})

Tabs.MainTab:Slider({
    Title = "命中框可见度",
    Value = { Min = 0, Max = 10, Default = 6 },
    Step = 1,
    Callback = function(val)
        SmallIntegerValue = val
    end
})

Tabs.MainTab:Dropdown({
    Title = "队伍检测",
    Values = {"自由混战", "团队模式", "所有人"},
    Default = "团队模式",
    Callback = function(val)
        GameMode = val
    end
})

Tabs.MainTab:Space()
Tabs.MainTab:Paragraph({ Title = "锁定", Desc = "自动锁定目标" })

Tabs.MainTab:Toggle({
    Title = "启用锁定",
    Default = false,
    Callback = function(state)
        Flag1 = state
        if Flag1 then
            if not NullValue then
                NullValue = RunService.RenderStepped:Connect(Function3)
            end
        else
            if NullValue then
                NullValue:Disconnect()
                NullValue = nil
            end
            EnemyCharacter = nil
        end
    end
})

Tabs.MainTab:Dropdown({
    Title = "锁定目标",
    Values = {"敌人", "所有人"},
    Default = "敌人",
    Callback = function(val)
        GameModeLock = val
        EnemyCharacter = nil
    end
})

Tabs.MainTab:Toggle({
    Title = "启用平滑锁定",
    Default = false,
    Callback = function(state)
        BooleanFlagLock = state
    end
})

Tabs.MainTab:Slider({
    Title = "锁定平滑度",
    Value = { Min = 1, Max = 50, Default = 20 },
    Step = 1,
    Callback = function(val)
        TimeValue = val / 100
    end
})

Tabs.MainTab:Space()
Tabs.MainTab:Paragraph({ Title = "扳机", Desc = "准星瞄准时自动射击" })

Tabs.MainTab:Toggle({
    Title = "启用自动射击",
    Default = false,
    Callback = function(state)
        getgenv().triggerb = state
        if not state and Flag2 then
            Flag2 = false
            mouse1release()
        end
    end
})

Tabs.MainTab:Dropdown({
    Title = "扳机队伍模式",
    Values = {"自由混战", "团队模式", "所有人"},
    Default = "团队模式",
    Callback = function(val)
        GameType = val
    end
})

Tabs.MainTab:Space()
Tabs.MainTab:Paragraph({ Title = "自瞄", Desc = "自动寻找并击杀敌人 (高风险)" })

Tabs.MainTab:Toggle({
    Title = "启用自瞄/自动刷",
    Default = false,
    Callback = function(state)
        getgenv().AutoFarm = state
        local NullValue1 = nil
        local BooleanFlag1 = false
        ReplicatedStorage.wkspc.CurrentCurse.Value = state and "Infinite Ammo" or ""
        local function Function6(FuncParam3)
            if FuncParam3 and FuncParam3 ~= LocalPlayer then
                if FuncParam3:IsA("Player") and PlayerService:FindFirstChild(FuncParam3.Name) then
                    if FuncParam3.Character and (FuncParam3.Character:FindFirstChild("HumanoidRootPart") and not FuncParam3.Character:FindFirstChild("ForceField")) then
                        if FuncParam3:FindFirstChild("Status") and FuncParam3.Status.Alive.Value then
                            if FuncParam3.Team and LocalPlayer.Team then
                                if FuncParam3.Team ~= LocalPlayer.Team then
                                    return FuncParam3.Team.Name ~= "Spectator"
                                else
                                    return false
                                end
                            else
                                return false
                            end
                        else
                            return false
                        end
                    else
                        return false
                    end
                else
                    return false
                end
            else
                return false
            end
        end
        local function Function7()
            local MaxValue1 = math.huge
            local PlayerService1 = PlayerService
            local PlayerList2, PlayerItem1, PlayerIndex1 = pairs(PlayerService1:GetPlayers())
            local NullObject1 = nil
            while true do
                local CharacterModel3
                PlayerIndex1, CharacterModel3 = PlayerList2(PlayerItem1, PlayerIndex1)
                if PlayerIndex1 == nil then
                    break
                end
                if Function6(CharacterModel3) then
                    local DistanceMagnitude1 = (LocalPlayer.Character.HumanoidRootPart.Position - CharacterModel3.Character.HumanoidRootPart.Position).Magnitude
                    if DistanceMagnitude1 < MaxValue1 then
                        NullObject1 = CharacterModel3
                        MaxValue1 = DistanceMagnitude1
                    end
                end
            end
            return NullObject1
        end
        local function Function8()
            ReplicatedStorage.wkspc.TimeScale.Value = 12
            NullValue1 = RunService.Stepped:Connect(function()
                if getgenv().AutoFarm then
                    if ReplicatedStorage.wkspc.Status.RoundOver.Value == true then
                        if BooleanFlag1 then
                            mouse1release()
                            BooleanFlag1 = false
                        end
                        return
                    end
                    if not (LocalPlayer:FindFirstChild("Status") and LocalPlayer.Status.Alive.Value) then
                        if BooleanFlag1 then
                            mouse1release()
                            BooleanFlag1 = false
                        end
                        return
                    end
                    local PlayerObject1 = Function7()
                    if PlayerObject1 then
                        local HumanoidRootPart = PlayerObject1.Character.HumanoidRootPart
                        local PositionOffset = HumanoidRootPart.Position - HumanoidRootPart.CFrame.LookVector * 2 + Vector3.new(0, 2, 0)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(PositionOffset)
                        if PlayerObject1.Character:FindFirstChild("Head") then
                            local HeadPosition2 = PlayerObject1.Character.Head.Position
                            camera.CFrame = CFrame.new(camera.CFrame.Position, HeadPosition2)
                        end
                        if not BooleanFlag1 then
                            mouse1press()
                            BooleanFlag1 = true
                        end
                    elseif BooleanFlag1 then
                        mouse1release()
                        BooleanFlag1 = false
                    end
                else
                    if NullValue1 then
                        NullValue1:Disconnect()
                        NullValue1 = nil
                    end
                    if BooleanFlag1 then
                        mouse1release()
                        BooleanFlag1 = false
                    end
                end
            end)
        end
        if state then
            task.wait(0.5)
            if LocalPlayer.Character then
                Function8()
            end
        else
            ReplicatedStorage.wkspc.CurrentCurse.Value = ""
            getgenv().AutoFarm = false
            ReplicatedStorage.wkspc.TimeScale.Value = 1
            if NullValue1 then
                NullValue1:Disconnect()
                local UnusedValue = nil
            end
            if BooleanFlag1 then
                mouse1release()
                local UnusedFlag = false
            end
        end
    end
})

-- ============================================================
-- ===== 武器 Tab =====
-- ============================================================
Tabs.GunTab:Paragraph({ Title = "枪械改装", Desc = "修改你的武器性能" })

Tabs.GunTab:Paragraph({ Title = "弹药", Desc = "弹药相关修改" })

Tabs.GunTab:Toggle({
    Title = "无限弹药",
    Default = false,
    Callback = function(state)
        ReplicatedStorage.wkspc.CurrentCurse.Value = state and "Infinite Ammo" or ""
    end
})

Tabs.GunTab:Toggle({
    Title = "无限弹药（覆盖）",
    Default = false,
    Callback = function(state)
        BooleanValue1 = state
        if BooleanValue1 then
            game:GetService("RunService").Stepped:connect(function()
                pcall(function()
                    if BooleanValue1 and Options.InfAmmoV2Toggle and Options.InfAmmoV2Toggle.Value then
                        local PlayerGui = LocalPlayer.PlayerGui
                        PlayerGui.GUI.Client.Variables.ammocount.Value = 99
                        PlayerGui.GUI.Client.Variables.ammocount2.Value = 99
                    end
                end)
            end)
        end
    end
})

Tabs.GunTab:Space()
Tabs.GunTab:Paragraph({ Title = "射击机制", Desc = "修改射击行为" })

Tabs.GunTab:Toggle({
    Title = "瞬间换弹",
    Default = false,
    Callback = function(state)
        local FastReloadToggle = state
        local WeaponList, WeaponItem, WeaponIndex = pairs(ReplicatedStorage.Weapons:GetChildren())
        while true do
            local UnusedVariable
            WeaponIndex, UnusedVariable = WeaponList(WeaponItem, WeaponIndex)
            if WeaponIndex == nil then
                break
            end
            if UnusedVariable:FindFirstChild("ReloadTime") then
                if FastReloadToggle then
                    if not WeaponConfig.ReloadTime[UnusedVariable] then
                        WeaponConfig.ReloadTime[UnusedVariable] = UnusedVariable.ReloadTime.Value
                    end
                    UnusedVariable.ReloadTime.Value = 0.01
                elseif WeaponConfig.ReloadTime[UnusedVariable] then
                    UnusedVariable.ReloadTime.Value = WeaponConfig.ReloadTime[UnusedVariable]
                end
            end
            if UnusedVariable:FindFirstChild("EReloadTime") then
                if FastReloadToggle then
                    if not WeaponConfig.EReloadTime[UnusedVariable] then
                        WeaponConfig.EReloadTime[UnusedVariable] = UnusedVariable.EReloadTime.Value
                    end
                    UnusedVariable.EReloadTime.Value = 0.01
                elseif WeaponConfig.EReloadTime[UnusedVariable] then
                    UnusedVariable.EReloadTime.Value = WeaponConfig.EReloadTime[UnusedVariable]
                end
            end
        end
    end
})

Tabs.GunTab:Toggle({
    Title = "快速射击",
    Default = false,
    Callback = function(state)
        local FastFireToggle = state
        local WeaponDescendant, WeaponDescendantIndex, WeaponDescendant = pairs(ReplicatedStorage.Weapons:GetDescendants())
        while true do
            local UnknownValue
            WeaponDescendant, UnknownValue = WeaponDescendant(WeaponDescendantIndex, WeaponDescendant)
            if WeaponDescendant == nil then
                break
            end
            if UnknownValue.Name == "FireRate" or UnknownValue.Name == "BFireRate" then
                if FastFireToggle then
                    if not WeaponConfig.FireRate[UnknownValue] then
                        WeaponConfig.FireRate[UnknownValue] = UnknownValue.Value
                    end
                    UnknownValue.Value = 0.02
                elseif WeaponConfig.FireRate[UnknownValue] then
                    UnknownValue.Value = WeaponConfig.FireRate[UnknownValue]
                end
            end
        end
    end
})

Tabs.GunTab:Toggle({
    Title = "强制全自动",
    Default = false,
    Callback = function(state)
        local AlwaysAutoToggleValue = state
        local WeaponDescendant1, WeaponDescendant2, WeaponDescendant3 = pairs(ReplicatedStorage.Weapons:GetDescendants())
        while true do
            local UnusedValue
            WeaponDescendant3, UnusedValue = WeaponDescendant1(WeaponDescendant2, WeaponDescendant3)
            if WeaponDescendant3 == nil then
                break
            end
            if UnusedValue.Name == "Auto" or (UnusedValue.Name == "AutoFire" or (UnusedValue.Name == "Automatic" or (UnusedValue.Name == "AutoShoot" or UnusedValue.Name == "AutoGun"))) then
                if AlwaysAutoToggleValue then
                    if not WeaponConfig.Auto[UnusedValue] then
                        WeaponConfig.Auto[UnusedValue] = UnusedValue.Value
                    end
                    UnusedValue.Value = true
                elseif WeaponConfig.Auto[UnusedValue] then
                    UnusedValue.Value = WeaponConfig.Auto[UnusedValue]
                end
            end
        end
    end
})

Tabs.GunTab:Space()
Tabs.GunTab:Paragraph({ Title = "武器稳定性", Desc = "减少散布和后坐力" })

Tabs.GunTab:Toggle({
    Title = "无散布",
    Default = false,
    Callback = function(state)
        local NoSpreadToggleValue = state
        local WeaponDescendant4, WeaponDescendant5, WeaponDescendant6 = pairs(ReplicatedStorage.Weapons:GetDescendants())
        while true do
            local UnusedValue1
            WeaponDescendant6, UnusedValue1 = WeaponDescendant4(WeaponDescendant5, WeaponDescendant6)
            if WeaponDescendant6 == nil then
                break
            end
            if UnusedValue1.Name == "MaxSpread" or (UnusedValue1.Name == "Spread" or UnusedValue1.Name == "SpreadControl") then
                if NoSpreadToggleValue then
                    if not WeaponConfig.Spread[UnusedValue1] then
                        WeaponConfig.Spread[UnusedValue1] = UnusedValue1.Value
                    end
                    UnusedValue1.Value = 0
                elseif WeaponConfig.Spread[UnusedValue1] then
                    UnusedValue1.Value = WeaponConfig.Spread[UnusedValue1]
                end
            end
        end
    end
})

Tabs.GunTab:Toggle({
    Title = "无后坐力",
    Default = false,
    Callback = function(state)
        local NoRecoilToggleValue = state
        local WeaponDescendant7, WeaponDescendant8, WeaponDescendant9 = pairs(ReplicatedStorage.Weapons:GetDescendants())
        while true do
            local UnusedValue2
            WeaponDescendant9, UnusedValue2 = WeaponDescendant7(WeaponDescendant8, WeaponDescendant9)
            if WeaponDescendant9 == nil then
                break
            end
            if UnusedValue2.Name == "RecoilControl" or UnusedValue2.Name == "Recoil" then
                if NoRecoilToggleValue then
                    if not WeaponConfig.Recoil[UnusedValue2] then
                        WeaponConfig.Recoil[UnusedValue2] = UnusedValue2.Value
                    end
                    UnusedValue2.Value = 0
                elseif WeaponConfig.Recoil[UnusedValue2] then
                    UnusedValue2.Value = WeaponConfig.Recoil[UnusedValue2]
                end
            end
        end
    end
})

-- ============================================================
-- ===== 移动 Tab =====
-- ============================================================
Tabs.PlayerTab:Paragraph({ Title = "飞行作弊", Desc = "在地图上飞行" })

Tabs.PlayerTab:Toggle({
    Title = "启用飞行",
    Default = false,
    Callback = function(state)
        if state then
            FlyFunction()
        else
            StopFlyingFunction()
        end
    end
})

Tabs.PlayerTab:Slider({
    Title = "飞行速度",
    Value = { Min = 1, Max = 500, Default = 50 },
    Step = 1,
    Callback = function(val)
        FlightSettings.flyspeed = val
    end
})

Tabs.PlayerTab:Space()
Tabs.PlayerTab:Paragraph({ Title = "速度作弊", Desc = "自定义行走速度" })

Tabs.PlayerTab:Toggle({
    Title = "启用速度",
    Default = false,
    Callback = function(state)
        BooleanValueSpeed = state
    end
})

Tabs.PlayerTab:Dropdown({
    Title = "速度方法",
    Values = VectorTypes,
    Default = "速度",
    Callback = function(val)
        VectorType1 = val
    end
})

Tabs.PlayerTab:Slider({
    Title = "行走速度",
    Value = { Min = 16, Max = 500, Default = 16 },
    Step = 1,
    Callback = function(val)
        WalkSpeedConfig.WalkSpeed = val
    end
})

Tabs.PlayerTab:Space()
Tabs.PlayerTab:Paragraph({ Title = "跳跃作弊", Desc = "无限跳跃" })

Tabs.PlayerTab:Toggle({
    Title = "启用无限跳跃",
    Default = false,
    Callback = function(state)
        BooleanValue1 = state
        if BooleanValue1 then
            InputService.JumpRequest:Connect(function()
                if BooleanValue1 and Options.InfJumpToggle and Options.InfJumpToggle.Value then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        end
    end
})

Tabs.PlayerTab:Space()
Tabs.PlayerTab:Paragraph({ Title = "其他移动", Desc = "反自瞄、穿墙等" })

Tabs.PlayerTab:Toggle({
    Title = "启用反自瞄",
    Default = false,
    Callback = function(state)
        local AntiAimToggleValue = state
        local Character2 = LocalPlayer.Character
        if Character2 then
            Character2 = Character2:FindFirstChild("HumanoidRootPart")
        end
        if AntiAimToggleValue then
            if Character2 then
                local BodyAngularVelocity1 = Instance.new("BodyAngularVelocity")
                BodyAngularVelocity1.Name = "AntiAimSpin"
                BodyAngularVelocity1.AngularVelocity = Vector3.new(0, IntegerValueSpin, 0)
                BodyAngularVelocity1.MaxTorque = Vector3.new(0, math.huge, 0)
                BodyAngularVelocity1.P = 500000
                BodyAngularVelocity1.Parent = Character2
                NilValueSpin = Instance.new("BodyGyro")
                NilValueSpin.Name = "AntiAimGyro"
                NilValueSpin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                NilValueSpin.CFrame = Character2.CFrame
                NilValueSpin.P = 3000
                NilValueSpin.Parent = Character2
            end
        elseif Character2 then
            local AntiAimSpin1 = Character2:FindFirstChild("AntiAimSpin")
            if AntiAimSpin1 then
                AntiAimSpin1:Destroy()
            end
            if NilValueSpin then
                NilValueSpin:Destroy()
                NilValueSpin = nil
            end
        end
    end
})

Tabs.PlayerTab:Slider({
    Title = "旋转速度",
    Value = { Min = 10, Max = 100, Default = 10 },
    Step = 1,
    Callback = function(val)
        IntegerValueSpin = val
        local Character3 = LocalPlayer.Character
        if Character3 then
            Character3 = Character3:FindFirstChild("HumanoidRootPart")
        end
        local AntiAimSpin2 = Character3 and Character3:FindFirstChild("AntiAimSpin")
        if AntiAimSpin2 then
            AntiAimSpin2.AngularVelocity = Vector3.new(0, IntegerValueSpin, 0)
        end
    end
})

Tabs.PlayerTab:Toggle({
    Title = "启用穿墙",
    Default = false,
    Callback = function(state)
        BooleanValue2 = state
        if BooleanValue2 then
            spawn(function()
                while BooleanValue2 and Options.NoClipToggle and Options.NoClipToggle.Value do
                    local Character4 = LocalPlayer.Character
                    if Character4 then
                        local Descendant1, Descendant2, Descendant3 = pairs(Character4:GetDescendants())
                        while true do
                            local UnusedValue3
                            Descendant3, UnusedValue3 = Descendant1(Descendant2, Descendant3)
                            if Descendant3 == nil then
                                break
                            end
                            if UnusedValue3:IsA("BasePart") then
                                UnusedValue3.CanCollide = false
                            end
                        end
                    end
                    RunService.Stepped:Wait()
                end
                local Character5 = LocalPlayer.Character
                if Character5 then
                    local Descendant4, Descendant5, Descendant6 = pairs(Character5:GetDescendants())
                    while true do
                        local UnusedValue4
                        Descendant6, UnusedValue4 = Descendant4(Descendant5, Descendant6)
                        if Descendant6 == nil then
                            break
                        end
                        if UnusedValue4:IsA("BasePart") then
                            UnusedValue4.CanCollide = true
                        end
                    end
                end
            end)
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function(Parameter8)
    if BooleanValue2 and Options.NoClipToggle and Options.NoClipToggle.Value then
        task.spawn(function()
            while BooleanValue2 and (Options.NoClipToggle and Options.NoClipToggle.Value and Parameter8.Parent) do
                local Instance1 = Parameter8
                local Descendant7, Descendant8, Descendant9 = pairs(Instance1:GetDescendants())
                while true do
                    local UnusedValue5
                    Descendant9, UnusedValue5 = Descendant7(Descendant8, Descendant9)
                    if Descendant9 == nil then
                        break
                    end
                    if UnusedValue5:IsA("BasePart") then
                        UnusedValue5.CanCollide = false
                    end
                end
                RunService.Stepped:Wait()
            end
            if Parameter8 and Parameter8.Parent then
                local Instance2 = Parameter8
                local Descendant10, Descendant11, Descendant12 = pairs(Instance2:GetDescendants())
                while true do
                    local UnusedValue6
                    Descendant12, UnusedValue6 = Descendant10(Descendant11, Descendant12)
                    if Descendant12 == nil then
                        break
                    end
                    if UnusedValue6:IsA("BasePart") then
                        UnusedValue6.CanCollide = true
                    end
                end
            end
        end)
    end
end)

Tabs.PlayerTab:Space()
Tabs.PlayerTab:Paragraph({ Title = "物品传送", Desc = "将拾取物传送到身边" })

Tabs.PlayerTab:Toggle({
    Title = "启用拾取物传送",
    Default = false,
    Callback = function(state)
        BooleanValue3 = state
        if BooleanValue3 then
            managePickups()
        end
    end
})

Tabs.PlayerTab:Dropdown({
    Title = "拾取物筛选",
    Values = {"生命", "弹药", "两者"},
    Default = "两者",
    Callback = function(val)
        StringOption = ({
            生命 = "DeadHP",
            弹药 = "DeadAmmo",
            两者 = "Both"
        })[val] or "Both"
    end
})

-- ============================================================
-- ===== 视觉 Tab =====
-- ============================================================
Tabs.VisualsTab:Paragraph({ Title = "玩家轮廓", Desc = "使玩家在墙后可见" })

Tabs.VisualsTab:Toggle({
    Title = "启用轮廓",
    Default = false,
    Callback = function(state)
        ConfigTableCharm.Enabled = state
        if ConfigTableCharm.Enabled then
            NilValueCharm = RunService.Heartbeat:Connect(FunctionUtilCharm)
        else
            if NilValueCharm then
                NilValueCharm:Disconnect()
                NilValueCharm = nil
            end
            local TableKeyValue, TableKey1, TableValue1 = pairs(EmptyTableCharm)
            while true do
                local UnusedVariable1
                TableValue1, UnusedVariable1 = TableKeyValue(TableKey1, TableValue1)
                if TableValue1 == nil then
                    break
                end
                LocalFunctionCharmRemove(TableValue1)
            end
            EmptyTableCharm = {}
        end
    end
})

Tabs.VisualsTab:Dropdown({
    Title = "队伍检测",
    Values = {"敌人", "队友", "所有人"},
    Default = "敌人",
    Callback = function(val)
        ConfigTableCharm.TeamCheck = val
    end
})

Tabs.VisualsTab:Colorpicker({
    Title = "内部颜色",
    Default = ConfigTableCharm.InnerColor,
    Callback = function(color)
        ConfigTableCharm.InnerColor = color
    end
})

Tabs.VisualsTab:Colorpicker({
    Title = "轮廓颜色",
    Default = ConfigTableCharm.OutlineColor,
    Callback = function(color)
        ConfigTableCharm.OutlineColor = color
    end
})

Tabs.VisualsTab:Slider({
    Title = "内部透明度",
    Value = { Min = 0, Max = 1, Default = ConfigTableCharm.InnerTransparency },
    Step = 0.01,
    Callback = function(val)
        ConfigTableCharm.InnerTransparency = val
    end
})

Tabs.VisualsTab:Slider({
    Title = "轮廓透明度",
    Value = { Min = 0, Max = 1, Default = ConfigTableCharm.OutlineTransparency },
    Step = 0.01,
    Callback = function(val)
        ConfigTableCharm.OutlineTransparency = val
    end
})

Tabs.VisualsTab:Space()
Tabs.VisualsTab:Paragraph({ Title = "世界ESP", Desc = "显示拾取物位置" })

Tabs.VisualsTab:Toggle({
    Title = "弹药ESP",
    Default = false,
    Callback = function(state)
        FunctionUtilESP3(state, "DeadAmmo", "Ammo Box", "DeadAmmoESPToggle")
    end
})

Tabs.VisualsTab:Toggle({
    Title = "生命值ESP",
    Default = false,
    Callback = function(state)
        FunctionUtilESP3(state, "DeadHP", "HP Jar", "DeadHPESPToggle")
    end
})

-- ============================================================
-- ===== 世界 Tab =====
-- ============================================================
Tabs.WorldTab:Paragraph({ Title = "光照与效果", Desc = "调整游戏视觉效果" })

Tabs.WorldTab:Toggle({
    Title = "全亮",
    Default = false,
    Callback = function(state)
        if state then
            LightingService.Ambient = Color3.new(1, 1, 1)
            LightingService.ColorShift_Top = Color3.new(1, 1, 1)
            LightingService.ColorShift_Bottom = Color3.new(1, 1, 1)
        else
            LightingService.Ambient = LightingConfig.Ambient
            LightingService.ColorShift_Top = LightingConfig.ColorShift_Top
            LightingService.ColorShift_Bottom = LightingConfig.ColorShift_Bottom
        end
    end
})

Tabs.WorldTab:Toggle({
    Title = "无雾",
    Default = false,
    Callback = function(state)
        if state then
            LightingService.FogEnd = 1000000
        else
            LightingService.FogEnd = LightingConfig.FogEnd
        end
    end
})

Tabs.WorldTab:Toggle({
    Title = "无阴影",
    Default = false,
    Callback = function(state)
        LightingService.GlobalShadows = not state
    end
})

Tabs.WorldTab:Toggle({
    Title = "启用透视",
    Default = false,
    Callback = function(state)
        BooleanValueXray = state
        if BooleanValueXray then
            local WorkspaceObject1 = Workspace
            local DescendantIndex1, DescendantObject1, DescendantName1 = pairs(WorkspaceObject1:GetDescendants())
            while true do
                local UnusedVariable4
                DescendantName1, UnusedVariable4 = DescendantIndex1(DescendantObject1, DescendantName1)
                if DescendantName1 == nil then
                    break
                end
                if UnusedVariable4:IsA("BasePart") then
                    if not UnusedVariable4:FindFirstChild("OriginalTransparency") then
                        local NumberValue = Instance.new("NumberValue")
                        NumberValue.Name = "OriginalTransparency"
                        NumberValue.Value = UnusedVariable4.Transparency
                        NumberValue.Parent = UnusedVariable4
                    end
                    UnusedVariable4.Transparency = 0.5
                end
            end
        else
            local WorkspaceObject2 = Workspace
            local DescendantIndex2, DescendantObject2, DescendantName2 = pairs(WorkspaceObject2:GetDescendants())
            while true do
                local UnusedVariable5
                DescendantName2, UnusedVariable5 = DescendantIndex2(DescendantObject2, DescendantName2)
                if DescendantName2 == nil then
                    break
                end
                if UnusedVariable5:IsA("BasePart") and UnusedVariable5:FindFirstChild("OriginalTransparency") then
                    UnusedVariable5.Transparency = UnusedVariable5.OriginalTransparency.Value
                    UnusedVariable5.OriginalTransparency:Destroy()
                end
            end
        end
    end
})

Tabs.WorldTab:Space()
Tabs.WorldTab:Paragraph({ Title = "相机", Desc = "相机设置" })

Tabs.WorldTab:Slider({
    Title = "视野 (FOV)",
    Value = { Min = 0, Max = 120, Default = 70 },
    Step = 1,
    Callback = function(val)
        LocalPlayer.Settings.FOV.Value = val
    end
})

Tabs.WorldTab:Space()
Tabs.WorldTab:Paragraph({ Title = "性能", Desc = "优化游戏性能" })

Tabs.WorldTab:Toggle({
    Title = "降低延迟",
    Default = false,
    Callback = function(state)
        if state then
            local WorkspaceObject3 = Workspace
            local DescendantIndex3, DescendantObject3, DescendantName3 = pairs(WorkspaceObject3:GetDescendants())
            while true do
                local UnusedVariable6
                DescendantName3, UnusedVariable6 = DescendantIndex3(DescendantObject3, DescendantName3)
                if DescendantName3 == nil then
                    break
                end
                if UnusedVariable6:IsA("BasePart") and not UnusedVariable6.Parent:FindFirstChild("Humanoid") then
                    ConfigTablePerf1[UnusedVariable6] = UnusedVariable6.Material
                    UnusedVariable6.Material = Enum.Material.SmoothPlastic
                    if UnusedVariable6:IsA("Texture") then
                        table.insert(ConfigTablePerf2, UnusedVariable6)
                        UnusedVariable6:Destroy()
                    end
                end
            end
        else
            local ConfigKey1, ConfigValue1, ConfigIndex1 = pairs(ConfigTablePerf1)
            while true do
                local UnusedVariable7
                ConfigIndex1, UnusedVariable7 = ConfigKey1(ConfigValue1, ConfigIndex1)
                if ConfigIndex1 == nil then
                    break
                end
                if ConfigIndex1 and ConfigIndex1:IsA("BasePart") then
                    ConfigIndex1.Material = UnusedVariable7
                end
            end
            ConfigTablePerf1 = {}
        end
    end
})

Tabs.WorldTab:Toggle({
    Title = "FPS提升",
    Default = false,
    Callback = function(state)
        if state then
            local TerrainObject = Workspace.Terrain
            TerrainObject.WaterWaveSize = 0
            TerrainObject.WaterWaveSpeed = 0
            TerrainObject.WaterReflectance = 0
            TerrainObject.WaterTransparency = 0
            LightingService.GlobalShadows = false
            LightingService.FogEnd = 387420489
            LightingService.Brightness = 0
            settings().Rendering.QualityLevel = "Level01"
            local GameDescendantIndex, GameDescendantObject, GameDescendantName = pairs(game:GetDescendants())
            while true do
                local UnusedVariable8
                GameDescendantName, UnusedVariable8 = GameDescendantIndex(GameDescendantObject, GameDescendantName)
                if GameDescendantName == nil then
                    break
                end
                if UnusedVariable8:IsA("Part") or (UnusedVariable8:IsA("Union") or (UnusedVariable8:IsA("CornerWedgePart") or UnusedVariable8:IsA("TrussPart"))) then
                    ConfigTablePerf1[UnusedVariable8] = UnusedVariable8.Material
                    UnusedVariable8.Material = "Plastic"
                    UnusedVariable8.Reflectance = 0
                elseif UnusedVariable8:IsA("Decal") or UnusedVariable8:IsA("Texture") then
                    table.insert(ConfigTablePerf2, UnusedVariable8)
                    UnusedVariable8.Transparency = 1
                elseif UnusedVariable8:IsA("ParticleEmitter") or UnusedVariable8:IsA("Trail") then
                    UnusedVariable8.Lifetime = NumberRange.new(0)
                elseif UnusedVariable8:IsA("Explosion") then
                    UnusedVariable8.BlastPressure = 1
                    UnusedVariable8.BlastRadius = 1
                elseif UnusedVariable8:IsA("Fire") or (UnusedVariable8:IsA("SpotLight") or UnusedVariable8:IsA("Smoke")) then
                    UnusedVariable8.Enabled = false
                elseif UnusedVariable8:IsA("MeshPart") then
                    ConfigTablePerf1[UnusedVariable8] = UnusedVariable8.Material
                    UnusedVariable8.Material = "Plastic"
                    UnusedVariable8.Reflectance = 0
                    UnusedVariable8.TextureID = 1.0385902758728956e16
                end
            end
            local LightingObject = LightingService
            local ChildInstance, ChildName, ChildObject = pairs(LightingObject:GetChildren())
            while true do
                local UnknownVariable
                ChildObject, UnknownVariable = ChildInstance(ChildName, ChildObject)
                if ChildObject == nil then
                    break
                end
                if UnknownVariable:IsA("BlurEffect") or (UnknownVariable:IsA("SunRaysEffect") or (UnknownVariable:IsA("ColorCorrectionEffect") or (UnknownVariable:IsA("BloomEffect") or UnknownVariable:IsA("DepthOfFieldEffect")))) then
                    ConfigTablePerf3[UnknownVariable] = UnknownVariable.Enabled
                    UnknownVariable.Enabled = false
                end
            end
        else
            local TerrainProperty = Workspace.Terrain
            TerrainProperty.WaterWaveSize = TerrainConfig.WaterWaveSize
            TerrainProperty.WaterWaveSpeed = TerrainConfig.WaterWaveSpeed
            TerrainProperty.WaterReflectance = TerrainConfig.WaterReflectance
            TerrainProperty.WaterTransparency = TerrainConfig.WaterTransparency
            LightingService.GlobalShadows = LightingConfigPerf.GlobalShadows
            LightingService.FogEnd = LightingConfigPerf.FogEnd
            LightingService.Brightness = LightingConfigPerf.Brightness
            settings().Rendering.QualityLevel = "Automatic"
            local CollectionKey, CollectionValue, CollectionObject = pairs(ConfigTablePerf1)
            while true do
                local UnusedVariable
                CollectionObject, UnusedVariable = CollectionKey(CollectionValue, CollectionObject)
                if CollectionObject == nil then
                    break
                end
                if CollectionObject and CollectionObject:IsA("BasePart") then
                    CollectionObject.Material = UnusedVariable
                    CollectionObject.Reflectance = 0
                end
            end
            ConfigTablePerf1 = {}
            local ItemKey, ItemValue, ItemObject = pairs(ConfigTablePerf3)
            while true do
                local TempVariable
                ItemObject, TempVariable = ItemKey(ItemValue, ItemObject)
                if ItemObject == nil then
                    break
                end
                if ItemObject then
                    ItemObject.Enabled = TempVariable
                end
            end
            ConfigTablePerf3 = {}
            local PairKey, PairValue, PairObject = pairs(ConfigTablePerf2)
            while true do
                local DummyVariable
                PairObject, DummyVariable = PairKey(PairValue, PairObject)
                if PairObject == nil then
                    break
                end
                if DummyVariable and DummyVariable.Parent then
                    DummyVariable.Transparency = 0
                end
            end
            ConfigTablePerf2 = {}
        end
    end
})

-- ============================================================
-- ===== 皮肤 Tab =====
-- ============================================================
Tabs.SkinsTab:Paragraph({ Title = "手臂皮肤", Desc = "自定义手臂外观" })

Tabs.SkinsTab:Dropdown({
    Title = "手臂材质",
    Values = {"塑料", "力场", "木头", "草"},
    Default = "塑料",
    Callback = function(val)
        MaterialType = val
    end
})

Tabs.SkinsTab:Colorpicker({
    Title = "手臂颜色",
    Default = Color3.fromRGB(50, 50, 50),
    Callback = function(color)
        ColorValue = color
    end
})

Tabs.SkinsTab:Toggle({
    Title = "启用手臂皮肤",
    Default = false,
    Callback = function(state)
        BooleanFlagSkinArm = state
        if BooleanFlagSkinArm then
            spawn(function()
                while BooleanFlagSkinArm and Options.ArmCharmsToggle and Options.ArmCharmsToggle.Value do
                    task.wait(0.01)
                    local ArmsModel = Workspace.Camera:FindFirstChild("Arms")
                    if ArmsModel then
                        local DescendantInstance, DescendantName, DescendantObject = pairs(ArmsModel:GetDescendants())
                        while true do
                            local UnusedModel
                            DescendantObject, UnusedModel = DescendantInstance(DescendantName, DescendantObject)
                            if DescendantObject == nil then
                                break
                            end
                            if UnusedModel.Name == "Right Arm" or UnusedModel.Name == "Left Arm" then
                                if UnusedModel:IsA("BasePart") then
                                    UnusedModel.Material = MaterialMap[MaterialType] or Enum.Material.Plastic
                                    UnusedModel.Color = ColorValue
                                end
                            elseif UnusedModel:IsA("SpecialMesh") then
                                if UnusedModel.TextureId == "" then
                                    UnusedModel.TextureId = "rbxassetid://0"
                                    UnusedModel.VertexColor = FunctionParam(ColorValue)
                                end
                            elseif UnusedModel.Name == "L" or UnusedModel.Name == "R" then
                                UnusedModel:Destroy()
                            end
                        end
                    end
                end
            end)
        end
    end
})

Tabs.SkinsTab:Space()
Tabs.SkinsTab:Paragraph({ Title = "枪械皮肤", Desc = "自定义枪械外观" })

Tabs.SkinsTab:Dropdown({
    Title = "枪械材质",
    Values = {"塑料", "力场", "木头", "草"},
    Default = "塑料",
    Callback = function(val)
        MaterialProperty = val
    end
})

Tabs.SkinsTab:Colorpicker({
    Title = "枪械颜色",
    Default = Color3.fromRGB(50, 50, 50),
    Callback = function(color)
        ColorProperty = color
    end
})

Tabs.SkinsTab:Toggle({
    Title = "启用枪械皮肤",
    Default = false,
    Callback = function(state)
        FlagValueSkinGun = state
        if FlagValueSkinGun then
            spawn(function()
                while FlagValueSkinGun and Options.GunCharmsToggle and Options.GunCharmsToggle.Value do
                    task.wait(0.01)
                    if Workspace.Camera:FindFirstChild("Arms") then
                        local ArmDescendant, ArmInstance, ArmObject = pairs(Workspace.Camera.Arms:GetDescendants())
                        while true do
                            local TempModel
                            ArmObject, TempModel = ArmDescendant(ArmInstance, ArmObject)
                            if ArmObject == nil then
                                break
                            end
                            if TempModel:IsA("MeshPart") then
                                TempModel.Material = MaterialMap[MaterialProperty] or Enum.Material.Plastic
                                TempModel.Color = ColorProperty
                            end
                        end
                    end
                end
            end)
        end
    end
})

Tabs.SkinsTab:Space()
Tabs.SkinsTab:Paragraph({ Title = "彩虹枪", Desc = "彩虹效果" })

Tabs.SkinsTab:Toggle({
    Title = "彩虹效果（波浪）",
    Default = false,
    Callback = function(state)
        EnabledFlagRainbow = state
    end
})

RunService.RenderStepped:Connect(function()
    if EnabledFlagRainbow and Workspace.Camera:FindFirstChild("Arms") then
        local ArmChild, ArmKey, ArmValue = pairs(Workspace.Camera.Arms:GetDescendants())
        while true do
            local DummyModel
            ArmValue, DummyModel = ArmChild(ArmKey, ArmValue)
            if ArmValue == nil then
                break
            end
            if DummyModel.ClassName == "MeshPart" then
                DummyModel.Color = Color3.fromHSV(zigzag(CountValue), 1, 1)
                CountValue = CountValue + 0.0001
            end
        end
    end
end)

Tabs.SkinsTab:Toggle({
    Title = "彩虹效果（脉冲）",
    Default = false,
    Callback = function(state)
        DisabledFlagRainbow = state
    end
})

RunService.RenderStepped:Connect(function()
    if DisabledFlagRainbow and Workspace.Camera:FindFirstChild("Arms") then
        ZeroValueRainbow = (ZeroValueRainbow + DecimalValueRainbow) % 1
        local ArmDescendant1, ArmInstance1, ArmObject1 = pairs(Workspace.Camera.Arms:GetDescendants())
        while true do
            local UnusedInstance
            ArmObject1, UnusedInstance = ArmDescendant1(ArmInstance1, ArmObject1)
            if ArmObject1 == nil then
                break
            end
            if UnusedInstance.ClassName == "MeshPart" then
                UnusedInstance.Color = Color3.fromHSV(ZeroValueRainbow, 1, 1)
            end
        end
    end
end)

-- ============================================================
-- ===== 杂项 Tab =====
-- ============================================================
Tabs.ExtraTab:Paragraph({ Title = "资料伪造", Desc = "修改显示数据（客户端）" })

Tabs.ExtraTab:Toggle({
    Title = "伪造等级",
    Default = false,
    Callback = function(state)
        local MaxLevelToggle = state
        local CareerStats = LocalPlayer.CareerStatsCache
        if MaxLevelToggle then
            if not ScoreboardData.Score then
                ScoreboardData.Score = CareerStats.Score.Value
            end
            if not ScoreboardData.Kills then
                ScoreboardData.Kills = CareerStats.Kills.Value
            end
            CareerStats.Score.Value = 1
            CareerStats.Kills.Value = 1
        elseif ScoreboardData.Score and ScoreboardData.Kills then
            CareerStats.Score.Value = ScoreboardData.Score
            CareerStats.Kills.Value = ScoreboardData.Kills
        end
    end
})

Tabs.ExtraTab:Toggle({
    Title = "伪造名字",
    Default = false,
    Callback = function(state)
        GameFlag = state
        GameProperty = GameFlag
        if GameFlag then
            local PlayerGui2 = LocalPlayer.PlayerGui
            if PlayerGui2:FindFirstChild("Menew_Main") and (PlayerGui2.Menew_Main:FindFirstChild("Container") and PlayerGui2.Menew_Main.Container:FindFirstChild("PlrName")) then
                GameInfo.GUIName = PlayerGui2.Menew_Main.Container.PlrName.Text
            end
            if PlayerGui2:FindFirstChild("GUI") and PlayerGui2.GUI:FindFirstChild("Winner") then
                GameInfo.WinnerName = PlayerGui2.GUI.Winner.Visible
            end
            if PlayerGui2:FindFirstChild("GUI_Scorecard") and (PlayerGui2.GUI_Scorecard:FindFirstChild("Scorecard") and (PlayerGui2.GUI_Scorecard.Scorecard:FindFirstChild("PlayerCard") and PlayerGui2.GUI_Scorecard.Scorecard.PlayerCard:FindFirstChild("Username"))) then
                GameInfo.ScorecardName = PlayerGui2.GUI_Scorecard.Scorecard.PlayerCard.Username.Text
            end
            for LoopCounter1 = 1, 6 do
                if Workspace.KillFeed:FindFirstChild(tostring(LoopCounter1)) then
                    GameInfo.KillFeed[LoopCounter1] = Workspace.KillFeed[tostring(LoopCounter1)].Killer.Value
                end
            end
            spawn(function()
                while GameProperty and Options.HideNameToggle and Options.HideNameToggle.Value do
                    pcall(LocalFunctionSpoof)
                    task.wait(0.2)
                end
            end)
        else
            GameProperty = false
            pcall(FunctionRestoreSpoof)
        end
    end
})

Tabs.ExtraTab:Space()
Tabs.ExtraTab:Paragraph({ Title = "聊天徽章", Desc = "显示特殊徽章" })

LocalFunctionTag("IsChad", "Chad")
LocalFunctionTag("VIP", "VIP")
LocalFunctionTag("OldVIP", "Old VIP")
LocalFunctionTag("Romin", "Romin")
LocalFunctionTag("IsAdmin", "Admin")

-- ============================================================
-- ===== 设置 Tab =====
-- ============================================================
Tabs.SettingsTab:Paragraph({ Title = "服务器工具", Desc = "服务器切换功能" })

Tabs.SettingsTab:Button({
    Title = "服务器跳转",
    Callback = function()
        local PlaceId = game.PlaceId
        local EmptyTable = {}
        local EmptyString = ""
        local CurrentHour = os.date("!*t").hour
        if not pcall(function()
            EmptyTable = HttpService:JSONDecode(readfile("NotSameServers.json"))
        end) then
            table.insert(EmptyTable, CurrentHour)
            local HttpService = HttpService
            writefile("NotSameServers.json", HttpService:JSONEncode(EmptyTable))
        end
        function teleportReturner()
            local DataContainer
            if EmptyString ~= "" then
                DataContainer = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. EmptyString))
            else
                DataContainer = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            end
            if DataContainer.nextPageCursor and (DataContainer.nextPageCursor ~= "null" and DataContainer.nextPageCursor ~= nil) then
                EmptyString = DataContainer.nextPageCursor
            end
            local DataKey, DataValue, DataObject = pairs(DataContainer.data)
            local ZeroCount = 0
            while true do
                local IdContainer
                DataObject, IdContainer = DataKey(DataValue, DataObject)
                if DataObject == nil then
                    break
                end
                local BooleanValue = true
                local IdString = tostring(IdContainer.id)
                if tonumber(IdContainer.maxPlayers) > tonumber(IdContainer.playing) then
                    local TableKey, TableValue, TableObject = pairs(EmptyTable)
                    while true do
                        local TempVariable2
                        TableObject, TempVariable2 = TableKey(TableValue, TableObject)
                        if TableObject == nil then
                            break
                        end
                        if ZeroCount == 0 then
                            if tonumber(CurrentHour) ~= tonumber(TempVariable2) then
                                pcall(function()
                                    delfile("NotSameServers.json")
                                    EmptyTable = {}
                                    table.insert(EmptyTable, CurrentHour)
                                end)
                            end
                        elseif IdString == tostring(TempVariable2) then
                            BooleanValue = false
                        end
                        ZeroCount = ZeroCount + 1
                    end
                    if BooleanValue == true then
                        table.insert(EmptyTable, IdString)
                        task.wait()
                        pcall(function()
                            local HttpService1 = HttpService
                            writefile("NotSameServers.json", HttpService1:JSONEncode(EmptyTable))
                            task.wait()
                            TeleportService:TeleportToPlaceInstance(PlaceId, IdString, LocalPlayer)
                        end)
                        task.wait(4)
                    end
                end
            end
        end
        function teleport()
            while task.wait() do
                pcall(function()
                    teleportReturner()
                    if EmptyString ~= "" then
                        teleportReturner()
                    end
                end)
            end
        end
        teleport()
    end
})

Tabs.SettingsTab:Button({
    Title = "重新加入服务器",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

Tabs.SettingsTab:Space()
Tabs.SettingsTab:Paragraph({ Title = "游戏设置", Desc = "修改游戏参数" })

Tabs.SettingsTab:Input({
    Title = "游戏速度（客户端）",
    PlaceholderText = "默认 1",
    Callback = function(text)
        local TimeScaleValue = tonumber(text)
        if TimeScaleValue then
            ReplicatedStorage.wkspc.TimeScale.Value = TimeScaleValue
        end
    end
})

Tabs.SettingsTab:Space()
Tabs.SettingsTab:Paragraph({ Title = "官方群聊", Desc = "加入获取支持" })

Tabs.SettingsTab:Button({
    Title = "复制QQ群号",
    Callback = function()
        setclipboard("https://discord.gg/gdpCUVj6uS")
    end
})

Tabs.SettingsTab:Space()
Tabs.SettingsTab:Paragraph({ Title = "界面设置", Desc = "UI 快捷键" })

Tabs.SettingsTab:Input({
    Title = "打开UI快捷键",
    PlaceholderText = "RightShift / F1 等",
    Callback = function(text)
        UIOpenKey = text
    end
})

-- ===== 监听快捷键 =====
local UIOpenKey = "RightShift"
InputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local keyCode = Enum.KeyCode[UIOpenKey]
    if keyCode and input.KeyCode == keyCode then
        if Window then
            Window.Visible = not Window.Visible
        end
    end
end)

-- ===== 初始化完成 =====
Window:SelectTab(1)
ShowNotification = function(msg, color, duration)
    color = color or Color3.fromRGB(0, 150, 255)
    duration = duration or 2.5
    if _G.NotificationGui then _G.NotificationGui:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    gui.Name = "ArsenalNotification"
    _G.NotificationGui = gui

    local container = Instance.new("Frame")
    container.Parent = gui
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true

    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(0, 300, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0
    frame.Position = UDim2.new(0, 10, 0, -60)

    local corner = Instance.new("UICorner")
    corner.Parent = frame
    corner.CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Parent = frame
    stroke.Color = color
    stroke.Thickness = 2

    local text = Instance.new("TextLabel")
    text.Parent = frame
    text.Size = UDim2.new(1, -20, 1, -10)
    text.Position = UDim2.new(0, 10, 0, 5)
    text.BackgroundTransparency = 1
    text.Text = msg
    text.TextColor3 = Color3.fromRGB(220, 220, 255)
    text.TextSize = 14
    text.Font = Enum.Font.Gotham
    text.TextWrapped = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Top

    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0, 10, 0, 10)})
    tweenIn:Play()
    task.delay(duration, function()
        if not frame.Parent then return end
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0, 10, 0, -60)})
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            gui:Destroy()
            _G.NotificationGui = nil
        end)
    end)
end

-- 通知
ShowNotification("Arsenal Y-HUB 已加载 (WindUI)", Color3.fromRGB(255, 100, 50))
task.wait(2)
ShowNotification("作者: y | 协助者: 蓝鲸鱼", Color3.fromRGB(50, 200, 255))