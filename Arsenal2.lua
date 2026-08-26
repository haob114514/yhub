-- ========== 修改点：使用 ghproxy.net 镜像加速加载 Fluent 库 ==========
local LibraryLoader = loadstring(game:HttpGetAsync("https://ghproxy.net/https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local LibraryScript = loadstring(game:HttpGetAsync("https://ghproxy.net/https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local LibraryScript1 = loadstring(game:HttpGetAsync("https://ghproxy.net/https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
-- ====================================================================

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

local LibraryConfig = LibraryLoader
local WindowObject = LibraryLoader.CreateWindow(LibraryConfig, {
    Title = "Y—HUB | 兵工厂 | v1",
    SubTitle = "作者：y|协助者：蓝鲸鱼",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local TabConfig = {
    Main = WindowObject:CreateTab({
        Title = "战斗",
        Icon = "swords"
    }),
    Gun = WindowObject:CreateTab({
        Title = "武器",
        Icon = "crosshair"
    }),
    Player = WindowObject:CreateTab({
        Title = "移动",
        Icon = "user"
    }),
    Visuals = WindowObject:CreateTab({
        Title = "视觉",
        Icon = "eye"
    }),
    World = WindowObject:CreateTab({
        Title = "世界",
        Icon = "globe"
    }),
    Skins = WindowObject:CreateTab({
        Title = "皮肤",
        Icon = "palette"
    }),
    Extra = WindowObject:CreateTab({
        Title = "杂项",
        Icon = "puzzle"
    }),
    Settings = WindowObject:CreateTab({
        Title = "设置",
        Icon = "settings"
    })
}
local OptionsConfig = LibraryLoader.Options
TabConfig.Main:AddSection("命中框")
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
TabConfig.Main:CreateToggle("HitboxToggle", {
    Title = "启用命中框扩展",
    Description = "扩大敌人命中框。",
    Default = false
}):OnChanged(function()
    BooleanFlag = OptionsConfig.HitboxToggle.Value
    LibraryLoader:Notify({
        Title = "命中框扩展",
        Content = "状态：" .. (BooleanFlag and "已启用" or "已禁用"),
        Duration = 3
    })
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
end)
TabConfig.Main:CreateSlider("HitboxSizeSlider", {
    Title = "命中框大小",
    Description = "敌人命中框的大小。",
    Default = 21,
    Min = 1,
    Max = 30,
    Rounding = 0
}):OnChanged(function(Param1)
    IntegerValue = Param1
end)
TabConfig.Main:CreateSlider("HitboxTransSlider", {
    Title = "命中框可见度",
    Description = "调整命中框可见度。0完全隐形，10完全可见。",
    Default = 6,
    Min = 0,
    Max = 10,
    Rounding = 1
}):OnChanged(function(Param2)
    SmallIntegerValue = Param2
end)
TabConfig.Main:CreateDropdown("HitboxTeamDropdown", {
    Title = "队伍检测",
    Description = "选择功能将针对哪些玩家。",
    Values = {
        "自由混战",
        "团队模式",
        "所有人"
    },
    Default = "团队模式"
}):OnChanged(function(Param3)
    GameMode = Param3
end)
TabConfig.Main:AddSection("锁定")
local Flag1 = false
local GameMode = "敌人"
local EnemyCharacter = nil
local NullValue = nil
local DistanceValue = 200
local BooleanFlag = false
local TimeValue = 0.2
local function Function1(FuncParam)
    if FuncParam and (FuncParam ~= LocalPlayer and (FuncParam.Team and LocalPlayer.Team)) then
        return GameMode == "所有人" and true or FuncParam.Team ~= LocalPlayer.Team
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
            if BooleanFlag then
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
TabConfig.Main:CreateToggle("LockOnToggle", {
    Title = "启用锁定",
    Description = "自动将相机对准可见目标的头部。",
    Default = false
}):OnChanged(function(Param4)
    Flag1 = Param4
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
end)
TabConfig.Main:CreateDropdown("LockOnTargetDropdown", {
    Title = "锁定目标",
    Description = "选择锁定将针对谁。",
    Values = {
        "敌人",
        "所有人"
    },
    Default = "敌人"
}):OnChanged(function(Param5)
    GameMode = Param5
    EnemyCharacter = nil
end)
TabConfig.Main:CreateToggle("SmoothLockOnToggle", {
    Title = "启用平滑锁定",
    Description = "平滑地移动相机而不是瞬间捕捉。",
    Default = false
}):OnChanged(function(Param6)
    BooleanFlag = Param6
end)
TabConfig.Main:CreateSlider("SmoothnessSlider", {
    Title = "锁定平滑度",
    Description = "控制平滑速度。数值越低越慢。",
    Default = 20,
    Min = 1,
    Max = 50,
    Rounding = 0
}):OnChanged(function(Param7)
    TimeValue = Param7 / 100
end)
TabConfig.Main:AddSection("扳机")
getgenv().triggerb = false
local GameType = "团队模式"
local BooleanValue = true
local Flag2 = false
local RaycastParams3 = RaycastParams.new()
RaycastParams3.FilterType = Enum.RaycastFilterType.Blacklist
TabConfig.Main:CreateToggle("TriggerBotToggle", {
    Title = "启用自动射击",
    Description = "当准星对准敌人时自动射击。",
    Default = false
}):OnChanged(function(FuncParam1)
    getgenv().triggerb = FuncParam1
    LibraryLoader:Notify({
        Title = "扳机",
        Content = "状态：" .. (FuncParam1 and "已启用" or "已禁用"),
        Duration = 3
    })
    if not FuncParam1 and Flag2 then
        Flag2 = false
        mouse1release()
    end
end)
TabConfig.Main:CreateDropdown("TriggerTeamDropdown", {
    Title = "扳机队伍模式",
    Description = "决定扳机将攻击谁。",
    Values = {
        "自由混战",
        "团队模式",
        "所有人"
    },
    Default = "团队模式"
}):OnChanged(function(FuncParam2)
    GameType = FuncParam2
end)
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
TabConfig.Main:AddSection("自瞄")
TabConfig.Main:CreateToggle("AutoFarmToggle", {
    Title = "启用自瞄/自动刷",
    Description = "警告：非常明显。自动寻找并击杀敌人。",
    Default = false
}):OnChanged(function(Param10)
    getgenv().AutoFarm = Param10
    LibraryLoader:Notify({
        Title = "自瞄",
        Content = "状态：" .. (Param10 and "已启用" or "已禁用"),
        Duration = 3,
        SubContent = Param10 and "警告：这是一个高风险功能。" or nil
    })
    local NullValue1 = nil
    local BooleanFlag1 = false
    ReplicatedStorage.wkspc.CurrentCurse.Value = Param10 and "Infinite Ammo" or ""
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
    if Param10 then
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
end)
TabConfig.Gun:CreateParagraph("WeaponModHeader", {
    Title = "枪械改装",
    Content = "修改你的武器性能。"
})
local WeaponConfig = {
    FireRate = {},
    ReloadTime = {},
    EReloadTime = {},
    Auto = {},
    Spread = {},
    Recoil = {}
}
TabConfig.Gun:AddSection("弹药")
TabConfig.Gun:CreateToggle("InfAmmoV1Toggle", {
    Title = "无限弹药",
    Description = "使用此功能你的武器将会有无限弹药。",
    Default = false
}):OnChanged(function()
    ReplicatedStorage.wkspc.CurrentCurse.Value = OptionsConfig.InfAmmoV1Toggle.Value and "Infinite Ammo" or ""
end)
local BooleanValue1 = false
TabConfig.Gun:CreateToggle("InfAmmoV2Toggle", {
    Title = "无限弹药（覆盖）",
    Description = "强制你的弹药数量保持满。",
    Default = false
}):OnChanged(function()
    BooleanValue1 = OptionsConfig.InfAmmoV2Toggle.Value
    if BooleanValue1 then
        game:GetService("RunService").Stepped:connect(function()
            pcall(function()
                if BooleanValue1 and OptionsConfig.InfAmmoV2Toggle.Value then
                    local PlayerGui = LocalPlayer.PlayerGui
                    PlayerGui.GUI.Client.Variables.ammocount.Value = 99
                    PlayerGui.GUI.Client.Variables.ammocount2.Value = 99
                end
            end)
        end)
    end
end)
TabConfig.Gun:AddSection("射击机制")
TabConfig.Gun:CreateToggle("FastReloadToggle", {
    Title = "瞬间换弹",
    Description = "移除换弹时间。",
    Default = false
}):OnChanged(function()
    local FastReloadToggle = OptionsConfig.FastReloadToggle.Value
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
end)
TabConfig.Gun:CreateToggle("FastFireToggle", {
    Title = "快速射击",
    Description = "提高所有武器的射速。",
    Default = false
}):OnChanged(function()
    local FastFireToggle = OptionsConfig.FastFireToggle.Value
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
end)
TabConfig.Gun:CreateToggle("AlwaysAutoToggle", {
    Title = "强制全自动",
    Description = "使所有武器变为全自动。",
    Default = false
}):OnChanged(function()
    local AlwaysAutoToggleValue = OptionsConfig.AlwaysAutoToggle.Value
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
end)
TabConfig.Gun:AddSection("武器稳定性")
TabConfig.Gun:CreateToggle("NoSpreadToggle", {
    Title = "无散布",
    Description = "移除所有武器散布。",
    Default = false
}):OnChanged(function()
    local NoSpreadToggleValue = OptionsConfig.NoSpreadToggle.Value
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
end)
TabConfig.Gun:CreateToggle("NoRecoilToggle", {
    Title = "无后坐力",
    Description = "移除所有武器后坐力。",
    Default = false
}):OnChanged(function()
    local NoRecoilToggleValue = OptionsConfig.NoRecoilToggle.Value
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
end)
TabConfig.Player:AddSection("飞行作弊")
TabConfig.Player:CreateToggle("FlyToggle", {
    Title = "启用飞行",
    Description = "允许你在地图上飞行。",
    Default = false
}):OnChanged(function()
    if OptionsConfig.FlyToggle.Value then
        FlyFunction()
    else
        StopFlyingFunction()
    end
    LibraryLoader:Notify({
        Title = "飞行",
        Content = "状态：" .. (OptionsConfig.FlyToggle.Value and "已启用" or "已禁用"),
        Duration = 3
    })
end)
TabConfig.Player:CreateSlider("FlySpeedSlider", {
    Title = "飞行速度",
    Description = "控制飞行时的移动速度。",
    Default = 50,
    Min = 1,
    Max = 500,
    Rounding = 0
}):OnChanged(function(Parameter1)
    FlightSettings.flyspeed = Parameter1
end)
TabConfig.Player:AddSection("速度作弊")
local WalkSpeedConfig = {
    WalkSpeed = 16
}
local BooleanValue = false
TabConfig.Player:CreateToggle("CustomWalkSpeedToggle", {
    Title = "启用速度",
    Description = "允许自定义行走速度。",
    Default = false
}):OnChanged(function()
    BooleanValue = OptionsConfig.CustomWalkSpeedToggle.Value
end)
local VectorTypes = {
    "速度",
    "向量",
    "CFrame"
}
local VectorType1 = VectorTypes[1]
TabConfig.Player:CreateDropdown("WalkMethodDropdown", {
    Title = "速度方法",
    Description = "应用速度的物理方法。",
    Values = VectorTypes,
    Default = "速度"
}):OnChanged(function(Parameter2)
    VectorType1 = Parameter2
end)
TabConfig.Player:CreateSlider("WalkSpeedSlider", {
    Title = "行走速度",
    Description = "设置想要的行走速度。",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 0
}):OnChanged(function(Parameter3)
    WalkSpeedConfig.WalkSpeed = Parameter3
end)
local function LocalFunction1(Parameter4, Parameter5)
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
    if BooleanValue and (LocalPlayer and LocalPlayer.Character) and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalFunction1(LocalPlayer, Parameter6)
    end
end)
TabConfig.Player:AddSection("跳跃作弊")
local BooleanValue1 = false
TabConfig.Player:CreateToggle("InfJumpToggle", {
    Title = "启用无限跳跃",
    Description = "允许你在空中跳跃。",
    Default = false
}):OnChanged(function()
    BooleanValue1 = OptionsConfig.InfJumpToggle.Value
    if BooleanValue1 then
        InputService.JumpRequest:Connect(function()
            if BooleanValue1 and OptionsConfig.InfJumpToggle.Value then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
end)
TabConfig.Player:AddSection("其他移动")
local IntegerValue = 10
local NilValue = nil
TabConfig.Player:CreateToggle("AntiAimToggle", {
    Title = "启用反自瞄",
    Description = "旋转你使敌人更难击中你。",
    Default = false
}):OnChanged(function()
    local AntiAimToggleValue = OptionsConfig.AntiAimToggle.Value
    LibraryLoader:Notify({
        Title = "反自瞄",
        Content = "状态：" .. (AntiAimToggleValue and "已启用" or "已禁用"),
        Duration = 3
    })
    local Character2 = LocalPlayer.Character
    if Character2 then
        Character2 = Character2:FindFirstChild("HumanoidRootPart")
    end
    if AntiAimToggleValue then
        if Character2 then
            local BodyAngularVelocity1 = Instance.new("BodyAngularVelocity")
            BodyAngularVelocity1.Name = "AntiAimSpin"
            BodyAngularVelocity1.AngularVelocity = Vector3.new(0, IntegerValue, 0)
            BodyAngularVelocity1.MaxTorque = Vector3.new(0, math.huge, 0)
            BodyAngularVelocity1.P = 500000
            BodyAngularVelocity1.Parent = Character2
            NilValue = Instance.new("BodyGyro")
            NilValue.Name = "AntiAimGyro"
            NilValue.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            NilValue.CFrame = Character2.CFrame
            NilValue.P = 3000
            NilValue.Parent = Character2
        end
    elseif Character2 then
        local AntiAimSpin1 = Character2:FindFirstChild("AntiAimSpin")
        if AntiAimSpin1 then
            AntiAimSpin1:Destroy()
        end
        if NilValue then
            NilValue:Destroy()
            NilValue = nil
        end
    end
end)
TabConfig.Player:CreateSlider("SpinSpeedSlider", {
    Title = "旋转速度",
    Description = "调整旋转速度。",
    Default = 10,
    Min = 10,
    Max = 100,
    Rounding = 0
}):OnChanged(function(Parameter7)
    IntegerValue = Parameter7
    local Character3 = LocalPlayer.Character
    if Character3 then
        Character3 = Character3:FindFirstChild("HumanoidRootPart")
    end
    local AntiAimSpin2 = Character3 and Character3:FindFirstChild("AntiAimSpin")
    if AntiAimSpin2 then
        AntiAimSpin2.AngularVelocity = Vector3.new(0, IntegerValue, 0)
    end
end)
local BooleanValue2 = false
local function LocalFunction2()
    local Player1 = LocalPlayer
    while BooleanValue2 and OptionsConfig.NoClipToggle.Value do
        local Character4 = Player1.Character
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
    local Character5 = Player1.Character
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
end
TabConfig.Player:CreateToggle("NoClipToggle", {
    Title = "启用穿墙",
    Description = "让你可以穿过墙壁。",
    Default = false
}):OnChanged(function()
    BooleanValue2 = OptionsConfig.NoClipToggle.Value
    if BooleanValue2 then
        spawn(LocalFunction2)
    end
    LibraryLoader:Notify({
        Title = "穿墙",
        Content = "状态：" .. (BooleanValue2 and "已启用" or "已禁用"),
        Duration = 3
    })
end)
LocalPlayer.CharacterAdded:Connect(function(Parameter8)
    if BooleanValue2 and OptionsConfig.NoClipToggle.Value then
        task.spawn(function()
            while BooleanValue2 and (OptionsConfig.NoClipToggle.Value and Parameter8.Parent) do
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
TabConfig.Player:AddSection("物品传送")
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
TabConfig.Player:CreateToggle("CollectDebrisToggle", {
    Title = "启用拾取物传送",
    Description = "将物品传送到你身边。",
    Default = false
}):OnChanged(function()
    BooleanValue3 = OptionsConfig.CollectDebrisToggle.Value
    if BooleanValue3 then
        managePickups()
    end
end)
TabConfig.Player:CreateDropdown("DebrisDropdown", {
    Title = "拾取物筛选",
    Description = "选择传送哪些物品。",
    Values = {
        "生命",
        "弹药",
        "两者"
    },
    Default = "两者"
}):OnChanged(function(Parameter9)
    StringOption = ({
        生命 = "DeadHP",
        弹药 = "DeadAmmo",
        两者 = "Both"
    })[Parameter9] or "Both"
end)
TabConfig.Visuals:CreateParagraph("PlayerCharmsSection", {
    Title = "玩家轮廓",
    Content = "使玩家在墙后可见。"
})
local ConfigTable = {
    Enabled = false,
    TeamCheck = "敌人",
    InnerColor = Color3.fromRGB(0, 150, 255),
    OutlineColor = Color3.fromRGB(0, 0, 0),
    InnerTransparency = 0.6,
    OutlineTransparency = 0.2
}
local PlayerGui = LocalPlayer
local PlayerGuiInstance = LocalPlayer.WaitForChild(PlayerGui, "PlayerGui")
local EmptyTable = {}
local NilValue1 = nil
local function LocalFunction3(Parameter10)
    if EmptyTable[Parameter10] then
        local TableValue1, TableValue2, TableValue3 = pairs(EmptyTable[Parameter10])
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
        EmptyTable[Parameter10] = nil
    end
end
local function LocalFunction4(Parameter11)
    if Parameter11 and (Parameter11.Character and not EmptyTable[Parameter11]) then
        EmptyTable[Parameter11] = {}
        local CharacterChild1, CharacterChild2, CharacterChild3 = pairs(Parameter11.Character:GetChildren())
        while true do
            local BoxSize
            CharacterChild3, BoxSize = CharacterChild1(CharacterChild2, CharacterChild3)
            if CharacterChild3 == nil then
                break
            end
            if BoxSize:IsA("BasePart") then
                local BoxSize1 = BoxSize.Size
                if BooleanFlag and (ConfigTable[Parameter11] and ConfigTable[Parameter11][BoxSize.Name]) then
                    BoxSize1 = ConfigTable[Parameter11][BoxSize.Name].Size
                end
                local BoxHandleAdornment1 = Instance.new("BoxHandleAdornment")
                local InnerColor = ConfigTable.InnerColor
                local InnerTransparency = ConfigTable.InnerTransparency
                BoxHandleAdornment1.Parent = PlayerGuiInstance
                BoxHandleAdornment1.Transparency = InnerTransparency
                BoxHandleAdornment1.Color3 = InnerColor
                BoxHandleAdornment1.Size = BoxSize1
                BoxHandleAdornment1.ZIndex = 5
                BoxHandleAdornment1.AlwaysOnTop = true
                BoxHandleAdornment1.Adornee = BoxSize
                local BoxHandleAdornment2 = Instance.new("BoxHandleAdornment")
                local BoxSize2 = BoxSize1 + Vector3.new(0.1, 0.1, 0.1)
                local OutlineColor = ConfigTable.OutlineColor
                local OutlineTransparency = ConfigTable.OutlineTransparency
                BoxHandleAdornment2.Parent = PlayerGuiInstance
                BoxHandleAdornment2.Transparency = OutlineTransparency
                BoxHandleAdornment2.Color3 = OutlineColor
                BoxHandleAdornment2.Size = BoxSize2
                BoxHandleAdornment2.ZIndex = 4
                BoxHandleAdornment2.AlwaysOnTop = true
                BoxHandleAdornment2.Adornee = BoxSize
                EmptyTable[Parameter11][BoxSize] = {
                    fill = BoxHandleAdornment1,
                    outline = BoxHandleAdornment2
                }
            end
        end
    end
end
local function LocalFunction5(Parameter1)
    if EmptyTable[Parameter1] and Parameter1.Character then
        local KeyValue, Key, ObjectSize = pairs(EmptyTable[Parameter1])
        while true do
            local ObjectFill
            ObjectSize, ObjectFill = KeyValue(Key, ObjectSize)
            if ObjectSize == nil then
                break
            end
            if ObjectSize and ObjectSize.Parent == Parameter1.Character then
                local SizeValue = ObjectSize.Size
                if BooleanFlag and (ConfigTable[Parameter1] and ConfigTable[Parameter1][ObjectSize.Name]) then
                    SizeValue = ConfigTable[Parameter1][ObjectSize.Name].Size
                end
                local FillColor = ObjectFill.fill
                local FillTransparency = ObjectFill.fill
                local FillColor3 = ObjectFill.fill
                local InnerColorValue = ConfigTable.InnerColor
                local InnerTransparencyValue = ConfigTable.InnerTransparency
                FillColor3.Size = SizeValue
                FillTransparency.Transparency = InnerTransparencyValue
                FillColor.Color3 = InnerColorValue
                local OutlineColorValue = ObjectFill.outline
                local OutlineTransparencyValue = ObjectFill.outline
                local OutlineThickness = ObjectFill.outline
                local OutlineColor = ConfigTable.OutlineColor
                local OutlineTransparency = ConfigTable.OutlineTransparency
                OutlineThickness.Size = SizeValue + Vector3.new(0.1, 0.1, 0.1)
                OutlineTransparencyValue.Transparency = OutlineTransparency
                OutlineColorValue.Color3 = OutlineColor
            else
                ObjectFill.fill:Destroy()
                ObjectFill.outline:Destroy()
                EmptyTable[Parameter1][ObjectSize] = nil
            end
        end
    else
        LocalFunction3(Parameter1)
    end
end
local function FunctionUtil()
    if ConfigTable.Enabled then
        local TableKey, TableValue, TableIndex = pairs(EmptyTable)
        while true do
            local UnusedVariable
            TableIndex, UnusedVariable = TableKey(TableValue, TableIndex)
            if TableIndex == nil then
                break
            end
            if not (TableIndex and (TableIndex.Parent and TableIndex.Character)) then
                LocalFunction3(TableIndex)
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
                if (ConfigTable.TeamCheck == "所有人" or ConfigTable.TeamCheck == "队友" and LocalPlayer.Team == PlayerData.Team) and true or (ConfigTable.TeamCheck == "敌人" and LocalPlayer.Team ~= PlayerData.Team and true or false) then
                    if EmptyTable[PlayerData] then
                        LocalFunction5(PlayerData)
                    else
                        LocalFunction4(PlayerData)
                    end
                else
                    LocalFunction3(PlayerData)
                end
            end
        end
    end
end
TabConfig.Visuals:CreateToggle("CharmsToggle", {
    Title = "启用轮廓",
    Default = false
}):OnChanged(function(Parameter2)
    ConfigTable.Enabled = Parameter2
    if ConfigTable.Enabled then
        NilValue1 = RunService.Heartbeat:Connect(FunctionUtil)
    else
        if NilValue1 then
            NilValue1:Disconnect()
            NilValue1 = nil
        end
        local TableKeyValue, TableKey1, TableValue1 = pairs(EmptyTable)
        while true do
            local UnusedVariable1
            TableValue1, UnusedVariable1 = TableKeyValue(TableKey1, TableValue1)
            if TableValue1 == nil then
                break
            end
            LocalFunction3(TableValue1)
        end
        EmptyTable = {}
    end
end)
TabConfig.Visuals:CreateDropdown("CharmsTeamDropdown", {
    Title = "队伍检测",
    Values = {
        "敌人",
        "队友",
        "所有人"
    },
    Default = "敌人"
}):OnChanged(function(Parameter3)
    ConfigTable.TeamCheck = Parameter3
end)
TabConfig.Visuals:CreateColorpicker("CharmsInnerColor", {
    Title = "内部颜色",
    Default = ConfigTable.InnerColor
}):OnChanged(function(Parameter4)
    ConfigTable.InnerColor = Parameter4
end)
TabConfig.Visuals:CreateColorpicker("CharmsOutlineColor", {
    Title = "轮廓颜色",
    Default = ConfigTable.OutlineColor
}):OnChanged(function(Parameter5)
    ConfigTable.OutlineColor = Parameter5
end)
TabConfig.Visuals:CreateSlider("CharmsInnerTransparency", {
    Title = "内部透明度",
    Min = 0,
    Max = 1,
    Default = ConfigTable.InnerTransparency,
    Rounding = 2
}):OnChanged(function(Parameter6)
    ConfigTable.InnerTransparency = Parameter6
end)
TabConfig.Visuals:CreateSlider("CharmsOutlineTransparency", {
    Title = "轮廓透明度",
    Min = 0,
    Max = 1,
    Default = ConfigTable.OutlineTransparency,
    Rounding = 2
}):OnChanged(function(Parameter7)
    ConfigTable.OutlineTransparency = Parameter7
end)
PlayerService.PlayerRemoving:Connect(LocalFunction3)
PlayerService.PlayerAdded:Connect(function(ParameterUtil)
    ParameterUtil.CharacterRemoving:Connect(function()
        LocalFunction3(ParameterUtil)
    end)
end)
TabConfig.Visuals:AddSection("世界ESP")
local ConfigTable = {}
local DontAskTable = "dontask"
local function FunctionUtil1(Parameter8, Parameter9)
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
local function FunctionUtil2(Parameter10, Parameter11)
    if Parameter10:IsA("TouchTransmitter") then
        local ParentObject = Parameter10.Parent
        if not ParentObject:FindFirstChild(DontAskTable) then
            ConfigTable[ParentObject] = FunctionUtil1(ParentObject, Parameter11)
        end
    end
end
local function FunctionUtil3(Parameter12, ParameterUtil1, ParameterUtil2, ParameterUtil3)
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
                FunctionUtil2(UnusedVariable2, ParameterUtil2)
            end
        end
        game.Workspace.DescendantAdded:Connect(function(Parameter13)
            if OptionsConfig[ParameterUtil3].Value and (Parameter13:IsA("TouchTransmitter") and Parameter13.Parent.Name == ParameterUtil1) then
                FunctionUtil2(Parameter13, ParameterUtil2)
            end
        end)
    else
        local ConfigKey, ConfigValue, ConfigIndex = pairs(ConfigTable)
        while true do
            local UnusedVariable3
            ConfigIndex, UnusedVariable3 = ConfigKey(ConfigValue, ConfigIndex)
            if ConfigIndex == nil then
                break
            end
            if ConfigIndex and (UnusedVariable3 and (UnusedVariable3:FindFirstChild("TextLabel") and UnusedVariable3.TextLabel.Text == ParameterUtil2)) then
                UnusedVariable3:Destroy()
                ConfigTable[ConfigIndex] = nil
            end
        end
    end
end
TabConfig.Visuals:CreateToggle("DeadAmmoESPToggle", {
    Title = "弹药ESP",
    Description = "显示弹药拾取点的位置。",
    Default = false
}):OnChanged(function()
    FunctionUtil3(OptionsConfig.DeadAmmoESPToggle.Value, "DeadAmmo", "Ammo Box", "DeadAmmoESPToggle")
end)
TabConfig.Visuals:CreateToggle("DeadHPESPToggle", {
    Title = "生命值ESP",
    Description = "显示生命拾取点的位置。",
    Default = false
}):OnChanged(function()
    FunctionUtil3(OptionsConfig.DeadHPESPToggle.Value, "DeadHP", "HP Jar", "DeadHPESPToggle")
end)
TabConfig.World:AddSection("光照与效果")
local LightingConfig = {
    Ambient = LightingService.Ambient,
    ColorShift_Top = LightingService.ColorShift_Top,
    ColorShift_Bottom = LightingService.ColorShift_Bottom,
    FogEnd = LightingService.FogEnd,
    GlobalShadows = LightingService.GlobalShadows
}
TabConfig.World:CreateToggle("FullBrightToggle", {
    Title = "全亮",
    Description = "移除阴影",
    Default = false
}):OnChanged(function(Parameter14)
    if Parameter14 then
        LightingService.Ambient = Color3.new(1, 1, 1)
        LightingService.ColorShift_Top = Color3.new(1, 1, 1)
        LightingService.ColorShift_Bottom = Color3.new(1, 1, 1)
    else
        LightingService.Ambient = LightingConfig.Ambient
        LightingService.ColorShift_Top = LightingConfig.ColorShift_Top
        LightingService.ColorShift_Bottom = LightingConfig.ColorShift_Bottom
    end
end)
TabConfig.World:CreateToggle("NoFogToggle", {
    Title = "无雾",
    Description = "移除距离雾效。",
    Default = false
}):OnChanged(function(Parameter15)
    if Parameter15 then
        LightingService.FogEnd = 1000000
    else
        LightingService.FogEnd = LightingConfig.FogEnd
    end
end)
TabConfig.World:CreateToggle("NoShadowsToggle", {
    Title = "无阴影",
    Description = "禁用全局阴影以提升性能。",
    Default = false
}):OnChanged(function(Parameter16)
    LightingService.GlobalShadows = not Parameter16
end)
local BooleanValue = false
TabConfig.World:CreateToggle("XrayToggle", {
    Title = "启用视角透视",
    Description = "使游戏物体透明。",
    Default = false
}):OnChanged(function()
    BooleanValue = OptionsConfig.XrayToggle.Value
    LibraryLoader:Notify({
        Title = "透视",
        Content = "状态：" .. (BooleanValue and "已启用" or "已禁用"),
        Duration = 3
    })
    if BooleanValue then
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
end)
TabConfig.World:AddSection("相机")
TabConfig.World:CreateSlider("FovSliderWorld", {
    Title = "视野（FOV）",
    Description = "调整相机的视野。",
    Default = 70,
    Min = 0,
    Max = 120,
    Rounding = 0
}):OnChanged(function(Parameter17)
    LocalPlayer.Settings.FOV.Value = Parameter17
end)
TabConfig.World:AddSection("性能")
local ConfigTable1 = {}
local ConfigTable2 = {}
local LightingConfig1 = {
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
local ConfigTable3 = {}
TabConfig.World:CreateToggle("AntiLagToggle", {
    Title = "降低延迟",
    Description = "减少纹理和材质以提高FPS。",
    Default = false
}):OnChanged(function()
    if OptionsConfig.AntiLagToggle.Value then
        local WorkspaceObject3 = Workspace
        local DescendantIndex3, DescendantObject3, DescendantName3 = pairs(WorkspaceObject3:GetDescendants())
        while true do
            local UnusedVariable6
            DescendantName3, UnusedVariable6 = DescendantIndex3(DescendantObject3, DescendantName3)
            if DescendantName3 == nil then
                break
            end
            if UnusedVariable6:IsA("BasePart") and not UnusedVariable6.Parent:FindFirstChild("Humanoid") then
                ConfigTable1[UnusedVariable6] = UnusedVariable6.Material
                UnusedVariable6.Material = Enum.Material.SmoothPlastic
                if UnusedVariable6:IsA("Texture") then
                    table.insert(ConfigTable2, UnusedVariable6)
                    UnusedVariable6:Destroy()
                end
            end
        end
    else
        local ConfigKey1, ConfigValue1, ConfigIndex1 = pairs(ConfigTable1)
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
        ConfigTable1 = {}
    end
end)
TabConfig.World:CreateToggle("FPSBoostToggle", {
    Title = "FPS提升",
    Description = "移除几乎所有视觉效果以获得最大FPS。",
    Default = false
}):OnChanged(function()
    if OptionsConfig.FPSBoostToggle.Value then
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
                ConfigTable1[UnusedVariable8] = UnusedVariable8.Material
                UnusedVariable8.Material = "Plastic"
                UnusedVariable8.Reflectance = 0
            elseif UnusedVariable8:IsA("Decal") or UnusedVariable8:IsA("Texture") then
                table.insert(ConfigTable2, UnusedVariable8)
                UnusedVariable8.Transparency = 1
            elseif UnusedVariable8:IsA("ParticleEmitter") or UnusedVariable8:IsA("Trail") then
                UnusedVariable8.Lifetime = NumberRange.new(0)
            elseif UnusedVariable8:IsA("Explosion") then
                UnusedVariable8.BlastPressure = 1
                UnusedVariable8.BlastRadius = 1
            elseif UnusedVariable8:IsA("Fire") or (UnusedVariable8:IsA("SpotLight") or UnusedVariable8:IsA("Smoke")) then
                UnusedVariable8.Enabled = false
            elseif UnusedVariable8:IsA("MeshPart") then
                ConfigTable1[UnusedVariable8] = UnusedVariable8.Material
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
                ConfigTable3[UnknownVariable] = UnknownVariable.Enabled
                UnknownVariable.Enabled = false
            end
        end
    else
        local TerrainProperty = Workspace.Terrain
        TerrainProperty.WaterWaveSize = TerrainConfig.WaterWaveSize
        TerrainProperty.WaterWaveSpeed = TerrainConfig.WaterWaveSpeed
        TerrainProperty.WaterReflectance = TerrainConfig.WaterReflectance
        TerrainProperty.WaterTransparency = TerrainConfig.WaterTransparency
        LightingService.GlobalShadows = LightingConfig1.GlobalShadows
        LightingService.FogEnd = LightingConfig1.FogEnd
        LightingService.Brightness = LightingConfig1.Brightness
        settings().Rendering.QualityLevel = "Automatic"
        local CollectionKey, CollectionValue, CollectionObject = pairs(ConfigTable1)
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
        ConfigTable1 = {}
        local ItemKey, ItemValue, ItemObject = pairs(ConfigTable3)
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
        ConfigTable3 = {}
        local PairKey, PairValue, PairObject = pairs(ConfigTable2)
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
        ConfigTable2 = {}
    end
end)
TabConfig.Skins:AddSection("手臂皮肤")
local function FunctionParam(FunctionArgument)
    return Vector3.new(FunctionArgument.R, FunctionArgument.G, FunctionArgument.B)
end

-- 材质映射表
local MaterialMap = {
    ["塑料"] = Enum.Material.Plastic,
    ["力场"] = Enum.Material.ForceField,
    ["木头"] = Enum.Material.Wood,
    ["草"] = Enum.Material.Grass
}

local MaterialType = "塑料"
TabConfig.Skins:CreateDropdown("ArmMatDropdown", {
    Title = "手臂材质",
    Values = {
        "塑料",
        "力场",
        "木头",
        "草"
    },
    Default = "塑料"
}):OnChanged(function(ParameterValue)
    MaterialType = ParameterValue
end)
local ColorValue = Color3.new(0.19607843137254902, 0.19607843137254902, 0.19607843137254902)
TabConfig.Skins:CreateColorpicker("ArmColorPicker", {
    Title = "手臂颜色",
    Default = Color3.fromRGB(50, 50, 50)
}):OnChanged(function()
    ColorValue = OptionsConfig.ArmColorPicker.Value
end)
local BooleanFlag = false
TabConfig.Skins:CreateToggle("ArmCharmsToggle", {
    Title = "启用手臂皮肤",
    Default = false
}):OnChanged(function()
    BooleanFlag = OptionsConfig.ArmCharmsToggle.Value
    if BooleanFlag then
        spawn(function()
            while BooleanFlag and OptionsConfig.ArmCharmsToggle.Value do
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
end)
TabConfig.Skins:AddSection("枪械皮肤")
local MaterialProperty = "塑料"
TabConfig.Skins:CreateDropdown("GunMatDropdown", {
    Title = "枪械材质",
    Values = {
        "塑料",
        "力场",
        "木头",
        "草"
    },
    Default = "塑料"
}):OnChanged(function(ArgumentValue)
    MaterialProperty = ArgumentValue
end)
local ColorProperty = Color3.new(0.19607843137254902, 0.19607843137254902, 0.19607843137254902)
TabConfig.Skins:CreateColorpicker("GunColorPicker", {
    Title = "枪械颜色",
    Default = Color3.fromRGB(50, 50, 50)
}):OnChanged(function()
    ColorProperty = OptionsConfig.GunColorPicker.Value
end)
local FlagValue = false
TabConfig.Skins:CreateToggle("GunCharmsToggle", {
    Title = "启用枪械皮肤",
    Default = false
}):OnChanged(function()
    FlagValue = OptionsConfig.GunCharmsToggle.Value
    if FlagValue then
        spawn(function()
            while FlagValue and OptionsConfig.GunCharmsToggle.Value do
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
end)
TabConfig.Skins:AddSection("彩虹枪")
local EnabledFlag = false
local CountValue = 1
function zigzag(ParamValue)
    return math.acos(math.cos(ParamValue * math.pi)) / math.pi
end
TabConfig.Skins:CreateToggle("Rainbow1Toggle", {
    Title = "彩虹效果（波浪）",
    Default = false
}):OnChanged(function()
    EnabledFlag = OptionsConfig.Rainbow1Toggle.Value
end)
RunService.RenderStepped:Connect(function()
    if EnabledFlag and Workspace.Camera:FindFirstChild("Arms") then
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
local DisabledFlag = false
local ZeroValue = 0
local DecimalValue = 0.1
TabConfig.Skins:CreateToggle("Rainbow2Toggle", {
    Title = "彩虹效果（脉冲）",
    Default = false
}):OnChanged(function()
    DisabledFlag = OptionsConfig.Rainbow2Toggle.Value
end)
RunService.RenderStepped:Connect(function()
    if DisabledFlag and Workspace.Camera:FindFirstChild("Arms") then
        ZeroValue = (ZeroValue + DecimalValue) % 1
        local ArmDescendant1, ArmInstance1, ArmObject1 = pairs(Workspace.Camera.Arms:GetDescendants())
        while true do
            local UnusedInstance
            ArmObject1, UnusedInstance = ArmDescendant1(ArmInstance1, ArmObject1)
            if ArmObject1 == nil then
                break
            end
            if UnusedInstance.ClassName == "MeshPart" then
                UnusedInstance.Color = Color3.fromHSV(ZeroValue, 1, 1)
            end
        end
    end
end)
TabConfig.Extra:AddSection("资料伪造")
local ScoreboardData = {
    Score = nil,
    Kills = nil
}
TabConfig.Extra:CreateToggle("MaxLevelToggle", {
    Title = "伪造等级",
    Description = "在视觉上将你的等级和统计数据设为最大（客户端）。",
    Default = false
}):OnChanged(function()
    local MaxLevelToggle = OptionsConfig.MaxLevelToggle.Value
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
end)
local GameInfo = {
    GUIName = nil,
    KillFeed = {},
    WinnerName = nil,
    ScorecardName = nil
}
local GameFlag = false
local GameProperty = false
local function LocalFunction()
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
local function Function1()
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
TabConfig.Extra:CreateToggle("HideNameToggle", {
    Title = "伪造名字",
    Description = "在大多数UI元素上更改你的名字（客户端）。",
    Default = false
}):OnChanged(function()
    GameFlag = OptionsConfig.HideNameToggle.Value
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
            while GameProperty and OptionsConfig.HideNameToggle.Value do
                pcall(LocalFunction)
                task.wait(0.2)
            end
        end)
    else
        GameProperty = false
        pcall(Function1)
    end
end)
TabConfig.Extra:AddSection("聊天徽章")
local function LocalFunction1(Param1, Argument1)
    TabConfig.Extra:CreateToggle(Param1 .. "TagToggle", {
        Title = "启用" .. Argument1 .. "徽章",
        Default = false
    }):OnChanged(function()
        local PlayerObject = LocalPlayer
        if OptionsConfig[Param1 .. "TagToggle"].Value then
            if not PlayerObject:FindFirstChild(Param1) then
                Instance.new("IntValue", PlayerObject).Name = Param1
            end
        elseif PlayerObject:FindFirstChild(Param1) then
            PlayerObject[Param1]:Destroy()
        end
    end)
end
LocalFunction1("IsChad", "Chad")
LocalFunction1("VIP", "VIP")
LocalFunction1("OldVIP", "Old VIP")
LocalFunction1("Romin", "Romin")
LocalFunction1("IsAdmin", "Admin")
TabConfig.Settings:AddSection("服务器工具")
local TouchEnabled = InputService.TouchEnabled
if TouchEnabled then
    TouchEnabled = not InputService.KeyboardEnabled
end
if TouchEnabled then
    TabConfig.Settings:AddSection("持久触控灵敏度")
    local UserGameSettings = UserSettings():GetService("UserGameSettings")
    local TouchSensitivity = UserGameSettings.TouchCameraMovementSensitivity
    local NilValue = nil
    local MobileSensToggle = TabConfig.Settings:CreateToggle("MobileSensToggle", {
        Title = "启用持久灵敏度",
        Description = "强制覆盖触控相机灵敏度。游戏不会重置此设置。",
        Default = false
    })
    local MobileSensSlider = TabConfig.Settings:CreateSlider("MobileSensSlider", {
        Title = "灵敏度级别",
        Description = "调整触控操作的相机灵敏度。",
        Default = TouchSensitivity * 100,
        Min = 1,
        Max = 200,
        Rounding = 0
    })
    local function LocalFunction2()
        if UserGameSettings then
            if OptionsConfig.MobileSensToggle.Value then
                local SensitivityLevel = OptionsConfig.MobileSensSlider.Value / 100
                if UserGameSettings.TouchCameraMovementSensitivity ~= SensitivityLevel then
                    UserGameSettings.TouchCameraMovementSensitivity = SensitivityLevel
                end
            elseif UserGameSettings.TouchCameraMovementSensitivity ~= TouchSensitivity then
                UserGameSettings.TouchCameraMovementSensitivity = TouchSensitivity
            end
        end
    end
    local function LocalFunction3()
        if OptionsConfig.MobileSensToggle.Value then
            if not (NilValue and NilValue.Connected) then
                NilValue = RunService.Heartbeat:Connect(LocalFunction2)
            end
        else
            if NilValue and NilValue.Connected then
                NilValue:Disconnect()
                NilValue = nil
            end
            LocalFunction2()
        end
    end
    MobileSensToggle:OnChanged(LocalFunction3)
    MobileSensSlider:OnChanged(LocalFunction2)
    game:BindToClose(function()
        if UserGameSettings then
            UserGameSettings.TouchCameraMovementSensitivity = TouchSensitivity
        end
    end)
    task.spawn(LocalFunction3)
end
TabConfig.Settings:CreateButton({
    Title = "服务器跳转",
    Description = "寻找并传送你到一个新服务器。",
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
TabConfig.Settings:CreateButton({
    Title = "重新加入服务器",
    Description = "将你传送回当前服务器。",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})
TabConfig.Settings:AddSection("游戏设置")
TabConfig.Settings:CreateInput("TimeScaleInput", {
    Title = "游戏速度（客户端）",
    Description = "调整游戏的整体速度。默认值为1。",
    Default = "1",
    Numeric = true
}):OnChanged(function()
    local TimeScaleValue = tonumber(OptionsConfig.TimeScaleInput.Value)
    if TimeScaleValue then
        ReplicatedStorage.wkspc.TimeScale.Value = TimeScaleValue
    end
end)
TabConfig.Settings:AddSection("官方群聊")
TabConfig.Settings:CreateButton({
    Title = "复制QQ群号",
    Description = "加入我们的QQ群聊获取支持",
    Callback = function()
        setclipboard("https://discord.gg/gdpCUVj6uS")
        LibraryLoader:Notify({
            Title = "QQ群号已复制",
            Content = "QQ群号已复制到你的剪贴板。",
            Duration = 4
        })
    end
})

-- ===== 新增：自定义快捷键打开/关闭 UI =====
TabConfig.Settings:AddSection("界面设置")

local UIOpenKey = "RightShift"  -- 默认键名

TabConfig.Settings:CreateInput("UIOpenKeyInput", {
    Title = "打开UI快捷键",
    Description = "输入 Enum.KeyCode 的键名，例如 RightShift、F1 等",
    Default = "RightShift",
    Numeric = false
}):OnChanged(function(value)
    UIOpenKey = value
end)

-- 监听键盘事件
InputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end  -- 忽略聊天输入等情况
    local keyCode = Enum.KeyCode[UIOpenKey]
    if keyCode and input.KeyCode == keyCode then
        if WindowObject then
            WindowObject.Visible = not WindowObject.Visible
        end
    end
end)
-- ==========================================

LibraryScript:SetLibrary(LibraryLoader)
LibraryScript1:SetLibrary(LibraryLoader)
LibraryScript:IgnoreThemeSettings()
LibraryScript:SetIgnoreIndexes({})
LibraryScript1:SetFolder("Twistzz")
LibraryScript:SetFolder("Twistzz/Arsenal")
LibraryScript1:BuildInterfaceSection(TabConfig.Settings)
LibraryScript:BuildConfigSection(TabConfig.Settings)
WindowObject:SelectTab(1)
local UiElement = LibraryLoader
LibraryLoader.Notify(UiElement, {
    Title = "Twistzz",
    Content = "脚本初始化成功。",
    Duration = 8
})
pcall(LibraryScript.LoadAutoloadConfig)