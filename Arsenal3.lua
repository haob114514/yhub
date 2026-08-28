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
    if no
