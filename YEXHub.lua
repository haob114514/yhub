game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "YEX Hub加载器",
    Text = "脚本已注入，正在加载 UI...",
    Duration = 3
})


local Env = getfenv()
local LogService = game:GetService("LogService")
local getconnections = Env.getconnections
local cons = getconnections(LogService.MessageOut)
if cons then
    for _, v in pairs(cons) do
        pcall(function() v:Disable() end)
    end
end

local function cleanupConnections()
    pcall(function()
        for _, conn in ipairs(getconnections(LogService.MessageOut) or {}) do
            pcall(function() conn:Disable() end)
        end
    end)
end
cleanupConnections()
print("✅ 环境净化完成")


local WindUI
do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    if ok then
        WindUI = result
    else
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end
end


if not WindUI or not WindUI.CreateWindow then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "加载失败",
        Text = "WindUI 库加载失败，请检查网络",
        Duration = 5
    })
    error("WindUI 库未正确加载")
end


local function createUI()
    local success, err = pcall(function()
        local Window = WindUI:CreateWindow({
            Title = "<font color='#FFFFFF'>Y</font><font color='#CCCCCC'>E</font><font color='#999999'>X</font> <font color='#666666'>H</font><font color='#444444'>u</font><font color='#333333'>b</font>",
            Folder = "ftgshub",
            NewElements = true,
            HideSearchBar = false,
            Size = UDim2.fromOffset(600, 550),
            Theme = "Dark",  
            UserEnabled = true,
            SideBarWidth = 135,
            HasOutline = true,
            Background = "https://i.postimg.cc/hvQRDPLQ/999.jpg",
            OpenButton = {
                Title = "YEX Hub",
                CornerRadius = UDim.new(1,0),
                StrokeThickness = 1.5,
                Enabled = true,
                Draggable = true,
                OnlyMobile = false,
                Color = ColorSequence.new(Color3.fromHex("FFFFFF"), Color3.fromHex("FFFFFF"))
            },
            Topbar = { Height = 44, ButtonsType = "Mac" }
        })

        
        task.spawn(function()
            task.wait(0.2) 

            local mainFrame = Window.UIElements and Window.UIElements.Main
            if not mainFrame then return end

            
            local corner = mainFrame:FindFirstChildOfClass("UICorner")
            if not corner then
                corner = Instance.new("UICorner")
                corner.Name = "MainCorner"
                corner.Parent = mainFrame
            end
            corner.CornerRadius = UDim.new(0, 16)

            
            mainFrame.ClipsDescendants = true

            
            local sidebar = mainFrame:FindFirstChild("SideBar")
            if sidebar then
                local sidebarCorner = sidebar:FindFirstChildOfClass("UICorner")
                if not sidebarCorner then
                    sidebarCorner = Instance.new("UICorner")
                    sidebarCorner.Name = "SidebarCorner"
                    sidebarCorner.Parent = sidebar
                end
                sidebarCorner.CornerRadius = UDim.new(0, 16)
                sidebar.ClipsDescendants = true
            end
        end)

        

        
        Window:Tag({ Title = "请选择服务器", Radius = 10, Color = Color3.fromHex("#ffffff") })

        
        local ScriptTab = Window:Tab({
            Title = "服务器",
            Desc = "点击按钮加载对应脚本",
            Icon = "solar:code-square-bold",
            IconColor = Color3.fromHex("#999999"),
            IconShape = "Square",
            Border = true,
        })

        
        ScriptTab:Button({
            Title = "兵工厂",
            Color = Color3.fromHex("999999"),
            Justify = "Center",
            Icon = "sword",
            IconAlign = "Left",
            Callback = function()
                Window:Destroy()
                local ok, err = pcall(function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/haob114514/yhub/refs/heads/main/Arsenal3.lua"))()
                end)
                if not ok then
                    WindUI:Notify({ Title = "加载失败", Content = "兵工厂出错: "..tostring(err), Duration = 5 })
                end
            end
        })

        pcall(function() ScriptTab:Divider() end)

        
        ScriptTab:Button({
            Title = "监狱人生",
            Color = Color3.fromHex("999999"),
            Justify = "Center",
            Icon = "sword",
            IconAlign = "Left",
            Callback = function()
                Window:Destroy()
                local ok, err = pcall(function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/haob114514/yhub/refs/heads/main/Prisonlife1.lua"))()
                end)
                if not ok then
                    WindUI:Notify({ Title = "加载失败", Content = "监狱人生出错: "..tostring(err), Duration = 5 })
                end
            end
        })

        
        local function startGrayscaleBorder()
            local mainFrame = Window.UIElements and Window.UIElements.Main
            if not mainFrame then return end
            local oldStroke = mainFrame:FindFirstChild("GrayscaleStroke")
            if oldStroke then oldStroke:Destroy() end
            local colorScheme = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex("FFFFFF")),
                ColorSequenceKeypoint.new(0.25, Color3.fromHex("CCCCCC")),
                ColorSequenceKeypoint.new(0.5, Color3.fromHex("999999")),
                ColorSequenceKeypoint.new(0.75, Color3.fromHex("666666")),
                ColorSequenceKeypoint.new(1, Color3.fromHex("333333"))
            })
            local stroke = Instance.new("UIStroke")
            stroke.Name = "GrayscaleStroke"
            stroke.Thickness = 1.5
            stroke.Color = Color3.fromRGB(255,255,255)
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.LineJoinMode = Enum.LineJoinMode.Round
            stroke.Parent = mainFrame
            local gradient = Instance.new("UIGradient")
            gradient.Color = colorScheme
            gradient.Rotation = 0
            gradient.Parent = stroke
            local angle = 0
            local connection
            connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
                if not stroke or stroke.Parent == nil then
                    connection:Disconnect()
                    return
                end
                angle = (angle + 180 * dt) % 360
                gradient.Rotation = angle
            end)
        end
        startGrayscaleBorder()

        -- 额外渐变遮罩
        local mainFrame = Window.UIElements and Window.UIElements.Main
        if mainFrame then
            local overlay = Instance.new("Frame")
            overlay.Name = "BackgroundOverlay"
            overlay.Size = UDim2.fromScale(1,1)
            overlay.Position = UDim2.fromScale(0,0)
            overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
            overlay.BackgroundTransparency = 0.3
            overlay.BorderSizePixel = 0
            overlay.ZIndex = 0

            
            local overlayCorner = Instance.new("UICorner")
            overlayCorner.Name = "OverlayCorner"
            overlayCorner.CornerRadius = UDim.new(0, 16)
            overlayCorner.Parent = overlay

            local gradient = Instance.new("UIGradient")
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255):Lerp(Color3.fromRGB(0,0,0), 0.1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0):Lerp(Color3.fromRGB(255,255,255), 0.1))
            })
            gradient.Rotation = 45
            gradient.Parent = overlay
            overlay.Parent = mainFrame
        end

        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "加载成功",
            Text = " UI 已显示",
            Duration = 2
        })
    end)

    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "UI 创建失败",
            Text = "错误: "..tostring(err),
            Duration = 8
        })
        warn("UI 创建错误:", err)
    end
end

createUI()
print("✅YEX Hub执行完毕")
