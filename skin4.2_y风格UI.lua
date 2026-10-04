local clock
clock = os.clock
local clock2
clock2 = os.clock
local floor
floor = math.floor
local ceil
ceil = math.ceil
local abs
abs = math.abs
local min
min = math.min
local max
max = math.max
local sqrt
sqrt = math.sqrt
local rad
rad = math.rad
local clamp
clamp = math.clamp
local vector
vector = Vector3.new
local vector2
vector2 = Vector2.new
local color
color = Color3.fromRGB
local cframe
cframe = CFrame.new
local format
format = string.format
local func1

local function func2()
	local func3 = cloneref
	if not func3 then
		return function(param1)
			return param1
		end
	end
	local obj = setmetatable({}, { __mode = "v" })

	return function(obj1)
		if not obj1 then
			return nil
		end
		local debugId = obj1:GetDebugId()
		local entry1 = obj[debugId]
		if entry1 then
			return entry1
		end
		local value1 = func3(obj1)
		obj[debugId] = value1
		return value1
	end
end

func1 = func2()

if getgenv().SkinHubLoaded then
	game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Nexus ", Text = "请勿重复执行", Duration = 3 })
	return
end

getgenv().SkinHubLoaded = true
local obj2, obj3, lib, lib2, lib3, options, toggles, list1, lib4, func4
local obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, localPlayer, flag1
local tbl1, func5, func6, func7, tbl2

do
	local result1 = clock()
	obj2 = func1(game:GetService("HttpService"))
	obj3 = func1(game:GetService("TeleportService"))
	lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
	lib2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/addons/ThemeManager.lua"))()
	lib3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/addons/SaveManager.lua"))()
	lib.ForceCheckbox = true
	options = lib.Options
	toggles = lib.Toggles
	list1 = {}
	lib4 = nil

	pcall(function()
		lib4 = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/MSESP/refs/heads/main/source.luau"))()
	end)

	if lib4 == nil then
		lib4 = getgenv().mstudio45_ESP
	end

	if lib4 ~= nil then
		pcall(function()
			lib4.GlobalConfig.Billboards = true
			lib4.GlobalConfig.Distance = true
		end)
	end

	list1.addESP = function(param2)
		if lib4 == nil then
			return nil
		end
		local ok, result = pcall(lib4.Add, lib4, param2)
		if ok then
			return result
		end
		return nil
	end

	list1.destroyESP = function(instance2)
		if instance2 ~= nil then
			pcall(function()
				instance2:Destroy()
			end)
		end
	end

	list1.notify = function(message, flag2)
		lib:Notify(message, flag2 or 2)
	end

	func4 = function(instance3, ...)
		local tbl3 = { ... }

		for i = 1, #tbl3 do
			local entry2 = tbl3[i]

			if instance3 then
				instance3 = instance3:FindFirstChild(entry2)
			else
				instance3 = nil
			end

			if not instance3 then
				return nil
			end
		end

		return instance3
	end

	obj4 = func1(game:GetService("Players"))
	obj5 = func1(game:GetService("RunService"))
	obj6 = func1(game:GetService("UserInputService"))
	obj7 = func1(game:GetService("ReplicatedStorage"))
	obj8 = func1(game:GetService("TweenService"))
	obj9 = func1(game:GetService("Lighting"))
	obj10 = func1(game:GetService("Stats"))
	local value2 = func1(game:GetService("CoreGui"))
	obj11 = func1(game:GetService("MarketplaceService"))
	local network = obj10 and obj10:FindFirstChild("Network")
	network = network and network:FindFirstChild("ServerStatsItem")
	local dataPing = network and network:FindFirstChild("Data Ping")
	localPlayer = obj4.LocalPlayer

	list1.createFloatingButton = function(name, text, position, textSize, callback1)
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = name
		screenGui.ResetOnSpawn = false
		screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0, 60, 0, 60)
		textButton.Position = position
		textButton.BackgroundColor3 = lib.Scheme.MainColor
		textButton.BackgroundTransparency = 0.2
		textButton.BorderSizePixel = 0
		textButton.Text = text
		textButton.TextColor3 = Color3.new(1, 1, 1)
		textButton.TextSize = textSize
		textButton.Font = Enum.Font.GothamBold
		textButton.Parent = screenGui
		textButton.Active = true
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 12)
		uiCorner.Parent = textButton
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Color = lib.Scheme.AccentColor
		uiStroke.Thickness = 2.5
		uiStroke.Transparency = 0.3
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Parent = textButton
		local flag3 = false
		local flag4 = false
		local position2 = nil
		local position3 = nil
		local tbl4 = {}

		table.insert(tbl4, textButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				flag3 = true
				flag4 = false
				position2 = input.Position
				position3 = textButton.Position
			end
		end))

		table.insert(tbl4, obj6.InputChanged:Connect(function(input)
			if flag3 and input.UserInputType == Enum.UserInputType.MouseMovement then
				if (input.Position - position2).Magnitude > 4 then
					flag4 = true
				end

				local n = input.Position - position2
				textButton.Position = UDim2.new(position3.X.Scale, position3.X.Offset + n.X, position3.Y.Scale, position3.Y.Offset + n.Y)
			end
		end))

		table.insert(tbl4, obj6.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				flag3 = false
			end
		end))

		table.insert(tbl4, screenGui.Destroying:Connect(function()
			for _, value3 in tbl4 do
				pcall(function()
					value3:Disconnect()
				end)
			end
		end))

		textButton.MouseButton1Click:Connect(function()
			if flag4 then
				return
			end
			callback1()
		end)

		return screenGui, textButton
	end

	list1.GUN_NAME_SET = {
		Musket = true,
		Carbine = true,
		Rifle = true,
		Pistol = true,
		Blunderbuss = true,
		["Air Rifle"] = true,
		["Horse Artillery Pistol"] = true,
		["Nock Gun"] = true,
		["Navy Pistol"] = true,
		["Brass Pistol"] = true,
		["Double Barrel Pistol"] = true,
		["Flintlock Pistol"] = true,
		["Model 29"] = true,
		["Old Blunderbuss"] = true,
		["Needle Gun"] = true,
		Shotgun = true,
		["Bolt Rifle"] = true,
		["Officer Pistol"] = true,
		["Heavy Pistol"] = true,
		["Light Dragoon Pistol"] = true,
	}

	list1.WEAPON_SPEED_MAP = {
		Musket = 1650,
		Rifle = 1800,
		["Baker Rifle"] = 1750,
		["Jäger Rifle"] = 1750,
		["Ferguson Rifle"] = 1700,
		Carbine = 1550,
		Musketoon = 1500,
		["Air Rifle"] = 1300,
		["Needle Gun"] = 1600,
		["Bolt Rifle"] = 1700,
		Pistol = 900,
		["Flintlock Pistol"] = 880,
		["Navy Pistol"] = 920,
		["Brass Pistol"] = 890,
		["Officer Pistol"] = 950,
		["Heavy Pistol"] = 900,
		["Light Dragoon Pistol"] = 910,
		["Horse Artillery Pistol"] = 930,
		["Double Barrel Pistol"] = 900,
		Colt = 950,
		["Duckfoot Pistol"] = 850,
		["Howdah Pistol"] = 880,
		Blunderbuss = 650,
		["Old Blunderbuss"] = 630,
		["Nock Gun"] = 680,
		Shotgun = 620,
	}

	list1.sharedIsGun = function(instance4)
		if not instance4 or not instance4:IsA("Tool") then
			return false
		end
		local animations = instance4:FindFirstChild("Animations")
		if not animations then
			return false
		end
		return animations:FindFirstChild("Aim") ~= nil or animations:FindFirstChild("Aiming") ~= nil
	end

	list1.sharedGetShotsLoaded = function(obj)
		if not obj then
			return 0
		end
		local shotsLoaded = obj:FindFirstChild("ShotsLoaded")
		if shotsLoaded and (shotsLoaded:IsA("IntValue") or shotsLoaded:IsA("NumberValue")) then
			return shotsLoaded.Value
		end
		local players = workspace:FindFirstChild("Players")

		if players then
			local obj12 = players:FindFirstChild(localPlayer.Name)

			if obj12 then
				local obj13 = obj12:FindFirstChild(obj.Name)

				if obj13 then
					local shotsLoaded2 = obj13:FindFirstChild("ShotsLoaded")
					if shotsLoaded2 and (shotsLoaded2:IsA("IntValue") or shotsLoaded2:IsA("NumberValue")) then
						return shotsLoaded2.Value
					end
				end
			end
		end

		return 0
	end

	list1.sharedGetRemote = function(obj)
		if not obj then
			return nil
		end
		local remoteEvent = obj:FindFirstChild("RemoteEvent")
		if remoteEvent then
			return remoteEvent
		end
		local players = workspace:FindFirstChild("Players")

		if players then
			local obj14 = players:FindFirstChild(localPlayer.Name)

			if obj14 then
				local obj15 = obj14:FindFirstChild(obj.Name)
				if obj15 then
					return obj15:FindFirstChild("RemoteEvent")
				end
			end
		end

		return nil
	end

	list1.getHeldToolRemote = function()
		local character = localPlayer.Character
		if not character then
			return nil, nil
		end

		for _, value4 in character:GetChildren() do
			if value4:IsA("Tool") then
				local remoteEvent = value4:FindFirstChild("RemoteEvent")
				if remoteEvent then
					return remoteEvent, value4
				end
			end
		end

		return nil, nil
	end

	list1.sharedGetCurrentBulletSpeed = function()
		local character = localPlayer.Character
		if not character then
			return 900
		end
		local tool = character:FindFirstChildOfClass("Tool")
		if not tool then
			return 900
		end
		local name = tool.Name
		local value5 = list1.WEAPON_SPEED_MAP[name]
		if value5 then
			return value5
		end
		local obj16 = name:lower()
		if obj16:find("rifle") or obj16:find("musket") or obj16:find("carbine") or obj16:find("needle") or obj16:find("bolt") or obj16:find("jäger") or obj16:find("ferguson") or obj16:find("musketoon") then
			return 1650
		end

		if obj16:find("pistol") or obj16:find("colt") or obj16:find("revolver") or obj16:find("horse") or obj16:find("double") then
			return 900
		end

		if obj16:find("blunderbuss") or obj16:find("nock") or obj16:find("shotgun") then
			return 650
		end
		return 900
	end

	list1.sharedGetPing = function()
		local ok, result = pcall(function()
			return dataPing:GetValue()
		end)

		if ok and result then
			return result
		end
		return 0
	end

	list1._charAddedHandlers = {}

	localPlayer.CharacterAdded:Connect(function(character)
		local charAddedHandlers = list1._charAddedHandlers

		for i = 1, #charAddedHandlers do
			local entry3 = charAddedHandlers[i]

			if entry3 then
				local ok, result = pcall(entry3, character)

				if not ok then
					warn("[SkinHub] CharacterAdded handler error: " .. tostring(result))
				end
			end
		end
	end)

	list1.onCharacterAdded = function(param3)
		table.insert(list1._charAddedHandlers, param3)

		return function()
			for i = #list1._charAddedHandlers, 1, -1 do
				if list1._charAddedHandlers[i] == param3 then
					table.remove(list1._charAddedHandlers, i)
					break
				end
			end
		end
	end

	list1.ZombieWatch = { _models = {}, _addedSubs = {}, _started = false }
	local tbl5 = { "Zombies", "Camera" }

	list1.ZombieWatch.start = function()
		if list1.ZombieWatch._started then
			return
		end
		list1.ZombieWatch._started = true
		local addedSubs = list1.ZombieWatch._addedSubs

		local function func8(instance5)
			if instance5:IsA("Model") and not list1.ZombieWatch._models[instance5] then
				list1.ZombieWatch._models[instance5] = true

				for _, addedSub in addedSubs do
					task.spawn(addedSub, instance5)
				end
			end
		end

		local function func9(instance6)
			if not instance6 or instance6:GetAttribute("SkinHubZombieWatch") then
				return
			end
			instance6:SetAttribute("SkinHubZombieWatch", true)

			instance6.ChildAdded:Connect(function(child)
				task.defer(func8, child)
			end)

			instance6.ChildRemoved:Connect(function(child)
				list1.ZombieWatch._models[child] = nil
			end)

			for _, value6 in instance6:GetChildren() do
				task.spawn(func8, value6)
			end
		end

		local function func10()
			for _, value7 in tbl5 do
				func9(workspace:FindFirstChild(value7))
			end
		end

		func10()

		workspace.ChildAdded:Connect(function(child)
			for _, value8 in tbl5 do
				if child.Name == value8 then
					task.defer(func9, child)
				end
			end
		end)
	end

	list1.ZombieWatch.getAll = function()
		local list2 = {}

		for k in list1.ZombieWatch._models do
			if k.Parent then
				list2[#list2 + 1] = k
			else
				list1.ZombieWatch._models[k] = nil
			end
		end

		return list2
	end

	list1.ZombieWatch.onAdded = function(param4)
		table.insert(list1.ZombieWatch._addedSubs, param4)

		return function()
			local foundAt = table.find(list1.ZombieWatch._addedSubs, param4)

			if foundAt then
				table.remove(list1.ZombieWatch._addedSubs, foundAt)
			end
		end
	end

	list1.ZombieWatch.forEach = function(param5)
		for _, value9 in list1.ZombieWatch.getAll() do
			pcall(param5, value9)
		end
	end

	local str1 = "fish"

	pcall(function()
		local imageManager = lib.ImageManager
		if not imageManager then
			return
		end

		if not imageManager.GetAsset("SkinHubLogo") then
			imageManager.AddAsset("SkinHubLogo", 0, "https://i.postimg.cc/bvtQNNsN/cgf.png")
		end

		str1 = imageManager.GetAsset("SkinHubLogo") or str1
	end)

	local n = 100

	local obj17 = lib:CreateLoading({
		Title = "Nexus",
		Icon = str1,
		IconSize = UDim2.fromOffset(40, 40),
		CurrentStep = 0,
		TotalSteps = n,
		ShowSidebar = false,
		AlwaysOnTop = true,
		WindowWidth = 460,
		WindowHeight = 220,
		ContentWidth = 460,
	})

	obj17:SetMessage("Nexus")
	obj17:SetDescription("正在初始化...")
	obj17:SetCurrentStep(0)
	local color2 = Color3.fromRGB(255, 255, 255)

	__StyleLoadingDesc = function()
		local screenGui = obj17 and obj17.ScreenGui
		if not screenGui then
			return
		end

		local function func11(instance7)
			if instance7:IsA("TextLabel") then
				pcall(function()
					instance7.TextColor3 = color2
					instance7.TextStrokeTransparency = 0.4
					instance7.TextStrokeColor3 = Color3.fromRGB(20, 60, 100)
				end)

				if not instance7:GetAttribute("SkinHubDescLock") then
					instance7:SetAttribute("SkinHubDescLock", true)

					instance7:GetPropertyChangedSignal("TextColor3"):Connect(function()
						if instance7.TextColor3 ~= color2 then
							pcall(function()
								instance7.TextColor3 = color2
							end)
						end
					end)
				end
			end
		end

		for _, getDescendant in screenGui:GetDescendants() do
			func11(getDescendant)
		end

		if not screenGui:GetAttribute("SkinHubDescHook") then
			screenGui:SetAttribute("SkinHubDescHook", true)

			screenGui.DescendantAdded:Connect(function(descendant)
				task.defer(function()
					func11(descendant)
				end)
			end)
		end
	end

	task.defer(function()
		pcall(__StyleLoadingDesc)
	end)

	list1.bootLanguage = "中文"
	list1.bootLanguagePicked = false
	list1.bootLanguageGui = nil
	local playerGui = localPlayer:WaitForChild("PlayerGui")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SkinHubLanguagePicker"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 2147483646
	screenGui.Parent = playerGui
	local frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(0.5, 1)
	frame.Position = UDim2.new(0.5, 0, 1, -24)
	frame.Size = UDim2.new(0, 280, 0, 76)
	frame.BackgroundColor3 = color(8, 14, 26)
	frame.BackgroundTransparency = 0.15
	frame.BorderSizePixel = 0
	frame.Parent = screenGui
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 10)
	uiCorner.Parent = frame
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = color(45, 90, 140)
	uiStroke.Thickness = 1.5
	uiStroke.Parent = frame
	local textLabel = Instance.new("TextLabel")
	textLabel.BackgroundTransparency = 1
	textLabel.Position = UDim2.new(0, 0, 0, 4)
	textLabel.Size = UDim2.new(1, 0, 0, 20)
	textLabel.Font = Enum.Font.GothamBold
	textLabel.Text = "语言 / Language"
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextSize = 14
	textLabel.Parent = frame
	local tbl6 = {}

	local function func12()
		for k, value10 in tbl6 do
			if k == list1.bootLanguage then
				value10.BackgroundColor3 = color(80, 200, 255)
				value10.TextColor3 = color(4, 8, 16)
			else
				value10.BackgroundColor3 = color(18, 32, 56)
				value10.TextColor3 = Color3.new(1, 1, 1)
			end
		end
	end

	local function func13(text, param6)
		local textButton = Instance.new("TextButton")
		textButton.Position = UDim2.new(0, param6, 0, 30)
		textButton.Size = UDim2.new(0, 128, 0, 36)
		textButton.Font = Enum.Font.GothamBold
		textButton.Text = text
		textButton.TextSize = 15
		textButton.BorderSizePixel = 0
		textButton.Parent = frame
		local uiCorner2 = Instance.new("UICorner")
		uiCorner2.CornerRadius = UDim.new(0, 8)
		uiCorner2.Parent = textButton

		textButton.MouseButton1Click:Connect(function()
			list1.bootLanguage = text
			list1.bootLanguagePicked = true
			func12()

			if type(__FinishLoading) == "function" then
				task.defer(__FinishLoading)
			end
		end)

		tbl6[text] = textButton
	end

	func13("中文", 8)
	func13("English", 144)
	func12()
	list1.bootLanguageGui = screenGui

	list1.destroyBootLanguagePicker = function()
		if list1.bootLanguageGui == nil then
			return
		end

		pcall(function()
			list1.bootLanguageGui:Destroy()
		end)

		list1.bootLanguageGui = nil
	end

	local flag5 = color(34, 197, 94)
	local value11 = color(74, 222, 128)
	local value12 = color(19, 33, 26)
	local value13 = color(14, 21, 17)
	local value14 = color(34, 197, 94)
	local color3 = Color3.new(1, 1, 1)
	local font = Font.fromEnum(Enum.Font.SciFi)
	local screenGui2 = obj17.ScreenGui

	local function func14(parent)
		if parent:IsA("Frame") then
			local backgroundColor3 = parent.BackgroundColor3

			if backgroundColor3 == Color3.fromRGB(15, 15, 15) then
				parent.BackgroundColor3 = value13
			elseif backgroundColor3 == Color3.fromRGB(25, 25, 25) then
				parent.BackgroundColor3 = value12
			elseif backgroundColor3 == Color3.fromRGB(125, 85, 255) then
				parent.BackgroundColor3 = flag5
			end

			if parent.BackgroundColor3 == flag5 and parent.Size.Y.Offset <= 20 then
				if not parent:FindFirstChildOfClass("UIGradient") then
					local uiGradient = Instance.new("UIGradient")
					uiGradient.Color = ColorSequence.new(flag5, value11)
					uiGradient.Rotation = 0
					uiGradient.Parent = parent
				end
			end
		elseif parent:IsA("ImageLabel") then
			if not (parent.Size.X.Offset >= 36) then
				parent.ImageColor3 = flag5
			end
		elseif parent:IsA("UIStroke") then
			parent.Color = value14
		elseif parent:IsA("TextLabel") then
			parent.TextColor3 = color3
			parent.TextStrokeTransparency = 0.4
			parent.TextStrokeColor3 = color(20, 60, 100)

			if not parent:GetAttribute("SkinHubFontGuard") then
				parent:SetAttribute("SkinHubFontGuard", true)
				local flag6 = false

				parent:GetPropertyChangedSignal("FontFace"):Connect(function()
					if flag6 then
						return
					end

					if parent.FontFace ~= font then
						flag6 = true
						parent.FontFace = font
						flag6 = false
					end
				end)

				task.spawn(function()
					while parent and parent.Parent do
						if parent.FontFace ~= font then
							parent.FontFace = font
						end

						task.wait(0.15)
					end
				end)
			end

			if parent.FontFace ~= font then
				parent.FontFace = font
			end

			if parent.Text == "Nexus HUB" and not parent:GetAttribute("SkinHubTitleFX") then
				parent:SetAttribute("SkinHubTitleFX", true)
				local uiGradient = Instance.new("UIGradient")
				local colorSequence = ColorSequence.new
				local value15 = ColorSequenceKeypoint.new(0, color(74, 222, 128))
				local value16 = ColorSequenceKeypoint.new(0.35, color(255, 255, 255))
				local new = ColorSequenceKeypoint.new
				local value17 = ColorSequenceKeypoint.new(0.65, color(134, 239, 172))
				local tbl7 = { value15, value16, value17 }

				do
					local values = table.pack(new(1, color(74, 222, 128)))
					table.move(values, 1, values.n, 4, tbl7)
				end

				uiGradient.Color = colorSequence(tbl7)
				uiGradient.Parent = parent

				task.spawn(function()
					local now = os.clock()

					while parent and parent.Parent do
						uiGradient.Rotation = (os.clock() - now) * 60 % 360
						obj5.RenderStepped:Wait()
					end
				end)
			end
		end
	end

	for _, getDescendant2 in screenGui2:GetDescendants() do
		pcall(func14, getDescendant2)
	end

	screenGui2.DescendantAdded:Connect(function(descendant)
		task.defer(function()
			pcall(func14, descendant)
		end)
	end)

	task.defer(function()
		for _, getDescendant3 in screenGui2:GetDescendants() do
			if getDescendant3:IsA("Frame") and getDescendant3.Size.X.Offset >= 400 and getDescendant3.Size.Y.Offset >= 180 then
				local uiStroke2 = getDescendant3:FindFirstChildOfClass("UIStroke")

				if uiStroke2 then
					uiStroke2.Color = flag5
					uiStroke2.Thickness = 1.5
					uiStroke2.Transparency = 0.4

					task.spawn(function()
						while getDescendant3 and getDescendant3.Parent do
							uiStroke2.Transparency = 0.25 + (math.sin(os.clock() * 1.8) + 1) * 0.5 * 0.35
							task.wait(0.05)
						end
					end)
				end

				break
			end
		end
	end)

	local n2 = 0
	local n3 = 90
	local flag7 = false
	local flag8 = false

	task.spawn(function()
		local tbl8 = {
			{ 0, "Nexus", "正在启动..." },
			{ 15, "初始化界面", "准备 UI 资源..." },
			{ 35, "加载模块", "解析脚本模块..." },
			{ 55, "构建功能", "注册自动化任务..." },
			{ 75, "应用主题", "调整配色与字体..." },
			{ 85, "收尾工作", "检查依赖..." },
		}

		local n4 = 1

		while not flag7 and n2 < n3 do
			if n4 <= #tbl8 and n2 >= tbl8[n4][1] then
				obj17:SetMessage(tbl8[n4][2])
				obj17:SetDescription(tbl8[n4][3])
				n4 += 1
			end

			n2 = math.min(n2 + math.random(2, 4), 90)
			obj17:SetCurrentStep(n2)
			task.wait(0.05)
		end

		obj17:SetCurrentStep(90)
		obj17:SetMessage("请选择语言")
		obj17:SetDescription("Please select your language")
		pcall(__StyleLoadingDesc)
	end)

	__FinishLoading = function()
		if flag8 then
			return
		end
		flag8 = true
		flag7 = true
		list1.destroyBootLanguagePicker()

		task.spawn(function()
			if list1.bootLanguagePicked and options and options.InterfaceLanguage then
				pcall(function()
					options.InterfaceLanguage:SetValue(list1.bootLanguage)
				end)

				pcall(function()
					SetInterfaceLanguage(list1.bootLanguage)
				end)
			end

			task.wait(0.15)
			obj17:SetMessage("加载完成")
			obj17:SetDescription("Loading complete")
			pcall(__StyleLoadingDesc)

			while n2 < n do
				n2 = math.min(n2 + 2, 100)
				obj17:SetCurrentStep(n2)
				task.wait(0.03)
			end

			task.wait(0.4)
			local screenGui3 = Instance.new("ScreenGui")
			screenGui3.Name = "SkinHubFadeOverlay"
			screenGui3.DisplayOrder = 2147483647
			screenGui3.IgnoreGuiInset = true
			screenGui3.ResetOnSpawn = false

			if not pcall(function()
				screenGui3.Parent = func1(game:GetService("CoreGui"))
			end) then
				screenGui3.Parent = obj4.LocalPlayer:WaitForChild("PlayerGui")
			end

			local frame2 = Instance.new("Frame")
			frame2.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
			frame2.BackgroundTransparency = 1
			frame2.Size = UDim2.fromScale(1, 1)
			frame2.BorderSizePixel = 0
			frame2.ZIndex = 1
			frame2.Parent = screenGui3
			local tween = obj8:Create(frame2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 })
			tween:Play()
			tween.Completed:Wait()
			obj17:Continue()
			task.wait(0.15)
			local tween2 = obj8:Create(frame2, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
			tween2:Play()
			tween2.Completed:Wait()
			screenGui3:Destroy()

			pcall(function()
				func1(game:GetService("StarterGui")):SetCore("SendNotification", { Title = "Nexus", Text = format("已加载，耗时 %.2f 秒", clock() - result1), Duration = 5 })
			end)
		end)
	end

	lib.Scheme = {
		BackgroundColor = Color3.new(0, 0, 0),
		MainColor = color(19, 33, 26),
		AccentColor = color(34, 197, 94),
		OutlineColor = color(74, 222, 128),
		FontColor = Color3.new(1, 1, 1),
		Font = Font.fromEnum(Enum.Font.Code),
		RedColor = color(255, 80, 80),
		DestructiveColor = color(220, 38, 38),
		DarkColor = Color3.new(0, 0, 0),
		WhiteColor = Color3.new(1, 1, 1),
		BackgroundImage = "",
	}

	local obj18 = lib:CreateWindow({
		Title = "Nexus",
		Footer = "Created by nexus制作团队",
		NotifySide = "Right",
		ShowCustomCursor = true,
		CornerRadius = 18,
		TabButtonsStyle = {
			Gap = 6,
			Padding = 6,
			CornerRadius = 10,
			Indicator = true,
			IndicatorWidth = 3,
			IndicatorHeight = 22,
		},
		Icon = str1,
		IconSize = UDim2.fromOffset(44, 44),
		Animations = {
			ToggleWindow = false,
			TabSwitch = true,
			Groupbox = true,
			Dropdown = true,
			KeyPicker = true,
		},
		TabTransitionTime = 0.22,
		TabSwipeOffset = 26,
		TabSwipeFrom = "Auto",
	})

	obj18:SetBackgroundImage("https://i.postimg.cc/gj9vkZbh/zhe-feng-bi-zhi-cha-hua-zi-ran-nu-shen.jpg")

	task.defer(function()
		local screenGui3 = lib.ScreenGui
		if not screenGui3 then
			return
		end

		for _, getDescendant4 in screenGui3:GetDescendants() do
			if getDescendant4:IsA("ImageLabel") and getDescendant4.ScaleType == Enum.ScaleType.Stretch and getDescendant4.BackgroundTransparency == 1 and getDescendant4.Size == UDim2.fromScale(1, 1) then
				getDescendant4.ImageTransparency = 1
				break
			end
		end
	end)

	lib.IsMobile = true

	for _, value18 in lib.Floats:GetChildren() do
		if value18:IsA("TextButton") then
			if value18.Text == "Toggle" then
				value18.Text = "Nexus"
				value18.TextColor3 = Color3.new(1, 1, 1)
				value18.TextSize = 13
				value18.FontFace = Font.fromEnum(Enum.Font.SciFi)
				value18.Size = UDim2.new(0, 55, 0, 55)
				value18.Position = UDim2.new(0.02, 0, 0.5, -120)
				value18.AnchorPoint = Vector2.new(0, 0.5)
				value18.BackgroundTransparency = 1
				local uiCorner2 = value18:FindFirstChild("UICorner")

				if not uiCorner2 then
					uiCorner2 = Instance.new("UICorner")
					uiCorner2.Parent = value18
				end

				uiCorner2.CornerRadius = UDim.new(1, 0)
				local uiGradient = value18:FindFirstChild("UIGradient")

				if uiGradient then
					uiGradient:Destroy()
				end

				local strokeOuter = value18:FindFirstChild("StrokeOuter")

				if not strokeOuter then
					strokeOuter = Instance.new("UIStroke")
					strokeOuter.Name = "StrokeOuter"
					strokeOuter.Parent = value18
				end

				strokeOuter.Thickness = 4
				strokeOuter.Transparency = 0.2
				strokeOuter.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				strokeOuter.Color = color(0, 110, 180)
				local strokeInner = value18:FindFirstChild("StrokeInner")

				if not strokeInner then
					strokeInner = Instance.new("UIStroke")
					strokeInner.Name = "StrokeInner"
					strokeInner.Parent = value18
				end

				strokeInner.Thickness = 2
				strokeInner.Transparency = 0
				strokeInner.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				strokeInner.Color = color(220, 250, 255)
				value18.TextStrokeColor3 = color(20, 60, 100)
				value18.TextStrokeTransparency = 0.35
				local font2 = Font.fromEnum(Enum.Font.SciFi)
				local flag9 = false

				value18:GetPropertyChangedSignal("FontFace"):Connect(function()
					if flag9 then
						return
					end

					if value18.FontFace ~= font2 then
						flag9 = true
						value18.FontFace = font2
						flag9 = false
					end
				end)

				task.spawn(function()
					while value18 and value18.Parent do
						if value18.FontFace ~= font2 then
							value18.FontFace = font2
						end

						task.wait(0.2)
					end
				end)

				task.spawn(function()
					while value18 and value18.Parent do
						local n4 = (math.sin(clock2() * 2.2) + 1) * 0.5
						strokeOuter.Transparency = 0.1 + n4 * 0.3
						strokeInner.Transparency = 0.3 + n4 * 0.4
						task.wait(0.05)
					end
				end)

				local flag10 = false
				local flag11 = false
				local flag12 = false
				local tween = nil

				local function func15()
					if tween then
						tween:Cancel()
					end

					local n4

					if flag12 then
						n4 = 68
					elseif flag11 then
						n4 = 48
					elseif flag10 then
						n4 = 62
					else
						n4 = 55
					end

					tween = obj8:Create(value18, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(0, n4, 0, n4) })
					tween:Play()
				end

				value18.MouseEnter:Connect(function()
					flag10 = true
					func15()
				end)

				value18.MouseLeave:Connect(function()
					flag10 = false
					func15()
				end)

				local position = nil
				local n4 = 5

				value18.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						flag11 = true
						position = input.Position
						func15()
					end
				end)

				value18.InputChanged:Connect(function(input)
					if not flag11 or not position then
						return
					end

					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						if (input.Position - position).Magnitude > n4 and not flag12 then
							flag12 = true
							func15()
						end
					end
				end)

				obj6.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						flag11 = false
						flag12 = false
						position = nil
						func15()
					end
				end)
			end

			if value18.Text == "Lock" then
				value18.Visible = false
			end
		end
	end

	flag1 = "中文"
	tbl1 = {}

	pcall(function()
		local response = game:HttpGet("https://raw.githubusercontent.com/Zephyrastic/Translations/main/translations/en.json")
		local data = obj2:JSONDecode(response)
		if typeof(data) ~= "table" then
			return
		end

		for k, value19 in data do
			if typeof(k) == "string" and typeof(value19) == "string" and value19 ~= "" then
				tbl1[k] = value19
			end
		end
	end)

	local obj = setmetatable({}, { __mode = "k" })
	local tbl9 = {}

	pcall(function()
		local response = game:HttpGet("https://raw.githubusercontent.com/Zephyrastic/Translations/main/translations/en-fragments.json")
		local data = obj2:JSONDecode(response)
		if typeof(data) ~= "table" then
			return
		end

		for k, value20 in data do
			if typeof(k) == "string" and typeof(value20) == "string" and value20 ~= "" then
				tbl9[k] = value20
			end
		end
	end)

	func5 = function(obj19)
		if flag1 ~= "English" then
			return obj19
		end

		if tbl1[obj19] then
			return tbl1[obj19]
		end

		if type(obj19) ~= "string" then
			return obj19
		end
		local flag13 = obj19:byte(1)
		if flag13 and flag13 < 128 then
			return obj19
		end

		for k, value21 in tbl9 do
			obj19 = string.gsub(obj19, k, value21)
		end

		return obj19
	end

	func6 = function(param7)
		return func5(param7)
	end

	local tbl10 = {}

	for k, value22 in tbl1 do
		tbl10[value22] = k
	end

	local function func16(param8)
		if tbl10[param8] then
			return tbl10[param8]
		end
		return param8
	end

	local function func17()
		local screenGui3 = lib and lib.ScreenGui
		if not screenGui3 then
			return false
		end
		local flag14 = false

		for _, value23 in screenGui3:GetChildren() do
			if value23:IsA("TextLabel") and value23:FindFirstChildOfClass("UIPadding") and value23:FindFirstChildOfClass("UIStroke") and value23:FindFirstChildOfClass("UICorner") and not value23:GetAttribute("SkinHubTooltipHook") then
				value23:SetAttribute("SkinHubTooltipHook", true)
				local flag15 = false

				value23:GetPropertyChangedSignal("Text"):Connect(function()
					if flag15 then
						return
					end
					local text = value23.Text
					if type(text) ~= "string" or text == "" then
						return
					end

					if flag1 == "English" then
						local flag16 = func5(text)

						if flag16 ~= text then
							flag15 = true
							value23.Text = flag16
							flag15 = false
						end
					elseif string.byte(text, 1) and string.byte(text, 1) < 128 then
						local flag17 = func16(text)

						if flag17 ~= text then
							flag15 = true
							value23.Text = flag17
							flag15 = false
						end
					end
				end)

				flag14 = true
			end
		end

		return flag14
	end

	local function func18(instance8)
		if instance8:GetAttribute("SkinHubLiveTranslate") then
			return
		end
		instance8:SetAttribute("SkinHubLiveTranslate", true)
		local flag18 = false

		instance8:GetPropertyChangedSignal("Text"):Connect(function()
			if flag18 then
				return
			end
			local text = instance8.Text
			if type(text) ~= "string" or text == "" then
				return
			end

			if flag1 ~= "English" then
				return
			end
			local text2 = tbl1[text]

			if not text2 then
				local list3 = string.split(text, ", ")
				local len = #list3 > 1

				for _, value24 in list3 do
					if not tbl1[value24] then
						len = false
						break
					end
				end

				if len then
					local list4 = {}

					for _, value25 in list3 do
						list4[#list4 + 1] = tbl1[value25]
					end

					text2 = table.concat(list4, ", ")
				end
			end

			if text2 and text2 ~= text then
				flag18 = true
				instance8.Text = text2
				flag18 = false
			end
		end)

		if instance8:IsA("TextBox") then
			instance8:GetPropertyChangedSignal("PlaceholderText"):Connect(function()
				if flag18 then
					return
				end
				local placeholderText = instance8.PlaceholderText
				if type(placeholderText) ~= "string" or placeholderText == "" then
					return
				end

				if flag1 ~= "English" then
					return
				end
				local entry4 = tbl1[placeholderText]

				if entry4 and entry4 ~= placeholderText then
					flag18 = true
					instance8.PlaceholderText = entry4
					flag18 = false
				end
			end)
		end
	end

	local function func19()
		local screenGui3 = lib and lib.ScreenGui
		if not screenGui3 then
			return false
		end

		if screenGui3:GetAttribute("SkinHubLiveTranslateRoot") then
			return true
		end
		screenGui3:SetAttribute("SkinHubLiveTranslateRoot", true)

		screenGui3.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
				func18(descendant)
			end
		end)

		for _, getDescendant5 in screenGui3:GetDescendants() do
			if getDescendant5:IsA("TextLabel") or getDescendant5:IsA("TextButton") or getDescendant5:IsA("TextBox") then
				func18(getDescendant5)
			end
		end

		return true
	end

	task.spawn(function()
		local flag19 = false

		for i = 1, 100 do
			flag19 = flag19 or func17()
			if not (flag19 and func19()) then
				task.wait(0.2)
				continue
			end
			break
		end

		while not func19() do
			task.wait(0.5)
		end
	end)

	local function func20()
		local tbl11 = {}

		if lib and lib.ScreenGui then
			table.insert(tbl11, lib.ScreenGui)
		end

		local playerGui2 = localPlayer:FindFirstChildOfClass("PlayerGui")

		if playerGui2 then
			table.insert(tbl11, playerGui2)
		end

		if value2 then
			table.insert(tbl11, value2)
		end

		return tbl11
	end

	local function func21(instance9)
		if lib and lib.ScreenGui then
			if instance9 == lib.ScreenGui or instance9:IsDescendantOf(lib.ScreenGui) then
				return false
			end
		end

		for i = 1, 20 do
			if not instance9 then
				return false
			end

			if instance9.Name == "RobloxGui" then
				return true
			end
			instance9 = instance9.Parent
		end

		return false
	end

	local function func22(instance10)
		return instance10:IsA("TextLabel") or instance10:IsA("TextButton") or instance10:IsA("TextBox")
	end

	local function func23(param9, flag20)
		if typeof(param9.Text) ~= "string" then
			return
		end
		local text = func16(param9.Text)
		obj[param9] = text
		text = flag20 == "English" and func5(text) or text

		if param9.Text ~= text then
			param9.Text = text
		end
	end

	func7 = function(param10)
		flag1 = param10

		for _, value26 in func20() do
			for _, getDescendant6 in value26:GetDescendants() do
				if func22(getDescendant6) and not func21(getDescendant6) then
					func23(getDescendant6, param10)
				end
			end
		end

		if options.PvpAimPart then
			options.PvpAimPart:SetValue(options.PvpAimPart.Value)
		end

		if options.AutoRepairMode then
			options.AutoRepairMode:SetValue(options.AutoRepairMode.Value)
		end

		if options.AuraMode then
			options.AuraMode:SetValue(options.AuraMode.Value)
		end
	end

	task.defer(function()
		local tbl12 = {}
		local flag21 = false

		local function func24()
			flag21 = false
			if flag1 ~= "English" then
				table.clear(tbl12)
				return
			end

			for k in tbl12 do
				if k.Parent and func22(k) and not func21(k) then
					func23(k, flag1)
				end
			end

			table.clear(tbl12)
		end

		for _, value27 in func20() do
			value27.DescendantAdded:Connect(function(descendant)
				if flag1 ~= "English" then
					return
				end

				if not func22(descendant) then
					return
				end
				tbl12[descendant] = true

				if not flag21 then
					flag21 = true
					task.defer(func24)
				end
			end)
		end
	end)

	tbl2 = {
		Home = obj18:AddTab("主页", "house"),
		Main = obj18:AddTab("主要与杀戮", "sword"),
		Auto = obj18:AddTab("其他与透视", "eye"),
		Minor = obj18:AddTab("防护功能", "shield"),
		Anims = obj18:AddTab("动画包", "film"),
		AutoFunc = obj18:AddTab("自动与PVP", "zap"),
		Extra = obj18:AddTab("职业功能", "users"),
		LocalPlayer = obj18:AddTab("本地玩家", "user"),
		Misc = obj18:AddTab("杂项", "layout-grid"),
		Settings = obj18:AddTab("设置", "settings"),
	}
end

do
	local obj20 = tbl2.Home:AddGroupbox({ Side = "Left", Name = "用户", IconName = "user", Description = "账号信息" })
	local obj21 = tbl2.Home:AddGroupbox({ Side = "Right", Name = "会话", IconName = "clock", Description = "在线状态" })
	local value28 = localPlayer
	local result3 = clock()

	local function func25(param11, flag22)
		return flag1 == "English" and flag22 or param11
	end

	local str2 = "Unknown"

	pcall(function()
		if identifyexecutor then
			str2 = identifyexecutor()
		end
	end)

	local frame = Instance.new("Frame")
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.new(1, 0, 1, 0)
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "Avatar"
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	imageLabel.Size = UDim2.new(0, 96, 0, 96)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = "rbxasset://textures/ui/iconAssetMissing.png"
	imageLabel.ScaleType = Enum.ScaleType.Crop
	imageLabel.BorderColor3 = color(0, 0, 0)
	imageLabel.Parent = frame

	task.spawn(function()
		local ok, image = pcall(function()
			return obj4:GetUserThumbnailAsync(value28.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		end)

		if ok and image and image ~= "" and imageLabel and imageLabel.Parent then
			imageLabel.Image = image
		end
	end)

	obj20:AddUIPassthrough("HomeAvatar", { Instance = frame, Height = 110 })
	local name = value28.Name
	local obj22 = obj20:AddLabel(("%s: %s"):format(func25("用户名", "Username"), name))
	local userId = value28.UserId
	local obj23 = obj20:AddLabel(("%s: %d"):format(func25("用户ID", "UserId"), userId))
	local obj24 = obj20:AddLabel(("%s: %s"):format(func25("执行器", "Executor"), str2))
	local addLabel = obj20.AddLabel
	local format2 = ("%s: 00:00:00").format
	local value29 = func25("会话时间", "Session Time")
	local obj25 = addLabel(obj20, format2("%s: 00:00:00", value29))

	obj20:AddButton({
		Text = "复制用户名",
		Func = function()
			pcall(function()
				setclipboard(value28.Name)
			end)
		end,
	})

	obj20:AddButton({
		Text = "复制个人资料链接",
		Func = function()
			pcall(function()
				setclipboard(("https://www.roblox.com/users/%d/profile"):format(value28.UserId))
			end)
		end,
	})

	local obj26 = tbl2.Home:AddGroupbox({ Side = "Left", Name = "信息", IconName = "info", Description = "版本信息" })
	obj26:AddLabel("用户类型：付费版")
	obj26:AddLabel("英文翻译：Zephy")
	obj26:AddLabel("脚本优化：Zephy")
	local str3 = "Unknown"

	pcall(function()
		local productInfo = obj11:GetProductInfo(game.PlaceId)

		if productInfo and productInfo.Name then
			str3 = productInfo.Name
		end
	end)

	local list5 = obj4
	local obj27 = obj21:AddLabel(("%s: %s"):format(func25("游戏", "Game"), str3))
	local maxPlayers = list5.MaxPlayers
	local obj28 = obj21:AddLabel(("%s: %d/%d"):format(func25("玩家", "Players"), #list5:GetPlayers(), maxPlayers))
	obj21:AddLabel(("JobId: %s"):format(game.JobId ~= "" and game.JobId:sub(1, 8) .. "..." or "Studio"))
	local addLabel2 = obj21.AddLabel
	local format3 = ("%s: 0 ms").format
	local value30 = func25("延迟", "Ping")
	local obj29 = addLabel2(obj21, format3("%s: 0 ms", value30))

	obj21:AddButton({
		Text = "重新加入服务器",
		Func = function()
			pcall(function()
				obj3:TeleportToPlaceInstance(game.PlaceId, game.JobId, value28)
			end)
		end,
	})

	obj21:AddButton({
		Text = "复制 Job ID",
		Func = function()
			pcall(function()
				setclipboard(game.JobId)
			end)
		end,
	})

	task.spawn(function()
		while true do
			local num1 = floor(clock() - result3)
			local num2 = floor(num1 / 3600)
			local num3 = floor(num1 % 3600 / 60)
			local n = num1 % 60

			pcall(function()
				local name2 = value28.Name
				obj22:SetText(("%s: %s"):format(func25("用户名", "Username"), name2))
				local userId2 = value28.UserId
				obj23:SetText(("%s: %d"):format(func25("用户ID", "UserId"), userId2))
				obj24:SetText(("%s: %s"):format(func25("执行器", "Executor"), str2))
				obj27:SetText(("%s: %s"):format(func25("游戏", "Game"), str3))
				obj25:SetText(("%s: %02d:%02d:%02d"):format(func25("会话时间", "Session Time"), num2, num3, n))
				local maxPlayers2 = list5.MaxPlayers
				obj28:SetText(("%s: %d/%d"):format(func25("玩家", "Players"), #list5:GetPlayers(), maxPlayers2))
				local value31 = floor(obj10.Network.ServerStatsItem["Data Ping"]:GetValue())
				obj29:SetText(("%s: %d ms"):format(func25("延迟", "Ping"), value31))
			end)

			task.wait(1)
		end
	end)
end

do
	local obj30 = tbl2.Misc:AddGroupbox({ Side = "Left", Name = "杂项功能", IconName = "layout-grid", Description = "视野辅助" })
	local obj31 = tbl2.Misc:AddGroupbox({ Side = "Right", Name = "娱乐功能", IconName = "party-popper", Description = "趣味效果" })

	obj31:AddToggle("RollTiltToggle", {
		Text = "我好像有点卡顿",
		Default = false,
		Tooltip = func6("让人物看起来卡卡的"),
		Callback = function(value)
			if value then
				list1.rollTiltStart()
			else
				list1.rollTiltStop()
			end
		end,
	})

	obj31:AddSlider("RollTiltSpeed", {
		Text = "卡顿程度",
		Default = 3,
		Min = 1,
		Max = 10,
		Suffix = " 级",
		Callback = function(rollTiltSpeed)
			list1.rollTiltSpeed = rollTiltSpeed
		end,
	})

	obj31:AddToggle("SpinToggle", {
		Text = "旋转",
		Default = false,
		Tooltip = func6("让人物持续旋转"),
		Callback = function(enabled)
			list1.spin.enabled = enabled

			if enabled then
				list1.spin.start()
			else
				list1.spin.stop()
			end
		end,
	})

	obj31:AddSlider("SpinSpeed", {
		Text = "旋转速度",
		Default = 5,
		Min = 1,
		Max = 30,
		Suffix = " 级",
		Callback = function(speed)
			list1.spin.speed = speed
		end,
	})

	obj31:AddToggle("ThirdPersonToggle", {
		Text = "解除视角限制",
		Default = false,
		Tooltip = func6("解除玩家视角上限"),
		Callback = function(value)
			if value then
				list1.thirdPerson.start()
			else
				list1.thirdPerson.stop()
			end
		end,
	})

	obj31:AddToggle("AnimFreezeToggle", {
		Text = "人体十字架",
		Default = false,
		Tooltip = func6("化身成人体十字架"),
		Callback = function(value)
			if value then
				list1.animFreeze.start()
			else
				list1.animFreeze.stop()
			end
		end,
	})

	obj31:AddToggle("InvertToggle", {
		Text = "倒立行走",
		Default = false,
		Tooltip = func6("让玩家倒立"),
		Callback = function(value)
			list1.invert.setEnabled(value)
		end,
	})

	obj31:AddToggle("BigHeadToggle", {
		Text = "大头儿子",
		Default = false,
		Tooltip = func6("所有僵尸变成大头儿子"),
		Callback = function(value)
			if value then
				list1.bigHead.enable()
			else
				list1.bigHead.disable()
			end
		end,
	})

	obj31:AddSlider("BigHeadSize", {
		Text = "头部大小",
		Default = 3,
		Min = 1,
		Max = 10,
		Suffix = " 倍",
		Callback = function(headSize)
			list1.bigHead.headSize = headSize

			if list1.bigHead.enabled then
				list1.bigHead.updateAllZombies()
			end
		end,
	})

	obj31:AddSlider("BigHeadTrans", {
		Text = "头部透明度",
		Default = 5,
		Min = 1,
		Max = 10,
		Suffix = " 级",
		Callback = function(value)
			list1.bigHead.headTrans = value / 10

			if list1.bigHead.enabled then
				list1.bigHead.updateAllZombies()
			end
		end,
	})

	obj31:AddToggle("AnimLoop1205Toggle", {
		Text = "自己猜🤓",
		Default = false,
		Tooltip = func6("自己猜🤓"),
		Callback = function(animLoop1205Enabled)
			list1.animLoop1205Enabled = animLoop1205Enabled

			if animLoop1205Enabled then
				list1.startAnimLoop1205()
			else
				list1.stopAnimLoop1205()
			end
		end,
	})

	obj30:AddButton({
		Text = "删除帽子",
		Func = function()
			list1.removeAllHats()
		end,
	})

	obj30:AddButton({
		Text = "删除上衣",
		Func = function()
			list1.removeAllShirts()
		end,
	})

	obj30:AddButton({
		Text = "删除裤子",
		Func = function()
			list1.removeAllPants()
		end,
	})

	obj30:AddButton({
		Text = "一键删除以上全部",
		Func = function()
			list1.removeAllHats()
			list1.removeAllShirts()
			list1.removeAllPants()
		end,
	})

	obj30:AddButton({
		Text = "移除马车模型",
		Func = function()
			list1.removeCarriages()
		end,
	})

	obj30:AddButton({
		Text = "降低画质 <font color=\"rgb(255,0,0)\">（不可恢复）</font>",
		Func = function()
			local terrain = workspace.Terrain

			pcall(function()
				sethiddenproperty(obj9, "Technology", 2)
				sethiddenproperty(terrain, "Decoration", false)
			end)

			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 0
			obj9.GlobalShadows = false
			obj9.FogEnd = 9e9
			obj9.Brightness = 0

			pcall(function()
				local level01 = Enum.QualityLevel.Level01
				settings().Rendering.QualityLevel = level01
			end)

			for _, descendant in pairs(workspace:GetDescendants()) do
				if descendant:IsA("BasePart") and not descendant:IsA("MeshPart") then
					descendant.Material = "Plastic"
					descendant.Reflectance = 0
				elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
					descendant.Transparency = 1
				elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
					descendant.Lifetime = NumberRange.new(0)
				elseif descendant:IsA("Explosion") then
					descendant.BlastPressure = 1
					descendant.BlastRadius = 1
				elseif descendant:IsA("Fire") or descendant:IsA("SpotLight") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then
					descendant.Enabled = false
				elseif descendant:IsA("MeshPart") then
					descendant.Material = "Plastic"
					descendant.Reflectance = 0
				elseif descendant:IsA("SpecialMesh") then
					descendant.TextureId = ""
				elseif descendant:IsA("ShirtGraphic") then
					descendant.Graphic = ""
				end
			end

			for _, child in pairs(obj9:GetChildren()) do
				if child:IsA("BlurEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") or child:IsA("BloomEffect") or child:IsA("DepthOfFieldEffect") then
					child.Enabled = false
				end
			end
		end,
	})

	obj30:AddSlider("WaveSkipCount", {
		Text = "波次数",
		Default = 1,
		Min = 1,
		Max = 100,
		Rounding = 0,
		Callback = function(waveNum)
			list1.waveNum = waveNum
		end,
	})

	obj30:AddButton({
		Text = "跳过 N 波",
		Func = function()
			list1.sendChatCmd("/skipwave " .. list1.waveNum)
		end,
	})

	list1.Bright = { Enabled = false, OriginalLighting = nil }

	obj30:AddToggle("BrightToggle", {
		Text = "亮度提升",
		Default = false,
		Tooltip = func6("提高场景亮度"),
		Callback = function(value)
			local value32 = obj9

			if value then
				if not list1.Bright.OriginalLighting then
					list1.Bright.OriginalLighting = {
						ClockTime = value32.ClockTime,
						Ambient = value32.Ambient,
						GlobalShadows = value32.GlobalShadows,
						OutdoorAmbient = value32.OutdoorAmbient,
					}
				end

				value32.ClockTime = 14
				value32.Ambient = color(255, 255, 255)
				value32.GlobalShadows = false
				value32.OutdoorAmbient = color(255, 255, 255)
				list1.Bright.Enabled = true
			else
				if list1.Bright.OriginalLighting then
					value32.ClockTime = list1.Bright.OriginalLighting.ClockTime
					value32.Ambient = list1.Bright.OriginalLighting.Ambient
					value32.GlobalShadows = list1.Bright.OriginalLighting.GlobalShadows
					value32.OutdoorAmbient = list1.Bright.OriginalLighting.OutdoorAmbient
				end

				list1.Bright.Enabled = false
			end
		end,
	})

	obj30:AddToggle("NoFogToggle", {
		Text = "无雾效果",
		Default = false,
		Tooltip = func6("移除雾效与大气效果，并在地图切换后自动重新应用"),
		Callback = function(noFogEnabled)
			list1.noFogEnabled = noFogEnabled

			if noFogEnabled then
				list1.applyNoFog()
				list1.startNoFogMonitor()
			else
				list1.stopNoFogMonitor()
				list1.restoreNoFog()
			end
		end,
	})
end

local obj32 = tbl2.Misc:AddGroupbox({ Side = "Left", Name = "娱乐", IconName = "smile", Description = "一键操作" })
list1.oneClick = list1.oneClick or {}
list1.oneClick.ui = nil
list1.oneClick.VALID_WEAPONS = { Carbine = true, Axe = true, Pickaxe = true }

list1.oneClick.getCurrentWeapon = function()
	local character = localPlayer.Character
	if not character then
		return nil
	end

	for _, value33 in character:GetChildren() do
		if value33:IsA("Tool") then
			if list1.oneClick.VALID_WEAPONS[value33.Name] then
				if value33:FindFirstChild("RemoteEvent") then
					return value33
				end
			end
		end
	end

	return nil
end

list1.oneClick.collectTargets = function()
	local tbl13 = {}

	for _, getDescendant7 in workspace:GetDescendants() do
		if getDescendant7.Name == "DoorHit" or getDescendant7.Name == "BreakGlass" then
			table.insert(tbl13, getDescendant7)
		end
	end

	pcall(function()
		if getnilinstances then
			for _, getnilinstance in getnilinstances() do
				if getnilinstance.Name == "DoorHit" or getnilinstance.Name == "BreakGlass" then
					table.insert(tbl13, getnilinstance)
				end
			end
		end
	end)

	local tbl14 = {}
	local tbl15 = {}

	for _, value34 in tbl13 do
		if not tbl14[value34] then
			tbl14[value34] = true
			table.insert(tbl15, value34)
		end
	end

	return tbl15
end

list1.oneClick.getTargetPosition = function(obj)
	if obj:IsA("BasePart") then
		return obj.Position
	end

	if obj:IsA("Attachment") then
		return obj.WorldPosition
	end

	if obj.Parent and obj.Parent:IsA("BasePart") then
		return obj.Parent.Position
	end

	if obj.Parent and obj.Parent.Parent and obj.Parent.Parent:IsA("BasePart") then
		return obj.Parent.Parent.Position
	end
	return Vector3.zero
end

list1.oneClick.execute = function()
	local obj33 = list1.oneClick.getCurrentWeapon()
	if not obj33 then
		lib:Notify(func5("请手持卡宾枪/稿子/斧头"), 2)
		return
	end
	local remoteEvent = obj33:FindFirstChild("RemoteEvent")
	if not remoteEvent then
		return
	end
	local list6 = list1.oneClick.collectTargets()
	if #list6 == 0 then
		return
	end

	pcall(function()
		remoteEvent:FireServer("BraceBlock")
		task.wait(0.08)
		remoteEvent:FireServer("StopBraceBlock")
		task.wait(0.05)

		for _, value35 in list6 do
			local value36 = list1.oneClick.getTargetPosition(value35)
			remoteEvent:FireServer("FeedbackStunObject", value35, value36)
			task.wait(0.003)
		end
	end)
end

list1.oneClick.createUI = function()
	if list1.oneClick.ui then
		list1.oneClick.ui:Destroy()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "OneClick"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
	local textButton = Instance.new("TextButton")
	textButton.Size = UDim2.new(0, 60, 0, 60)
	textButton.Position = UDim2.new(0.5, -30, 0.45, 0)
	textButton.BackgroundColor3 = color(30, 30, 40)
	textButton.BackgroundTransparency = 0.2
	textButton.BorderSizePixel = 0
	textButton.Text = "拆"
	textButton.TextColor3 = color(255, 255, 255)
	textButton.TextSize = 24
	textButton.Font = Enum.Font.GothamBold
	textButton.Parent = screenGui
	textButton.Active = true
	textButton.Draggable = true
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 12)
	uiCorner.Parent = textButton
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Parent = textButton
	uiStroke.Color = color(100, 200, 255)
	uiStroke.Thickness = 2.5
	uiStroke.Transparency = 0.3
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	list1.oneClick.ui = screenGui

	textButton.MouseButton1Click:Connect(function()
		task.spawn(list1.oneClick.execute)
	end)
end

list1.flyAway = { isEnabled = false, connections = {}, toggleBtn = nil, screenGui = nil }

list1.flyAway.SafeGetCharacter = function(obj)
	if not obj then
		return nil
	end
	local character = obj.Character
	if not character or not character.Parent then
		return nil
	end
	return character
end

list1.flyAway.SafeGetHumanoid = function(obj34)
	if not obj34 then
		return nil
	end
	return obj34:FindFirstChildOfClass("Humanoid")
end

list1.flyAway.SafeGetHRP = function(instance11)
	if not instance11 then
		return nil
	end
	return instance11:FindFirstChild("HumanoidRootPart")
end

list1.flyAway.UpdateButton = function()
	if not list1.flyAway.toggleBtn then
		return
	end

	if list1.flyAway.isEnabled then
		list1.flyAway.toggleBtn.Text = "关"
		list1.flyAway.toggleBtn.BackgroundColor3 = color(200, 80, 80)
	else
		list1.flyAway.toggleBtn.Text = "碰"
		list1.flyAway.toggleBtn.BackgroundColor3 = color(30, 30, 40)
	end
end

list1.flyAway.ToggleCore = function(isEnabled)
	list1.flyAway.isEnabled = isEnabled

	for _, connection4 in list1.flyAway.connections do
		if connection4 then
			pcall(function()
				connection4:Disconnect()
			end)
		end
	end

	list1.flyAway.connections = {}

	if list1.flyAway.isEnabled then
		local connection = obj5.Stepped:Connect(function()
			if not list1.flyAway.isEnabled then
				return
			end
			local value37 = list1.flyAway.SafeGetCharacter(localPlayer)
			local obj35 = list1.flyAway.SafeGetHumanoid(value37)
			local value38 = list1.flyAway.SafeGetHRP(value37)

			if obj35 and value38 then
				pcall(function()
					obj35.PlatformStand = false
					obj35.Sit = false
					obj35.AutoRotate = true
					local state = obj35:GetState()

					if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Ragdoll then
						obj35:ChangeState(Enum.HumanoidStateType.GettingUp)
					end
				end)
			end

			if list1.flyAway.isEnabled then
				for _, getPlayer in obj4:GetPlayers() do
					if getPlayer ~= localPlayer then
						local obj36 = list1.flyAway.SafeGetCharacter(getPlayer)

						if obj36 then
							for _, getDescendant8 in obj36:GetDescendants() do
								if getDescendant8:IsA("BasePart") then
									pcall(function()
										getDescendant8.CanCollide = false
									end)
								end
							end
						end
					end
				end
			end
		end)

		table.insert(list1.flyAway.connections, connection)
		-- 𝖲𝗈𝗎𝗋𝖼𝖾 𝖫𝖾𝖺𝗄 (𝖲𝖫) | https://discord.gg/x7YbZeezpm

		local connection2 = obj5.Heartbeat:Connect(function()
			if not list1.flyAway.isEnabled then
				return
			end
			local value39 = list1.flyAway.SafeGetCharacter(localPlayer)
			local flag23 = list1.flyAway.SafeGetHRP(value39)
			local obj37 = list1.flyAway.SafeGetHumanoid(value39)

			if obj37 and flag23 then
				pcall(function()
					local assemblyLinearVelocity = flag23.AssemblyLinearVelocity
					obj37:ChangeState(Enum.HumanoidStateType.Running)
					local y = assemblyLinearVelocity.Y

					if y > 35 then
						y = 35
					end

					if y < -40 then
						y = -40
					end

					flag23.AssemblyAngularVelocity = Vector3.new(1350, 1350, 1350)
					flag23.AssemblyLinearVelocity = vector(assemblyLinearVelocity.X * 1, y, assemblyLinearVelocity.Z * 1)
					obj5.RenderStepped:Wait()

					if flag23 and flag23.Parent then
						flag23.AssemblyAngularVelocity = Vector3.zero
					end
				end)
			end
		end)

		table.insert(list1.flyAway.connections, connection2)
	end

	list1.flyAway.UpdateButton()
end

list1.flyAway.CreateUI = function()
	if list1.flyAway.screenGui then
		list1.flyAway.screenGui:Destroy()
	end

	list1.flyAway.screenGui = Instance.new("ScreenGui")
	list1.flyAway.screenGui.Name = "碰UI"
	list1.flyAway.screenGui.ResetOnSpawn = false
	list1.flyAway.screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
	list1.flyAway.toggleBtn = Instance.new("TextButton")
	list1.flyAway.toggleBtn.Size = UDim2.new(0, 60, 0, 60)
	list1.flyAway.toggleBtn.Position = UDim2.new(0.5, -30, 0.45, 0)
	list1.flyAway.toggleBtn.BackgroundColor3 = color(30, 30, 40)
	list1.flyAway.toggleBtn.BackgroundTransparency = 0.2
	list1.flyAway.toggleBtn.BorderSizePixel = 0
	list1.flyAway.toggleBtn.Text = "碰"
	list1.flyAway.toggleBtn.TextColor3 = color(255, 255, 255)
	list1.flyAway.toggleBtn.TextSize = 24
	list1.flyAway.toggleBtn.Font = Enum.Font.GothamBold
	list1.flyAway.toggleBtn.Parent = list1.flyAway.screenGui
	list1.flyAway.toggleBtn.Active = true
	list1.flyAway.toggleBtn.Draggable = true
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 12)
	uiCorner.Parent = list1.flyAway.toggleBtn
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = color(100, 200, 255)
	uiStroke.Thickness = 2.5
	uiStroke.Transparency = 0.3
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke.Parent = list1.flyAway.toggleBtn

	list1.flyAway.toggleBtn.MouseButton1Click:Connect(function()
		list1.flyAway.isEnabled = not list1.flyAway.isEnabled
		list1.flyAway.ToggleCore(list1.flyAway.isEnabled)
	end)

	list1.flyAway.UpdateButton()
end

list1.flyAway.Start = function()
	if list1.flyAway.screenGui and list1.flyAway.screenGui.Parent then
		return
	end
	list1.flyAway.CreateUI()
	list1.flyAway.isEnabled = false
	list1.flyAway.ToggleCore(false)
end

list1.flyAway.Stop = function()
	if list1.flyAway.screenGui then
		list1.flyAway.screenGui:Destroy()
		list1.flyAway.screenGui = nil
		list1.flyAway.toggleBtn = nil
	end

	if list1.flyAway.isEnabled then
		list1.flyAway.ToggleCore(false)
	end

	for _, connection5 in list1.flyAway.connections do
		if connection5 then
			pcall(function()
				connection5:Disconnect()
			end)
		end
	end

	list1.flyAway.connections = {}
end

obj32:AddToggle("OneClickToggle", {
	Text = "打全图门窗",
	Default = false,
	Callback = function(value)
		if value then
			list1.oneClick.createUI()
		elseif list1.oneClick.ui then
			list1.oneClick.ui:Destroy()
		end
	end,
})

obj32:AddToggle("FlyAwayToggle", {
	Text = "打开甩飞快捷栏",
	Default = false,
	Callback = function(value)
		if value then
			list1.flyAway.Start()
		else
			list1.flyAway.Stop()
		end
	end,
})

list1.invisScript = list1.invisScript or { enabled = false, cleanup = nil }

list1.startInvisScript = function()
	if list1.invisScript.enabled then
		return
	end

	if type(loadstring) ~= "function" then
		list1.notify(func5("错误") .. ": loadstring unavailable", 2)
		return
	end

	local chunk = loadstring([[local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local c = true
local h = {}
local d = Vector3.new(0, 0, 0)

local sg = Instance.new("ScreenGui")
sg.Name = "InvisFloatWindow"
sg.ResetOnSpawn = false
sg.Parent = LocalPlayer:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 60, 0, 60)
btn.Position = UDim2.new(0.5, -30, 0.45, 0)
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
btn.BackgroundTransparency = 0.2
btn.BorderSizePixel = 0
btn.Text = "关"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 18
btn.Font = Enum.Font.GothamBold
btn.Parent = sg
btn.Active = true
btn.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = btn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 200, 255)
stroke.Thickness = 2.5
stroke.Transparency = 0.3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = btn

local function updateOffset()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local head = char:FindFirstChild("Head")
    local topY = hrp.Position.Y + hrp.Size.Y * 0
    if head then
        topY = head.Position.Y + head.Size.Y * 0
    end
    local up = (topY - hrp.Position.Y) + 500
    d = Vector3.new(0, up, 0)
end

local btnConn = btn.MouseButton1Click:Connect(function()
    c = not c
    if c then
        btn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
        btn.Text = "开"
    else
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        btn.Text = "关"
    end
end)

c = false
btn.Text = "关"
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)

local heartbeatConn = RunService.Heartbeat:Connect(function()
    if c == true and LocalPlayer.Character then
        local i = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not i then return end
        updateOffset()
        h[1] = i.CFrame
        h[2] = i.AssemblyLinearVelocity
        local j = i.CFrame + d
        i.CFrame = j
        i.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        RunService.RenderStepped:Wait()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = h[1]
            LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = h[2]
        end
    end
end)

local originalIndex
originalIndex = hookmetamethod(game, "__index", newcclosure(function(self, l)
    if c == true then
        if not checkcaller() then
            if l == "CFrame" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
                if self == LocalPlayer.Character.HumanoidRootPart then
                    return (h[1] or CFrame.new()) + d
                elseif self == LocalPlayer.Character.Head then
                    local m = h[1] or CFrame.new()
                    return m + d
                end
            end
        end
    end
    return originalIndex(self, l)
end))

local renderBindName = "FakePosCamFix_" .. tostring(math.random(100000, 999999))
RunService:BindToRenderStep(
    renderBindName,
    Enum.RenderPriority.Camera.Value + 1,
    function()
        if c == true and LocalPlayer.Character then
            local cam = workspace.CurrentCamera
            if cam then
                cam.CFrame = cam.CFrame - d
            end
        end
    end
)

return function()
    c = false
    if btnConn then pcall(function() btnConn:Disconnect() end) end
    if heartbeatConn then pcall(function() heartbeatConn:Disconnect() end) end
    if sg and sg.Parent then pcall(function() sg:Destroy() end) end
    pcall(function() RunService:UnbindFromRenderStep(renderBindName) end)
    if originalIndex then
        pcall(function() hookmetamethod(game, "__index", originalIndex) end)
    end
end
]])

	if not chunk then
		list1.notify(func5("错误") .. ": loadstring failed", 2)
		return
	end
	local ok, cleanup = pcall(chunk)

	if not ok then
		warn("[InvisScript] load error: " .. tostring(cleanup))
		list1.notify(func5("错误") .. ": " .. tostring(cleanup), 3)
		return
	end

	list1.invisScript.enabled = true
	list1.invisScript.cleanup = cleanup
end

list1.stopInvisScript = function()
	if not list1.invisScript.enabled then
		return
	end
	list1.invisScript.enabled = false

	if list1.invisScript.cleanup then
		pcall(list1.invisScript.cleanup)
		list1.invisScript.cleanup = nil
	end

	pcall(function()
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		playerGui = playerGui and playerGui:FindFirstChild("InvisFloatWindow")

		if playerGui then
			playerGui:Destroy()
		end
	end)
end

obj32:AddToggle("InvisScriptToggle", {
	Text = "打开隐身快捷栏",
	Default = false,
	Callback = function(value)
		if value then
			list1.startInvisScript()
		else
			list1.stopInvisScript()
		end
	end,
})

local obj38
obj38 = tbl2.Anims:AddGroupbox({ Side = "Left", Name = "动画包", IconName = "film", Description = "姿势动画" })
local obj39
obj39 = tbl2.Anims:AddGroupbox({ Side = "Right", Name = "其它动画", IconName = "clapperboard", Description = "舞蹈动作" })

do
	local obj40 = tbl2.AutoFunc:AddGroupbox({ Side = "Left", Name = "自动功能", IconName = "zap", Description = "自动挖拾" })
	list1.autoDigEnabled = false
	list1.autoDigConnection = nil

	list1.DIGGABLE_PATHS = {
		"Vardohus Fortress/Modes/Objective/DoorSnow/Diggable",
		"Vardohus Fortress/Modes/Objective/Diggable",
		"OLD Vardohus Fortress/Modes/Objective/DigSnow/Diggable",
	}

	list1.getDiggingTool = function()
		local character = localPlayer.Character
		if not character then
			return nil
		end

		for _, value40 in character:GetChildren() do
			if (value40.Name == "Shovel" or value40.Name == "Spade") and value40:FindFirstChild("RemoteEvent") then
				return value40
			end
		end

		for _, value41 in localPlayer.Backpack:GetChildren() do
			if (value41.Name == "Shovel" or value41.Name == "Spade") and value41:FindFirstChild("RemoteEvent") then
				return value41
			end
		end

		return nil
	end

	list1.findValidDiggable = function()
		for _, value42 in list1.DIGGABLE_PATHS do
			local tbl16 = {}

			for match in string.gmatch(value42, "[^/]+") do
				table.insert(tbl16, match)
			end

			local obj41 = workspace

			for _, value43 in tbl16 do
				obj41 = obj41:FindFirstChild(value43)
				if obj41 then
					continue
				end
				break
			end

			if obj41 then
				return obj41
			end
		end

		return nil
	end

	list1.executeDig = function()
		if not list1.autoDigEnabled then
			return
		end
		local flag24 = list1.findValidDiggable()
		if not flag24 then
			return
		end
		local obj42 = list1.getDiggingTool()
		if not obj42 then
			return
		end

		if obj42.Parent ~= localPlayer.Character then
			obj42.Parent = localPlayer.Character
			task.wait(0.2)
		end

		local remoteEvent = obj42:FindFirstChild("RemoteEvent")
		if not remoteEvent then
			return
		end

		pcall(function()
			remoteEvent:FireServer("Dig", flag24, flag24.Position)
		end)
	end

	list1.autoDigLoop = function()
		while list1.autoDigEnabled do
			list1.executeDig()
			task.wait(0.01)
		end
	end

	list1.toggleAutoDig = function(autoDigEnabled)
		list1.autoDigEnabled = autoDigEnabled

		if autoDigEnabled then
			if list1.autoDigConnection then
				task.cancel(list1.autoDigConnection)
			end

			list1.autoDigConnection = task.spawn(list1.autoDigLoop)
			list1.notify(func5("自动挖雪已开启"), 2)
		else
			if list1.autoDigConnection then
				task.cancel(list1.autoDigConnection)
				list1.autoDigConnection = nil
			end

			list1.notify(func5("自动挖雪已关闭"), 2)
		end
	end

	list1.onCharacterAdded(function()
		if list1.autoDigEnabled then
			list1.autoDigEnabled = false

			if list1.autoDigConnection then
				task.cancel(list1.autoDigConnection)
				list1.autoDigConnection = nil
			end

			local autoDigToggle = toggles.AutoDigToggle

			if autoDigToggle and autoDigToggle.SetValue then
				autoDigToggle:SetValue(false)
			end
		end
	end)

	obj40:AddToggle("AutoDigToggle", {
		Text = "自动挖雪",
		Default = false,
		Tooltip = func6("自动挖掘雪堆（需要铲子）"),
		Callback = function(value)
			list1.toggleAutoDig(value)
		end,
	})

	list1.autoCollectEnabled = false
	list1.autoCollectConnection = nil
	list1.activePrompts = {}
	list1.descendantAddedConn = nil

	list1.setupAutoCollect = function()
		if list1.descendantAddedConn then
			list1.descendantAddedConn:Disconnect()
		end

		for _, getDescendant9 in workspace:GetDescendants() do
			if getDescendant9:IsA("ProximityPrompt") then
				list1.activePrompts[getDescendant9] = true
			end
		end

		list1.descendantAddedConn = workspace.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("ProximityPrompt") then
				list1.activePrompts[descendant] = true
			end
		end)

		list1.autoCollectConnection = obj5.Heartbeat:Connect(function()
			if not list1.autoCollectEnabled or not localPlayer.Character then
				return
			end
			local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return
			end

			for k in list1.activePrompts do
				if k and k.Parent and k:IsA("ProximityPrompt") and k.Enabled then
					local parent = k.Parent

					if parent:IsA("BasePart") then
						if (parent.Position - humanoidRootPart.Position).Magnitude <= k.MaxActivationDistance then
							pcall(function()
								fireproximityprompt(k)
							end)
						end
					end
				else
					list1.activePrompts[k] = nil
				end
			end
		end)
	end

	list1.toggleAutoCollect = function(autoCollectEnabled)
		list1.autoCollectEnabled = autoCollectEnabled

		if autoCollectEnabled then
			if list1.autoCollectConnection then
				list1.autoCollectConnection:Disconnect()
			end

			if list1.descendantAddedConn then
				list1.descendantAddedConn:Disconnect()
			end

			list1.activePrompts = {}
			list1.setupAutoCollect()
			list1.notify(func5("自动收集已开启"), 2)
		else
			if list1.autoCollectConnection then
				list1.autoCollectConnection:Disconnect()
				list1.autoCollectConnection = nil
			end

			if list1.descendantAddedConn then
				list1.descendantAddedConn:Disconnect()
				list1.descendantAddedConn = nil
			end

			list1.activePrompts = {}
			list1.notify(func5("自动收集已关闭"), 2)
		end
	end

	list1.onCharacterAdded(function()
		if list1.autoCollectEnabled then
			list1.autoCollectEnabled = false

			if list1.autoCollectConnection then
				list1.autoCollectConnection:Disconnect()
				list1.autoCollectConnection = nil
			end

			if list1.descendantAddedConn then
				list1.descendantAddedConn:Disconnect()
				list1.descendantAddedConn = nil
			end

			list1.activePrompts = {}
			local autoCollectToggle = toggles.AutoCollectToggle

			if autoCollectToggle and autoCollectToggle.SetValue then
				autoCollectToggle:SetValue(false)
			end
		end
	end)

	obj40:AddToggle("AutoCollectToggle", {
		Text = "自动收集",
		Default = false,
		Tooltip = func6("自动触发附近的收集提示（Kaub地图）"),
		Callback = function(value)
			list1.toggleAutoCollect(value)
		end,
	})

	if not list1.autoFeatures then
		list1.autoFeatures = {}
	end

	list1.autoFeatures.brickBreaker = list1.autoFeatures.brickBreaker or {
		active = false,
		thread = nil,
		cachedMap = nil,
		cachedWall = nil,
		cachedBricks = nil,
		lastRefresh = 0,
	}

	list1.getBrickBreakerTool = function()
		local character = localPlayer.Character
		if not character then
			return nil
		end

		for _, value44 in character:GetChildren() do
			if value44:IsA("Tool") and value44:FindFirstChild("RemoteEvent") then
				local obj43 = value44.Name:lower()
				if obj43:find("斧") or obj43:find("锤") or obj43:find("axe") or obj43:find("hammer") or obj43:find("sledge") or obj43:find("pickaxe") then
					return value44:FindFirstChild("RemoteEvent")
				end
			end
		end

		return nil
	end

	list1.getBrickWall = function()
		local result4 = clock()
		if result4 - list1.autoFeatures.brickBreaker.lastRefresh < 1 and list1.autoFeatures.brickBreaker.cachedWall then
			return list1.autoFeatures.brickBreaker.cachedBricks or {}, list1.autoFeatures.brickBreaker.cachedWall
		end
		list1.autoFeatures.brickBreaker.lastRefresh = result4
		local cachedMap = list1.autoFeatures.brickBreaker.cachedMap

		if not cachedMap or not cachedMap.Parent then
			local catacombesDeParis = workspace:FindFirstChild("Catacombes de Paris")

			if not catacombesDeParis then
				for _, value45 in workspace:GetChildren() do
					if value45.Name:lower():find("catacomb") then
						catacombesDeParis = value45
						break
					end
				end

				cachedMap = catacombesDeParis
			else
				cachedMap = catacombesDeParis
			end

			list1.autoFeatures.brickBreaker.cachedMap = cachedMap
		end

		if not cachedMap then
			return {}, nil
		end
		local brickwall = cachedMap:FindFirstChild("Modes") and cachedMap.Modes:FindFirstChild("Objective") and cachedMap.Modes.Objective:FindFirstChild("brickwall")
		if not brickwall then
			return {}, nil
		end
		local cachedBricks = {}

		for _, value46 in brickwall:GetChildren() do
			if value46:IsA("BasePart") then
				table.insert(cachedBricks, value46)
			end
		end

		list1.autoFeatures.brickBreaker.cachedBricks = cachedBricks
		list1.autoFeatures.brickBreaker.cachedWall = brickwall
		return cachedBricks, brickwall
	end

	list1.breakBrickOnce = function()
		local flag25 = list1.getBrickBreakerTool()
		if not flag25 then
			return
		end
		local list7, obj44 = list1.getBrickWall()
		if not obj44 or #list7 == 0 then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end

		if (humanoidRootPart.Position - obj44:GetPivot().Position).Magnitude > 10 then
			return
		end
		pcall(flag25.FireServer, flag25, "Swing", "Over")

		for i = 1, #list7, 25 do
			for i2 = i, min(i + 25 - 1, #list7) do
				pcall(flag25.FireServer, flag25, "HitBreakable", { list7[i2] }, Vector3.new(0.97238314, 0, -0.23338981))
			end

			task.wait(0.1)
		end
	end

	list1.brickBreakerLoop = function()
		while list1.autoFeatures.brickBreaker.active do
			list1.breakBrickOnce()
			task.wait(0.3)
		end
	end

	obj40:AddToggle("AutoBreakWallToggle", {
		Text = "自动砸砖墙",
		Tooltip = func6("巴黎地下墓穴自动砸砖墙"),
		Default = false,
		Callback = function(active)
			list1.autoFeatures.brickBreaker.active = active

			if active then
				if list1.autoFeatures.brickBreaker.thread then
					task.cancel(list1.autoFeatures.brickBreaker.thread)
				end

				list1.autoFeatures.brickBreaker.thread = task.spawn(list1.brickBreakerLoop)
				list1.notify(func5("自动砸砖墙已开启"), 2)
			else
				if list1.autoFeatures.brickBreaker.thread then
					task.cancel(list1.autoFeatures.brickBreaker.thread)
				end

				list1.autoFeatures.brickBreaker.thread = nil
				list1.autoFeatures.brickBreaker.cachedMap = nil
				list1.autoFeatures.brickBreaker.cachedWall = nil
				list1.autoFeatures.brickBreaker.cachedBricks = nil
				list1.notify(func5("自动砸砖墙已关闭"), 2)
			end
		end,
	})

	local autoBarrel = {
		enabled = false,
		thread = nil,
		markers = {},
		activeZone = nil,
		idx = 1,
		GetNil = function(param12, param13)
			local ok, result = pcall(function()
				return getnilinstances
			end)

			if not ok then
				return nil
			end

			for _, value47 in result() do
				if value47.Name ~= param12 then
					continue
				end

				local ok2, result2 = pcall(function()
					return value47:GetDebugId()
				end)

				if not ok2 or result2 == param13 then
					return value47
				end
			end

			return nil
		end,
		GetEvent = function()
			for _, value48 in { localPlayer.Character, localPlayer:FindFirstChild("Backpack") }, nil, nil do
				if value48 then
					for _, value49 in value48:GetChildren() do
						if value49:IsA("Tool") and value49:FindFirstChild("RemoteEvent") then
							return value49:FindFirstChild("RemoteEvent")
						end
					end
				end
			end

			local RemoteEvent = list1.autoBarrel.GetNil("RemoteEvent", "1_1065169")
			if RemoteEvent then
				return RemoteEvent
			end
			return nil
		end,
		FindAxe = function()
			for _, value50 in { localPlayer.Character, localPlayer:FindFirstChild("Backpack") }, nil, nil do
				if value50 then
					for _, value51 in value50:GetChildren() do
						if value51:IsA("Tool") and (value51.Name:find("斧") or value51.Name:find("Axe")) and value51:FindFirstChild("RemoteEvent") then
							return value51
						end
					end
				end
			end

			return nil
		end,
		EquipAxe = function(instance12)
			if instance12 and localPlayer.Character and instance12.Parent ~= localPlayer.Character then
				instance12.Parent = localPlayer.Character
			end
		end,
		UnequipAxe = function(instance13)
			if instance13 and localPlayer:FindFirstChild("Backpack") and instance13.Parent == localPlayer.Character then
				instance13.Parent = localPlayer.Backpack
			end
		end,
		CreateMarker = function(position, text)
			local part = Instance.new("Part")
			part.Size = Vector3.new(5, 0.2, 5)
			part.Position = position
			part.Anchored = true
			part.CanCollide = false
			part.Transparency = 0.3
			part.BrickColor = BrickColor.new("Bright red")
			part.Material = Enum.Material.Neon
			part.Parent = workspace
			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Parent = part
			billboardGui.Adornee = part
			billboardGui.Size = UDim2.new(0, 200, 0, 50)
			billboardGui.StudsOffset = Vector3.new(0, 3, 0)
			billboardGui.MaxDistance = 100
			billboardGui.AlwaysOnTop = true
			local textLabel = Instance.new("TextLabel")
			textLabel.Parent = billboardGui
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.Text = text
			textLabel.TextColor3 = Color3.new(1, 1, 1)
			textLabel.BackgroundTransparency = 1
			textLabel.TextStrokeTransparency = 0
			textLabel.Font = Enum.Font.SourceSansBold
			textLabel.TextSize = 20
			return part
		end,
	}

	local zones = {}

	local tbl17 = {
		name = "Sixth.Vat",
		markerPos = Vector3.new(-504, 84, -887),
		markerText = func5("站在这自动攻击"),
		getBarrel = function()
			for _, getDescendant10 in workspace:GetDescendants() do
				if getDescendant10.Name == "WeaponHitEvent" and getDescendant10:GetFullName():find("Sixth.Vat") then
					return getDescendant10
				end
			end

			return nil
		end,
		attacks = {
			{
				dir = Vector3.new(-500.75604, 84.927505, -890.66754),
				pos = Vector3.new(-0.89652354, 0.060126048, -0.43889672),
			},
			{
				dir = Vector3.new(-500.98862, 85.332466, -890.1306),
				pos = Vector3.new(-0.9041061, 0.06780118, -0.42189467),
			},
			{
				dir = Vector3.new(-501.20587, 88.09386, -885.5167),
				pos = Vector3.new(-0.9857517, 0.07103491, 0.15247163),
			},
			{
				dir = Vector3.new(-501.19708, 88.0306, -885.4305),
				pos = Vector3.new(-0.9857517, 0.07103491, 0.15247163),
			},
			{
				dir = Vector3.new(-501.08237, 85.746765, -883.75226),
				pos = Vector3.new(-0.9848724, 0.06706964, 0.15977508),
			},
			{
				dir = Vector3.new(-501.0717, 85.640114, -883.64154),
				pos = Vector3.new(-0.98487234, 0.067069635, 0.15977506),
			},
			{
				dir = Vector3.new(-501.14145, 85.49108, -884.00916),
				pos = Vector3.new(-0.9848723, 0.06706963, 0.15977503),
			},
			{
				dir = Vector3.new(-501.06598, 85.75685, -883.6555),
				pos = Vector3.new(-0.98487234, 0.067069635, 0.15977506),
			},
			{
				dir = Vector3.new(-500.78323, 85.59901, -890.52026),
				pos = Vector3.new(-0.8965356, 0.059777364, -0.4389197),
			},
			{
				dir = Vector3.new(-501.03415, 85.72296, -889.8983),
				pos = Vector3.new(-0.9848487, 0.06741139, -0.15977699),
			},
			{
				dir = Vector3.new(-501.09647, 85.69531, -889.52576),
				pos = Vector3.new(-0.9848487, 0.0674114, -0.15977699),
			},
			{
				dir = Vector3.new(-501.11978, 85.646645, -889.4025),
				pos = Vector3.new(-0.9848487, 0.06741139, -0.15977699),
			},
			{
				dir = Vector3.new(-501.16486, 85.47568, -889.19714),
				pos = Vector3.new(-0.98485446, 0.06732521, -0.15977794),
			},
			{
				dir = Vector3.new(-501.12622, 85.940796, -884.10394),
				pos = Vector3.new(-0.9848723, 0.067069635, 0.15977506),
			},
			{
				dir = Vector3.new(-501.1567, 85.96322, -884.3014),
				pos = Vector3.new(-0.9848723, 0.06706963, 0.15977506),
			},
			{
				dir = Vector3.new(-501.34366, 88.06598, -886.39453),
				pos = Vector3.new(-0.9857517, 0.07103491, 0.15247163),
			},
			{ dir = Vector3.new(-500.15363, 85.16352, -889.7227), pos = Vector3.new(0, 1, 0) },
			{
				dir = Vector3.new(-501.2279, 87.05052, -885.19653),
				pos = Vector3.new(-0.9848732, 0.067056514, 0.1597752),
			},
			{
				dir = Vector3.new(-500.1642, 85.16352, -889.6371),
				pos = Vector3.new(0, 0.99999994, 0),
			},
			{
				dir = Vector3.new(-501.29144, 88.43513, -886.2289),
				pos = Vector3.new(-0.985762, 0.07103563, 0.15240449),
			},
			{
				dir = Vector3.new(-501.23367, 88.04647, -887.66705),
				pos = Vector3.new(-0.98581445, 0.070850246, -0.15215096),
			},
			{
				dir = Vector3.new(-501.07944, 85.71344, -889.62317),
				pos = Vector3.new(-0.9848487, 0.06741139, -0.15977699),
			},
			{
				dir = Vector3.new(-501.16504, 85.38667, -889.23346),
				pos = Vector3.new(-0.98485446, 0.06732521, -0.15977794),
			},
			{
				dir = Vector3.new(-501.0604, 85.61904, -889.7803),
				pos = Vector3.new(-0.9848487, 0.0674114, -0.15977699),
			},
			{
				dir = Vector3.new(-501.24405, 88.32903, -887.4678),
				pos = Vector3.new(-0.98580045, 0.07084924, -0.15224236),
			},
			{
				dir = Vector3.new(-500.76483, 86.16497, -890.4764),
				pos = Vector3.new(-0.90410596, 0.06780121, -0.42189494),
			},
		},
	}

	local tbl18 = {
		name = "Fifth.Vat",
		markerPos = Vector3.new(-503, 84, -855),
		markerText = func5("站在这自动攻击"),
		getBarrel = function()
			local ok, result = pcall(function()
				local london = workspace:FindFirstChild("London")
				return london and london.Modes.Objective.PlantEvent.Vats.Fifth.Vat.Union
			end)

			if ok and result and result:FindFirstChild("WeaponHitEvent") then
				return result:FindFirstChild("WeaponHitEvent")
			end
			return list1.autoBarrel.GetNil("WeaponHitEvent", "1_1065268")
		end,
		attacks = {
			{
				dir = Vector3.new(-501.07547, 85.681076, -858.6612),
				pos = Vector3.new(-0.98484874, 0.0674114, -0.159777),
			},
			{
				dir = Vector3.new(-501.18845, 85.63276, -857.9856),
				pos = Vector3.new(-0.98485446, 0.067325205, -0.15977792),
			},
			{
				dir = Vector3.new(-501.4731, 85.29793, -856.372),
				pos = Vector3.new(-0.98492193, 0.06730186, -0.15937145),
			},
			{
				dir = Vector3.new(-500.92535, 85.855034, -852.1581),
				pos = Vector3.new(-0.90419996, 0.067528576, 0.42173722),
			},
			{
				dir = Vector3.new(-500.88934, 85.85879, -852.0815),
				pos = Vector3.new(-0.9041999, 0.067528576, 0.4217372),
			},
			{
				dir = Vector3.new(-501.176, 87.96922, -854.2655),
				pos = Vector3.new(-0.9857516, 0.07103491, 0.15247163),
			},
			{
				dir = Vector3.new(-501.03616, 85.97066, -852.56134),
				pos = Vector3.new(-0.98487234, 0.067069635, 0.15977506),
			},
			{
				dir = Vector3.new(-501.0589, 88.31807, -853.687),
				pos = Vector3.new(-0.9848724, 0.067069635, 0.15977506),
			},
			{ dir = Vector3.new(-499.66125, 85.16353, -853.49677), pos = Vector3.new(0, 1, 0) },
			{
				dir = Vector3.new(-501.037, 87.9361, -853.3915),
				pos = Vector3.new(-0.98487234, 0.067069635, 0.15977506),
			},
			{
				dir = Vector3.new(-500.39682, 85.50465, -854.4968),
				pos = Vector3.new(0.7061626, -0.05049091, -0.7062471),
			},
			{
				dir = Vector3.new(-500.93835, 85.88355, -852.19055),
				pos = Vector3.new(-0.90419996, 0.06752858, 0.42173725),
			},
			{
				dir = Vector3.new(-500.9397, 85.8612, -852.1898),
				pos = Vector3.new(-0.9041999, 0.067528576, 0.4217372),
			},
			{
				dir = Vector3.new(-501.0238, 85.66065, -852.35504),
				pos = Vector3.new(-0.98487234, 0.06706963, 0.15977505),
			},
			{
				dir = Vector3.new(-501.04617, 85.94073, -852.6105),
				pos = Vector3.new(-0.98487234, 0.06706963, 0.15977505),
			},
			{
				dir = Vector3.new(-500.78168, 85.65259, -851.8307),
				pos = Vector3.new(-0.8974282, 0.05971466, 0.43710032),
			},
			{
				dir = Vector3.new(-500.8728, 85.297035, -851.9692),
				pos = Vector3.new(-0.8974283, 0.059714667, 0.43710032),
			},
			{
				dir = Vector3.new(-501.1628, 84.407585, -855.2833),
				pos = Vector3.new(0.70647174, 0.04231629, -0.70647496),
			},
			{
				dir = Vector3.new(-499.37216, 84.492935, -857.3116),
				pos = Vector3.new(0.6035478, 0.5211642, 0.60342175),
			},
			{
				dir = Vector3.new(-501.2195, 88.377556, -854.73663),
				pos = Vector3.new(-0.98576206, 0.071035646, 0.15240449),
			},
			{
				dir = Vector3.new(-501.17966, 85.689224, -858.0156),
				pos = Vector3.new(-0.9848487, 0.06741139, -0.15977699),
			},
			{
				dir = Vector3.new(-501.1714, 85.6417, -858.0866),
				pos = Vector3.new(-0.98484874, 0.0674114, -0.159777),
			},
			{
				dir = Vector3.new(-501.17776, 85.642426, -858.04694),
				pos = Vector3.new(-0.9848487, 0.0674114, -0.159777),
			},
			{
				dir = Vector3.new(-501.07324, 85.03772, -858.94867),
				pos = Vector3.new(-0.9848843, 0.06680974, -0.15981026),
			},
			{
				dir = Vector3.new(-501.22708, 88.80728, -854.98596),
				pos = Vector3.new(-0.98576206, 0.07103564, 0.1524045),
			},
			{
				dir = Vector3.new(-501.07352, 85.897545, -858.58203),
				pos = Vector3.new(-0.98484874, 0.06741139, -0.15977699),
			},
		},
	}

	local tbl19 = {
		name = "Eleventh.Vat",
		markerPos = Vector3.new(-549, 86, -811),
		markerText = func5("站在这自动攻击"),
		getBarrel = function()
			local ok, result = pcall(function()
				return func4(workspace, "London", "Modes", "Objective", "PlantEvent", "Vats", "Eleventh", "Vat", "Union")
			end)

			if ok and result and result:FindFirstChild("WeaponHitEvent") then
				return result:FindFirstChild("WeaponHitEvent")
			end
			return list1.autoBarrel.GetNil("WeaponHitEvent", "1_1073300")
		end,
		attacks = {
			{
				dir = Vector3.new(-552.7838, 88.71797, -809.0079),
				pos = Vector3.new(0.98476565, 0.067194454, 0.16037914),
			},
			{
				dir = Vector3.new(-552.7044, 89.815094, -811.3433),
				pos = Vector3.new(0.9857639, 0.07104273, -0.15238886),
			},
			{
				dir = Vector3.new(-552.6829, 89.84794, -811.1889),
				pos = Vector3.new(0.98576397, 0.07104273, -0.15238887),
			},
			{
				dir = Vector3.new(-553.07263, 85.68813, -814.20605),
				pos = Vector3.new(0.90414244, -0.067688905, -0.4218347),
			},
			{
				dir = Vector3.new(-552.8813, 87.53904, -813.42303),
				pos = Vector3.new(0.9848784, 0.06709598, -0.15972693),
			},
			{
				dir = Vector3.new(-552.87427, 85.38809, -813.2256),
				pos = Vector3.new(0.98481035, -0.067274585, -0.16007093),
			},
			{
				dir = Vector3.new(-552.59705, 87.250275, -809.54016),
				pos = Vector3.new(0.98476404, 0.06718805, 0.16039178),
			},
			{
				dir = Vector3.new(-552.732, 87.07971, -808.63654),
				pos = Vector3.new(0.98478204, 0.06877595, 0.15960649),
			},
			{
				dir = Vector3.new(-552.6297, 87.18196, -809.311),
				pos = Vector3.new(0.98476565, 0.06719446, 0.16037914),
			},
			{
				dir = Vector3.new(-552.58185, 88.96362, -810.9475),
				pos = Vector3.new(0.98576397, 0.07104273, -0.15238887),
			},
			{
				dir = Vector3.new(-552.91504, 87.483086, -813.6546),
				pos = Vector3.new(0.9848784, 0.06709599, -0.15972693),
			},
			{
				dir = Vector3.new(-552.92816, 85.77101, -813.718),
				pos = Vector3.new(0.98481035, -0.06727458, -0.16007093),
			},
			{
				dir = Vector3.new(-552.77795, 88.10868, -808.78876),
				pos = Vector3.new(0.98476404, 0.06718804, 0.16039176),
			},
			{
				dir = Vector3.new(-552.76764, 88.29107, -808.92865),
				pos = Vector3.new(0.984764, 0.06718804, 0.16039175),
			},
			{
				dir = Vector3.new(-552.7499, 89.06903, -809.36346),
				pos = Vector3.new(0.984764, 0.06718804, 0.16039175),
			},
			{
				dir = Vector3.new(-552.751, 88.92, -809.2942),
				pos = Vector3.new(0.98476404, 0.06718804, 0.16039176),
			},
			{
				dir = Vector3.new(-552.653, 87.09329, -809.1295),
				pos = Vector3.new(0.98478204, 0.06877594, 0.15960647),
			},
			{
				dir = Vector3.new(-552.44196, 86.75629, -810.2867),
				pos = Vector3.new(0.984782, 0.06877593, 0.15960647),
			},
			{
				dir = Vector3.new(-552.9142, 85.77261, -813.6325),
				pos = Vector3.new(0.9848103, -0.06727458, -0.16007091),
			},
			{
				dir = Vector3.new(-552.76385, 87.46857, -812.7283),
				pos = Vector3.new(0.9848784, 0.06709598, -0.15972692),
			},
			{
				dir = Vector3.new(-552.9091, 86.100426, -813.73914),
				pos = Vector3.new(0.98481035, -0.067274585, -0.16007093),
			},
			{
				dir = Vector3.new(-552.8866, 85.23353, -813.23645),
				pos = Vector3.new(0.98481035, -0.067274585, -0.16007093),
			},
			{
				dir = Vector3.new(-552.6922, 84.79696, -809.4828),
				pos = Vector3.new(0.9848438, -0.06738122, 0.1598204),
			},
			{
				dir = Vector3.new(-552.7633, 86.98217, -808.4014),
				pos = Vector3.new(0.98483956, 0.067443065, 0.15981972),
			},
			{
				dir = Vector3.new(-552.69714, 86.88089, -808.76624),
				pos = Vector3.new(0.9848396, 0.06744306, 0.15981974),
			},
			{
				dir = Vector3.new(-552.7866, 89.133865, -812.1694),
				pos = Vector3.new(0.9848784, 0.06709599, -0.15972693),
			},
			{
				dir = Vector3.new(-552.7429, 87.9488, -812.3979),
				pos = Vector3.new(0.9848811, 0.06705528, -0.15972736),
			},
		},
	}

	local tbl20 = {
		name = "Eighth.Vat",
		markerPos = Vector3.new(-551, 73, -863),
		markerText = func5("站在这自动攻击"),
		getBarrel = function()
			local ok, result = pcall(function()
				local london = workspace:FindFirstChild("London")
				return london and london.Modes.Objective.PlantEvent.Vats.Eighth.Vat.Union
			end)

			if ok and result and result:FindFirstChild("WeaponHitEvent") then
				return result:FindFirstChild("WeaponHitEvent")
			end
			return list1.autoBarrel.GetNil("WeaponHitEvent", "1_1078763")
		end,
		attacks = {
			{
				dir = Vector3.new(-554.957, 74.623535, -861.18964),
				pos = Vector3.new(0.89145, -0.2004975, 0.40634662),
			},
			{
				dir = Vector3.new(-554.94885, 74.613556, -861.21246),
				pos = Vector3.new(0.89145005, -0.20049751, 0.40634665),
			},
			{
				dir = Vector3.new(-554.80457, 74.60722, -861.53204),
				pos = Vector3.new(0.89145, -0.20049748, 0.40634662),
			},
			{
				dir = Vector3.new(-554.8045, 74.65089, -861.5106),
				pos = Vector3.new(0.89145, -0.20049748, 0.4063466),
			},
			{
				dir = Vector3.new(-554.6135, 74.701675, -861.9043),
				pos = Vector3.new(0.8914683, -0.20056136, 0.40627486),
			},
			{
				dir = Vector3.new(-554.6528, 74.588844, -861.8741),
				pos = Vector3.new(0.89143723, -0.20055987, 0.40634373),
			},
			{
				dir = Vector3.new(-554.6643, 74.60165, -861.8426),
				pos = Vector3.new(0.89145, -0.20049746, 0.40634656),
			},
			{
				dir = Vector3.new(-554.6403, 74.7055, -861.8439),
				pos = Vector3.new(0.89145, -0.20049748, 0.4063466),
			},
			{
				dir = Vector3.new(-553.95575, 74.82688, -867.0438),
				pos = Vector3.new(0.96702576, -0.20930187, -0.14509974),
			},
			{
				dir = Vector3.new(-553.9352, 74.665886, -866.6744),
				pos = Vector3.new(0.9670257, -0.20930186, -0.14509976),
			},
			{
				dir = Vector3.new(-553.9174, 74.855194, -866.8293),
				pos = Vector3.new(0.9670257, -0.20930186, -0.14509974),
			},
			{
				dir = Vector3.new(-553.90857, 74.83263, -866.7375),
				pos = Vector3.new(0.9670257, -0.20930187, -0.14509974),
			},
			{
				dir = Vector3.new(-553.47955, 77.100334, -864.2589),
				pos = Vector3.new(0.9661953, -0.19930883, 0.16353197),
			},
			{
				dir = Vector3.new(-553.4386, 77.0082, -864.62286),
				pos = Vector3.new(0.96637833, -0.209183, 0.1495171),
			},
			{ dir = Vector3.new(-554.3455, 74.50676, -865.581), pos = Vector3.new(0, -1, 0) },
			{
				dir = Vector3.new(-553.6022, 76.671036, -864.05756),
				pos = Vector3.new(0.9661952, -0.19930883, 0.16353197),
			},
			{
				dir = Vector3.new(-553.59204, 76.67828, -864.1087),
				pos = Vector3.new(0.9661953, -0.19930881, 0.16353197),
			},
			{
				dir = Vector3.new(-554.0542, 74.54925, -867.2995),
				pos = Vector3.new(0.96702576, -0.20930187, -0.14509976),
			},
			{
				dir = Vector3.new(-554.0468, 74.52961, -867.2221),
				pos = Vector3.new(0.96702576, -0.20930187, -0.14509976),
			},
			{
				dir = Vector3.new(-553.8126, 74.88644, -866.1759),
				pos = Vector3.new(0.9670257, -0.20930184, -0.14509974),
			},
			{
				dir = Vector3.new(-553.8118, 74.88818, -866.1729),
				pos = Vector3.new(0.96702576, -0.20930187, -0.14509976),
			},
			{
				dir = Vector3.new(-553.91675, 74.664246, -866.5492),
				pos = Vector3.new(0.96702576, -0.20930189, -0.14509976),
			},
			{
				dir = Vector3.new(-554.6526, 74.563324, -861.8871),
				pos = Vector3.new(0.89145005, -0.2004975, 0.40634662),
			},
			{
				dir = Vector3.new(-554.6871, 74.51005, -861.8376),
				pos = Vector3.new(0.8914684, -0.20056139, 0.40627494),
			},
			{
				dir = Vector3.new(-553.98035, 74.56279, -866.8266),
				pos = Vector3.new(0.96702576, -0.20930187, -0.14509976),
			},
			{
				dir = Vector3.new(-553.9917, 74.51576, -866.8348),
				pos = Vector3.new(0.96702576, -0.20930187, -0.14509974),
			},
			{
				dir = Vector3.new(-553.4251, 77.44363, -864.1622),
				pos = Vector3.new(0.9661952, -0.1993088, 0.16353196),
			},
			{
				dir = Vector3.new(-554.6713, 74.7969, -861.7308),
				pos = Vector3.new(0.89145005, -0.20049754, 0.40634656),
			},
			{
				dir = Vector3.new(-553.3532, 77.73155, -864.236),
				pos = Vector3.new(0.9661952, -0.19930881, 0.16353197),
			},
			{
				dir = Vector3.new(-553.48865, 76.52338, -864.97766),
				pos = Vector3.new(0.96637833, -0.209183, 0.1495171),
			},
			{
				dir = Vector3.new(-554.21155, 74.735115, -862.81683),
				pos = Vector3.new(0.9661952, -0.19930878, 0.16353194),
			},
			{
				dir = Vector3.new(-554.95905, 74.62028, -861.1867),
				pos = Vector3.new(0.89145, -0.2004975, 0.40634665),
			},
		},
	}

	zones[1] = tbl17
	zones[2] = tbl18
	zones[3] = tbl19
	zones[4] = tbl20
	autoBarrel.zones = zones

	autoBarrel.ClearMarkers = function()
		for _, marker in list1.autoBarrel.markers do
			if marker and marker.Parent then
				marker:Destroy()
			end
		end

		list1.autoBarrel.markers = {}
	end

	autoBarrel.MainLoop = function()
		while list1.autoBarrel.enabled do
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")

			if character then
				local value52 = nil

				for _, zone in list1.autoBarrel.zones do
					local flag26 = zone.getBarrel()

					if flag26 and flag26.Parent then
						if (character.Position - zone.markerPos).Magnitude <= 7 then
							zone.barrelObj = flag26
							value52 = zone
							break
						else
							value52 = nil
						end
					else
						value52 = nil
					end
				end

				if value52 and list1.autoBarrel.activeZone ~= value52 then
					list1.autoBarrel.activeZone = value52
					list1.autoBarrel.idx = 1
					local value53 = list1.autoBarrel.FindAxe()

					if value53 then
						list1.autoBarrel.EquipAxe(value53)
						task.wait(0.3)
					end
				end

				if not value52 and list1.autoBarrel.activeZone then
					list1.autoBarrel.activeZone = nil
				end

				if list1.autoBarrel.activeZone and value52 then
					local value54 = list1.autoBarrel.GetEvent()

					if value54 then
						local activeZone = list1.autoBarrel.activeZone

						if not activeZone.barrelObj or not activeZone.barrelObj.Parent then
							activeZone.barrelObj = activeZone.getBarrel()
						end

						if activeZone.barrelObj and activeZone.barrelObj.Parent then
							local value55 = activeZone.attacks[list1.autoBarrel.idx]
							pcall(value54.FireServer, value54, "PrepareSwing")
							pcall(value54.FireServer, value54, "Swing", "Side")
							pcall(value54.FireServer, value54, "WeaponHitEvent", activeZone.barrelObj, value55.dir, value55.pos)
						end

						list1.autoBarrel.idx = list1.autoBarrel.idx + 1

						if #activeZone.attacks < list1.autoBarrel.idx then
							list1.autoBarrel.idx = 1
						end
					end
				end
			elseif list1.autoBarrel.activeZone then
				local value56 = list1.autoBarrel.FindAxe()

				if value56 then
					pcall(list1.autoBarrel.UnequipAxe, value56)
				end

				list1.autoBarrel.activeZone = nil
			end

			task.wait(0.1)
		end
	end

	autoBarrel.Start = function()
		if list1.autoBarrel.enabled then
			return
		end
		list1.autoBarrel.enabled = true
		list1.autoBarrel.ClearMarkers()

		for _, zone2 in list1.autoBarrel.zones do
			local value57 = list1.autoBarrel.CreateMarker(zone2.markerPos, zone2.markerText)
			table.insert(list1.autoBarrel.markers, value57)
		end

		if list1.autoBarrel.thread then
			task.cancel(list1.autoBarrel.thread)
		end

		list1.autoBarrel.thread = task.spawn(list1.autoBarrel.MainLoop)
		list1.notify(func5("自动打酒桶已开启"), 2)
	end

	autoBarrel.Stop = function()
		list1.autoBarrel.enabled = false

		if list1.autoBarrel.thread then
			task.cancel(list1.autoBarrel.thread)
			list1.autoBarrel.thread = nil
		end

		list1.autoBarrel.ClearMarkers()
		list1.autoBarrel.activeZone = nil
		list1.autoBarrel.idx = 1
		list1.notify(func5("自动打酒桶已关闭"), 2)
	end

	list1.autoBarrel = autoBarrel

	obj40:AddToggle("AutoBarrelToggle", {
		Text = "自动打酒桶",
		Default = false,
		Tooltip = func6("自动攻击伦敦酒桶"),
		Callback = function(value)
			if value then
				list1.autoBarrel.Start()
			else
				list1.autoBarrel.Stop()
			end
		end,
	})

	list1.autoWestminster = { enabled = false, thread = nil, AttackInterval = 0.1, AttackRange = 15, _tmp = {} }

	list1.autoWestminster.getTargetParts = function()
		list1.autoWestminster._tmp.west = workspace:FindFirstChild("Westminster")
		if not list1.autoWestminster._tmp.west then
			return {}
		end
		list1.autoWestminster._tmp.modes = list1.autoWestminster._tmp.west:FindFirstChild("Modes")
		if not list1.autoWestminster._tmp.modes then
			return {}
		end
		list1.autoWestminster._tmp.obj = list1.autoWestminster._tmp.modes:FindFirstChild("Objective")
		if not list1.autoWestminster._tmp.obj then
			return {}
		end
		list1.autoWestminster._tmp.barricade = list1.autoWestminster._tmp.obj:FindFirstChild("StreetBarricade")
		if not list1.autoWestminster._tmp.barricade then
			return {}
		end
		list1.autoWestminster._tmp.model = list1.autoWestminster._tmp.barricade:FindFirstChild("Model")
		if not list1.autoWestminster._tmp.model then
			return {}
		end
		list1.autoWestminster._tmp.boundingBox = list1.autoWestminster._tmp.model:FindFirstChild("BoundingBox")
		if not list1.autoWestminster._tmp.boundingBox then
			return {}
		end
		list1.autoWestminster._tmp.parts = {}

		if list1.autoWestminster._tmp.boundingBox:IsA("BasePart") then
			list1.autoWestminster._tmp.parts[#list1.autoWestminster._tmp.parts + 1] = list1.autoWestminster._tmp.boundingBox
		end

		list1.autoWestminster._tmp.children = list1.autoWestminster._tmp.boundingBox:GetDescendants()

		for i = 1, #list1.autoWestminster._tmp.children do
			if list1.autoWestminster._tmp.children[i]:IsA("BasePart") then
				list1.autoWestminster._tmp.parts[#list1.autoWestminster._tmp.parts + 1] = list1.autoWestminster._tmp.children[i]
			end
		end

		return list1.autoWestminster._tmp.parts
	end

	list1.autoWestminster.getNearestTarget = function(num4)
		list1.autoWestminster._tmp.parts = list1.autoWestminster.getTargetParts()
		list1.autoWestminster._tmp.bestPart = nil
		list1.autoWestminster._tmp.bestDist = list1.autoWestminster.AttackRange + 1

		for i = 1, #list1.autoWestminster._tmp.parts do
			list1.autoWestminster._tmp.dist = (list1.autoWestminster._tmp.parts[i].Position - num4).Magnitude

			if list1.autoWestminster._tmp.dist < list1.autoWestminster._tmp.bestDist then
				list1.autoWestminster._tmp.bestDist = list1.autoWestminster._tmp.dist
				list1.autoWestminster._tmp.bestPart = list1.autoWestminster._tmp.parts[i]
			end
		end

		if not list1.autoWestminster._tmp.bestPart then
			return nil, nil, nil, nil
		end
		list1.autoWestminster._tmp.hitPos = list1.autoWestminster._tmp.bestPart.Position
		list1.autoWestminster._tmp.normal = (num4 - list1.autoWestminster._tmp.hitPos).Unit
		return list1.autoWestminster._tmp.bestPart, list1.autoWestminster._tmp.hitPos, list1.autoWestminster._tmp.normal, list1.autoWestminster._tmp.bestDist
	end

	list1.autoWestminster.getCurrentWeaponRemote = function()
		return list1.getHeldToolRemote()
	end

	list1.autoWestminster.performAttack = function(obj45, param14, param15, param16)
		if not obj45 then
			return
		end
		obj45:FireServer("PrepareSwing")
		task.wait(0.02)
		obj45:FireServer("Swing", "Side")
		task.wait(0.02)
		obj45:FireServer("HitCon", param14, param15, param16)
	end

	list1.autoWestminster.attackLoop = function()
		while list1.autoWestminster.enabled do
			local tmp = list1.autoWestminster._tmp
			local tmp2 = list1.autoWestminster._tmp
			local value58, value59 = list1.autoWestminster.getCurrentWeaponRemote()
			tmp.remote = value58
			tmp2.weapon = value59

			if list1.autoWestminster._tmp.remote and list1.autoWestminster._tmp.weapon and localPlayer.Character then
				list1.autoWestminster._tmp.root = localPlayer.Character:FindFirstChild("HumanoidRootPart")

				if list1.autoWestminster._tmp.root then
					local tmp3 = list1.autoWestminster._tmp
					local tmp4 = list1.autoWestminster._tmp
					local tmp5 = list1.autoWestminster._tmp
					local tmp6 = list1.autoWestminster._tmp
					local value60, value61, value62, value63 = list1.autoWestminster.getNearestTarget(list1.autoWestminster._tmp.root.Position)
					tmp3.tPart = value60
					tmp4.hPos = value61
					tmp5.normal = value62
					tmp6.dist = value63

					if list1.autoWestminster._tmp.tPart and list1.autoWestminster._tmp.dist <= list1.autoWestminster.AttackRange then
						list1.autoWestminster.performAttack(list1.autoWestminster._tmp.remote, list1.autoWestminster._tmp.tPart, list1.autoWestminster._tmp.hPos, list1.autoWestminster._tmp.normal)
					end
				end
			end

			task.wait(list1.autoWestminster.AttackInterval)
		end
	end

	list1.autoWestminster.Start = function()
		if list1.autoWestminster.enabled then
			return
		end
		list1.autoWestminster.enabled = true

		if list1.autoWestminster.thread then
			task.cancel(list1.autoWestminster.thread)
		end

		list1.autoWestminster.thread = task.spawn(list1.autoWestminster.attackLoop)
		list1.notify(func5("自动打威斯特敏障碍已开启"), 2)
	end

	list1.autoWestminster.Stop = function()
		list1.autoWestminster.enabled = false

		if list1.autoWestminster.thread then
			task.cancel(list1.autoWestminster.thread)
			list1.autoWestminster.thread = nil
		end

		list1.notify(func5("自动打威斯特敏障碍已关闭"), 2)
	end

	obj40:AddToggle("AutoWestminsterToggle", {
		Text = "自动打威斯特敏障碍",
		Default = false,
		Tooltip = func6("自动攻击威斯特敏路障"),
		Callback = function(value)
			if value then
				list1.autoWestminster.Start()
			else
				list1.autoWestminster.Stop()
			end
		end,
	})

	list1.autoLeipzigBarricade = { enabled = false, thread = nil, AttackInterval = 0.3, _tmp = {} }

	list1.autoLeipzigBarricade.getTarget = function()
		list1.autoLeipzigBarricade._tmp.leipzig = workspace:FindFirstChild("Leipzig")
		if not list1.autoLeipzigBarricade._tmp.leipzig then
			return nil
		end
		list1.autoLeipzigBarricade._tmp.modes = list1.autoLeipzigBarricade._tmp.leipzig:FindFirstChild("Modes")
		if not list1.autoLeipzigBarricade._tmp.modes then
			return nil
		end
		list1.autoLeipzigBarricade._tmp.objective = list1.autoLeipzigBarricade._tmp.modes:FindFirstChild("Objective")
		if not list1.autoLeipzigBarricade._tmp.objective then
			return nil
		end
		list1.autoLeipzigBarricade._tmp.barricade = list1.autoLeipzigBarricade._tmp.objective:FindFirstChild("Barricade")
		if not list1.autoLeipzigBarricade._tmp.barricade then
			return nil
		end
		return list1.autoLeipzigBarricade._tmp.barricade:FindFirstChild("Hitbox")
	end

	list1.autoLeipzigBarricade.getCurrentWeaponRemote = function()
		return list1.getHeldToolRemote()
	end

	list1.autoLeipzigBarricade.performAttack = function(obj46, flag27)
		if not obj46 or not flag27 then
			return
		end
		list1.autoLeipzigBarricade._tmp.hitPos = Vector3.new(-154.15071, -6.2045636, -95.3622)
		list1.autoLeipzigBarricade._tmp.normal = Vector3.new(0.2588048, 0, 0.9659296)
		obj46:FireServer("PrepareSwing")
		task.wait(0.02)
		obj46:FireServer("Swing", "Side")
		task.wait(0.02)
		obj46:FireServer("HitCon", flag27, list1.autoLeipzigBarricade._tmp.hitPos, list1.autoLeipzigBarricade._tmp.normal)
	end

	list1.autoLeipzigBarricade.attackLoop = function()
		while list1.autoLeipzigBarricade.enabled do
			local tmp = list1.autoLeipzigBarricade._tmp
			local tmp2 = list1.autoLeipzigBarricade._tmp
			local value64, value65 = list1.autoLeipzigBarricade.getCurrentWeaponRemote()
			tmp.remote = value64
			tmp2.weapon = value65
			list1.autoLeipzigBarricade._tmp.target = list1.autoLeipzigBarricade.getTarget()

			if list1.autoLeipzigBarricade._tmp.remote and list1.autoLeipzigBarricade._tmp.target then
				list1.autoLeipzigBarricade.performAttack(list1.autoLeipzigBarricade._tmp.remote, list1.autoLeipzigBarricade._tmp.target)
			end

			task.wait(list1.autoLeipzigBarricade.AttackInterval)
		end
	end

	list1.autoLeipzigBarricade.Start = function()
		if list1.autoLeipzigBarricade.enabled then
			return
		end
		list1.autoLeipzigBarricade.enabled = true

		if list1.autoLeipzigBarricade.thread then
			task.cancel(list1.autoLeipzigBarricade.thread)
		end

		list1.autoLeipzigBarricade.thread = task.spawn(list1.autoLeipzigBarricade.attackLoop)
		list1.notify(func5("自动打莱比锡木板已开启"), 2)
	end

	list1.autoLeipzigBarricade.Stop = function()
		list1.autoLeipzigBarricade.enabled = false

		if list1.autoLeipzigBarricade.thread then
			task.cancel(list1.autoLeipzigBarricade.thread)
			list1.autoLeipzigBarricade.thread = nil
		end

		list1.notify(func5("自动打莱比锡木板已关闭"), 2)
	end

	obj40:AddToggle("AutoLeipzigToggle", {
		Text = "自动打莱比锡木板",
		Default = false,
		Tooltip = func6("自动攻击莱比锡木板"),
		Callback = function(value)
			if value then
				list1.autoLeipzigBarricade.Start()
			else
				list1.autoLeipzigBarricade.Stop()
			end
		end,
	})

	list1.autoCopenhagenGate = { enabled = false, thread = nil, AttackRange = 5, AttackInterval = 0.2, _tmp = {} }

	list1.autoCopenhagenGate.getTarget = function()
		list1.autoCopenhagenGate._tmp.copenhagen = workspace:FindFirstChild("Copenhagen")
		if not list1.autoCopenhagenGate._tmp.copenhagen then
			return nil
		end
		list1.autoCopenhagenGate._tmp.modes = list1.autoCopenhagenGate._tmp.copenhagen:FindFirstChild("Modes")
		if not list1.autoCopenhagenGate._tmp.modes then
			return nil
		end
		list1.autoCopenhagenGate._tmp.obj = list1.autoCopenhagenGate._tmp.modes:FindFirstChild("Objective")
		if not list1.autoCopenhagenGate._tmp.obj then
			return nil
		end
		list1.autoCopenhagenGate._tmp.gateObj = list1.autoCopenhagenGate._tmp.obj:FindFirstChild("GateObj")
		if not list1.autoCopenhagenGate._tmp.gateObj then
			return nil
		end
		list1.autoCopenhagenGate._tmp.gate = list1.autoCopenhagenGate._tmp.gateObj:FindFirstChild("Gate")
		if not list1.autoCopenhagenGate._tmp.gate then
			return nil
		end
		return list1.autoCopenhagenGate._tmp.gate:FindFirstChild("Lock")
	end

	list1.autoCopenhagenGate.getCurrentWeaponRemote = function()
		return list1.getHeldToolRemote()
	end

	list1.autoCopenhagenGate.performAttack = function(obj47, flag28)
		if not obj47 or not flag28 then
			return
		end
		list1.autoCopenhagenGate._tmp.hitPos = Vector3.new(62.246265, 9.197623, -45.4807)
		list1.autoCopenhagenGate._tmp.normal = Vector3.new(0.90587777, 0.03483456, -0.42210424)
		obj47:FireServer("PrepareSwing")
		task.wait(0.02)
		obj47:FireServer("Swing", "Thrust")
		task.wait(0.02)
		obj47:FireServer("HitCon", flag28, list1.autoCopenhagenGate._tmp.hitPos, list1.autoCopenhagenGate._tmp.normal)
	end

	list1.autoCopenhagenGate.attackLoop = function()
		while list1.autoCopenhagenGate.enabled do
			local tmp = list1.autoCopenhagenGate._tmp
			local tmp2 = list1.autoCopenhagenGate._tmp
			local value66, value67 = list1.autoCopenhagenGate.getCurrentWeaponRemote()
			tmp.remote = value66
			tmp2.weapon = value67
			list1.autoCopenhagenGate._tmp.target = list1.autoCopenhagenGate.getTarget()

			if list1.autoCopenhagenGate._tmp.remote and list1.autoCopenhagenGate._tmp.target then
				if localPlayer.Character then
					list1.autoCopenhagenGate._tmp.root = localPlayer.Character:FindFirstChild("HumanoidRootPart")

					if list1.autoCopenhagenGate._tmp.root then
						list1.autoCopenhagenGate._tmp.dist = (list1.autoCopenhagenGate._tmp.root.Position - list1.autoCopenhagenGate._tmp.target.Position).Magnitude

						if list1.autoCopenhagenGate._tmp.dist <= list1.autoCopenhagenGate.AttackRange then
							list1.autoCopenhagenGate.performAttack(list1.autoCopenhagenGate._tmp.remote, list1.autoCopenhagenGate._tmp.target)
						end
					end
				end
			end

			task.wait(list1.autoCopenhagenGate.AttackInterval)
		end
	end

	list1.autoCopenhagenGate.Start = function()
		if list1.autoCopenhagenGate.enabled then
			return
		end
		list1.autoCopenhagenGate.enabled = true

		if list1.autoCopenhagenGate.thread then
			task.cancel(list1.autoCopenhagenGate.thread)
		end

		list1.autoCopenhagenGate.thread = task.spawn(list1.autoCopenhagenGate.attackLoop)
		list1.notify(func5("自动打哥本哈根锁已开启"), 2)
	end

	list1.autoCopenhagenGate.Stop = function()
		list1.autoCopenhagenGate.enabled = false

		if list1.autoCopenhagenGate.thread then
			task.cancel(list1.autoCopenhagenGate.thread)
			list1.autoCopenhagenGate.thread = nil
		end

		list1.notify(func5("自动打哥本哈根锁已关闭"), 2)
	end

	obj40:AddToggle("AutoCopenhagenToggle", {
		Text = "自动打哥本哈根锁",
		Default = false,
		Tooltip = func6("自动攻击哥本哈根门锁"),
		Callback = function(value)
			if value then
				list1.autoCopenhagenGate.Start()
			else
				list1.autoCopenhagenGate.Stop()
			end
		end,
	})

	list1.autoCannon = { enabled = false, connection = nil, lastReloadTime = 0, reloadCooldown = 0.5 }

	list1.autoCannon.findNearestGun = function()
		local character = localPlayer.Character
		if not character or not character.Parent then
			return nil
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil
		end
		local huge = math.huge
		local value68 = nil

		for _, getDescendant11 in workspace:GetDescendants() do
			if getDescendant11.Name == "12 Pound Gun" and getDescendant11:IsA("Model") then
				local hole = getDescendant11:FindFirstChild("Gun") and getDescendant11.Gun:FindFirstChild("Hole")

				if hole then
					local magnitude = (hole.Position - humanoidRootPart.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						value68 = getDescendant11
					end
				end
			end
		end

		return value68
	end

	list1.autoCannon.reload = function()
		local result5 = clock()
		if result5 - list1.autoCannon.lastReloadTime < list1.autoCannon.reloadCooldown then
			return
		end
		local obj48 = list1.autoCannon.findNearestGun()

		if obj48 then
			local interact = obj48:FindFirstChild("Gun") and obj48.Gun:FindFirstChild("Hole") and obj48.Gun.Hole:FindFirstChild("Interact")

			if interact and interact:IsA("RemoteEvent") then
				interact:FireServer()
				list1.autoCannon.lastReloadTime = result5
			end
		end
	end

	list1.startAutoCannon = function()
		list1.stopAutoCannon()
		list1.autoCannon.enabled = true
		list1.autoCannon.connection = obj5.Heartbeat:Connect(list1.autoCannon.reload)
		list1.notify(func5("自动装填大炮已开启"), 2)
	end

	list1.stopAutoCannon = function()
		list1.autoCannon.enabled = false

		if list1.autoCannon.connection then
			list1.autoCannon.connection:Disconnect()
			list1.autoCannon.connection = nil
		end

		list1.notify(func5("自动装填大炮已关闭"), 2)
	end

	obj40:AddToggle("AutoCannonToggle", {
		Text = "自动装填大炮",
		Default = false,
		Tooltip = func6("自动装填最近的12磅炮"),
		Callback = function(value)
			if value then
				list1.startAutoCannon()
			else
				list1.stopAutoCannon()
			end
		end,
	})

	list1.autoBell = { enabled = false, conn = nil }

	list1.autoBell.start = function()
		if list1.autoBell.conn then
			return
		end
		list1.autoBell.enabled = true

		list1.autoBell.conn = obj5.Heartbeat:Connect(function()
			if not list1.autoBell.enabled then
				return
			end
			local leipzig = workspace:FindFirstChild("Leipzig")

			if leipzig and leipzig:FindFirstChild("Modes") then
				local modes = leipzig.Modes

				if modes:FindFirstChild("Objective") then
					local bellInteract = modes.Objective:FindFirstChild("BellInteract")

					if bellInteract and bellInteract:FindFirstChild("Interact") then
						pcall(function()
							bellInteract.Interact:FireServer()
						end)
					end
				end
			end
		end)
	end

	list1.autoBell.stop = function()
		list1.autoBell.enabled = false

		if list1.autoBell.conn then
			list1.autoBell.conn:Disconnect()
			list1.autoBell.conn = nil
		end
	end

	obj40:AddToggle("AutoBellToggle", {
		Text = "莱比锡自动拉铃",
		Default = false,
		Tooltip = func6("自动拉响莱比锡钟楼铃铛"),
		Callback = function(value)
			if value then
				list1.autoBell.start()
			else
				list1.autoBell.stop()
			end
		end,
	})

	list1.LondonBoardAuto = { enabled = false, heartbeat = nil, refPos = Vector3.new(-149.42, 31.08, -1354.9), range = 7 }

	list1.LondonBoardAuto.getWeaponRemote = function()
		return list1.getHeldToolRemote()
	end

	list1.LondonBoardAuto.cachedLeft = nil
	list1.LondonBoardAuto.cachedRight = nil

	local function func26()
		local cachedLeft = list1.LondonBoardAuto.cachedLeft
		local cachedRight = list1.LondonBoardAuto.cachedRight
		if cachedLeft and cachedRight and cachedLeft.Parent and cachedRight.Parent then
			return cachedLeft, cachedRight
		end

		local ok, cachedLeft2, cachedRight2 = pcall(function()
			local london = workspace:FindFirstChild("London")
			if not london then
				return nil, nil
			end
			return london.Modes.Objective.SniperSection.BarricadedDoors.Left.Boards, london.Modes.Objective.SniperSection.BarricadedDoors.Right.Boards
		end)

		if not ok then
			return nil, nil
		end
		list1.LondonBoardAuto.cachedLeft = cachedLeft2
		list1.LondonBoardAuto.cachedRight = cachedRight2
		return cachedLeft2, cachedRight2
	end

	list1.LondonBoardAuto.execute = function()
		if not list1.LondonBoardAuto.enabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart or (humanoidRootPart.Position - list1.LondonBoardAuto.refPos).Magnitude > list1.LondonBoardAuto.range then
			return
		end
		local obj49 = list1.LondonBoardAuto.getWeaponRemote()
		if not obj49 then
			return
		end
		local obj50, obj51 = func26()
		if not obj50 or not obj51 then
			return
		end

		for _, value69 in {
			function()
				obj49:FireServer("PrepareSwing")
			end,
			function()
				obj49:FireServer("Swing", "Over")
			end,
			function()
				obj49:FireServer("HitCon", obj50:GetChildren()[2], Vector3.new(-149.42076, 31.076683, -1354.8972), Vector3.new(-2.0772219e-05, 1, 7.6293945e-05))
			end,
			function()
				obj49:FireServer("HitCon", obj51:GetChildren()[2], Vector3.new(-145.23814, 33.006237, -1366.2483), Vector3.new(0.9428723, 7.6293945e-05, 0.33315423))
			end,
			function()
				obj49:FireServer("HitCon", obj50:GetChildren()[2], Vector3.new(-149.55505, 29.676874, -1354.6289), Vector3.new(-0.9428972, 5.841255e-06, -0.33308378))
			end,
			function()
				obj49:FireServer("HitCon", obj50:GetChildren()[2], Vector3.new(-149.55505, 29.676874, -1354.6289), Vector3.new(-0.9428972, 5.841255e-06, -0.33308378))
			end,
			function()
				obj49:FireServer("HitCon", obj50:GetChildren()[2], Vector3.new(-150.2777, 29.679218, -1351.9828), Vector3.new(0.9428972, -5.841255e-06, 0.33308378))
			end,
			function()
				obj49:FireServer("HitCon", obj51:GetChildren()[2], Vector3.new(-146.18898, 32.863514, -1363.5574), Vector3.new(0.9428723, 7.6293945e-05, 0.33315423))
			end,
		}, nil, nil do
			pcall(value69)
		end
	end

	list1.LondonBoardAuto.start = function()
		if list1.LondonBoardAuto.thread then
			return
		end
		list1.LondonBoardAuto.enabled = true

		list1.LondonBoardAuto.thread = task.spawn(function()
			while list1.LondonBoardAuto.enabled do
				list1.LondonBoardAuto.execute()
				task.wait(0.1)
			end
		end)
	end

	list1.LondonBoardAuto.stop = function()
		list1.LondonBoardAuto.enabled = false

		if list1.LondonBoardAuto.thread then
			task.cancel(list1.LondonBoardAuto.thread)
			list1.LondonBoardAuto.thread = nil
		end
	end

	obj40:AddToggle("LondonBoardToggle", {
		Text = "自动打伦敦四块木板",
		Default = false,
		Tooltip = func6("自动攻击伦敦狙神处四块木板"),
		Callback = function(value)
			if value then
				list1.LondonBoardAuto.start()
			else
				list1.LondonBoardAuto.stop()
			end
		end,
	})

	list1.autoBandage = { enabled = false, thread = nil, cooldown = 0, healedOnce = false }

	list1.autoBandage.getHealth = function()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		return humanoid and humanoid.Health or 0
	end

	list1.autoBandage.getMaxHealth = function()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		return humanoid and humanoid.MaxHealth or 100
	end

	list1.autoBandage.findBandage = function()
		local character = localPlayer.Character

		if character then
			for _, value70 in character:GetChildren() do
				if value70:IsA("Tool") and value70.Name:lower():find("bandage") then
					return value70
				end
			end
		end

		local backpack = localPlayer:FindFirstChild("Backpack")

		if backpack then
			for _, value71 in backpack:GetChildren() do
				if value71:IsA("Tool") and value71.Name:lower():find("bandage") then
					return value71
				end
			end
		end

		return nil
	end

	list1.autoBandage.zombieNear = function(num5, param17)
		for _, value72 in { "Zombies", "Camera" }, nil, nil do
			local obj52 = workspace:FindFirstChild(value72)

			if obj52 then
				for _, getDescendant12 in obj52:GetDescendants() do
					if getDescendant12:IsA("Model") and getDescendant12.Name == "m_Zombie" then
						local humanoidRootPart = getDescendant12:FindFirstChild("HumanoidRootPart")
						if humanoidRootPart and (humanoidRootPart.Position - num5).Magnitude <= param17 then
							return true
						end
					end
				end
			end
		end

		return false
	end

	list1.autoBandage.loop = function()
		while list1.autoBandage.enabled do
			task.wait(0.5)
			local num6 = list1.autoBandage.getHealth()
			local num7 = list1.autoBandage.getMaxHealth()
			local n = num6 / num7 * 100

			if num7 <= num6 then
				list1.autoBandage.healedOnce = false
			else
				if n < 50 then
					list1.autoBandage.healedOnce = false
				end

				if not (list1.autoBandage.healedOnce and n >= 50) then
					local character = localPlayer.Character
					local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

					if not (humanoidRootPart and list1.autoBandage.zombieNear(humanoidRootPart.Position, 5)) then
						local obj53 = list1.autoBandage.findBandage()

						if obj53 then
							local cooldown = list1.autoBandage.cooldown

							if not (clock() - cooldown < 1) then
								list1.autoBandage.cooldown = clock()

								if obj53.Parent ~= character then
									pcall(function()
										obj53.Parent = character
									end)

									task.wait(0.3)
								end

								local remoteEvent = obj53:FindFirstChild("RemoteEvent")

								if remoteEvent then
									pcall(function()
										remoteEvent:FireServer()
									end)

									list1.autoBandage.healedOnce = true
								end

								task.wait(1)
							end
						end
					end
				end
			end
		end
	end

	list1.autoBandage.start = function()
		if list1.autoBandage.thread then
			return
		end
		list1.autoBandage.enabled = true
		list1.autoBandage.healedOnce = false
		list1.autoBandage.thread = task.spawn(list1.autoBandage.loop)
	end

	list1.autoBandage.stop = function()
		list1.autoBandage.enabled = false
		list1.autoBandage.healedOnce = false

		if list1.autoBandage.thread then
			task.cancel(list1.autoBandage.thread)
			list1.autoBandage.thread = nil
		end
	end

	obj40:AddToggle("AutoBandageToggle", {
		Text = "自动打绷带",
		Default = false,
		Tooltip = func6("血量低于75%时自动使用绷带（仅一次，低于50%重置）"),
		Callback = function(value)
			if value then
				list1.autoBandage.start()
			else
				list1.autoBandage.stop()
			end
		end,
	})

	list1.autoWatch = { enabled = false, thread = nil, range = 5, done = false }

	list1.autoWatch.getModelPos = function(obj54)
		local pivot = obj54:GetPivot()
		if pivot then
			return pivot.Position
		end

		for _, getDescendant13 in obj54:GetDescendants() do
			if getDescendant13:IsA("BasePart") then
				return getDescendant13.Position
			end
		end

		return nil
	end

	list1.autoWatch.getHRP = function()
		local character = localPlayer.Character
		return character and character:FindFirstChild("HumanoidRootPart")
	end

	list1.autoWatch.loop = function()
		list1.autoWatch.done = false

		while list1.autoWatch.enabled and not list1.autoWatch.done do
			task.wait(0.2)
			local num8 = list1.autoWatch.getHRP()

			if not num8 then
				task.wait(0.5)
			else
				local westminster = workspace:FindFirstChild("Westminster")

				if westminster then
					local modes = westminster:FindFirstChild("Modes")

					if modes then
						local objective = modes:FindFirstChild("Objective")

						if objective then
							local wellingtonScene = objective:FindFirstChild("WellingtonScene")

							if wellingtonScene then
								local pocketWatch = wellingtonScene:FindFirstChild("Pocket Watch")

								if pocketWatch then
									local proximityPrompt = pocketWatch:FindFirstChild("ProximityPrompt")

									if proximityPrompt and proximityPrompt:IsA("ProximityPrompt") and proximityPrompt.Enabled then
										local num9 = list1.autoWatch.getModelPos(pocketWatch)

										if num9 and (num9 - num8.Position).Magnitude <= list1.autoWatch.range then
											pcall(function()
												fireproximityprompt(proximityPrompt)
											end)

											if proximityPrompt.HoldDuration > 0 then
												for i = 1, 50 do
													pcall(function()
														fireproximityprompt(proximityPrompt)
													end)

													task.wait(0.01)
												end
											end
										end
									end
								else
									list1.autoWatch.done = true

									pcall(function()
										list1.notify(func5("自动拿怀表已完成"), 2)
									end)
								end
							end
						end
					end
				end
			end
		end

		if list1.autoWatch.done then
			list1.autoWatch.enabled = false
			list1.autoWatch.thread = nil
		end
	end

	list1.autoWatch.start = function()
		if list1.autoWatch.thread then
			return
		end
		list1.autoWatch.enabled = true
		list1.autoWatch.done = false
		list1.autoWatch.thread = task.spawn(list1.autoWatch.loop)
	end

	list1.autoWatch.stop = function()
		list1.autoWatch.enabled = false
		list1.autoWatch.done = false

		if list1.autoWatch.thread then
			task.cancel(list1.autoWatch.thread)
			list1.autoWatch.thread = nil
		end
	end

	obj40:AddToggle("AutoWatchToggle", {
		Text = "自动拿怀表",
		Default = false,
		Tooltip = func6("自动拾取威斯敏斯特怀表"),
		Callback = function(value)
			if value then
				list1.autoWatch.start()
			else
				list1.autoWatch.stop()
			end
		end,
	})

	list1.autoFlag = { enabled = false, thread = nil, range = 5, done = false }

	list1.autoFlag.getHRP = function()
		return list1.autoWatch.getHRP()
	end

	list1.autoFlag.getModelPos = function(param18)
		return list1.autoWatch.getModelPos(param18)
	end

	list1.autoFlag.loop = function()
		list1.autoFlag.done = false

		while list1.autoFlag.enabled and not list1.autoFlag.done do
			task.wait(0.3)
			local num10 = list1.autoFlag.getHRP()

			if not num10 then
				task.wait(0.5)
			else
				local exitTo = nil

				for _, getDescendant14 in workspace:GetDescendants() do
					if getDescendant14:IsA("ProximityPrompt") and getDescendant14.Enabled then
						local parent = getDescendant14.Parent

						if parent and parent.Name == "Standard" and parent:IsA("Model") then
							local num11 = list1.autoFlag.getModelPos(parent)
							if num11 and (num11 - num10.Position).Magnitude <= list1.autoFlag.range then
								exitTo = 1
								break
							end
						end
					end
				end

				if exitTo == 1 then
					for i = 1, 25 do
						if s4.Enabled then
							pcall(function()
								fireproximityprompt(s4)
							end)

							if s4.HoldDuration > 0 then
								for i2 = 1, 30 do
									pcall(function()
										fireproximityprompt(s4)
									end)

									task.wait(0.01)
								end
							end

							task.wait(0.2)
							continue
						end

						break
					end

					list1.autoFlag.done = true

					pcall(function()
						list1.notify(func5("自动抢旗杆已完成"), 2)
					end)
				end
			end
		end

		if list1.autoFlag.done then
			list1.autoFlag.enabled = false
			list1.autoFlag.thread = nil
		end
	end

	list1.autoFlag.start = function()
		if list1.autoFlag.thread then
			return
		end
		list1.autoFlag.enabled = true
		list1.autoFlag.done = false
		list1.autoFlag.thread = task.spawn(list1.autoFlag.loop)
	end

	list1.autoFlag.stop = function()
		list1.autoFlag.enabled = false
		list1.autoFlag.done = false

		if list1.autoFlag.thread then
			task.cancel(list1.autoFlag.thread)
			list1.autoFlag.thread = nil
		end
	end

	obj40:AddToggle("AutoFlagToggle", {
		Text = "自动抢旗杆",
		Default = false,
		Tooltip = func6("自动拾取威斯敏斯特旗杆"),
		Callback = function(value)
			if value then
				list1.autoFlag.start()
			else
				list1.autoFlag.stop()
			end
		end,
	})

	list1.autoAttackDoor = { enabled = false, thread = nil, range = 10, attackCooldown = 0.3 }

	list1.autoAttackDoor.getWeaponRemote = function()
		return list1.getHeldToolRemote()
	end

	list1.autoAttackDoor.findTargets = function()
		local character = localPlayer.Character
		if not character then
			return {}
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return {}
		end
		local position = humanoidRootPart.Position
		local tbl21 = {}
		local tbl22 = {}

		for _, getDescendant15 in workspace:GetDescendants() do
			if getDescendant15:IsA("BasePart") and getDescendant15.CanQuery ~= false and getDescendant15.Parent then
				local magnitude = (getDescendant15.Position - position).Magnitude

				if magnitude <= list1.autoAttackDoor.range then
					local obj55 = getDescendant15.Name:upper()

					if getDescendant15.Name == "Main" or obj55:find("DOOR") or obj55:find("GATE") then
						local str4 = tostring(getDescendant15)

						if not tbl22[str4] then
							tbl22[str4] = true
							table.insert(tbl21, { part = getDescendant15, dist = magnitude })
						end
					end
				end
			end
		end

		table.sort(tbl21, function(param19, param20)
			return param19.dist < param20.dist
		end)

		return tbl21
	end

	list1.autoAttackDoor.loop = function()
		while list1.autoAttackDoor.enabled do
			local autoAttackDo = list1.autoAttackDoor.getWeaponRemote()

			if autoAttackDo and localPlayer.Character then
				local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					local autoAttackDo2 = list1.autoAttackDoor.findTargets()

					if #autoAttackDo2 > 0 then
						local first1 = autoAttackDo2[1]
						local position = first1.part.Position
						local unit = (humanoidRootPart.Position - position).Unit

						pcall(function()
							autoAttackDo:FireServer("PrepareSwing")
							task.wait(0.02)
							autoAttackDo:FireServer("Swing", "Side")
							task.wait(0.02)
							autoAttackDo:FireServer("HitCon", first1.part, position, unit)
						end)

						task.wait(list1.autoAttackDoor.attackCooldown)
					end
				end
			end

			task.wait(0.1)
		end
	end

	list1.autoAttackDoor.start = function()
		if list1.autoAttackDoor.thread then
			return
		end
		list1.autoAttackDoor.enabled = true
		list1.autoAttackDoor.thread = task.spawn(list1.autoAttackDoor.loop)
	end

	list1.autoAttackDoor.stop = function()
		list1.autoAttackDoor.enabled = false

		if list1.autoAttackDoor.thread then
			task.cancel(list1.autoAttackDoor.thread)
			list1.autoAttackDoor.thread = nil
		end
	end

	obj40:AddToggle("AutoAttackDoorToggle", {
		Text = "自动攻击门",
		Default = false,
		Tooltip = func6("自动攻击附近的门"),
		Callback = function(value)
			if value then
				list1.autoAttackDoor.start()
			else
				list1.autoAttackDoor.stop()
			end
		end,
	})

	list1.autoFindDoctor = {
		enabled = false,
		thread = nil,
		threshold = 40,
		teleportCount = 0,
		maxTeleports = 2,
		prevHP = 100,
		trigger = 50,
	}

	list1.autoFindDoctor.getHRP = function(instance14)
		return instance14 and instance14:FindFirstChild("HumanoidRootPart")
	end

	list1.autoFindDoctor.getHealth = function()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		return humanoid and humanoid.Health or 0
	end

	list1.autoFindDoctor.getMaxHealth = function()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		return humanoid and humanoid.MaxHealth or 100
	end

	list1.autoFindDoctor.isDoctor = function(obj)
		if obj == localPlayer then
			return false
		end

		if obj:GetAttribute("CurrentClass") == "Surgeon" then
			return true
		end
		local character = obj.Character

		if character then
			if character:GetAttribute("CurrentClass") == "Surgeon" then
				return true
			end

			if character:FindFirstChild("MedicalSupplies") then
				return true
			end

			if character:FindFirstChild("Meter") then
				return true
			end
		end

		return false
	end

	list1.autoFindDoctor.hasSupplies = function(obj)
		local character = obj.Character
		if not character then
			return false
		end
		local meter = character:FindFirstChild("Meter")
		return meter and meter.Value > 0 or false
	end

	list1.autoFindDoctor.findNearestDoctor = function(num12)
		local n = 999
		local value73 = nil

		for _, getPlayer2 in obj4:GetPlayers() do
			if not (not list1.autoFindDoctor.isDoctor(getPlayer2) or not list1.autoFindDoctor.hasSupplies(getPlayer2)) then
				local character = getPlayer2.Character
				character = character and list1.autoFindDoctor.getHRP(character)

				if character then
					local magnitude = (character.Position - num12).Magnitude

					if magnitude < n then
						n = magnitude
						value73 = getPlayer2
					end
				end
			end
		end

		return value73, n
	end

	list1.autoFindDoctor.teleportToDoctor = function(obj)
		local character = obj.Character
		local num13 = character and list1.autoFindDoctor.getHRP(character)
		if not num13 then
			return false
		end
		local character2 = localPlayer.Character
		character2 = character2 and list1.autoFindDoctor.getHRP(character2)
		if not character2 then
			return false
		end
		local n = num13.Position + num13.CFrame.LookVector * 2 + Vector3.new(0, 1, 0)
		if not pcall(function()
			character2.CFrame = cframe(n)
		end) then
			return false
		end
		local n2 = clock() + 1

		while clock() < n2 do
			local character3 = localPlayer.Character
			character3 = character3 and list1.autoFindDoctor.getHRP(character3)

			if character3 then
				pcall(function()
					character3.CFrame = cframe(n)
				end)
			end

			task.wait()
		end

		return true
	end

	list1.autoFindDoctor.loop = function()
		list1.autoFindDoctor.teleportCount = 0
		list1.autoFindDoctor.prevHP = 100
		list1.autoFindDoctor.trigger = list1.autoFindDoctor.threshold + 10

		while list1.autoFindDoctor.enabled do
			task.wait(1)
			local character = localPlayer.Character
			local flag29 = character and list1.autoFindDoctor.getHRP(character)

			if not flag29 then
				list1.autoFindDoctor.teleportCount = 0
				list1.autoFindDoctor.prevHP = 100
			else
				local autoFindDoct = list1.autoFindDoctor.getHealth()
				local n = autoFindDoct / list1.autoFindDoctor.getMaxHealth() * 100

				if n >= list1.autoFindDoctor.trigger then
					if list1.autoFindDoctor.teleportCount > 0 then
						print("[自动找医生] 血量恢复(" .. floor(n) .. "%)，重置")
					end

					list1.autoFindDoctor.teleportCount = 0
					list1.autoFindDoctor.prevHP = autoFindDoct
				elseif n < list1.autoFindDoctor.threshold then
					if autoFindDoct > list1.autoFindDoctor.prevHP then
						list1.autoFindDoctor.teleportCount = 0
						list1.autoFindDoctor.prevHP = autoFindDoct
					else
						local flag30, value74 = list1.autoFindDoctor.findNearestDoctor(flag29.Position)

						if not flag30 then
							list1.autoFindDoctor.prevHP = autoFindDoct
						elseif value74 <= 20 then
							list1.autoFindDoctor.teleportCount = 0
							list1.autoFindDoctor.prevHP = autoFindDoct
						else
							if list1.autoFindDoctor.teleportCount < list1.autoFindDoctor.maxTeleports then
								list1.autoFindDoctor.teleportCount = list1.autoFindDoctor.teleportCount + 1

								if not list1.autoFindDoctor.teleportToDoctor(flag30) then
									list1.autoFindDoctor.teleportCount = list1.autoFindDoctor.teleportCount - 1
								end
							end

							list1.autoFindDoctor.prevHP = autoFindDoct
						end
					end
				else
					if list1.autoFindDoctor.teleportCount > 0 and n >= list1.autoFindDoctor.threshold and n < list1.autoFindDoctor.trigger then
						if autoFindDoct > list1.autoFindDoctor.prevHP then
							list1.autoFindDoctor.teleportCount = 0
						end
					end

					list1.autoFindDoctor.prevHP = autoFindDoct
				end
			end
		end
	end

	list1.autoFindDoctor.start = function()
		if list1.autoFindDoctor.thread then
			return
		end
		list1.autoFindDoctor.enabled = true
		list1.autoFindDoctor.teleportCount = 0
		list1.autoFindDoctor.prevHP = 100
		list1.autoFindDoctor.trigger = list1.autoFindDoctor.threshold + 10
		list1.autoFindDoctor.thread = task.spawn(list1.autoFindDoctor.loop)
	end

	list1.autoFindDoctor.stop = function()
		list1.autoFindDoctor.enabled = false

		if list1.autoFindDoctor.thread then
			task.cancel(list1.autoFindDoctor.thread)
			list1.autoFindDoctor.thread = nil
		end

		list1.autoFindDoctor.teleportCount = 0
		list1.autoFindDoctor.prevHP = 100
	end

	obj40:AddToggle("AutoFindDoctorToggle", {
		Text = "自动找医生",
		Default = false,
		Tooltip = func6("血量低于阈值（默认40%）且还在掉血时传送至医生"),
		Callback = function(value)
			if value then
				list1.autoFindDoctor.start()
			else
				list1.autoFindDoctor.stop()
			end
		end,
	})

	obj40:AddSlider("DoctorThreshold", {
		Text = "找医生血量阈值 (%)",
		Default = 40,
		Min = 1,
		Max = 100,
		Suffix = "%",
		Callback = function(threshold)
			list1.autoFindDoctor.threshold = threshold
			list1.autoFindDoctor.trigger = threshold + 10
		end,
	})

	obj40:AddToggle("AutoHelpToggle", {
		Text = "自动求救",
		Default = false,
		Tooltip = func6("血量低于80%时自动发送语音求助"),
		Callback = function(value)
			if value then
				list1.autoHelp.start()
			else
				list1.autoHelp.stop()
			end
		end,
	})

	list1.autoDoorEnabled = false
	list1.autoDoorThread = nil
	list1.processingDoors = {}

	list1.autoDoorLoop = function()
		while list1.autoDoorEnabled do
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")

			if character then
				for _, getDescendant16 in workspace:GetDescendants() do
					if getDescendant16.Name == "Main" and getDescendant16:IsA("Model") then
						local ok, result = pcall(function()
							return getDescendant16:GetPivot()
						end)

						if ok and result and (character.Position - result.Position).Magnitude <= 23 then
							local attribute = getDescendant16:GetAttribute("Open")

							if attribute == nil then
								pcall(function()
									attribute = getDescendant16.Open
								end)
							end

							if attribute == false then
								local main = getDescendant16:FindFirstChild("Main")
								local interact = main and main:FindFirstChild("Interact")

								if interact and interact:IsA("RemoteEvent") and not list1.processingDoors[getDescendant16] then
									list1.processingDoors[getDescendant16] = true

									task.spawn(function()
										interact:FireServer()
										task.wait(0)
										list1.processingDoors[getDescendant16] = nil
									end)
								end
							end
						end
					end
				end
			end

			task.wait(0)
		end
	end

	list1.toggleAutoDoor = function(autoDoorEnabled)
		list1.autoDoorEnabled = autoDoorEnabled

		if autoDoorEnabled then
			if not list1.autoDoorThread then
				list1.autoDoorThread = task.spawn(list1.autoDoorLoop)
			end
		elseif list1.autoDoorThread then
			task.cancel(list1.autoDoorThread)
			list1.autoDoorThread = nil
		end
	end

	obj40:AddToggle("AutoDoorToggle", {
		Text = "自动开门",
		Default = false,
		Tooltip = func6("自动开启附近场景中的门（适用于所有地图）"),
		Callback = function(value)
			list1.toggleAutoDoor(value)
		end,
	})
end

list1.waveNum = 1

list1.sendChatCmd = function(payload)
	if not pcall(function()
		func1(game:GetService("TextChatService")):FindFirstChild("TextChannels").RBXGeneral:SendAsync(payload)
	end) then
		local events = obj7:FindFirstChild("Events")
		local chatUpdate = events and events:FindFirstChild("ChatUpdate")

		if chatUpdate then
			pcall(function()
				chatUpdate:FireServer(payload)
			end)
		end
	end
end

local list8
list8 = { _velHistory = {} }
local obj56 = tbl2.AutoFunc:AddGroupbox({ Side = "Right", Name = "PVP 功能", IconName = "swords", Description = "战斗辅助" })

obj56:AddToggle("PvpAimbotToggle", {
	Text = "开启自瞄",
	Default = false,
	Callback = function(value)
		if list8 and list8.toggle then
			list8.toggle(value)
		end
	end,
})

obj56:AddToggle("PvpSilentToggle", {
	Text = "启用静默",
	Default = false,
	Callback = function(silentMode)
		list8.silentMode = silentMode

		if list8.aimEnabled then
			if silentMode then
				list8.setupSilentHook()
			else
				list8.removeSilentHook()
			end
		end
	end,
})

obj56:AddDropdown("PvpAimPart", {
	Text = "瞄准部位",
	Values = { "头部", "身体" },
	Value = "头部",
	FormatDisplayValue = function(param21)
		return flag1 == "English" and (tbl1[param21] or param21) or param21
	end,
	Callback = function(value)
		if list8 and list8.setAimPart then
			list8.setAimPart(value)
		end
	end,
})

obj56:AddSlider("PvpFOVSize", {
	Text = "瞄准大小",
	Default = 90,
	Min = 1,
	Max = 360,
	Suffix = "°",
	Callback = function(value)
		if list8 and list8.setFOV then
			list8.setFOV(value)
		end
	end,
})

obj56:AddToggle("PvpTeamCheck", {
	Text = "队伍检测",
	Default = false,
	Callback = function(value)
		if list8 and list8.toggleTeamCheck then
			list8.toggleTeamCheck(value)
		end
	end,
})

obj56:AddToggle("PvpWallCheck", {
	Text = "墙体检测",
	Default = true,
	Callback = function(value)
		if list8 and list8.toggleWallCheck then
			list8.toggleWallCheck(value)
		end
	end,
})

obj56:AddToggle("PvpPrediction", {
	Text = "子弹预判",
	Default = false,
	Callback = function(value)
		if list8 and list8.togglePrediction then
			list8.togglePrediction(value)
		end
	end,
})

obj56:AddToggle("PvpMeleeAura", {
	Text = "杀戮光环（近战）",
	Default = false,
	Tooltip = func6("体验虐杀的快感"),
	Callback = function(value)
		if list8 and list8.toggleMelee then
			list8.toggleMelee(value)
		end
	end,
})

obj56:AddToggle("PvpTeleport", {
	Text = "预判传送至敌方身后",
	Default = false,
	Tooltip = func6("预判传送"),
	Callback = function(value)
		if list8 and list8.toggleTeleport then
			list8.toggleTeleport(value)
		end
	end,
})

obj56:AddToggle("PvpForceEquip", {
	Text = "强制装备武器",
	Default = false,
	Tooltip = func6("持续装备近战武器"),
	Callback = function(value)
		if list8 and list8.toggleForceEquip then
			list8.toggleForceEquip(value)
		end
	end,
})

list8.weaponSpeedMap = list1.WEAPON_SPEED_MAP

list8.getCurrentBulletSpeed = function()
	return list1.sharedGetCurrentBulletSpeed()
end

list8.getPing = function()
	return list1.sharedGetPing()
end

list8.getShotsLoaded = function()
	local character = localPlayer.Character
	return list1.sharedGetShotsLoaded(character and character:FindFirstChildOfClass("Tool"))
end

list8.aimEnabled = false
list8.aimPart = "Head"
list8.showFov = false
list8.fov = 90
list8.teamCheck = false
list8.prediction = false
list8.wallCheck = true
list8.aimConn = nil
list8.meleeEnabled = false
list8.meleeConn = nil
list8.tpEnabled = false
list8.tpThread = nil
list8.tpTarget = nil
list8.tpHighlight = nil
list8.bulletSpeed = 700
list8.silentMode = false
list8.silentHook = nil
list8.silentTarget = nil
list8._lastDistNotify = 0
list8._velHistory = {}
list8.lastNotifiedPlayer = nil
list8.indicatorData = nil
list8.indicatorPart = nil

do
	local function func27()
		local character = localPlayer.Character
		return list1.sharedIsGun(character and character:FindFirstChildOfClass("Tool"))
	end

	local function func28(num14, num15, param22)
		local tbl23 = {
			Vector3.zero,
			Vector3.new(0.5, 0.5, 0.5),
			Vector3.new(-0.5, 0.5, -0.5),
			Vector3.new(0.5, -0.5, 0.5),
			Vector3.new(-0.5, -0.5, -0.5),
			Vector3.new(0.8, 0, 0),
			Vector3.new(-0.8, 0, 0),
			Vector3.new(0, 0.8, 0),
			Vector3.new(0, -0.8, 0),
		}

		local n = #tbl23
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local filterDescendantsInstances = {}

		for _, getPlayer3 in obj4:GetPlayers() do
			if getPlayer3.Character then
				table.insert(filterDescendantsInstances, getPlayer3.Character)
			end
		end

		if param22 then
			table.insert(filterDescendantsInstances, param22)
		end

		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		local n2 = 0

		for _, value75 in tbl23 do
			local hit = workspace:Raycast(num14, num15 + value75 - num14, raycastParams)

			if hit then
				local instance = hit.Instance

				if instance and instance:IsA("BasePart") and instance.CanCollide then
					n2 += 1
				end
			end
		end

		return n2 > n / 2
	end

	local function func29()
		local value76 = localPlayer
		local character = value76.Character
		if not character then
			return nil
		end
		local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
		if not head then
			return nil
		end
		local currentCamera = workspace.CurrentCamera
		local n = list8.getCurrentBulletSpeed()

		if n <= 0 then
			n = 700
		end

		local n2 = list8.getPing() / 1000

		if not list8._velHistory then
			list8._velHistory = {}
		end

		local huge = math.huge
		local huge2 = math.huge
		local value77 = nil

		for _, getPlayer4 in obj4:GetPlayers() do
			if getPlayer4 ~= value76 then
				if not (list1.isMarked and list1.isMarked(getPlayer4)) then
					local character2 = getPlayer4.Character

					if character2 then
						local humanoid = character2:FindFirstChildOfClass("Humanoid")
						-- more leaks: https://discord.gg/x7YbZeezpm

						if not (not humanoid or humanoid.Health <= 0) then
							if not (humanoid.Health > 1000) then
								if list8.teamCheck then
									local flag31 = list1.getPlayerTeam(value76)
									local flag32 = list1.getPlayerTeam(getPlayer4)
									if flag31 and flag32 and flag31 == flag32 then
										continue
									end
								end

								local head2 = character2:FindFirstChild(list8.aimPart) or character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")

								if head2 then
									local magnitude = (head2.Position - currentCamera.CFrame.Position).Magnitude

									if not (magnitude > 1000) then
										if list8.wallCheck then
											if func28(head.Position, head2.Position, character2) then
												continue
											end
										end

										if list8.silentMode then
											if huge <= magnitude then
												continue
											end
											huge = magnitude
										else
											local flag33, flag34 = currentCamera:WorldToViewportPoint(head2.Position)
											if not flag33 or not flag34 then
												continue
											end
											local n3 = currentCamera.ViewportSize / 2
											local magnitude2 = (vector2(flag33.X, flag33.Y) - n3).Magnitude
											if magnitude2 > list8.fov or magnitude2 >= huge2 then
												continue
											end
											huge2 = magnitude2
										end

										local position = head2.Position
										local prediction2 = list8.prediction and n > 0
										local value78 = nil
										local value79

										if prediction2 then
											local humanoidRootPart = character2:FindFirstChild("HumanoidRootPart")
											local value80 = nil

											if humanoidRootPart then
												local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
												local flag35 = assemblyLinearVelocity and assemblyLinearVelocity.Magnitude > 0.3
												local value81 = nil

												if flag35 then
													if not list8._velHistory[getPlayer4] then
														list8._velHistory[getPlayer4] = {}
													end

													local list9 = list8._velHistory[getPlayer4]
													table.insert(list9, assemblyLinearVelocity)

													if #list9 > 8 then
														table.remove(list9, 1)
													end

													local result6 = vector()
													local n3 = 0

													for i = 1, #list9 do
														local n4 = i / #list9
														result6 += list9[i] * n4
														n3 += n4
													end

													if n3 > 0 then
														result6 /= n3
													end

													local n4 = 0

													if #list9 >= 2 then
														local value82 = list9[#list9 - 1].Unit:Dot(list9[#list9].Unit)
														n4 = 1 - abs(value82)
													end

													local n5 = 0

													if #list9 >= 2 then
														local magnitude2 = list9[#list9 - 1].Magnitude
														local magnitude3 = list9[#list9].Magnitude

														if magnitude2 > 0.1 then
															n5 = abs(magnitude3 - magnitude2) / magnitude2
														end
													end

													local n6 = 1.2 * (1 - min(1, n4 * 0.8 + n5 * 0.4) * 0.6)
													local n7 = magnitude / n + n2
													local n8 = vector(result6.X, 0, result6.Z) * n7 * n6
													local num16 = min(20, magnitude * 0.1)

													if num16 < n8.Magnitude then
														n8 = n8.Unit * num16
													end

													local y = result6.Y
													local n9

													if y < -0.5 then
														n9 = -(0.5 * workspace.Gravity * n7 * n7 * 0.25)
													else
														n9 = 0

														if y > 1.5 then
															n9 = y * n7 * 0.12
														end
													end

													local n10 = head2.Position + n8 + vector(0, n9, 0)
													value79 = n10
													value78 = n10
												else
													value79 = position
													value78 = value81
												end
											else
												value79 = position
												value78 = value80
											end
										else
											value79 = position
										end

										value77 = {
											player = getPlayer4,
											aimPos = value79,
											part = head2,
											dist = magnitude,
											bulletSpeed = n,
											predictedPos = value78,
										}
									end
								end
							end
						end
					end
				end
			end
		end

		for k in list8._velHistory do
			if not k or not k.Parent then
				list8._velHistory[k] = nil
			end
		end

		return value77
	end

	list8.updateIndicator = function(position, hasTarget)
		if not position then
			if list8.indicatorData then
				if list8.indicatorData.billboard then
					list8.indicatorData.billboard:Destroy()
				end

				list8.indicatorData = nil
			end

			if list8.indicatorPart then
				list8.indicatorPart:Destroy()
				list8.indicatorPart = nil
			end

			return
		end

		if not list8.indicatorPart or not list8.indicatorPart.Parent then
			list8.indicatorPart = Instance.new("Part")
			list8.indicatorPart.Name = "AimIndicatorAnchor"
			list8.indicatorPart.Size = Vector3.new(0.2, 0.2, 0.2)
			list8.indicatorPart.Transparency = 1
			list8.indicatorPart.CanCollide = false
			list8.indicatorPart.Anchored = true
			list8.indicatorPart.Parent = workspace
		end

		list8.indicatorPart.Position = position

		if not list8.indicatorData or not list8.indicatorData.billboard or not list8.indicatorData.billboard.Parent then
			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Size = UDim2.new(0, 25, 0, 25)
			billboardGui.StudsOffset = Vector3.zero
			billboardGui.AlwaysOnTop = true
			billboardGui.Adornee = list8.indicatorPart
			billboardGui.Parent = list8.indicatorPart
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 1, 0)
			frame.BackgroundTransparency = 1
			frame.Parent = billboardGui
			local frame2 = Instance.new("Frame")
			frame2.Size = UDim2.new(1, 0, 1, 0)
			frame2.BackgroundTransparency = 1
			frame2.Parent = frame
			local uiStroke = Instance.new("UIStroke")
			uiStroke.Thickness = 1
			uiStroke.Color = color(255, 255, 255)
			uiStroke.Transparency = 0.2
			uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke.Parent = frame2
			local uiCorner = Instance.new("UICorner")
			uiCorner.CornerRadius = UDim.new(1, 0)
			uiCorner.Parent = frame2
			local frame3 = Instance.new("Frame")
			frame3.Size = UDim2.new(0.65, 0, 0.65, 0)
			frame3.Position = UDim2.new(0.175, 0, 0.175, 0)
			frame3.BackgroundTransparency = 1
			frame3.Parent = frame
			local uiStroke2 = Instance.new("UIStroke")
			uiStroke2.Thickness = 0.7
			uiStroke2.Color = color(255, 255, 255)
			uiStroke2.Transparency = 0.35
			uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke2.Parent = frame3
			local uiCorner2 = Instance.new("UICorner")
			uiCorner2.CornerRadius = UDim.new(1, 0)
			uiCorner2.Parent = frame3
			local frame4 = Instance.new("Frame")
			frame4.Size = UDim2.new(0, 1, 0, 12)
			frame4.Position = UDim2.new(0.5, -0.5, 0.15, 0)
			frame4.BackgroundColor3 = color(255, 255, 255)
			frame4.BackgroundTransparency = 0.3
			frame4.Parent = frame
			local uiCorner3 = Instance.new("UICorner")
			uiCorner3.CornerRadius = UDim.new(0, 1)
			uiCorner3.Parent = frame4
			local uiGradient = Instance.new("UIGradient")
			local new = NumberSequenceKeypoint.new
			uiGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), new(1, 0.1) })
			uiGradient.Rotation = 180
			uiGradient.Parent = frame4
			local tbl24 = {}

			for _, value83 in { { -1, -1, 0 }, { 1, -1, 90 }, { -1, 1, -90 }, { 1, 1, 180 } }, nil, nil do
				local frame5 = Instance.new("Frame")
				frame5.Size = UDim2.new(0, 3.5, 0, 3.5)
				frame5.BackgroundTransparency = 1
				frame5.Position = UDim2.new(0.5 + value83[1] * 0.36, -1.75, 0.5 + value83[2] * 0.36, -1.75)
				frame5.Rotation = value83[3]
				frame5.Parent = frame
				local frame6 = Instance.new("Frame")
				frame6.Size = UDim2.new(1, 0, 0, 1)
				frame6.BackgroundColor3 = color(255, 255, 255)
				frame6.BackgroundTransparency = 0.4
				frame6.Parent = frame5
				local frame7 = Instance.new("Frame")
				frame7.Size = UDim2.new(0, 1, 1, 0)
				frame7.BackgroundColor3 = color(255, 255, 255)
				frame7.BackgroundTransparency = 0.4
				frame7.Parent = frame5
				table.insert(tbl24, frame5)
			end

			list8.indicatorData = {
				billboard = billboardGui,
				container = frame,
				outer = frame2,
				outerStroke = uiStroke,
				inner = frame3,
				innerStroke = uiStroke2,
				scanline = frame4,
				corners = tbl24,
				rotation = 0,
				hasTarget = false,
			}

			task.spawn(function()
				local rotation = 0

				while list8.indicatorData and list8.indicatorData.billboard and list8.indicatorData.billboard.Parent do
					rotation += 3

					if list8.indicatorData.outer then
						list8.indicatorData.outer.Rotation = rotation
					end

					if list8.indicatorData.inner then
						list8.indicatorData.inner.Rotation = -rotation * 0.6
					end

					if list8.indicatorData.scanline then
						list8.indicatorData.scanline.Rotation = rotation * 1.5
					end

					local hasTarget2 = list8.indicatorData.hasTarget
					local transparency = (math.sin(clock() * 4) + 1) / 2 * 0.2 + 0.15
					local transparency2 = (math.sin(clock() * 4 + 0.5) + 1) / 2 * 0.25 + 0.2

					if hasTarget2 then
						local value84 = color(0, floor((0.7 + (math.sin(clock() * 2) + 1) / 2 * 0.3) * 255), 80)

						if list8.indicatorData.outerStroke then
							list8.indicatorData.outerStroke.Color = value84
							list8.indicatorData.outerStroke.Transparency = transparency
						end

						if list8.indicatorData.innerStroke then
							list8.indicatorData.innerStroke.Color = value84
							list8.indicatorData.innerStroke.Transparency = transparency2
						end

						if list8.indicatorData.scanline then
							list8.indicatorData.scanline.BackgroundColor3 = value84
							list8.indicatorData.scanline.BackgroundTransparency = 0.3
						end

						for _, corner in list8.indicatorData.corners do
							for _, value85 in corner:GetChildren() do
								if value85:IsA("Frame") then
									value85.BackgroundColor3 = value84
								end
							end
						end
					else
						local value86 = color(255, 255, 255)

						if list8.indicatorData.outerStroke then
							list8.indicatorData.outerStroke.Color = value86
							list8.indicatorData.outerStroke.Transparency = transparency
						end

						if list8.indicatorData.innerStroke then
							list8.indicatorData.innerStroke.Color = value86
							list8.indicatorData.innerStroke.Transparency = transparency2
						end

						if list8.indicatorData.scanline then
							list8.indicatorData.scanline.BackgroundColor3 = value86
							list8.indicatorData.scanline.BackgroundTransparency = 0.3
						end

						for _, corner2 in list8.indicatorData.corners do
							for _, value87 in corner2:GetChildren() do
								if value87:IsA("Frame") then
									value87.BackgroundColor3 = value86
								end
							end
						end
					end

					task.wait(0.02)
				end
			end)
		else
			if list8.indicatorData.billboard.Adornee ~= list8.indicatorPart then
				list8.indicatorData.billboard.Adornee = list8.indicatorPart
			end

			list8.indicatorData.hasTarget = hasTarget
		end
	end

	list8.hideIndicator = function()
		if list8.indicatorData then
			if list8.indicatorData.billboard then
				list8.indicatorData.billboard:Destroy()
			end

			list8.indicatorData = nil
		end

		if list8.indicatorPart then
			list8.indicatorPart:Destroy()
			list8.indicatorPart = nil
		end
	end

	list8.setupSilentHook = function()
		if list8.silentHook then
			return
		end

		if type(hookmetamethod) ~= "function" then
			warn("静默自瞄需要 hookmetamethod")
			return
		end

		list8.silentHook = hookmetamethod(game, "__namecall", function(param23, ...)
			local packed1 = table.pack(...)

			if getnamecallmethod() == "FireServer" and list8.aimEnabled and list8.silentMode then
				local tbl25 = { ... }

				if tbl25[1] == "Fire" and list8.silentTarget and list8.silentTarget.aimPos then
					if localPlayer.Character then
						local tbl26 = {}

						for i = 1, #tbl25 do
							tbl26[i] = tbl25[i]
						end

						if #tbl26 >= 3 then
							tbl26[3] = list8.silentTarget.aimPos
						end

						return list8.silentHook(param23, unpack(tbl26))
					end
				end

				return list8.silentHook(param23, table.unpack(packed1, 1, packed1.n))
			end

			return list8.silentHook(param23, ...)
		end)
	end

	list8.removeSilentHook = function()
		if list8.silentHook then
			hookmetamethod(game, "__namecall", list8.silentHook)
			list8.silentHook = nil
		end
	end

	local function func30()
		while list8.aimEnabled do
			if not func27() then
				list8.hideIndicator()
				task.wait()
			else
				local result7 = func29()

				if result7 and result7.player and result7.player.Character then
					list8.silentTarget = result7
					list8.updateIndicator(result7.aimPos, true)

					if result7.player ~= list8.lastNotifiedPlayer then
						list8.lastNotifiedPlayer = result7.player

						pcall(function()
							local bulletSpeed = result7.bulletSpeed or 0
							list1.notify(flag1 == "English" and "Distance: " .. floor(result7.dist) .. " studs | Speed: " .. bulletSpeed or "距离: " .. floor(result7.dist) .. "格 | 速度: " .. bulletSpeed, 1)
						end)
					end

					if not list8.silentMode then
						local currentCamera = workspace.CurrentCamera

						if currentCamera then
							currentCamera.CFrame = cframe(currentCamera.CFrame.Position, result7.aimPos)
						end
					end
				else
					list8.silentTarget = nil
					list8.lastNotifiedPlayer = nil
					list8.updateIndicator(nil, false)
				end

				task.wait()
			end
		end
	end

	list8.toggle = function(aimEnabled)
		list8.aimEnabled = aimEnabled

		if aimEnabled then
			if not list8.aimConn then
				list8.aimConn = task.spawn(func30)

				if list8.silentMode then
					list8.setupSilentHook()
				else
					list8.removeSilentHook()
				end
			end
		else
			if list8.aimConn then
				task.cancel(list8.aimConn)
				list8.aimConn = nil
			end

			list8.removeSilentHook()
			list8.silentTarget = nil
			list8.lastNotifiedPlayer = nil
			list8.hideIndicator()
		end
	end
end

list8.setAimPart = function(flag36)
	list8.aimPart = flag36 == "身体" and "HumanoidRootPart" or "Head"
end

list8.toggleFOV = function(showFov)
	list8.showFov = showFov
end

list8.setFOV = function(fov)
	list8.fov = fov
end

list8.toggleTeamCheck = function(teamCheck)
	list8.teamCheck = teamCheck
end

list8.togglePrediction = function(prediction)
	list8.prediction = prediction
end

list8.setBulletSpeed = function(bulletSpeed)
	list8.bulletSpeed = bulletSpeed
end

list8.toggleWallCheck = function(wallCheck)
	list8.wallCheck = wallCheck
end

list8.toggleMelee = function(meleeEnabled)
	list8.meleeEnabled = meleeEnabled

	if meleeEnabled then
		if not list8.meleeConn then
			list8.meleeConn = obj5.Heartbeat:Connect(function()
				if not list8.meleeEnabled then
					return
				end
				local character = localPlayer.Character
				if not character then
					return
				end
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return
				end
				local tool = character:FindFirstChildOfClass("Tool")
				if not tool then
					return
				end
				local remoteEvent = tool:FindFirstChild("RemoteEvent")
				if not remoteEvent then
					return
				end

				for _, getPlayer5 in obj4:GetPlayers() do
					if getPlayer5 ~= localPlayer then
						if not (list1.isMarked and list1.isMarked(getPlayer5)) then
							if list8.teamCheck then
								local flag37 = list1.getPlayerTeam(localPlayer)
								local flag38 = list1.getPlayerTeam(getPlayer5)
								if flag37 and flag38 and flag37 == flag38 then
									continue
								end
							end

							local character2 = getPlayer5.Character

							if character2 then
								local humanoid = character2:FindFirstChildOfClass("Humanoid")

								if not (not humanoid or humanoid.Health <= 0) then
									if not (humanoid.Health > 1000) then
										local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

										if humanoidRootPart2 then
											if not ((humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude > 45) then
												local head = character2:FindFirstChild("Head")

												if head then
													pcall(function()
														remoteEvent:FireServer("PrepareSwing")
														remoteEvent:FireServer("Swing", "Side")
														remoteEvent:FireServer("HitPlayer", humanoid, head.Position)
													end)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end)
		end
	elseif list8.meleeConn then
		list8.meleeConn:Disconnect()
		list8.meleeConn = nil
	end
end

list8.toggleTeleport = function(tpEnabled)
	list8.tpEnabled = tpEnabled

	if tpEnabled then
		if list8.tpThread then
			return
		end
		list8.tpTargetHistory = {}
		list8.tpExtraLeadTime = 0.18
		list8.tpBackDistance = 4
		list8.tpUpOffset = 6
		list8.tpMaxPredict = 20

		list8.tpThread = task.spawn(function()
			while list8.tpEnabled do
				local character = obj4.LocalPlayer.Character

				if character then
					local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart then
						if list8.tpTarget then
							local character2 = list8.tpTarget.Character
							local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
							local flag39 = false

							if humanoidRootPart2 then
								local humanoid = character2:FindFirstChildOfClass("Humanoid")
								humanoid = humanoid and humanoid.Health > 0
								flag39 = false

								if humanoid then
									local flag40 = list1.getPlayerTeam(obj4.LocalPlayer)
									local flag41 = list1.getPlayerTeam(list8.tpTarget)
									local flag42 = not flag40 or not flag41 or flag40 ~= flag41
									flag39 = false

									if flag42 then
										flag39 = true
									end
								end
							end

							if not flag39 then
								if list8.tpHighlight then
									list8.tpHighlight:Destroy()
									list8.tpHighlight = nil
								end

								list8.tpTarget = nil
								list8.tpTargetHistory = {}
							end
						end

						if not list8.tpTarget then
							local flag43 = list1.getPlayerTeam(obj4.LocalPlayer)
							local huge = math.huge
							local value88 = nil

							for _, getPlayer6 in obj4:GetPlayers() do
								if getPlayer6 ~= obj4.LocalPlayer then
									local character2 = getPlayer6.Character

									if character2 then
										local humanoid = character2:FindFirstChildOfClass("Humanoid")

										if not (not humanoid or humanoid.Health <= 0) then
											local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

											if humanoidRootPart2 then
												local flag44 = list1.getPlayerTeam(getPlayer6)

												if not (flag43 and flag44 and flag43 == flag44) then
													local magnitude = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

													if magnitude < huge then
														huge = magnitude
														value88 = getPlayer6
													end
												end
											end
										end
									end
								end
							end

							if value88 then
								list8.tpTarget = value88
								list8.tpTargetHistory = {}

								if list8.tpHighlight then
									list8.tpHighlight:Destroy()
								end

								local highlight = Instance.new("Highlight")
								highlight.FillColor = color(0, 255, 0)
								highlight.OutlineColor = color(0, 255, 0)
								highlight.FillTransparency = 0.3
								highlight.OutlineTransparency = 0.3
								highlight.Adornee = value88.Character
								highlight.Parent = value88.Character
								list8.tpHighlight = highlight
							end
						end

						if list8.tpTarget and list8.tpTarget.Character then
							local humanoidRootPart2 = list8.tpTarget.Character:FindFirstChild("HumanoidRootPart")

							if humanoidRootPart2 then
								table.insert(list8.tpTargetHistory, { time = clock(), pos = humanoidRootPart2.Position, cframe = humanoidRootPart2.CFrame })

								if #list8.tpTargetHistory > 10 then
									table.remove(list8.tpTargetHistory, 1)
								end

								local n = list8.getPing() / 1000

								if #list8.tpTargetHistory < 2 then
									local position = humanoidRootPart2.Position
									humanoidRootPart.CFrame = cframe(humanoidRootPart2.Position - humanoidRootPart2.CFrame.LookVector * list8.tpBackDistance + vector(0, list8.tpUpOffset, 0), position)
									task.wait(0.2)
								else
									local tpTargetHistory = list8.tpTargetHistory
									local vector3 = Vector3.zero
									local n2 = 0
									local n3 = 0
									local n4 = 0

									for i = 2, #tpTargetHistory do
										local entry5 = tpTargetHistory[i - 1]
										local entry6 = tpTargetHistory[i]
										local n5 = entry6.time - entry5.time

										if n5 > 0.001 then
											vector3 += (entry6.pos - entry5.pos) / n5
											local lookVector = entry5.cframe.LookVector
											local lookVector2 = entry6.cframe.LookVector
											local value89 = lookVector:Cross(lookVector2)
											local flag45 = lookVector:Dot(lookVector2)
											local n6 = math.atan2(value89.Magnitude, flag45)

											if flag45 < 0 then
												n6 = 3.1415926535897931 - n6
											end

											n2 += n6
											n3 += n5
											n4 += 1
										end
									end

									if n4 > 0 then
										vector3 /= n4
									end

									local n5 = 0
									local n6 = 0

									if #tpTargetHistory >= 2 then
										local n7 = 1 - abs((tpTargetHistory[#tpTargetHistory - 1].pos - tpTargetHistory[#tpTargetHistory].pos).Unit:Dot((tpTargetHistory[#tpTargetHistory].pos - tpTargetHistory[#tpTargetHistory - 1].pos).Unit))
										local magnitude = (tpTargetHistory[#tpTargetHistory].pos - tpTargetHistory[#tpTargetHistory - 1].pos).Magnitude
										local magnitude2 = (tpTargetHistory[#tpTargetHistory].pos - tpTargetHistory[#tpTargetHistory - 1].pos).Magnitude
										local n8 = 0

										if magnitude > 0.1 then
											n5 = n7
											n6 = abs(magnitude2 - magnitude) / magnitude
										else
											n5 = n7
											n6 = n8
										end
									end

									local n7 = 1 - min(1, n5 * 0.8 + n6 * 0.4) * 0.6
									local entry7 = tpTargetHistory[#tpTargetHistory]
									local n8 = entry7.pos + vector3 * n * n7

									if list8.tpMaxPredict < (n8 - entry7.pos).Magnitude then
										n8 = entry7.pos + (n8 - entry7.pos).Unit * list8.tpMaxPredict
									end

									local lookVector = entry7.cframe.LookVector
									local n9 = 0

									if n3 > 0.001 then
										n9 = n2 / n3
									end

									local num17

									if n9 == 0 then
										num17 = lookVector
									else
										local n10 = n9 * n
										local vector4 = lookVector:Cross(Vector3.new(0, 1, 0))

										if vector4.Magnitude < 0.001 then
											vector4 = Vector3.new(1, 0, 0)
										end

										num17 = CFrame.fromAxisAngle(vector4.Unit, n10):VectorToWorldSpace(lookVector)
									end

									local n10 = n8 - num17 * list8.tpBackDistance
									local unit = vector3.Magnitude > 0.5 and vector3.Unit or Vector3.zero

									if unit.Magnitude > 0 then
										n10 += unit * vector3.Magnitude * list8.tpExtraLeadTime
									end

									humanoidRootPart.CFrame = cframe(n10 + vector(0, list8.tpUpOffset, 0), n8)
									task.wait(1e-09)
								end

								continue
							end
						end
					end
				end

				task.wait(1e-09)
			end
		end)
	else
		list8.tpEnabled = false

		if list8.tpThread then
			task.cancel(list8.tpThread)
			list8.tpThread = nil
		end

		if list8.tpHighlight then
			list8.tpHighlight:Destroy()
			list8.tpHighlight = nil
		end

		list8.tpTarget = nil
		list8.tpTargetHistory = {}
	end
end

list8.forceEquipEnabled = false
list8.forceEquipConn = nil

list8.toggleForceEquip = function(forceEquipEnabled)
	list8.forceEquipEnabled = forceEquipEnabled

	if forceEquipEnabled then
		if not list8.forceEquipConn then
			list8.forceEquipConn = obj5.Heartbeat:Connect(function()
				if not list8.forceEquipEnabled then
					return
				end
				local character = obj4.LocalPlayer.Character
				if not character then
					return
				end
				local backpack = obj4.LocalPlayer:FindFirstChild("Backpack")
				if not backpack then
					return
				end
				local flag46 = false

				for _, value90 in character:GetChildren() do
					if value90:IsA("Tool") and value90:GetAttribute("Melee") then
						flag46 = true
						break
					end
				end

				if not flag46 then
					for _, value91 in backpack:GetChildren() do
						if value91:IsA("Tool") and value91:GetAttribute("Melee") then
							value91.Parent = character
							break
						end
					end
				end
			end)
		end
	elseif list8.forceEquipConn then
		list8.forceEquipConn:Disconnect()
		list8.forceEquipConn = nil
	end
end

list1.onCharacterAdded(function()
	if list8.tpHighlight then
		list8.tpHighlight:Destroy()
		list8.tpHighlight = nil
	end

	list8.tpTarget = nil
	list8.hideIndicator()

	if list8.aimEnabled then
		list8.toggle(false)
		task.wait(0.5)
		list8.toggle(true)
	end

	if list8.meleeEnabled then
		list8.toggleMelee(false)
		task.wait(0.5)
		list8.toggleMelee(true)
	end

	if list8.tpEnabled then
		list8.toggleTeleport(false)
		task.wait(0.5)
		list8.toggleTeleport(true)
	end
end)

list1.disguise = {}
list1.disguise.lastVictimName = ""
list1.disguise.active = false

list1.disguise.getUserIdByUsername = function(param24)
	local ok, result = pcall(function()
		return game:HttpGet("https://users.roblox.com/v1/users/search?keyword=" .. obj2:UrlEncode(param24), true)
	end)

	if not ok then
		return nil, nil, nil
	end
	local data = obj2:JSONDecode(result)
	if data and data.data and #data.data > 0 then
		return data.data[1].id, data.data[1].name, data.data[1].displayName
	end
	return nil, nil, nil
end

list1.disguise.applyCharacterAppearance = function(parent, param25)
	local characterAppearanceAsync = obj4:GetCharacterAppearanceAsync(param25)

	for _, value92 in parent:GetChildren() do
		if value92:IsA("Accessory") or value92:IsA("Shirt") or value92:IsA("Pants") or value92:IsA("BodyColors") then
			value92:Destroy()
		end
	end

	for _, value93 in characterAppearanceAsync:GetChildren() do
		if value93:IsA("Shirt") or value93:IsA("Pants") or value93:IsA("BodyColors") then
			value93:Clone().Parent = parent
		elseif value93:IsA("Accessory") then
			parent.Humanoid:AddAccessory(value93:Clone())
		end
	end

	if characterAppearanceAsync:FindFirstChild("face") then
		if parent:WaitForChild("Head"):FindFirstChild("face") then
			parent.Head.face:Destroy()
		end

		local head = parent.Head
		characterAppearanceAsync.face:Clone().Parent = head
	end

	local parent2 = parent.Parent
	parent.Parent = nil
	parent.Parent = parent2
end

list1.disguise.applyAppearanceOnly = function(flag47)
	if flag47 == "" then
		lib:Notify({ Title = func5("错误"), Description = func5("请输入目标玩家名字"), Time = 3 })
		return false
	end

	return (pcall(function()
		local flag48 = localPlayer
		local flag49, value94, value95 = list1.disguise.getUserIdByUsername(flag47)
		if not flag49 then
			lib:Notify({ Title = func5("错误"), Description = func5("找不到该玩家"), Time = 3 })
			return
		end

		if not flag48.Character then
			flag48.CharacterAdded:Wait()
		end

		while true do
			task.wait()
			if not (flag48.Character and flag48.Character:FindFirstChild("Humanoid")) then
				continue
			end
			break
		end

		local character = flag48.Character
		list1.disguise.applyCharacterAppearance(character, flag49)
		task.wait(0.1)

		pcall(function()
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				workspace.CurrentCamera.CameraSubject = humanoid
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			end
		end)

		lib:Notify({
			Title = func5("成功"),
			Description = format(flag1 == "English" and "Replaced with %s's appearance" or "已替换为 %s 外观", value95),
			Time = 3,
		})
	end))
end

list1.disguise.changeNameOnly = function(flag50)
	if flag50 == "" then
		lib:Notify({ Title = func5("错误"), Description = func5("请输入新名字"), Time = 3 })
		return false
	end

	return (pcall(function()
		local flag51 = localPlayer
		local flag52, value96, value97 = list1.disguise.getUserIdByUsername(flag50)
		if not flag52 then
			lib:Notify({ Title = func5("错误"), Description = func5("该用户名不存在"), Time = 3 })
			return
		end

		if not flag51.Character then
			flag51.CharacterAdded:Wait()
		end

		while true do
			task.wait()
			if not (flag51.Character and flag51.Character:FindFirstChild("Humanoid")) then
				continue
			end
			break
		end

		local character = flag51.Character
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		pcall(function()
			flag51.Name = value96
			flag51.UserId = flag52
			flag51.CharacterAppearanceId = flag52
			flag51.DisplayName = value97
			character.Name = value96

			if humanoid then
				humanoid.DisplayName = value97
			end
		end)

		lib:Notify({
			Title = func5("成功"),
			Description = format(flag1 == "English" and "Name changed to: %s" or "名字已改为: %s", value97),
			Time = 3,
		})
	end))
end

if hookmetamethod then
	local value98 = nil

	local function func31(flag53, ...)
		if getnamecallmethod() == "Destroy" and list1.disguise.active then
			local character = localPlayer.Character
			if character and flag53 == character then
				return nil
			end
		end

		local packed2 = table.pack(...)
		return value98(flag53, table.unpack(packed2, 1, packed2.n))
	end

	value98 = hookmetamethod
	value98 = value98(game, "__namecall", func31)
end

list1.getPurchaseEvent = function()
	if not obj7 then
		return nil
	end
	local events = obj7:FindFirstChild("Events")
	if not events then
		return nil
	end
	local customize = events:FindFirstChild("Customize")
	if not customize then
		return nil
	end
	return customize:FindFirstChild("PurchaseEvent")
end

local func32

func32 = function()
	local character = localPlayer.Character
	if not character then
		return nil, nil
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return nil, nil
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	return humanoid, animator
end

do
	local function func33()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			for _, getPlayingAnimationTrack in humanoid:GetPlayingAnimationTracks() do
				pcall(function()
					getPlayingAnimationTrack:Stop()
				end)
			end
		end
	end

	local function func34()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.WalkSpeed = 16
		end
	end

	list1.resetAnims = function()
		func33()
		func34()
	end
end

do
	local function func35(obj57, animationId)
		local animation = Instance.new("Animation")
		animation.AnimationId = animationId
		local value99 = obj57:LoadAnimation(animation)
		value99.Priority = Enum.AnimationPriority.Action4
		return value99
	end

	list1.ANIM_KEYS = {
		"horseDance",
		"barry",
		"blyucher",
		"eatBroadcast",
		"playDead",
		"headlessSoldier",
		"crossUse",
		"fracture",
		"napoleon",
		"anim13725477218",
		"animEaten",
		"animBoatPull",
		"animCustomDual1",
		"animCustomDual2",
		"animLoop87443816703028",
		"animLoop15827239870",
		"animCustomDual3",
		"animPlayOnce14860627011",
		"anim107068529359282",
		"anim127516132968916",
		"anim27432686",
		"animCustomDual4",
	}

	list1.AnimStopOthers = function(flag54)
		if list1._animStopping then
			return
		end
		list1._animStopping = true

		for _, value100 in list1.ANIM_KEYS do
			local entry8 = list1[value100]

			if value100 ~= flag54 and entry8 and entry8.active then
				local entry9 = list1["stop" .. value100:sub(1, 1):upper() .. value100:sub(2)]

				if entry9 then
					pcall(entry9)
				end
			end
		end

		list1._animStopping = false
	end

	obj39:AddToggle("DanceHorseToggle", {
		Text = "骑马舞",
		Default = false,
		Tooltip = func6("播放骑马舞动画"),
		Callback = function(value)
			if value then
				list1.startHorseDance()
			else
				list1.stopHorseDance()
			end
		end,
	})

	list1.horseDance = { active = false, track = nil, thread = nil }

	list1.startHorseDance = function()
		if list1.horseDance.active then
			return
		end
		list1.AnimStopOthers("horseDance")
		list1.horseDance.active = true
		list1.resetAnims()
		local value101, obj58 = func32()
		if not obj58 then
			list1.horseDance.active = false
			return
		end
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://182435998"
		local obj59 = obj58:LoadAnimation(animation)
		obj59.Priority = Enum.AnimationPriority.Action4
		obj59.Looped = true
		obj59:Play()
		list1.horseDance.track = obj59
	end

	list1.stopHorseDance = function()
		if not list1.horseDance.active then
			return
		end
		list1.horseDance.active = false

		if list1.horseDance.track then
			pcall(function()
				list1.horseDance.track:Stop()
			end)
		end

		list1.resetAnims()
	end

	list1.barry = { active = false, trackList = {}, thread = nil }

	local function func36(param26)
		local value102 = func35(param26, "rbxassetid://14284371664")
		local value103 = func35(param26, "rbxassetid://14284387207")
		local value104 = func35(param26, "rbxassetid://14284382730")
		local trackList = { value102, value103, value104 }

		do
			local values = table.pack(func35(param26, "rbxassetid://14304936421"))
			table.move(values, 1, values.n, 4, trackList)
		end

		list1.barry.trackList = trackList

		local function func37(param27, param28)
			local flag55 = false

			local connection = param27.Stopped:Once(function()
				flag55 = true
			end)

			local result8 = clock2()

			while not flag55 and param27.IsPlaying and clock2() - result8 < param28 do
				task.wait(0.05)
			end

			pcall(function()
				connection:Disconnect()
			end)
		end

		while list1.barry.active do
			trackList[1]:Play()
			func37(trackList[1], 10)

			if list1.barry.active then
				trackList[2]:Play()
				task.wait(1)

				if trackList[2].IsPlaying then
					trackList[2]:Stop()
				end

				if list1.barry.active then
					trackList[3]:Play()
					func37(trackList[3], 10)

					if list1.barry.active then
						trackList[2]:Play()
						task.wait(0.3)

						if trackList[2].IsPlaying then
							trackList[2]:Stop()
						end

						if list1.barry.active then
							trackList[4]:Play()
							func37(trackList[4], 10)
							continue
						end
					end
				end
			end

			break
		end

		for _, value105 in trackList do
			pcall(function()
				value105:Stop()
			end)
		end

		list1.barry.trackList = {}
	end

	list1.startBarry = function()
		if list1.barry.active then
			return
		end
		list1.AnimStopOthers("barry")
		list1.barry.active = true
		list1.resetAnims()
		local value106, flag56 = func32()
		if not flag56 then
			list1.barry.active = false
			return
		end
		list1.barry.thread = task.spawn(func36, flag56)
	end
end

list1.stopBarry = function()
	if not list1.barry.active then
		return
	end
	list1.barry.active = false

	if list1.barry.thread then
		task.cancel(list1.barry.thread)
	end

	for _, value107 in list1.barry.trackList do
		pcall(function()
			value107:Stop()
		end)
	end

	list1.barry.trackList = {}
	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.horseDance and list1.horseDance.active then
		list1.stopHorseDance()
	end

	if list1.blyucher and list1.blyucher.active then
		list1.stopBlyucher()
	end

	if list1.barry and list1.barry.active then
		list1.stopBarry()
	end
end)

list1.blyucher = { active = false, thread = nil, tracks = {} }

list1.startBlyucher = function()
	if list1.blyucher.active then
		return
	end
	list1.AnimStopOthers("blyucher")
	list1.blyucher.active = true
	list1.resetAnims()
	local value108, obj60 = func32()
	if not obj60 then
		list1.blyucher.active = false
		return
	end

	local function func38(animationId)
		local animation = Instance.new("Animation")
		animation.AnimationId = animationId
		local value109 = obj60:LoadAnimation(animation)
		value109.Priority = Enum.AnimationPriority.Action4
		return value109
	end

	local obj61 = func38("rbxassetid://15603033178")
	local obj62 = func38("rbxassetid://16168689655")
	local obj63 = func38("rbxassetid://15680560478")
	local obj64 = func38("rbxassetid://15688743558")
	local obj65 = func38("rbxassetid://15637342030")
	list1.blyucher.tracks = { obj61, obj62, obj63, obj64, obj65 }

	list1.blyucher.thread = task.spawn(function()
		if not list1.blyucher.active then
			return
		end
		obj61:Play()
		obj61.Stopped:Wait()
		if not list1.blyucher.active then
			return
		end
		obj62:Play()
		obj62.Stopped:Wait()
		if not list1.blyucher.active then
			return
		end
		obj63:Play()
		task.wait(3)

		if obj63.IsPlaying then
			obj63:Stop()
		end

		if not list1.blyucher.active then
			return
		end
		obj64:Play()
		obj64.Stopped:Wait()
		if not list1.blyucher.active then
			return
		end
		obj63:Play()
		task.wait(3)

		if obj63.IsPlaying then
			obj63:Stop()
		end

		if not list1.blyucher.active then
			return
		end
		obj65:Play()
		obj65.Stopped:Wait()

		if list1.blyucher.active then
			list1.blyucher.active = false

			pcall(function()
				if type(list1.updateBlyucherButton) == "function" then
					list1.updateBlyucherButton(false)
				end
			end)

			list1.resetAnims()
		end
	end)
end

list1.stopBlyucher = function()
	if not list1.blyucher.active then
		return
	end
	list1.blyucher.active = false

	if list1.blyucher.thread then
		task.cancel(list1.blyucher.thread)
		list1.blyucher.thread = nil
	end

	for _, track3 in list1.blyucher.tracks do
		pcall(function()
			track3:Stop()
		end)
	end

	list1.blyucher.tracks = {}
	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.blyucher and list1.blyucher.active then
		list1.stopBlyucher()
	end
end)

obj39:AddToggle("DanceBlyucherToggle", {
	Text = "布吕歇尔",
	Default = false,
	Tooltip = func6("老不死的布吕歇尔动作（播放完整序列后自动停止）"),
	Callback = function(value)
		if value then
			list1.startBlyucher()

			list1.updateBlyucherButton = function(param29)
				local danceBlyucherToggle = toggles.DanceBlyucherToggle

				if danceBlyucherToggle and danceBlyucherToggle.SetValue then
					danceBlyucherToggle:SetValue(param29)
				end
			end
		else
			list1.stopBlyucher()
			list1.updateBlyucherButton = nil
		end
	end,
})

obj39:AddToggle("DanceBarryToggle", {
	Text = "Barry",
	Default = false,
	Tooltip = func6("耐咬王 Barry 动作"),
	Callback = function(value)
		if value then
			list1.startBarry()
		else
			list1.stopBarry()
		end
	end,
})

list1.eatBroadcast = { active = false, track = nil }

list1.startEatBroadcast = function()
	if list1.eatBroadcast.active then
		return
	end
	list1.AnimStopOthers("eatBroadcast")
	list1.eatBroadcast.active = true
	list1.resetAnims()
	local value110, obj66 = func32()
	if not obj66 then
		list1.eatBroadcast.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://18339432914"
	local obj67 = obj66:LoadAnimation(animation)
	obj67.Priority = Enum.AnimationPriority.Action4
	obj67:Play()
	list1.eatBroadcast.track = obj67
end

list1.stopEatBroadcast = function()
	if not list1.eatBroadcast.active then
		return
	end
	list1.eatBroadcast.active = false

	if list1.eatBroadcast.track then
		pcall(function()
			list1.eatBroadcast.track:Stop()
		end)

		list1.eatBroadcast.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.eatBroadcast and list1.eatBroadcast.active then
		list1.stopEatBroadcast()
	end
end)

obj39:AddToggle("DanceEatToggle", {
	Text = "吃东西",
	Default = false,
	Tooltip = func6("山伯乐吃东西动画"),
	Callback = function(value)
		if value then
			list1.startEatBroadcast()
		else
			list1.stopEatBroadcast()
		end
	end,
})

list1.playDead = { active = false, track = nil, thread = nil }

list1.startPlayDead = function()
	if list1.playDead.active then
		return
	end
	list1.AnimStopOthers("playDead")
	list1.playDead.active = true
	list1.resetAnims()
	local value111, obj68 = func32()
	if not obj68 then
		list1.playDead.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://89945348540089"
	local obj69 = obj68:LoadAnimation(animation)
	obj69.Priority = Enum.AnimationPriority.Action4
	list1.playDead.track = obj69

	list1.playDead.thread = task.spawn(function()
		while list1.playDead.active do
			obj69:Play()
			task.wait(1)

			if obj69.IsPlaying then
				obj69:Stop()
			end
		end
	end)
end

list1.stopPlayDead = function()
	if not list1.playDead.active then
		return
	end
	list1.playDead.active = false

	if list1.playDead.thread then
		task.cancel(list1.playDead.thread)
		list1.playDead.thread = nil
	end

	if list1.playDead.track then
		pcall(function()
			list1.playDead.track:Stop()
		end)

		list1.playDead.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.playDead and list1.playDead.active then
		list1.stopPlayDead()
	end
end)

obj39:AddToggle("DancePlayDeadToggle", {
	Text = "睡着了",
	Default = false,
	Tooltip = func6("装死动画"),
	Callback = function(value)
		if value then
			list1.startPlayDead()
		else
			list1.stopPlayDead()
		end
	end,
})

list1.headlessSoldier = { active = false, idleTrack = nil, walkTrack = nil, conn = nil }

list1.startHeadlessSoldier = function()
	if list1.headlessSoldier.active then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	for _, getPlayingAnimationTrack2 in humanoid:GetPlayingAnimationTracks() do
		pcall(function()
			getPlayingAnimationTrack2:Stop()
		end)
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://107080941320600"
	local animation2 = Instance.new("Animation")
	animation2.AnimationId = "rbxassetid://74764025513892"
	local obj70 = animator:LoadAnimation(animation)
	local obj71 = animator:LoadAnimation(animation2)
	obj70.Priority = Enum.AnimationPriority.Action3
	obj71.Priority = Enum.AnimationPriority.Action3
	list1.headlessSoldier.idleTrack = obj70
	list1.headlessSoldier.walkTrack = obj71
	list1.headlessSoldier.active = true

	local function func39()
		if not list1.headlessSoldier.active then
			return
		end

		if humanoid.MoveDirection.Magnitude > 0 then
			if obj71 and not obj71.IsPlaying then
				if obj70 and obj70.IsPlaying then
					obj70:Stop()
				end

				obj71:Play()
			end
		elseif obj70 and not obj70.IsPlaying then
			if obj71 and obj71.IsPlaying then
				obj71:Stop()
			end

			obj70:Play()
		end
	end

	func39()
	list1.headlessSoldier.conn = humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(func39)
end

list1.stopHeadlessSoldier = function()
	if not list1.headlessSoldier.active then
		return
	end
	list1.headlessSoldier.active = false

	if list1.headlessSoldier.conn then
		list1.headlessSoldier.conn:Disconnect()
		list1.headlessSoldier.conn = nil
	end

	if list1.headlessSoldier.idleTrack then
		pcall(function()
			list1.headlessSoldier.idleTrack:Stop()
		end)

		list1.headlessSoldier.idleTrack = nil
	end

	if list1.headlessSoldier.walkTrack then
		pcall(function()
			list1.headlessSoldier.walkTrack:Stop()
		end)

		list1.headlessSoldier.walkTrack = nil
	end
	-- 𝚂𝙻 | 𝚂𝚘𝚞𝚛𝚌𝚎 𝙻𝚎𝚊𝚔 // discord.gg/x7YbZeezpm

	local character = localPlayer.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			for _, getPlayingAnimationTrack3 in humanoid:GetPlayingAnimationTracks() do
				pcall(function()
					getPlayingAnimationTrack3:Stop()
				end)
			end
		end
	end
end

list1.onCharacterAdded(function()
	if list1.headlessSoldier and list1.headlessSoldier.active then
		list1.stopHeadlessSoldier()
		local headlessSoldierToggle = toggles.HeadlessSoldierToggle

		if headlessSoldierToggle and headlessSoldierToggle.SetValue then
			headlessSoldierToggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("HeadlessSoldierToggle", {
	Text = "无头士兵",
	Default = false,
	Tooltip = func6("播放无头士兵待机/行走动画（自动切换）"),
	Callback = function(value)
		if value then
			list1.startHeadlessSoldier()
		else
			list1.stopHeadlessSoldier()
		end
	end,
})

list1.crossUse = { active = false, track = nil }

list1.startCrossUse = function()
	if list1.crossUse.active then
		return
	end
	list1.AnimStopOthers("crossUse")
	list1.crossUse.active = true
	list1.resetAnims()
	local value112, obj72 = func32()
	if not obj72 then
		list1.crossUse.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://15210536563"
	local obj73 = obj72:LoadAnimation(animation)
	obj73.Priority = Enum.AnimationPriority.Action4
	obj73.Looped = true
	list1.crossUse.track = obj73
	obj73:Play()
end

list1.stopCrossUse = function()
	if not list1.crossUse.active then
		return
	end
	list1.crossUse.active = false

	if list1.crossUse.track then
		pcall(function()
			list1.crossUse.track:Stop()
		end)

		list1.crossUse.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.crossUse and list1.crossUse.active then
		list1.stopCrossUse()
		local crossUseToggle = toggles.CrossUseToggle

		if crossUseToggle and crossUseToggle.SetValue then
			crossUseToggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("CrossUseToggle", {
	Text = "十字架",
	Default = false,
	Tooltip = func6("播放十字架使用动画（循环）"),
	Callback = function(value)
		if value then
			list1.startCrossUse()
		else
			list1.stopCrossUse()
		end
	end,
})

list1.fracture = { active = false, track1 = nil, track2 = nil }

list1.startFracture = function()
	if list1.fracture.active then
		return
	end
	list1.AnimStopOthers("fracture")
	list1.fracture.active = true
	list1.resetAnims()
	local value113, obj74 = func32()
	if not obj74 then
		list1.fracture.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://12333490324"
	local obj75 = obj74:LoadAnimation(animation)
	obj75.Priority = Enum.AnimationPriority.Action4
	local animation2 = Instance.new("Animation")
	animation2.AnimationId = "rbxassetid://12333489072"
	local obj76 = obj74:LoadAnimation(animation2)
	obj76.Priority = Enum.AnimationPriority.Action4
	obj76.Looped = true
	list1.fracture.track1 = obj75
	list1.fracture.track2 = obj76
	obj75:Play()

	obj75.Stopped:Connect(function()
		if list1.fracture.active then
			obj76:Play()
		end
	end)
end

list1.stopFracture = function()
	if not list1.fracture.active then
		return
	end
	list1.fracture.active = false

	if list1.fracture.track1 then
		pcall(function()
			list1.fracture.track1:Stop()
		end)

		list1.fracture.track1 = nil
	end

	if list1.fracture.track2 then
		pcall(function()
			list1.fracture.track2:Stop()
		end)

		list1.fracture.track2 = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.fracture and list1.fracture.active then
		list1.stopFracture()
		local fractureToggle = toggles.FractureToggle

		if fractureToggle and fractureToggle.SetValue then
			fractureToggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("FractureToggle", {
	Text = "骨折",
	Default = false,
	Tooltip = func6("播放骨折动画（第一段播完第二段循环）"),
	Callback = function(value)
		if value then
			list1.startFracture()
		else
			list1.stopFracture()
		end
	end,
})

list1.napoleon = { active = false, idleTrack = nil, walkTrack = nil, conn = nil }

list1.startNapoleon = function()
	if list1.napoleon.active then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	for _, getPlayingAnimationTrack4 in humanoid:GetPlayingAnimationTracks() do
		pcall(function()
			getPlayingAnimationTrack4:Stop()
		end)
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://103557875332543"
	local obj77 = animator:LoadAnimation(animation)
	obj77.Priority = Enum.AnimationPriority.Action4
	list1.napoleon.idleTrack = obj77
	list1.napoleon.walkTrack = nil
	list1.napoleon.active = true

	local function func40()
		if not list1.napoleon.active then
			return
		end

		if not obj77.IsPlaying then
			obj77:Play()
		end
	end

	func40()
	list1.napoleon.conn = humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(func40)
end

list1.stopNapoleon = function()
	if not list1.napoleon.active then
		return
	end
	list1.napoleon.active = false

	if list1.napoleon.conn then
		list1.napoleon.conn:Disconnect()
		list1.napoleon.conn = nil
	end

	if list1.napoleon.idleTrack then
		pcall(function()
			list1.napoleon.idleTrack:Stop()
		end)

		list1.napoleon.idleTrack = nil
	end

	if list1.napoleon.walkTrack then
		pcall(function()
			list1.napoleon.walkTrack:Stop()
		end)

		list1.napoleon.walkTrack = nil
	end

	local character = localPlayer.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			for _, getPlayingAnimationTrack5 in humanoid:GetPlayingAnimationTracks() do
				pcall(function()
					getPlayingAnimationTrack5:Stop()
				end)
			end
		end
	end
end

list1.onCharacterAdded(function()
	if list1.napoleon and list1.napoleon.active then
		list1.stopNapoleon()
		local napoleonToggle = toggles.NapoleonToggle

		if napoleonToggle and napoleonToggle.SetValue then
			napoleonToggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("NapoleonToggle", {
	Text = "仙人背手",
	Default = false,
	Tooltip = func6("播放拿破仑背手动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			list1.startNapoleon()
		else
			list1.stopNapoleon()
		end
	end,
})

list1.anim13725477218 = { active = false, track = nil }

list1.startAnim13725477218 = function()
	if list1.anim13725477218.active then
		return
	end
	list1.AnimStopOthers("anim13725477218")
	list1.anim13725477218.active = true
	list1.resetAnims()
	local value114, obj78 = func32()
	if not obj78 then
		list1.anim13725477218.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://13725477218"
	local obj79 = obj78:LoadAnimation(animation)
	obj79.Priority = Enum.AnimationPriority.Action4
	obj79.Looped = true
	obj79:Play()
	list1.anim13725477218.track = obj79
end

list1.stopAnim13725477218 = function()
	if not list1.anim13725477218.active then
		return
	end
	list1.anim13725477218.active = false

	if list1.anim13725477218.track then
		pcall(function()
			list1.anim13725477218.track:Stop()
		end)

		list1.anim13725477218.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.anim13725477218 and list1.anim13725477218.active then
		list1.stopAnim13725477218()
		local anim13725477218Toggle = toggles.Anim13725477218Toggle

		if anim13725477218Toggle and anim13725477218Toggle.SetValue then
			anim13725477218Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("Anim13725477218Toggle", {
	Text = "突进肘击",
	Default = false,
	Tooltip = func6("循环播放指定动画（优先级 Action4）"),
	Callback = function(value)
		if value then
			list1.startAnim13725477218()
		else
			list1.stopAnim13725477218()
		end
	end,
})

list1.animEaten = { active = false, track = nil }

list1.startAnimEaten = function()
	if list1.animEaten.active then
		return
	end
	list1.AnimStopOthers("animEaten")
	list1.animEaten.active = true
	list1.resetAnims()
	local value115, obj80 = func32()
	if not obj80 then
		list1.animEaten.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://12333488486"
	local obj81 = obj80:LoadAnimation(animation)
	obj81.Priority = Enum.AnimationPriority.Action4
	obj81.Looped = true
	obj81:Play()
	list1.animEaten.track = obj81
end

list1.stopAnimEaten = function()
	if not list1.animEaten.active then
		return
	end
	list1.animEaten.active = false

	if list1.animEaten.track then
		pcall(function()
			list1.animEaten.track:Stop()
		end)

		list1.animEaten.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.animEaten and list1.animEaten.active then
		list1.stopAnimEaten()
		local animEatenToggle = toggles.AnimEatenToggle

		if animEatenToggle and animEatenToggle.SetValue then
			animEatenToggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("AnimEatenToggle", {
	Text = "被山伯乐啃",
	Default = false,
	Tooltip = func6("循环播放被啃动画"),
	Callback = function(value)
		if value then
			list1.startAnimEaten()
		else
			list1.stopAnimEaten()
		end
	end,
})

list1.animBoatPull = { active = false, track = nil }

list1.startAnimBoatPull = function()
	if list1.animBoatPull.active then
		return
	end
	list1.AnimStopOthers("animBoatPull")
	list1.animBoatPull.active = true
	list1.resetAnims()
	local value116, obj82 = func32()
	if not obj82 then
		list1.animBoatPull.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://122021683613392"
	local obj83 = obj82:LoadAnimation(animation)
	obj83.Priority = Enum.AnimationPriority.Action4
	obj83.Looped = true
	obj83:Play()
	list1.animBoatPull.track = obj83
end

list1.stopAnimBoatPull = function()
	if not list1.animBoatPull.active then
		return
	end
	list1.animBoatPull.active = false

	if list1.animBoatPull.track then
		pcall(function()
			list1.animBoatPull.track:Stop()
		end)

		list1.animBoatPull.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.animBoatPull and list1.animBoatPull.active then
		list1.stopAnimBoatPull()
		local animBoatPullToggle = toggles.AnimBoatPullToggle

		if animBoatPullToggle and animBoatPullToggle.SetValue then
			animBoatPullToggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("AnimBoatPullToggle", {
	Text = "扒船",
	Default = false,
	Tooltip = func6("循环播放扒船动画"),
	Callback = function(value)
		if value then
			list1.startAnimBoatPull()
		else
			list1.stopAnimBoatPull()
		end
	end,
})

list1.startDual = function(obj, animationId, animationId2)
	if obj.active then
		return
	end
	list1.AnimStopOthers(obj.key)
	local character = localPlayer.Character
	if not character then
		obj.active = false
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		obj.active = false
		return
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	list1.resetAnims()
	local animation = Instance.new("Animation")
	animation.AnimationId = animationId
	local animation2 = Instance.new("Animation")
	animation2.AnimationId = animationId2
	local obj84 = animator:LoadAnimation(animation)
	local obj85 = animator:LoadAnimation(animation2)
	obj84.Priority = Enum.AnimationPriority.Action3
	obj85.Priority = Enum.AnimationPriority.Action3
	obj.idleTrack = obj84
	obj.walkTrack = obj85
	obj.active = true

	local function func41()
		if not obj.active then
			return
		end

		if humanoid.MoveDirection.Magnitude > 0 then
			if not obj85.IsPlaying then
				if obj84.IsPlaying then
					obj84:Stop()
				end

				obj85:Play()
			end
		elseif not obj84.IsPlaying then
			if obj85.IsPlaying then
				obj85:Stop()
			end

			obj84:Play()
		end
	end

	func41()
	obj.conn = humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(func41)
end

list1.stopDual = function(obj)
	if not obj.active then
		return
	end
	obj.active = false

	if obj.conn then
		obj.conn:Disconnect()
		obj.conn = nil
	end

	if obj.idleTrack then
		pcall(function()
			obj.idleTrack:Stop()
		end)

		obj.idleTrack = nil
	end

	if obj.walkTrack then
		pcall(function()
			obj.walkTrack:Stop()
		end)

		obj.walkTrack = nil
	end

	list1.resetAnims()
	local character = localPlayer.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			for _, getPlayingAnimationTrack6 in humanoid:GetPlayingAnimationTracks() do
				pcall(function()
					getPlayingAnimationTrack6:Stop()
				end)
			end

			local animate = character:FindFirstChild("Animate")

			if animate then
				pcall(function()
					animate.Disabled = false
				end)
			end
		end
	end
end

list1.startIdleWalk = function(obj, animationId, animationId2, priority, walkSpeed, animationId3)
	local character = localPlayer.Character
	if not character then
		return nil
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return nil
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	for _, getPlayingAnimationTrack7 in humanoid:GetPlayingAnimationTracks() do
		pcall(function()
			getPlayingAnimationTrack7:Stop()
		end)
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = animationId
	local animation2 = Instance.new("Animation")
	animation2.AnimationId = animationId2
	local obj86 = animator:LoadAnimation(animation)
	local obj87 = animator:LoadAnimation(animation2)
	obj86.Priority = priority
	obj87.Priority = priority

	if walkSpeed then
		humanoid.WalkSpeed = walkSpeed
	end

	local value117 = nil

	if animationId3 then
		local animation3 = Instance.new("Animation")
		animation3.AnimationId = animationId3
		value117 = animator:LoadAnimation(animation3)
		value117.Priority = Enum.AnimationPriority.Action2
		value117.Looped = true
		value117:Play()
	end

	local function func42()
		if humanoid.MoveDirection.Magnitude > 0 then
			if not obj87.IsPlaying then
				if obj86.IsPlaying then
					obj86:Stop()
				end

				obj87:Play()
			end
		elseif not obj86.IsPlaying then
			if obj87.IsPlaying then
				obj87:Stop()
			end

			obj86:Play()
		end
	end

	local connection = humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(func42)
	func42()
	obj = obj or {}
	obj.idle = obj86
	obj.walk = obj87
	obj.conn = connection

	if value117 then
		obj.sit = value117
	end

	return obj
end

list1.stopIdleWalk = function(obj, walkSpeed)
	if obj then
		if obj.idle then
			pcall(function()
				obj.idle:Stop()
			end)

			obj.idle = nil
		end

		if obj.walk then
			pcall(function()
				obj.walk:Stop()
			end)

			obj.walk = nil
		end

		if obj.sit then
			pcall(function()
				obj.sit:Stop()
			end)

			obj.sit = nil
		end

		if obj.conn then
			pcall(function()
				obj.conn:Disconnect()
			end)

			obj.conn = nil
		end
	end

	local character = localPlayer.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			if walkSpeed then
				humanoid.WalkSpeed = walkSpeed
			end

			for _, getPlayingAnimationTrack8 in humanoid:GetPlayingAnimationTracks() do
				pcall(function()
					getPlayingAnimationTrack8:Stop()
				end)
			end

			local animate = character:FindFirstChild("Animate")

			if animate then
				pcall(function()
					animate.Disabled = false
				end)
			end
		end
	end
end

list1.animCustomDual1 = { active = false, idleTrack = nil, walkTrack = nil, conn = nil, key = "animCustomDual1" }

list1.startAnimCustomDual1 = function()
	list1.startDual(list1.animCustomDual1, "rbxassetid://86354512475506", "rbxassetid://78012833820631")
end

list1.stopAnimCustomDual1 = function()
	list1.stopDual(list1.animCustomDual1)
end

list1.onCharacterAdded(function()
	if list1.animCustomDual1 and list1.animCustomDual1.active then
		list1.stopAnimCustomDual1()
		local animCustomDual1Toggle = toggles.AnimCustomDual1Toggle

		if animCustomDual1Toggle and animCustomDual1Toggle.SetValue then
			animCustomDual1Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("AnimCustomDual1Toggle", {
	Text = "推炮车1",
	Default = false,
	Tooltip = func6("静止播放动画1，移动播放动画2"),
	Callback = function(value)
		if value then
			list1.startAnimCustomDual1()
		else
			list1.stopAnimCustomDual1()
		end
	end,
})

list1.animCustomDual2 = { active = false, idleTrack = nil, walkTrack = nil, conn = nil, key = "animCustomDual2" }

list1.startAnimCustomDual2 = function()
	list1.startDual(list1.animCustomDual2, "rbxassetid://110409103422089", "rbxassetid://105941369341054")
end

list1.stopAnimCustomDual2 = function()
	list1.stopDual(list1.animCustomDual2)
end

list1.onCharacterAdded(function()
	if list1.animCustomDual2 and list1.animCustomDual2.active then
		list1.stopAnimCustomDual2()
		local animCustomDual2Toggle = toggles.AnimCustomDual2Toggle

		if animCustomDual2Toggle and animCustomDual2Toggle.SetValue then
			animCustomDual2Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("AnimCustomDual2Toggle", {
	Text = "推炮车2",
	Default = false,
	Tooltip = func6("静止播放动画5，移动播放动画6"),
	Callback = function(value)
		if value then
			list1.startAnimCustomDual2()
		else
			list1.stopAnimCustomDual2()
		end
	end,
})

list1.animLoop87443816703028 = { active = false, track = nil, thread = nil }

list1.startAnimLoop87443816703028 = function()
	if list1.animLoop87443816703028.active then
		return
	end
	list1.AnimStopOthers("animLoop87443816703028")
	list1.animLoop87443816703028.active = true
	list1.resetAnims()
	local obj88
	obj88, obj88 = func32()
	if not obj88 then
		list1.animLoop87443816703028.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://87443816703028"

	list1.animLoop87443816703028.thread = task.spawn(function()
		while list1.animLoop87443816703028.active do
			if list1.animLoop87443816703028.track then
				pcall(function()
					list1.animLoop87443816703028.track:Stop()
				end)

				list1.animLoop87443816703028.track = nil
			end

			local obj89 = obj88:LoadAnimation(animation)
			obj89.Priority = Enum.AnimationPriority.Action4
			obj89.Looped = true
			obj89:Play()
			list1.animLoop87443816703028.track = obj89
			local result9 = clock()

			while list1.animLoop87443816703028.active and clock() - result9 < 0.5 do
				task.wait()
			end
		end
	end)
end

list1.stopAnimLoop87443816703028 = function()
	if not list1.animLoop87443816703028.active then
		return
	end
	list1.animLoop87443816703028.active = false

	if list1.animLoop87443816703028.thread then
		task.cancel(list1.animLoop87443816703028.thread)
		list1.animLoop87443816703028.thread = nil
	end

	if list1.animLoop87443816703028.track then
		pcall(function()
			list1.animLoop87443816703028.track:Stop()
		end)

		list1.animLoop87443816703028.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.animLoop87443816703028 and list1.animLoop87443816703028.active then
		list1.stopAnimLoop87443816703028()
		local animLoop87443816703028Toggle = toggles.AnimLoop87443816703028Toggle

		if animLoop87443816703028Toggle and animLoop87443816703028Toggle.SetValue then
			animLoop87443816703028Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("AnimLoop87443816703028Toggle", {
	Text = "神秘举东西",
	Default = false,
	Tooltip = func6("每0.5秒重新触发一次循环动画 ID: 87443816703028"),
	Callback = function(value)
		if value then
			list1.startAnimLoop87443816703028()
		else
			list1.stopAnimLoop87443816703028()
		end
	end,
})

list1.animLoop15827239870 = { active = false, track = nil, thread = nil }

list1.startAnimLoop15827239870 = function()
	if list1.animLoop15827239870.active then
		return
	end
	list1.AnimStopOthers("animLoop15827239870")
	list1.animLoop15827239870.active = true
	list1.resetAnims()
	local obj90
	obj90, obj90 = func32()
	if not obj90 then
		list1.animLoop15827239870.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://15827239870"

	list1.animLoop15827239870.thread = task.spawn(function()
		while list1.animLoop15827239870.active do
			if list1.animLoop15827239870.track then
				pcall(function()
					list1.animLoop15827239870.track:Stop()
				end)

				list1.animLoop15827239870.track = nil
			end

			local obj91 = obj90:LoadAnimation(animation)
			obj91.Priority = Enum.AnimationPriority.Action3
			obj91.Looped = false
			obj91:Play()
			list1.animLoop15827239870.track = obj91
			local result10 = clock()

			while list1.animLoop15827239870.active and clock() - result10 < 0.73 do
				task.wait()
			end
		end
	end)
end

list1.stopAnimLoop15827239870 = function()
	if not list1.animLoop15827239870.active then
		return
	end
	list1.animLoop15827239870.active = false

	if list1.animLoop15827239870.thread then
		task.cancel(list1.animLoop15827239870.thread)
		list1.animLoop15827239870.thread = nil
	end

	if list1.animLoop15827239870.track then
		pcall(function()
			list1.animLoop15827239870.track:Stop()
		end)

		list1.animLoop15827239870.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.animLoop15827239870 and list1.animLoop15827239870.active then
		list1.stopAnimLoop15827239870()
		local animLoop15827239870Toggle = toggles.AnimLoop15827239870Toggle

		if animLoop15827239870Toggle and animLoop15827239870Toggle.SetValue then
			animLoop15827239870Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("AnimLoop15827239870Toggle", {
	Text = "转枪",
	Default = false,
	Tooltip = func6("每0.73秒播放一次转枪动画"),
	Callback = function(value)
		if value then
			list1.startAnimLoop15827239870()
		else
			list1.stopAnimLoop15827239870()
		end
	end,
})

list1.animCustomDual3 = { active = false, idleTrack = nil, walkTrack = nil, conn = nil, key = "animCustomDual3" }

list1.startAnimCustomDual3 = function()
	list1.startDual(list1.animCustomDual3, "rbxassetid://99319014110614", "rbxassetid://115122618346402")
end

list1.stopAnimCustomDual3 = function()
	list1.stopDual(list1.animCustomDual3)
end

list1.onCharacterAdded(function()
	if list1.animCustomDual3 and list1.animCustomDual3.active then
		list1.stopAnimCustomDual3()
		local animCustomDual3Toggle = toggles.AnimCustomDual3Toggle

		if animCustomDual3Toggle and animCustomDual3Toggle.SetValue then
			animCustomDual3Toggle:SetValue(false)
		end
	end
end)

obj38:AddToggle("AnimCustomDual3Toggle", {
	Text = "推大炮1",
	Default = false,
	Tooltip = func6("静止播放动画1，移动播放动画2"),
	Callback = function(value)
		if value then
			list1.startAnimCustomDual3()
		else
			list1.stopAnimCustomDual3()
		end
	end,
})

list1.animPlayOnce14860627011 = { active = false, track = nil, session = 0 }

list1.startAnimPlayOnce14860627011 = function()
	if list1.animPlayOnce14860627011.active then
		return
	end
	list1.AnimStopOthers("animPlayOnce14860627011")
	list1.animPlayOnce14860627011.active = true
	list1.animPlayOnce14860627011.session = list1.animPlayOnce14860627011.session + 1
	local session = list1.animPlayOnce14860627011.session
	list1.resetAnims()
	local value118, obj92 = func32()
	if not obj92 then
		list1.animPlayOnce14860627011.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://14860627011"
	local obj93 = obj92:LoadAnimation(animation)
	obj93.Priority = Enum.AnimationPriority.Action4
	obj93:Play()
	list1.animPlayOnce14860627011.track = obj93

	task.delay(20, function()
		if list1.animPlayOnce14860627011 and list1.animPlayOnce14860627011.active and list1.animPlayOnce14860627011.session == session then
			list1.stopAnimPlayOnce14860627011()
			local animPlayOnce14860627011Toggle = toggles.AnimPlayOnce14860627011Toggle

			if animPlayOnce14860627011Toggle and animPlayOnce14860627011Toggle.SetValue then
				animPlayOnce14860627011Toggle:SetValue(false)
			end
		end
	end)
end

list1.stopAnimPlayOnce14860627011 = function()
	if not list1.animPlayOnce14860627011.active then
		return
	end
	list1.animPlayOnce14860627011.active = false
	list1.animPlayOnce14860627011.session = list1.animPlayOnce14860627011.session + 1

	if list1.animPlayOnce14860627011.track then
		pcall(function()
			list1.animPlayOnce14860627011.track:Stop()
		end)

		list1.animPlayOnce14860627011.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.animPlayOnce14860627011 and list1.animPlayOnce14860627011.active then
		list1.stopAnimPlayOnce14860627011()
		local animPlayOnce14860627011Toggle = toggles.AnimPlayOnce14860627011Toggle

		if animPlayOnce14860627011Toggle and animPlayOnce14860627011Toggle.SetValue then
			animPlayOnce14860627011Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("AnimPlayOnce14860627011Toggle", {
	Text = "开心舞蹈",
	Default = false,
	Tooltip = func6("播放动画（20秒后自动停止）"),
	Callback = function(value)
		if value then
			list1.startAnimPlayOnce14860627011()
		else
			list1.stopAnimPlayOnce14860627011()
		end
	end,
})

list1.anim107068529359282 = { active = false, track = nil }

list1.startAnim107068529359282 = function()
	if list1.anim107068529359282.active then
		return
	end
	list1.anim107068529359282.active = true
	list1.resetAnims()
	local value119, obj94 = func32()
	if not obj94 then
		list1.anim107068529359282.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://107068529359282"
	local obj95 = obj94:LoadAnimation(animation)
	obj95.Priority = Enum.AnimationPriority.Action4
	obj95.Looped = true
	obj95:Play()
	list1.anim107068529359282.track = obj95
end

list1.stopAnim107068529359282 = function()
	if not list1.anim107068529359282.active then
		return
	end
	list1.anim107068529359282.active = false

	if list1.anim107068529359282.track then
		pcall(function()
			list1.anim107068529359282.track:Stop()
		end)

		list1.anim107068529359282.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.anim107068529359282 and list1.anim107068529359282.active then
		list1.stopAnim107068529359282()
		local anim107068529359282Toggle = toggles.Anim107068529359282Toggle

		if anim107068529359282Toggle and anim107068529359282Toggle.SetValue then
			anim107068529359282Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("Anim107068529359282Toggle", {
	Text = "疯子",
	Default = false,
	Tooltip = func6("循环播放指定动画"),
	Callback = function(value)
		if value then
			list1.startAnim107068529359282()
		else
			list1.stopAnim107068529359282()
		end
	end,
})

list1.anim127516132968916 = { active = false, track = nil }

list1.startAnim127516132968916 = function()
	if list1.anim127516132968916.active then
		return
	end
	list1.anim127516132968916.active = true
	list1.resetAnims()
	local value120, obj96 = func32()
	if not obj96 then
		list1.anim127516132968916.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://127516132968916"
	local obj97 = obj96:LoadAnimation(animation)
	obj97.Priority = Enum.AnimationPriority.Action4
	obj97.Looped = true
	obj97:Play()
	list1.anim127516132968916.track = obj97
end

list1.stopAnim127516132968916 = function()
	if not list1.anim127516132968916.active then
		return
	end
	list1.anim127516132968916.active = false

	if list1.anim127516132968916.track then
		pcall(function()
			list1.anim127516132968916.track:Stop()
		end)

		list1.anim127516132968916.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.anim127516132968916 and list1.anim127516132968916.active then
		list1.stopAnim127516132968916()
		local anim127516132968916Toggle = toggles.Anim127516132968916Toggle

		if anim127516132968916Toggle and anim127516132968916Toggle.SetValue then
			anim127516132968916Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("Anim127516132968916Toggle", {
	Text = "趴下",
	Default = false,
	Tooltip = func6("循环播放指定动画"),
	Callback = function(value)
		if value then
			list1.startAnim127516132968916()
		else
			list1.stopAnim127516132968916()
		end
	end,
})

list1.anim27432686 = { active = false, track = nil, pauseThread = nil }

list1.startAnim27432686 = function()
	if list1.anim27432686.active then
		return
	end
	list1.AnimStopOthers("anim27432686")
	list1.anim27432686.active = true
	list1.resetAnims()
	local value121, obj98 = func32()
	if not obj98 then
		list1.anim27432686.active = false
		return
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://27432686"
	local obj99 = obj98:LoadAnimation(animation)
	obj99.Priority = Enum.AnimationPriority.Action4
	obj99.Looped = true
	obj99:Play()
	list1.anim27432686.track = obj99

	if list1.anim27432686.pauseThread then
		task.cancel(list1.anim27432686.pauseThread)
		list1.anim27432686.pauseThread = nil
	end

	list1.anim27432686.pauseThread = task.spawn(function()
		task.wait(0.3)

		if list1.anim27432686.active and list1.anim27432686.track then
			pcall(function()
				list1.anim27432686.track:AdjustSpeed(0)
			end)
		end

		list1.anim27432686.pauseThread = nil
	end)
end

list1.stopAnim27432686 = function()
	if not list1.anim27432686.active then
		return
	end
	list1.anim27432686.active = false

	if list1.anim27432686.pauseThread then
		task.cancel(list1.anim27432686.pauseThread)
		list1.anim27432686.pauseThread = nil
	end

	if list1.anim27432686.track then
		pcall(function()
			list1.anim27432686.track:Stop()
		end)

		list1.anim27432686.track = nil
	end

	list1.resetAnims()
end

list1.onCharacterAdded(function()
	if list1.anim27432686 and list1.anim27432686.active then
		list1.stopAnim27432686()
		local anim27432686Toggle = toggles.Anim27432686Toggle

		if anim27432686Toggle and anim27432686Toggle.SetValue then
			anim27432686Toggle:SetValue(false)
		end
	end
end)

obj39:AddToggle("Anim27432686Toggle", {
	Text = "僵尸",
	Default = false,
	Tooltip = func6("播放0.3秒后暂停定格"),
	Callback = function(value)
		if value then
			list1.startAnim27432686()
		else
			list1.stopAnim27432686()
		end
	end,
})

do
	local flag57 = false
	local value122 = nil
	local value123 = nil

	list1.startAnim92032645117961 = function()
		if flag57 then
			return
		end
		flag57 = true
		list1.resetAnims()
		local value124, obj100 = func32()
		if not obj100 then
			flag57 = false
			return
		end
		value123 = obj100
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://92032645117961"
		local obj101 = obj100:LoadAnimation(animation)
		obj101.Priority = Enum.AnimationPriority.Action4
		obj101:Play()
		value122 = obj101

		obj101.Stopped:Connect(function()
			if flag57 then
				list1.stopAnim92032645117961()
				local anim92032645117961Toggle = toggles.Anim92032645117961Toggle

				if anim92032645117961Toggle and anim92032645117961Toggle.SetValue then
					anim92032645117961Toggle:SetValue(false)
				end
			end
		end)
	end

	list1.stopAnim92032645117961 = function()
		flag57 = false

		if value122 then
			pcall(function()
				value122:Stop()
			end)

			value122 = nil
		end

		value123 = nil
		list1.resetAnims()
	end

	list1.onCharacterAdded(function()
		if flag57 then
			list1.stopAnim92032645117961()
			local anim92032645117961Toggle = toggles.Anim92032645117961Toggle

			if anim92032645117961Toggle and anim92032645117961Toggle.SetValue then
				anim92032645117961Toggle:SetValue(false)
			end
		end
	end)
end

obj39:AddToggle("Anim92032645117961Toggle", {
	Text = "被抓走",
	Default = false,
	Tooltip = func6("播放动画（播放一次后自动关闭）"),
	Callback = function(value)
		if value then
			list1.startAnim92032645117961()
		else
			list1.stopAnim92032645117961()
		end
	end,
})

local value125 = nil

list1.startAnim17593577988 = function()
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		local animator2 = Instance.new("Animator")
		animator2.Parent = humanoid
		animator = animator2
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://17593577988"
	value125 = animator:LoadAnimation(animation)
	value125.Priority = Enum.AnimationPriority.Action4
	value125:Play()
end

list1.stopAnim17593577988 = function()
	if value125 then
		pcall(function()
			value125:Stop()
		end)

		value125 = nil
	end
end

obj39:AddToggle("Anim17593577988Toggle", {
	Text = "爬绳子",
	Default = false,
	Tooltip = func6("播放动画"),
	Callback = function(value)
		if value then
			list1.startAnim17593577988()
		else
			list1.stopAnim17593577988()
		end
	end,
})

local value126 = nil

list1.startAnim17871770160 = function()
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://17871770160"
	value126 = animator:LoadAnimation(animation)
	value126.Priority = Enum.AnimationPriority.Action4
	value126.Looped = true
	value126:Play()
end

list1.stopAnim17871770160 = function()
	if value126 then
		pcall(function()
			value126:Stop()
		end)

		value126 = nil
	end
end

obj39:AddToggle("Anim17871770160Toggle", {
	Text = "翻滚",
	Default = false,
	Tooltip = func6("循环播放动画"),
	Callback = function(value)
		if value then
			list1.startAnim17871770160()
		else
			list1.stopAnim17871770160()
		end
	end,
})

do
	local animationId = "rbxassetid://14686794862"
	local value127 = nil
	local value128 = nil
	local value129 = nil
	local flag58 = false
	-- join us: https://discord.gg/x7YbZeezpm

	local function func43()
		if value129 then
			pcall(function()
				value129:Stop()
			end)

			value129 = nil
		end

		flag58 = false

		if value128 then
			value128.Text = "开"
			value128.BackgroundColor3 = color(30, 30, 40)
		end
	end

	local function func44()
		func43()
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		local animator = humanoid:FindFirstChildOfClass("Animator")

		if not animator then
			local animator2 = Instance.new("Animator")
			animator2.Parent = humanoid
			animator = animator2
		end

		local animation = Instance.new("Animation")
		animation.AnimationId = animationId
		local obj102 = animator:LoadAnimation(animation)
		obj102.Priority = Enum.AnimationPriority.Action4
		obj102:Play()
		obj102:AdjustSpeed(0)
		value129 = obj102
		flag58 = true

		if value128 then
			value128.Text = "关"
			value128.BackgroundColor3 = color(200, 80, 80)
		end
	end

	list1.toggleNewAnimUI = function(param30)
		if param30 then
			if value127 then
				value127:Destroy()
			end

			local NewAnimUI, value130 = list1.createFloatingButton("NewAnimUI", "开", UDim2.new(0.5, 105, 0.45, 0), 18, function()
				if flag58 then
					func43()
				else
					func44()
				end
			end)

			value127 = NewAnimUI
			value128 = value130
			flag58 = false
		else
			if value127 then
				value127:Destroy()
				value127 = nil
				value128 = nil
			end

			func43()
		end
	end
end

obj39:AddToggle("NewAnimUIToggle", {
	Text = "打开遁地快捷栏",
	Default = false,
	Tooltip = func6("无"),
	Callback = function(value)
		list1.toggleNewAnimUI(value)
	end,
})

do
	local flag59 = false
	local value131 = nil
	local thread = nil
	local value132 = nil
	local value133 = nil

	local function func45()
		if flag59 then
			return
		end
		flag59 = true
		local value134, obj103 = func32()
		if not obj103 then
			flag59 = false
			return
		end
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://17871770160"
		local obj104 = obj103:LoadAnimation(animation)
		obj104.Priority = Enum.AnimationPriority.Action4
		obj104.Looped = true
		obj104:Play()
		value131 = obj104

		if thread then
			task.cancel(thread)
		end

		thread = task.spawn(function()
			task.wait(0.45)

			if flag59 and value131 then
				pcall(function()
					value131:AdjustSpeed(0)
				end)
			end

			thread = nil
		end)
	end

	local function func46()
		flag59 = false

		if thread then
			task.cancel(thread)
			thread = nil
		end

		if value131 then
			pcall(function()
				value131:Stop()
			end)

			value131 = nil
		end
	end

	local function func47()
		if value133 then
			return
		end

		local Anim17871770160UI, value135 = list1.createFloatingButton("Anim17871770160UI", "开启", UDim2.new(0.5, 175, 0.45, 0), 18, function()
			if flag59 then
				func46()
				value132.Text = "开启"
				value132.BackgroundColor3 = color(30, 30, 40)
			else
				func45()
				value132.Text = "关闭"
				value132.BackgroundColor3 = color(200, 80, 80)
			end
		end)

		value132 = value135
		value133 = Anim17871770160UI
	end

	local function func48()
		if value133 then
			value133:Destroy()
			value133 = nil
			value132 = nil
		end

		func46()
	end

	list1.onCharacterAdded(function()
		if flag59 then
			func46()

			if value132 then
				value132.Text = "开启"
				value132.BackgroundColor3 = color(30, 30, 40)
			end
		end
	end)

	list1.toggleAnim17871770160UI = function(param31)
		if param31 then
			func47()
		else
			func48()
		end
	end
end

list1.animCustomDual4 = { active = false, idleTrack = nil, walkTrack = nil, conn = nil, key = "animCustomDual4" }

list1.startAnimCustomDual4 = function()
	list1.startDual(list1.animCustomDual4, "rbxassetid://99319014110614", "rbxassetid://81750747292490")
end

list1.stopAnimCustomDual4 = function()
	list1.stopDual(list1.animCustomDual4)
end

list1.onCharacterAdded(function()
	if list1.animCustomDual4 and list1.animCustomDual4.active then
		list1.stopAnimCustomDual4()
		local animCustomDual4Toggle = toggles.AnimCustomDual4Toggle

		if animCustomDual4Toggle and animCustomDual4Toggle.SetValue then
			animCustomDual4Toggle:SetValue(false)
		end
	end
end)

obj38:AddToggle("AnimCustomDual4Toggle", {
	Text = "拉大炮2",
	Default = false,
	Tooltip = func6("静止播放动画1，移动播放动画2"),
	Callback = function(value)
		if value then
			list1.startAnimCustomDual4()
		else
			list1.stopAnimCustomDual4()
		end
	end,
})

local obj105
obj105 = tbl2.Extra:AddGroupbox({ Side = "Left", Name = "工兵", IconName = "hammer", Description = "修建近战" })
local obj106

do
	local obj107 = tbl2.Extra:AddGroupbox({ Side = "Right", Name = "军官 线列 水手", IconName = "users", Description = "武器功能" })
	list1.officer = list1.officer or {}
	list1.officer.autoReload = { enabled = false, monitoredTools = {}, notifyCooldown = 4, lastNotifyTime = 0 }
	list1.officer.autoReload.isGun = list1.sharedIsGun
	list1.officer.autoReload.getShotsLoaded = list1.sharedGetShotsLoaded
	list1.officer.autoReload.getRemote = list1.sharedGetRemote

	list1.officer.autoReload.tryReload = function(obj)
		if not list1.officer.autoReload.enabled then
			return
		end

		if not obj or not obj.Parent then
			return
		end

		if not list1.officer.autoReload.isGun(obj) then
			return
		end

		if list1.officer.autoReload.getShotsLoaded(obj) == 0 then
			local obj108 = list1.officer.autoReload.getRemote(obj)

			if obj108 then
				pcall(function()
					obj108:FireServer("Reload")
				end)
			end
		end
	end

	list1.officer.autoReload.watchTool = function(obj)
		if not obj or not list1.officer.autoReload.isGun(obj) then
			return
		end

		if list1.officer.autoReload.monitoredTools[obj] then
			return
		end
		local shotsLoaded = obj:FindFirstChild("ShotsLoaded")
		local flag60 = not shotsLoaded

		if not flag60 then
			flag60 = not (shotsLoaded:IsA("IntValue") or shotsLoaded:IsA("NumberValue"))
		end

		if flag60 then
			local players = workspace:FindFirstChild("Players")

			if players then
				local obj109 = players:FindFirstChild(localPlayer.Name)

				if obj109 then
					local obj110 = obj109:FindFirstChild(obj.Name)

					if obj110 then
						shotsLoaded = obj110:FindFirstChild("ShotsLoaded")
					end
				end
			end
		end

		if not shotsLoaded then
			return
		end
		local obj111 = list1.officer.autoReload.getRemote(obj)
		local n = shotsLoaded.Value or 0

		if list1.officer.autoReload.enabled and n == 0 and obj111 then
			pcall(function()
				obj111:FireServer("Reload")
			end)
		end

		local flag61 = false
		local connection = nil

		local connection2 = shotsLoaded.Changed:Connect(function()
			local value136 = shotsLoaded.Value

			if list1.officer.autoReload.enabled and value136 == 0 and obj111 and not flag61 then
				flag61 = true

				pcall(function()
					obj111:FireServer("Reload")
				end)

				task.delay(1.2, function()
					flag61 = false
				end)
			end

			n = value136
		end)

		connection = obj.AncestryChanged:Connect(function(child, parent)
			if not parent then
				if connection2 then
					connection2:Disconnect()
				end

				list1.officer.autoReload.monitoredTools[obj] = nil

				if connection then
					connection:Disconnect()
				end
			end
		end)

		list1.officer.autoReload.monitoredTools[obj] = connection2
	end

	list1.officer.autoReload.scanAllTools = function()
		for _, monitoredTool in list1.officer.autoReload.monitoredTools do
			if monitoredTool then
				monitoredTool:Disconnect()
			end
		end

		list1.officer.autoReload.monitoredTools = {}
		local backpack = localPlayer:FindFirstChild("Backpack")

		if backpack then
			for _, value137 in backpack:GetChildren() do
				if value137:IsA("Tool") and list1.officer.autoReload.isGun(value137) then
					list1.officer.autoReload.watchTool(value137)
				end
			end
		end

		local character = localPlayer.Character

		if character then
			for _, value138 in character:GetChildren() do
				if value138:IsA("Tool") and list1.officer.autoReload.isGun(value138) then
					list1.officer.autoReload.watchTool(value138)
				end
			end
		end
	end

	list1.officer.autoReload.enable = function()
		if list1.officer.autoReload.enabled then
			return
		end
		list1.officer.autoReload.enabled = true
		list1.officer.autoReload.scanAllTools()

		if list1.officer.autoReload.backpackConn then
			list1.officer.autoReload.backpackConn:Disconnect()
		end

		local function func49()
			local backpack = localPlayer:FindFirstChild("Backpack")
			if not backpack then
				return false
			end

			if list1.officer.autoReload.backpackConn then
				list1.officer.autoReload.backpackConn:Disconnect()
			end

			list1.officer.autoReload.backpackConn = backpack.ChildAdded:Connect(function(child)
				if child:IsA("Tool") and list1.officer.autoReload.isGun(child) then
					task.wait(0.1)

					if list1.officer.autoReload.enabled then
						list1.officer.autoReload.watchTool(child)
					end
				end
			end)

			return true
		end

		if not func49() then
			task.spawn(function()
				while list1.officer.autoReload.enabled and not list1.officer.autoReload.backpackConn do
					task.wait(0.5)
					func49()
				end
			end)
		end

		if list1.officer.autoReload.characterConn then
			list1.officer.autoReload.characterConn:Disconnect()
			list1.officer.autoReload.characterConn = nil
		end

		if localPlayer.Character then
			list1.officer.autoReload.characterConn = localPlayer.Character.ChildAdded:Connect(function(child)
				if child:IsA("Tool") and list1.officer.autoReload.isGun(child) then
					task.wait(0.1)

					if list1.officer.autoReload.enabled then
						list1.officer.autoReload.watchTool(child)
						list1.officer.autoReload.tryReload(child)
					end
				end
			end)
		end

		list1.notify(func5("自动换弹已开启"), 2)
	end

	list1.officer.autoReload.disable = function()
		list1.officer.autoReload.enabled = false

		for _, monitoredTool2 in list1.officer.autoReload.monitoredTools do
			if monitoredTool2 then
				monitoredTool2:Disconnect()
			end
		end

		list1.officer.autoReload.monitoredTools = {}

		if list1.officer.autoReload.backpackConn then
			list1.officer.autoReload.backpackConn:Disconnect()
			list1.officer.autoReload.backpackConn = nil
		end

		if list1.officer.autoReload.characterConn then
			list1.officer.autoReload.characterConn:Disconnect()
			list1.officer.autoReload.characterConn = nil
		end

		list1.notify(func5("自动换弹已关闭"), 2)
	end

	obj107:AddToggle("OfficerAutoReloadToggle", {
		Text = "自动换弹",
		Default = false,
		Tooltip = func6("枪械子弹打空后自动装填"),
		Callback = function(value)
			if value then
				list1.officer.autoReload.enable()
			else
				list1.officer.autoReload.disable()
			end
		end,
	})

	list1.officer = list1.officer or {}
	list1.officer.autoHolster = { enabled = false, isHolstering = false, monitoredTools = {} }
	list1.officer.autoHolster.isGun = list1.sharedIsGun
	list1.officer.autoHolster.getShotsLoaded = list1.sharedGetShotsLoaded

	list1.officer.autoHolster.holsterAndReequip = function(obj)
		if not list1.officer.autoHolster.enabled then
			return
		end

		if list1.officer.autoHolster.isHolstering then
			return
		end

		if not obj or not obj.Parent then
			return
		end
		list1.officer.autoHolster.isHolstering = true

		task.spawn(function()
			local character = localPlayer.Character
			local backpack = localPlayer:FindFirstChild("Backpack")

			if character and backpack and obj and obj.Parent == character then
				obj.Parent = backpack
				task.wait(0.05)

				if obj and obj.Parent == backpack then
					obj.Parent = character
				end
			end

			task.wait(0.05)
			list1.officer.autoHolster.isHolstering = false
		end)
	end

	list1.officer.autoHolster.watchTool = function(obj)
		if not obj or not list1.officer.autoHolster.isGun(obj) then
			return
		end

		if list1.officer.autoHolster.monitoredTools[obj] then
			return
		end
		local shotsLoaded = obj:FindFirstChild("ShotsLoaded")
		local flag62 = not shotsLoaded

		if not flag62 then
			flag62 = not (shotsLoaded:IsA("IntValue") or shotsLoaded:IsA("NumberValue"))
		end

		if flag62 then
			local players = workspace:FindFirstChild("Players")

			if players then
				local obj112 = players:FindFirstChild(localPlayer.Name)

				if obj112 then
					local obj113 = obj112:FindFirstChild(obj.Name)

					if obj113 then
						shotsLoaded = obj113:FindFirstChild("ShotsLoaded")
					end
				end
			end
		end

		if not shotsLoaded then
			return
		end
		local n = shotsLoaded.Value or 0
		local connection = nil

		local connection2 = shotsLoaded.Changed:Connect(function()
			local value139 = shotsLoaded.Value

			if list1.officer.autoHolster.enabled and type(value139) == "number" and type(n) == "number" and value139 > n then
				for i = n + 1, value139 do
					task.spawn(function()
						list1.officer.autoHolster.holsterAndReequip(obj)
					end)
				end
			end

			n = value139
		end)

		connection = obj.AncestryChanged:Connect(function(child, parent)
			if not parent then
				if connection2 then
					connection2:Disconnect()
				end

				list1.officer.autoHolster.monitoredTools[obj] = nil

				if connection then
					connection:Disconnect()
				end
			end
		end)

		list1.officer.autoHolster.monitoredTools[obj] = connection2
	end

	list1.officer.autoHolster.scanAllTools = function()
		for _, monitoredTool3 in list1.officer.autoHolster.monitoredTools do
			if monitoredTool3 then
				monitoredTool3:Disconnect()
			end
		end

		list1.officer.autoHolster.monitoredTools = {}
		local backpack = localPlayer:FindFirstChild("Backpack")

		if backpack then
			for _, value140 in backpack:GetChildren() do
				if value140:IsA("Tool") and list1.officer.autoHolster.isGun(value140) then
					list1.officer.autoHolster.watchTool(value140)
				end
			end
		end

		local character = localPlayer.Character

		if character then
			for _, value141 in character:GetChildren() do
				if value141:IsA("Tool") and list1.officer.autoHolster.isGun(value141) then
					list1.officer.autoHolster.watchTool(value141)
				end
			end
		end
	end

	list1.officer.autoHolster.start = function()
		if list1.officer.autoHolster.enabled then
			return
		end
		list1.officer.autoHolster.enabled = true
		list1.officer.autoHolster.scanAllTools()

		if list1.officer.autoHolster.backpackConn then
			list1.officer.autoHolster.backpackConn:Disconnect()
		end

		local function func50()
			local backpack = localPlayer:FindFirstChild("Backpack")
			if not backpack then
				return false
			end

			if list1.officer.autoHolster.backpackConn then
				list1.officer.autoHolster.backpackConn:Disconnect()
			end

			list1.officer.autoHolster.backpackConn = backpack.ChildAdded:Connect(function(child)
				if child:IsA("Tool") and list1.officer.autoHolster.isGun(child) then
					task.wait(0.1)

					if list1.officer.autoHolster.enabled then
						list1.officer.autoHolster.watchTool(child)
					end
				end
			end)

			return true
		end

		if not func50() then
			task.spawn(function()
				while list1.officer.autoHolster.enabled and not list1.officer.autoHolster.backpackConn do
					task.wait(0.5)
					func50()
				end
			end)
		end

		if list1.officer.autoHolster.characterConn then
			list1.officer.autoHolster.characterConn:Disconnect()
			list1.officer.autoHolster.characterConn = nil
		end

		if localPlayer.Character then
			list1.officer.autoHolster.characterConn = localPlayer.Character.ChildAdded:Connect(function(child)
				if child:IsA("Tool") and list1.officer.autoHolster.isGun(child) then
					task.wait(0.1)

					if list1.officer.autoHolster.enabled then
						list1.officer.autoHolster.watchTool(child)
					end
				end
			end)
		end

		list1.notify(func5("自动收枪已开启"), 2)
	end

	list1.officer.autoHolster.stop = function()
		list1.officer.autoHolster.enabled = false

		for _, monitoredTool4 in list1.officer.autoHolster.monitoredTools do
			if monitoredTool4 then
				monitoredTool4:Disconnect()
			end
		end

		list1.officer.autoHolster.monitoredTools = {}

		if list1.officer.autoHolster.backpackConn then
			list1.officer.autoHolster.backpackConn:Disconnect()
			list1.officer.autoHolster.backpackConn = nil
		end

		if list1.officer.autoHolster.characterConn then
			list1.officer.autoHolster.characterConn:Disconnect()
			list1.officer.autoHolster.characterConn = nil
		end

		list1.notify(func5("自动收枪已关闭"), 2)
	end

	obj107:AddToggle("OfficerAutoHolsterToggle", {
		Text = "换弹完成后自动重新装备武器",
		Default = false,
		Tooltip = func6("每装填一发子弹后自动收回枪械再装备"),
		Callback = function(value)
			if value then
				list1.officer.autoHolster.start()
			else
				list1.officer.autoHolster.stop()
			end
		end,
	})

	list1.officer.autoJump = {
		enabled = false,
		jumpHeight = 3,
		cooldown = 0.5,
		lastJump = 0,
		trackCache = {},
		animator = nil,
		humanoid = nil,
		monitoring = false,
	}

	local tbl27 = {
		"rbxassetid://17406577733",
		"rbxassetid://15669224658",
		"rbxassetid://12591948314",
		"rbxassetid://12333491302",
	}

	list1.officer.autoJump.isTargetAnim = function(flag63)
		for _, value142 in tbl27 do
			if flag63 == value142 then
				return true
			end
		end

		return false
	end

	list1.officer.autoJump.doJump = function()
		if not list1.officer.autoJump.humanoid or not list1.officer.autoJump.humanoid.Parent then
			return
		end
		local lastJump = list1.officer.autoJump.lastJump
		if clock() - lastJump < list1.officer.autoJump.cooldown then
			return
		end

		task.spawn(function()
			pcall(function()
				local result11 = clock2()

				while clock2() - result11 < 1 do
					local state = list1.officer.autoJump.humanoid:GetState()
					if not (state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Climbing) then
						task.wait(0.05)
						continue
					end
					break
				end

				local humanoidRootPart = list1.officer.autoJump.humanoid.Parent:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					local z = humanoidRootPart.AssemblyLinearVelocity.Z
					humanoidRootPart.AssemblyLinearVelocity = vector(humanoidRootPart.AssemblyLinearVelocity.X, sqrt(2 * workspace.Gravity * clamp(list1.officer.autoJump.jumpHeight, 0, 6)), z)
					list1.officer.autoJump.lastJump = clock()
				end
			end)
		end)
	end

	list1.officer.autoJump.startMonitoring = function()
		if list1.officer.autoJump.monitoring then
			return
		end
		list1.officer.autoJump.monitoring = true

		task.spawn(function()
			while list1.officer.autoJump.monitoring do
				if list1.officer.autoJump.animator then
					local ok, result = pcall(function()
						return list1.officer.autoJump.animator:GetPlayingAnimationTracks()
					end)

					if ok and result then
						for _, value143 in result do
							local animation = value143.Animation

							if animation and list1.officer.autoJump.isTargetAnim(animation.AnimationId) and not list1.officer.autoJump.trackCache[value143] then
								list1.officer.autoJump.trackCache[value143] = true
								pcall(list1.officer.autoJump.doJump)

								value143.Stopped:Once(function()
									list1.officer.autoJump.trackCache[value143] = nil
								end)
							end
						end
					end
				end

				task.wait(0.08)
			end
		end)
	end

	list1.officer.autoJump.stopMonitoring = function()
		list1.officer.autoJump.monitoring = false
		list1.officer.autoJump.trackCache = {}
	end

	list1.officer.autoJump.refreshCharacter = function(obj114)
		list1.officer.autoJump.humanoid = obj114 and obj114:FindFirstChildOfClass("Humanoid")
		list1.officer.autoJump.animator = nil

		if list1.officer.autoJump.humanoid then
			list1.officer.autoJump.animator = list1.officer.autoJump.humanoid:FindFirstChildOfClass("Animator")

			if not list1.officer.autoJump.animator then
				list1.officer.autoJump.animator = Instance.new("Animator")
				list1.officer.autoJump.animator.Parent = list1.officer.autoJump.humanoid
			end
		end

		list1.officer.autoJump.trackCache = {}
		list1.officer.autoJump.lastJump = 0
	end

	list1.officer.autoJump.start = function()
		if list1.officer.autoJump.enabled then
			return
		end
		list1.officer.autoJump.enabled = true
		list1.officer.autoJump.refreshCharacter(localPlayer.Character)
		list1.officer.autoJump.startMonitoring()
		list1.notify(func5("自动跳刀已开启"), 2)
	end

	list1.officer.autoJump.stop = function()
		list1.officer.autoJump.enabled = false
		list1.officer.autoJump.stopMonitoring()
		list1.notify(func5("自动跳刀已关闭"), 2)
	end

	list1.onCharacterAdded(function(param32)
		task.wait(0.2)

		if list1.officer.autoJump.enabled then
			list1.officer.autoJump.refreshCharacter(param32)
			list1.officer.autoJump.startMonitoring()
		end
	end)

	obj107:AddToggle("OfficerAutoJumpToggle", {
		Text = "自动跳刀",
		Default = false,
		Tooltip = func6("军刀前刺动画时自动跳跃"),
		Callback = function(value)
			if value then
				list1.officer.autoJump.start()
			else
				list1.officer.autoJump.stop()
			end
		end,
	})

	list1.martyr = list1.martyr or {}
	list1.martyr.autoCharge = { enabled = false, thread = nil }

	list1.martyr.autoCharge.loop = function()
		while list1.martyr.autoCharge.enabled do
			local character = localPlayer.Character

			if character then
				for _, value144 in character:GetChildren() do
					if value144:IsA("Tool") then
						local remoteEvent = value144:FindFirstChild("RemoteEvent")

						if remoteEvent then
							pcall(function()
								remoteEvent:FireServer("Charge")
							end)
						end
					end
				end
			end

			task.wait(0.125)
		end
	end

	list1.martyr.autoCharge.start = function()
		if list1.martyr.autoCharge.thread then
			return
		end
		list1.martyr.autoCharge.enabled = true
		list1.martyr.autoCharge.thread = task.spawn(list1.martyr.autoCharge.loop)
		list1.notify(func5("自动冲锋已开启"), 2)
	end

	list1.martyr.autoCharge.stop = function()
		list1.martyr.autoCharge.enabled = false

		if list1.martyr.autoCharge.thread then
			task.cancel(list1.martyr.autoCharge.thread)
			list1.martyr.autoCharge.thread = nil
		end

		list1.notify(func5("自动冲锋已关闭"), 2)
	end

	list1.onCharacterAdded(function()
		if list1.martyr.autoCharge.enabled then
			task.wait(0.5)
			list1.martyr.autoCharge.stop()
			task.wait(0.1)
			list1.martyr.autoCharge.start()
		end
	end)

	obj107:AddToggle("MartyrAutoChargeToggle", {
		Text = "自动冲锋",
		Default = false,
		Tooltip = func6("能量满后自动开启冲锋"),
		Callback = function(value)
			if value then
				list1.martyr.autoCharge.start()
			else
				list1.martyr.autoCharge.stop()
			end
		end,
	})

	list1.martyr.autoBlackKnife = { enabled = false, thread = nil, cd = {}, range = 15, teamRange = 7 }

	list1.martyr.autoBlackKnife.getHRP = function(instance15)
		return instance15 and instance15:FindFirstChild("HumanoidRootPart")
	end

	list1.martyr.autoBlackKnife.getWeapon = function()
		local character = localPlayer.Character
		if not character then
			return nil
		end

		for _, value145 in character:GetChildren() do
			if value145:IsA("Tool") and value145:GetAttribute("Melee") then
				return value145
			end
		end

		return character:FindFirstChildOfClass("Tool")
	end

	list1.martyr.autoBlackKnife.getBarrelZombies = function()
		local tbl28 = {}
		local zombies = workspace:FindFirstChild("Zombies")

		if zombies then
			for _, value146 in zombies:GetChildren() do
				if value146:IsA("Model") and (value146:GetAttribute("Type") == "Barrel" or value146:FindFirstChild("Barrel")) then
					table.insert(tbl28, value146)
				end
			end
		end

		return tbl28
	end

	list1.martyr.autoBlackKnife.attackBarrel = function(instance16)
		if not instance16 then
			return false
		end
		local obj115 = list1.martyr.autoBlackKnife.getWeapon()
		if not obj115 then
			return false
		end
		local remoteEvent = obj115:FindFirstChild("RemoteEvent")
		if not remoteEvent then
			return false
		end
		local head = instance16:FindFirstChild("Head")
		if not head then
			return false
		end
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart then
			pcall(function()
				humanoidRootPart.CFrame = cframe(humanoidRootPart.Position, vector(head.Position.X, humanoidRootPart.Position.Y, head.Position.Z))
			end)
		end

		pcall(function()
			remoteEvent:FireServer("Swing", "Side")
			remoteEvent:FireServer("HitZombie", instance16, head.Position, true)
		end)

		return true
	end

	list1.martyr.autoBlackKnife.loop = function()
		while list1.martyr.autoBlackKnife.enabled do
			task.wait(0.15)
			local character = localPlayer.Character and list1.martyr.autoBlackKnife.getHRP(localPlayer.Character)

			if character then
				for _, getBarrelZomby in list1.martyr.autoBlackKnife.getBarrelZombies(), nil, nil do
					if list1.martyr.autoBlackKnife.enabled then
						local humanoidRootPart = getBarrelZomby:FindFirstChild("HumanoidRootPart")

						if humanoidRootPart then
							if not (list1.martyr.autoBlackKnife.range < (humanoidRootPart.Position - character.Position).Magnitude) then
								local flag64 = false
								local str5 = ""

								for _, getPlayer7 in obj4:GetPlayers() do
									if getPlayer7 == localPlayer then
										flag64 = false
										str5 = ""
									else
										local character2 = getPlayer7.Character and list1.martyr.autoBlackKnife.getHRP(getPlayer7.Character)

										if character2 and (character2.Position - humanoidRootPart.Position).Magnitude <= list1.martyr.autoBlackKnife.teamRange then
											str5 = getPlayer7.Name
											flag64 = true
											break
										else
											flag64 = false
											str5 = ""
										end
									end
								end

								if flag64 then
									local str6 = str5 .. tostring(getBarrelZomby)
									local flag65 = list1.martyr.autoBlackKnife.cd[str6]

									if flag65 then
										local num18 = list1.martyr.autoBlackKnife.cd[str6]
										flag65 = clock() - num18 < 0.5
									end

									if not flag65 then
										list1.martyr.autoBlackKnife.cd[str6] = clock()

										for i = 1, 3 do
											list1.martyr.autoBlackKnife.attackBarrel(getBarrelZomby)
											task.wait(0.05)
										end
									end
								end
							end
						end

						continue
					end

					break
				end
			end
		end
	end

	list1.martyr.autoBlackKnife.start = function()
		if list1.martyr.autoBlackKnife.thread then
			return
		end
		list1.martyr.autoBlackKnife.enabled = true
		list1.martyr.autoBlackKnife.cd = {}
		list1.martyr.autoBlackKnife.thread = task.spawn(list1.martyr.autoBlackKnife.loop)
		list1.notify(func5("自动黑刀已开启"), 2)
	end

	list1.martyr.autoBlackKnife.stop = function()
		list1.martyr.autoBlackKnife.enabled = false

		if list1.martyr.autoBlackKnife.thread then
			task.cancel(list1.martyr.autoBlackKnife.thread)
			list1.martyr.autoBlackKnife.thread = nil
		end

		list1.martyr.autoBlackKnife.cd = {}
		list1.notify(func5("自动黑刀已关闭"), 2)
	end

	obj107:AddToggle("MartyrAutoBlackKnifeToggle", {
		Text = "自动黑刀",
		Default = false,
		Tooltip = func6("队友靠近自爆时自动攻击"),
		Callback = function(value)
			if value then
				list1.martyr.autoBlackKnife.start()
			else
				list1.martyr.autoBlackKnife.stop()
			end
		end,
	})

	obj106 = func1(game:GetService("Workspace"))
	local obj116 = localPlayer
	list1.customBlackGunEnabled = false
	list1.customBlackGunNoEquip = false
	list1.customBlackGunCooldown = 0.3
	list1.customBlackGunEquipDelay = 0.1
	list1.customBlackGunBarrelDistance = 10
	list1.customWallCheckEnabled = false
	list1.customShootingThread = nil
	list1.customShootingRunning = false

	list1.isGun = function(obj)
		if not obj or not obj:IsA("Tool") then
			return false
		end
		local animations = obj:FindFirstChild("Animations")

		if animations then
			animations = animations:FindFirstChild("Aim") or animations:FindFirstChild("Aiming")
		end

		if animations then
			return true
		end
		return list1.GUN_NAME_SET[obj.Name] == true
	end

	list1.getShotsLoaded = list1.sharedGetShotsLoaded
	list1.getRemote = list1.sharedGetRemote

	list1.getAnyGun = function()
		local character = obj116.Character
		local backpack = obj116:FindFirstChild("Backpack")

		if backpack then
			for _, value147 in backpack:GetChildren() do
				if value147:IsA("Tool") and list1.isGun(value147) then
					local flag66 = list1.getShotsLoaded(value147)
					if flag66 and flag66 > 0 then
						return value147
					end
				end
			end
		end

		if character then
			for _, value148 in character:GetChildren() do
				if value148:IsA("Tool") and list1.isGun(value148) then
					local flag67 = list1.getShotsLoaded(value148)
					if flag67 and flag67 > 0 then
						return value148
					end
				end
			end
		end

		return nil
	end

	list1.hasAnyAmmo = function()
		local backpack = obj116:FindFirstChild("Backpack")

		if backpack then
			for _, value149 in backpack:GetChildren() do
				if value149:IsA("Tool") and list1.isGun(value149) then
					local flag68 = list1.getShotsLoaded(value149)
					if flag68 and flag68 > 0 then
						return true
					end
				end
			end
		end

		local character = obj116.Character

		if character then
			for _, value150 in character:GetChildren() do
				if value150:IsA("Tool") and list1.isGun(value150) then
					local flag69 = list1.getShotsLoaded(value150)
					if flag69 and flag69 > 0 then
						return true
					end
				end
			end
		end

		return false
	end

	list1.isWallBetween = function(num19, num20, param33)
		if not list1.customWallCheckEnabled then
			return false
		end
		local n = num20 - num19
		if n.Magnitude <= 0 then
			return false
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local filterDescendantsInstances = {}

		for _, getPlayer8 in obj4:GetPlayers() do
			if getPlayer8.Character then
				table.insert(filterDescendantsInstances, getPlayer8.Character)
			end
		end

		local zombies = obj106:FindFirstChild("Zombies")

		if zombies then
			table.insert(filterDescendantsInstances, zombies)
		end

		if param33 then
			table.insert(filterDescendantsInstances, param33)
		end

		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		return obj106:Raycast(num19, n, raycastParams) ~= nil
	end

	list1.hasPlayerNearBomber = function(instance17, param34)
		local humanoidRootPart = instance17:FindFirstChild("HumanoidRootPart") or instance17:FindFirstChild("Torso")
		if not humanoidRootPart then
			return false
		end
		local position = humanoidRootPart.Position

		for _, getPlayer9 in obj4:GetPlayers() do
			if getPlayer9 == obj116 then
				continue
			end
			local character = getPlayer9.Character

			if character then
				local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")

				if humanoidRootPart2 then
					if (position - humanoidRootPart2.Position).Magnitude <= param34 then
						return true
					end
				end
			end
		end

		return false
	end

	list1.getClosestBomber = function()
		local character = obj116.Character
		if not character then
			return nil, nil
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil, nil
		end
		local position = humanoidRootPart.Position
		local tbl29 = {}
		local camera = obj106:FindFirstChild("Camera")

		if camera then
			table.insert(tbl29, camera)
		end

		local zombies = obj106:FindFirstChild("Zombies")

		if zombies then
			table.insert(tbl29, zombies)
		end

		local n = 200
		local value151 = nil
		local value152 = nil

		for _, value153 in tbl29 do
			for _, getDescendant17 in value153:GetDescendants() do
				local isModel = getDescendant17:IsA("Model")
				--[[ ＳＬ | Ｓｏｕｒｃｅ Ｌｅａｋ :: discord.gg/x7YbZeezpm ]]

				if isModel then
					isModel = getDescendant17.Name == "m_Zombie" or getDescendant17:GetAttribute("Type") == "Barrel" or getDescendant17:FindFirstChild("Barrel")
				end

				if isModel then
					if getDescendant17:GetAttribute("Type") == "Barrel" or getDescendant17:FindFirstChild("Barrel") then
						local barrel = getDescendant17:FindFirstChild("Barrel") or getDescendant17:FindFirstChild("Head") or getDescendant17:FindFirstChild("HumanoidRootPart")

						if not (not barrel or not barrel:IsA("BasePart")) then
							local magnitude = (barrel.Position - position).Magnitude

							if magnitude <= 200 and magnitude < n then
								if not list1.isWallBetween(position, barrel.Position, getDescendant17) then
									n = magnitude
									value151 = barrel
									value152 = getDescendant17
								end
							end
						end
					end
				end
			end
		end

		return value151, value152
	end

	list1.shootAtTarget = function(obj, param35, flag70)
		if not flag70 or not obj then
			return
		end
		local obj117 = list1.getRemote(flag70)
		if not obj117 then
			return
		end
		local character = obj116.Character
		if not character then
			return
		end
		local model = character:FindFirstChild("Model") or character
		local serverTimeNow = obj106:GetServerTimeNow()

		pcall(function()
			obj117:FireServer("Fire", model, obj.Position, serverTimeNow)
		end)
	end

	list1.customShootingLoop = function()
		list1.customShootingRunning = true
		local flag71, flag72, character, flag73

		while true do
			local customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
			local exitTo = nil
			local flag74, flag75, flag76

			while customShootingRunning do
				local flag77, flag78, backpack, isTool, flag79

				if not list1.hasAnyAmmo() then
					task.wait(0.5)

					while list1.customBlackGunEnabled and not list1.hasAnyAmmo() do
						task.wait(0.5)
					end

					if list1.customBlackGunEnabled then
						flag71, flag72 = list1.getClosestBomber()
						flag77 = not flag71
						flag78 = flag77 or not flag72

						if flag78 then
							exitTo = 8
							break
						elseif not list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
							exitTo = 9
							break
						else
							character = obj116.Character

							if not character then
								exitTo = 10
								break
							else
								flag73 = list1.getAnyGun()

								if not flag73 then
									if not list1.customBlackGunNoEquip then
										backpack = obj116:FindFirstChild("Backpack")

										if backpack then
											for _, value154 in backpack:GetChildren() do
												isTool = value154:IsA("Tool") and list1.isGun(value154)

												if isTool then
													flag79 = list1.getShotsLoaded(value154)
													flag79 = flag79 and flag79 > 0

													if flag79 then
														value154.Parent = character
														task.wait(0.1)
														flag73 = value154
														break
													end
												end
											end
										end
									end

									if not flag73 then
										exitTo = 13
										break
									else
										flag74 = not list1.customBlackGunNoEquip
										flag75 = flag74 and flag73.Parent ~= character

										if flag75 then
											flag73.Parent = character
											task.wait(0.1)

											if flag73.Parent ~= character then
												task.wait(0.1)
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											elseif list1.getShotsLoaded(flag73) == 0 then
												task.wait(0.1)
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											else
												task.wait(list1.customBlackGunEquipDelay)
												flag76 = not flag71.Parent or not flag72.Parent

												if flag76 then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												elseif not list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												elseif list1.getShotsLoaded(flag73) == 0 then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												else
													list1.shootAtTarget(flag71, flag72, flag73)
													task.wait(list1.customBlackGunCooldown)
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												end
											end
										elseif list1.getShotsLoaded(flag73) == 0 then
											task.wait(0.1)
											customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
										else
											task.wait(list1.customBlackGunEquipDelay)
											flag76 = not flag71.Parent or not flag72.Parent

											if flag76 then
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											elseif not list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											elseif list1.getShotsLoaded(flag73) == 0 then
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											else
												list1.shootAtTarget(flag71, flag72, flag73)
												task.wait(list1.customBlackGunCooldown)
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											end
										end

										continue
									end
								else
									flag74 = not list1.customBlackGunNoEquip
									flag75 = flag74 and flag73.Parent ~= character

									if flag75 then
										flag73.Parent = character
										task.wait(0.1)

										if flag73.Parent ~= character then
											exitTo = 12
											break
										else
											if list1.getShotsLoaded(flag73) == 0 then
												task.wait(0.1)
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											else
												task.wait(list1.customBlackGunEquipDelay)
												flag76 = not flag71.Parent or not flag72.Parent

												if flag76 then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												elseif not list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												elseif list1.getShotsLoaded(flag73) == 0 then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												else
													list1.shootAtTarget(flag71, flag72, flag73)
													task.wait(list1.customBlackGunCooldown)
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												end
											end

											continue
										end
									else
										exitTo = 11
										break
									end
								end
							end
						end
					end
				else
					flag71, flag72 = list1.getClosestBomber()
					flag77 = not flag71
					flag78 = flag77 or not flag72

					if flag78 then
						exitTo = 1
						break
					elseif not list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
						exitTo = 2
						break
					else
						character = obj116.Character

						if not character then
							exitTo = 3
							break
						else
							flag73 = list1.getAnyGun()

							if not flag73 then
								if not list1.customBlackGunNoEquip then
									backpack = obj116:FindFirstChild("Backpack")

									if backpack then
										for _, value155 in backpack:GetChildren() do
											isTool = value155:IsA("Tool") and list1.isGun(value155)

											if isTool then
												flag79 = list1.getShotsLoaded(value155)
												flag79 = flag79 and flag79 > 0

												if flag79 then
													value155.Parent = character
													task.wait(0.1)
													flag73 = value155
													break
												end
											end
										end
									end
								end

								if not flag73 then
									exitTo = 5
									break
								else
									flag74 = not list1.customBlackGunNoEquip
									flag75 = flag74 and flag73.Parent ~= character

									if flag75 then
										flag73.Parent = character
										task.wait(0.1)

										if flag73.Parent ~= character then
											exitTo = 7
											break
										else
											if list1.getShotsLoaded(flag73) == 0 then
												task.wait(0.1)
												customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
											else
												task.wait(list1.customBlackGunEquipDelay)
												flag76 = not flag71.Parent or not flag72.Parent

												if flag76 then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												elseif not list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												elseif list1.getShotsLoaded(flag73) == 0 then
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												else
													list1.shootAtTarget(flag71, flag72, flag73)
													task.wait(list1.customBlackGunCooldown)
													customShootingRunning = list1.customBlackGunEnabled and list1.customShootingRunning
												end
											end

											continue
										end
									else
										exitTo = 6
										break
									end
								end
							else
								exitTo = 4
								break
							end
						end
					end
				end

				break
			end

			if exitTo == 1 then
				task.wait(0.15)
				continue
			end

			if exitTo == 2 then
				task.wait(0.15)
				continue
			end

			if exitTo == 3 then
				task.wait(0.15)
				continue
			end

			if exitTo == 4 then
				flag74 = not list1.customBlackGunNoEquip
				flag75 = flag74 and flag73.Parent ~= character

				if flag75 then
					flag73.Parent = character
					task.wait(0.1)

					if flag73.Parent ~= character then
						task.wait(0.1)
					elseif list1.getShotsLoaded(flag73) == 0 then
						task.wait(0.1)
					else
						task.wait(list1.customBlackGunEquipDelay)
						flag76 = not flag71.Parent or not flag72.Parent

						if not flag76 then
							if list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
								if list1.getShotsLoaded(flag73) ~= 0 then
									list1.shootAtTarget(flag71, flag72, flag73)
									task.wait(list1.customBlackGunCooldown)
								end
							end
						end
					end
				elseif list1.getShotsLoaded(flag73) == 0 then
					task.wait(0.1)
				else
					task.wait(list1.customBlackGunEquipDelay)
					flag76 = not flag71.Parent or not flag72.Parent

					if not flag76 then
						if list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
							if list1.getShotsLoaded(flag73) ~= 0 then
								list1.shootAtTarget(flag71, flag72, flag73)
								task.wait(list1.customBlackGunCooldown)
							end
						end
					end
				end

				continue
			end

			if exitTo == 5 then
				task.wait(0.3)
				continue
			end

			if exitTo == 6 then
				if list1.getShotsLoaded(flag73) == 0 then
					task.wait(0.1)
				else
					task.wait(list1.customBlackGunEquipDelay)
					flag76 = not flag71.Parent or not flag72.Parent

					if not flag76 then
						if list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
							if list1.getShotsLoaded(flag73) ~= 0 then
								list1.shootAtTarget(flag71, flag72, flag73)
								task.wait(list1.customBlackGunCooldown)
							end
						end
					end
				end

				continue
			end

			if exitTo == 7 then
				task.wait(0.1)
				continue
			end

			if exitTo == 8 then
				task.wait(0.15)
				continue
			end

			if exitTo == 9 then
				task.wait(0.15)
				continue
			end

			if exitTo == 10 then
				task.wait(0.15)
				continue
			end

			if exitTo == 11 then
				if list1.getShotsLoaded(flag73) == 0 then
					task.wait(0.1)
				else
					task.wait(list1.customBlackGunEquipDelay)
					flag76 = not flag71.Parent or not flag72.Parent

					if not flag76 then
						if list1.hasPlayerNearBomber(flag72, list1.customBlackGunBarrelDistance) then
							if list1.getShotsLoaded(flag73) ~= 0 then
								list1.shootAtTarget(flag71, flag72, flag73)
								task.wait(list1.customBlackGunCooldown)
							end
						end
					end
				end

				continue
			end

			if exitTo == 12 then
				task.wait(0.1)
				continue
			end

			if exitTo == 13 then
				task.wait(0.3)
				continue
			end
			break
		end

		list1.customShootingRunning = false

		if list1.customShootingThread then
			list1.customShootingThread = nil
		end
	end

	list1.startCustomShooting = function()
		if list1.customShootingThread then
			task.cancel(list1.customShootingThread)
			list1.customShootingThread = nil
		end

		list1.customShootingRunning = false
		list1.customShootingThread = task.spawn(list1.customShootingLoop)
	end

	list1.stopCustomShooting = function()
		list1.customBlackGunEnabled = false
		list1.customShootingRunning = false

		if list1.customShootingThread then
			task.cancel(list1.customShootingThread)
			list1.customShootingThread = nil
		end
	end

	list1.radiusCircle = { enabled = false, visuals = {}, updateConn = nil, zombieAddedDisposer = nil }
	list1.radiusCircle._lastColorCheck = setmetatable({}, { __mode = "k" })
	local brickColor = BrickColor.new("Bright red")
	local brickColor2 = BrickColor.new("Bright green")

	list1.radiusCircle.createCircle = function(instance18)
		if list1.radiusCircle.visuals[instance18] then
			pcall(list1.radiusCircle.visuals[instance18].Destroy, list1.radiusCircle.visuals[instance18])
			list1.radiusCircle.visuals[instance18] = nil
		end

		if not (instance18:FindFirstChild("HumanoidRootPart") or instance18:FindFirstChild("Torso")) then
			return nil
		end
		local customBlackGunBarrelDistance = list1.customBlackGunBarrelDistance or 10
		local part = Instance.new("Part")
		part.Name = "RadiusCircle"
		part.Shape = Enum.PartType.Cylinder
		part.Size = vector(0.3, customBlackGunBarrelDistance * 2, customBlackGunBarrelDistance * 2)
		part.BrickColor = brickColor
		part.Material = Enum.Material.Neon
		part.Transparency = 0.6
		part.Anchored = false
		part.CanCollide = false
		part.CanQuery = false
		part.Parent = obj106
		return part
	end

	list1.radiusCircle.updateVisual = function(instance19, part3)
		if not part3 or not instance19 or not part3.Parent then
			return
		end
		local humanoidRootPart = instance19:FindFirstChild("HumanoidRootPart") or instance19:FindFirstChild("Torso")
		if not humanoidRootPart then
			return
		end
		local position = humanoidRootPart.Position
		part3.CFrame = cframe(position.X, position.Y - 2.5, position.Z) * CFrame.Angles(0, 0, 1.5707963267948966)
		local customBlackGunBarrelDistance = list1.customBlackGunBarrelDistance or 10

		if abs(part3.Size.Y - customBlackGunBarrelDistance * 2) > 0.01 then
			part3.Size = vector(0.3, customBlackGunBarrelDistance * 2, customBlackGunBarrelDistance * 2)
		end

		local result12 = clock2()
		if result12 - (list1.radiusCircle._lastColorCheck[part3] or 0) < 0.1 then
			return
		end
		list1.radiusCircle._lastColorCheck[part3] = result12
		local flag80 = false

		for _, getPlayer10 in obj4:GetPlayers() do
			if getPlayer10 ~= localPlayer then
				local character = getPlayer10.Character

				if character then
					local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart2 then
						if (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude <= customBlackGunBarrelDistance then
							flag80 = true
							break
						end
					end
				end
			end
		end

		part3.BrickColor = flag80 and brickColor2 or brickColor
	end

	list1.radiusCircle.updateAll = function()
		for k, visual in list1.radiusCircle.visuals do
			if k and k.Parent and visual and visual.Parent then
				list1.radiusCircle.updateVisual(k, visual)
			else
				if visual then
					pcall(visual.Destroy, visual)
				end

				list1.radiusCircle.visuals[k] = nil
			end
		end
	end

	list1.radiusCircle.addZombie = function(instance20)
		if not list1.radiusCircle.enabled then
			return
		end

		if not instance20:IsA("Model") then
			return
		end

		if not (instance20:GetAttribute("Type") == "Barrel" or instance20:FindFirstChild("Barrel")) then
			return
		end

		if list1.radiusCircle.visuals[instance20] then
			return
		end
		local value156 = list1.radiusCircle.createCircle(instance20)

		if value156 then
			list1.radiusCircle.visuals[instance20] = value156
			list1.radiusCircle.updateVisual(instance20, value156)
		end
	end

	list1.radiusCircle.onZombieAdded = function(obj)
		if not list1.radiusCircle.enabled or not obj:IsA("Model") then
			return
		end

		task.spawn(function()
			local barrel = obj:GetAttribute("Type") == "Barrel" or obj:FindFirstChild("Barrel")

			if not barrel and obj.Parent then
				task.wait(0.5)
				barrel = obj.Parent and (obj:GetAttribute("Type") == "Barrel" or obj:FindFirstChild("Barrel"))
			end

			if barrel and obj.Parent then
				list1.radiusCircle.addZombie(obj)
			end
		end)
	end

	list1.radiusCircle.start = function()
		if list1.radiusCircle.updateConn then
			return
		end
		list1.radiusCircle.enabled = true

		for _, getDescendant18 in obj106:GetDescendants() do
			if getDescendant18.Name == "RadiusCircle" then
				getDescendant18:Destroy()
			end
		end

		list1.radiusCircle.visuals = {}
		list1.ZombieWatch.start()

		list1.radiusCircle.zombieAddedDisposer = list1.ZombieWatch.onAdded(function(param36)
			list1.radiusCircle.onZombieAdded(param36)
		end)

		list1.ZombieWatch.forEach(function(param37)
			list1.radiusCircle.addZombie(param37)
		end)

		list1.radiusCircle.updateConn = obj5.RenderStepped:Connect(function()
			if list1.radiusCircle.enabled then
				list1.radiusCircle.updateAll()
			end
		end)
	end

	list1.radiusCircle.stop = function()
		list1.radiusCircle.enabled = false

		if list1.radiusCircle.updateConn then
			list1.radiusCircle.updateConn:Disconnect()
			list1.radiusCircle.updateConn = nil
		end

		if list1.radiusCircle.zombieAddedDisposer then
			list1.radiusCircle.zombieAddedDisposer()
			list1.radiusCircle.zombieAddedDisposer = nil
		end

		for _, visual2 in list1.radiusCircle.visuals do
			pcall(visual2.Destroy, visual2)
		end

		list1.radiusCircle.visuals = {}
	end

	list1.radiusCircle.updateRadius = function(customBlackGunBarrelDistance)
		list1.customBlackGunBarrelDistance = customBlackGunBarrelDistance

		if list1.radiusCircle.enabled then
			list1.radiusCircle.updateAll()
		end
	end

	obj107:AddToggle("CustomBlackGunToggle", {
		Text = "自动黑枪",
		Default = false,
		Tooltip = func6("自动射击自爆僵尸"),
		Callback = function(customBlackGunEnabled)
			list1.customBlackGunEnabled = customBlackGunEnabled

			if customBlackGunEnabled then
				list1.startCustomShooting()
			else
				list1.stopCustomShooting()
			end
		end,
	})

	obj107:AddToggle("CustomBlackGunNoEquip", {
		Text = "无需装备武器",
		Default = false,
		Tooltip = func6("开启后直接从背包调用枪械射击，不需要装备到手上"),
		Callback = function(customBlackGunNoEquip)
			list1.customBlackGunNoEquip = customBlackGunNoEquip
		end,
	})

	obj107:AddToggle("CustomBlackGunWallCheck", {
		Text = "墙体检测",
		Default = false,
		Tooltip = func6("开启后不会射击被墙体遮挡的自爆"),
		Callback = function(customWallCheckEnabled)
			list1.customWallCheckEnabled = customWallCheckEnabled
		end,
	})

	obj107:AddToggle("RadiusCircleToggle", {
		Text = "显示黑枪半径",
		Default = false,
		Tooltip = func6("显示自爆周围的检测范围圆环"),
		Callback = function(value)
			if value then
				list1.radiusCircle.start()
			else
				list1.radiusCircle.stop()
			end
		end,
	})

	obj107:AddSlider("CustomBlackGunRange", {
		Text = "检测范围",
		Default = 10,
		Min = 1,
		Max = 20,
		Suffix = " 格",
		Tooltip = func6("检测自爆附近玩家的范围（圆环大小同步变化）"),
		Callback = function(customBlackGunBarrelDistance)
			list1.customBlackGunBarrelDistance = customBlackGunBarrelDistance
			list1.radiusCircle.updateRadius(customBlackGunBarrelDistance)
		end,
	})
end

if not list1.SilentAim then
	list1.SilentAim = {}
end

do
	local silentAim = list1.SilentAim
	silentAim.Enabled = false
	silentAim.SilentAimSelectedTypes = {}
	silentAim.SilentAimEnabledTypes = {}
	silentAim.SilentAimZombieTypes = { "Bomber", "Cuirassier", "Runner", "Zapper", "Igniter", "Shambler" }
	silentAim.SILENT_AIM_USE_FOV = false
	silentAim.SILENT_AIM_SHOW_FOV = false
	silentAim.SILENT_AIM_MOBILE_FOV = false
	silentAim.SILENT_AIM_FOV_SIZE = 50
	silentAim.SilentAimCurrentTarget = nil
	silentAim.SilentAimCurrentModel = nil
	silentAim.SilentAimUpdateConn = nil
	silentAim.oldFire = nil
	silentAim.CHECK_WALLS = true
	silentAim.MAX_TARGET_RANGE = 200
	silentAim.PREDICTION_ENABLED = false
	silentAim.indicatorData = nil
	silentAim.indicatorPart = nil

	for _, silentAimZombieType in silentAim.SilentAimZombieTypes do
		silentAim.SilentAimEnabledTypes[silentAimZombieType] = false
	end

	local function func51()
		return list1.sharedGetCurrentBulletSpeed()
	end

	local function func52()
		return list1.sharedGetPing()
	end

	silentAim.isWorldPosInSilentAimFov = function(param38)
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			return false
		end
		local value157, flag81 = currentCamera:WorldToViewportPoint(param38)
		if not flag81 then
			return false
		end
		local num21 = vector2(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
		return (vector2(value157.X, value157.Y) - num21).Magnitude <= silentAim.SILENT_AIM_FOV_SIZE
	end

	silentAim.UpdateSilentAimFovCircle = function()
		local currentCamera = workspace.CurrentCamera

		if silentAim.SILENT_AIM_SHOW_FOV and currentCamera and not silentAim.fovCircleDrawing then
			silentAim.fovCircleDrawing = Drawing.new("Circle")
			silentAim.fovCircleDrawing.Thickness = 1.5
			silentAim.fovCircleDrawing.NumSides = 64
			silentAim.fovCircleDrawing.Filled = false
			silentAim.fovCircleDrawing.Color = color(255, 255, 255)
			silentAim.fovCircleDrawing.Visible = true
		elseif (not silentAim.SILENT_AIM_SHOW_FOV or not currentCamera) and silentAim.fovCircleDrawing then
			if silentAim.fovCircleResizeConn then
				silentAim.fovCircleResizeConn:Disconnect()
				silentAim.fovCircleResizeConn = nil
			end

			silentAim.fovCircleDrawing:Remove()
			silentAim.fovCircleDrawing = nil
		end

		if silentAim.fovCircleDrawing and currentCamera then
			silentAim.fovCircleDrawing.Radius = silentAim.SILENT_AIM_FOV_SIZE
			silentAim.fovCircleDrawing.Position = vector2(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)

			if not silentAim.fovCircleResizeConn then
				silentAim.fovCircleResizeConn = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
					silentAim.UpdateSilentAimFovCircle()
				end)
			end
		end
	end

	local function func53(instance21)
		if not instance21 or not instance21:IsA("Model") then
			return nil
		end
		local parent = instance21.Parent
		if parent and parent.Name == "Slim" and parent.Parent and parent.Parent.Name == "Zombies" then
			return "Cuirassier"
		end
		local agent = instance21:FindFirstChild("Agent")

		if agent then
			local type_ = agent:FindFirstChild("Type")

			if type_ and type_:IsA("StringValue") then
				local lowered = string.lower(type_.Value or "")
				if lowered == "normal" then
					return "Shambler"
				end

				if lowered == "barrel" then
					return "Bomber"
				end

				if lowered == "fast" then
					return "Runner"
				end

				if lowered == "sapper" then
					return "Zapper"
				end

				if lowered == "igniter" then
					return "Igniter"
				end

				if lowered == "cuirassier" then
					return "Cuirassier"
				end
			end
		end

		if typeof(instance21.GetAttribute) == "function" then
			local attribute = instance21:GetAttribute("Type")

			if type(attribute) == "string" then
				local lowered2 = string.lower(attribute)
				if lowered2 == "normal" then
					return "Shambler"
				end

				if lowered2 == "barrel" then
					return "Bomber"
				end

				if lowered2 == "fast" then
					return "Runner"
				end

				if lowered2 == "sapper" then
					return "Zapper"
				end

				if lowered2 == "igniter" then
					return "Igniter"
				end

				if lowered2 == "cuirassier" then
					return "Cuirassier"
				end
			end
		end

		if instance21:FindFirstChild("Barrel", true) then
			return "Bomber"
		end

		if instance21:FindFirstChild("Whale Oil Lantern", true) then
			return "Igniter"
		end

		if instance21:FindFirstChild("Sword", true) then
			return "Cuirassier"
		end

		if instance21:FindFirstChild("Axe", true) and instance21:FindFirstChild("Head", true) then
			return "Zapper"
		end

		if instance21:FindFirstChild("Eye", true) and not instance21:FindFirstChild("Axe", true) then
			return "Runner"
		end
		return "Shambler"
	end

	local function func54()
		if localPlayer.Character and localPlayer.Character.Parent then
			local head = localPlayer.Character:FindFirstChild("Head")
			if head and head:IsA("BasePart") then
				return head.Position
			end
		end

		local currentCamera = workspace.CurrentCamera
		return currentCamera and currentCamera.CFrame.Position or nil
	end

	local function func55()
		local tbl30 = {}

		for _, getPlayer11 in obj4:GetPlayers() do
			local character = getPlayer11.Character

			if character and character:IsA("Model") then
				table.insert(tbl30, character)
			end
		end

		local camera = workspace:FindFirstChild("Camera")

		if camera then
			for _, getDescendant19 in camera:GetDescendants() do
				if getDescendant19 and getDescendant19:IsA("Model") and getDescendant19.Name == "m_Zombie" then
					table.insert(tbl30, getDescendant19)
				end
			end
		end

		return tbl30
	end

	local n = 0.95
	local n2 = 0.35
	local n3 = 0.4
	local n4 = 2.75
	local n5 = 0.6
	local n6 = 0.0001

	local function func56(part4, num22)
		if not part4 or not part4.Parent then
			return {}
		end
		num22 = num22 or part4.Position
		local cFrame = part4.CFrame
		local size = part4.Size or Vector3.one

		local function func57(num23)
			local n7 = num23 * n2

			if n7 < n3 then
				n7 = 0.4
			end

			if n4 < n7 then
				n7 = 2.75
			end

			return n7
		end

		local x2 = func57(size.X)
		local y2 = func57(size.Y)
		local z2 = func57(size.Z)
		local value158 = vector(0, y2, 0)
		local value159 = vector(0, -y2, 0)
		local value160 = vector(x2, 0, 0)
		local num24 = vector(-x2, 0, 0)
		local value161 = vector(0, 0, z2)
		local tbl31 = { Vector3.zero, value158, value159, value160, num24, value161 }

		do
			local values = table.pack(vector(0, 0, -z2))
			table.move(values, 1, values.n, 7, tbl31)
		end

		local list10 = {}

		for _, value162 in tbl31 do
			list10[#list10 + 1] = num22 + cFrame:VectorToWorldSpace(value162)
		end

		return list10
	end

	local function func58(num25, num26, flag82, list11)
		if not silentAim.CHECK_WALLS then
			return false
		end

		if not num26 then
			return false
		end

		if localPlayer.Character then
			local head = localPlayer.Character:FindFirstChild("Head")

			if head and head:IsA("BasePart") then
				num25 = head.Position
			end
		end

		if not num25 then
			return false
		end
		local n7 = num26 - num25
		local magnitude = n7.Magnitude
		if magnitude <= 0 then
			return false
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local filterDescendantsInstances = {}

		if list11 then
			for i = 1, #list11 do
				filterDescendantsInstances[#filterDescendantsInstances + 1] = list11[i]
			end
		end

		if localPlayer.Character then
			table.insert(filterDescendantsInstances, localPlayer.Character)
		end

		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		local magnitude2 = magnitude
		local num27 = num25
		local unit = n7.Unit

		for i = 1, 16 do
			local ok, result = pcall(function()
				return workspace:Raycast(num27, unit * magnitude2, raycastParams)
			end)

			if not ok or not result then
				return false
			end
			local instance = result.Instance
			if not instance then
				return false
			end

			if flag82 and instance:IsDescendantOf(flag82) then
				return false
			end
			local isBasePart = instance:IsA("BasePart")
			isBasePart = isBasePart and (not (isBasePart and instance.CanCollide) or (isBasePart and instance.Transparency or 0) >= n)
			local flag83 = false
			local parent

			if isBasePart then
				flag83 = true
				parent = instance
			else
				parent = instance
			end

			while true do
				if parent and parent.Parent then
					if parent:IsA("Model") and parent.Name == "m_Zombie" then
						flag83 = true
						break
					else
						parent = parent.Parent
						continue
					end
				end

				break
			end

			for _, getPlayer12 in obj4:GetPlayers() do
				local character = getPlayer12.Character
				if character and instance:IsDescendantOf(character) then
					flag83 = true
					break
				end
			end

			if flag83 then
				table.insert(raycastParams.FilterDescendantsInstances, instance)
				local n8 = result.Position + unit * 0.25
				if magnitude - n6 <= (n8 - num25).Magnitude then
					return false
				end
				num27 = n8
				magnitude2 = (num26 - num27).Magnitude
				continue
			end

			return true
		end

		return true
	end

	local function func59(flag84, instance22, param39, param40, param41)
		if not silentAim.CHECK_WALLS then
			return true
		end

		if not flag84 or not instance22 or not instance22.Parent then
			return false
		end
		local list12 = func56(instance22, param41)
		if #list12 == 0 then
			return false
		end
		local num28 = max(1, ceil(#list12 * n5))
		local n7 = 0

		for _, value163 in list12 do
			if not func58(flag84, value163, param39, param40) then
				n7 += 1
				if num28 <= n7 then
					return true
				end
			end
		end

		return false
	end

	local function func60(instance23)
		if not instance23 then
			return false
		end
		local state = instance23:FindFirstChild("State")
		if state and state:IsA("StringValue") and state.Value == "Spawn" then
			return true
		end
		local agent = instance23:FindFirstChild("Agent")

		if agent then
			local state2 = agent:FindFirstChild("State")
			if state2 and state2:IsA("StringValue") and state2.Value == "Spawn" then
				return true
			end
		end

		return false
	end

	local function func61(instance24)
		if not instance24 or not instance24.Parent then
			return nil
		end
		local head = instance24:FindFirstChild("Head", true)
		if head then
			return head
		end
		local torso = instance24:FindFirstChild("Torso") or instance24:FindFirstChild("UpperTorso") or instance24:FindFirstChild("HumanoidRootPart")
		if torso then
			return torso
		end
		local barrel = instance24:FindFirstChild("Barrel", true)
		if barrel then
			return barrel
		end
		return instance24.PrimaryPart
	end

	local function func62(part5)
		if not part5 or not part5.Parent then
			return nil
		end
		return part5.Position
	end

	silentAim.updateIndicator = function(position, hasTarget)
		if not position then
			if silentAim.indicatorData then
				if silentAim.indicatorData.billboard then
					silentAim.indicatorData.billboard:Destroy()
				end

				silentAim.indicatorData = nil
			end

			if silentAim.indicatorPart then
				silentAim.indicatorPart:Destroy()
				silentAim.indicatorPart = nil
			end

			return
		end

		if not silentAim.indicatorPart or not silentAim.indicatorPart.Parent then
			silentAim.indicatorPart = Instance.new("Part")
			silentAim.indicatorPart.Name = "SilentAimIndicatorAnchor"
			silentAim.indicatorPart.Size = Vector3.new(0.2, 0.2, 0.2)
			silentAim.indicatorPart.Transparency = 1
			silentAim.indicatorPart.CanCollide = false
			silentAim.indicatorPart.Anchored = true
			silentAim.indicatorPart.Parent = workspace
		end

		silentAim.indicatorPart.Position = position

		if not silentAim.indicatorData or not silentAim.indicatorData.billboard or not silentAim.indicatorData.billboard.Parent then
			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Size = UDim2.new(0, 25, 0, 25)
			billboardGui.StudsOffset = Vector3.zero
			billboardGui.AlwaysOnTop = true
			billboardGui.Adornee = silentAim.indicatorPart
			billboardGui.Parent = silentAim.indicatorPart
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 1, 0)
			frame.BackgroundTransparency = 1
			frame.Parent = billboardGui
			local frame2 = Instance.new("Frame")
			frame2.Size = UDim2.new(1, 0, 1, 0)
			frame2.BackgroundTransparency = 1
			frame2.Parent = frame
			local uiStroke = Instance.new("UIStroke")
			uiStroke.Thickness = 1
			uiStroke.Color = color(255, 255, 255)
			uiStroke.Transparency = 0.2
			uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke.Parent = frame2
			local uiCorner = Instance.new("UICorner")
			uiCorner.CornerRadius = UDim.new(1, 0)
			uiCorner.Parent = frame2
			local frame3 = Instance.new("Frame")
			frame3.Size = UDim2.new(0.65, 0, 0.65, 0)
			frame3.Position = UDim2.new(0.175, 0, 0.175, 0)
			frame3.BackgroundTransparency = 1
			frame3.Parent = frame
			local uiStroke2 = Instance.new("UIStroke")
			uiStroke2.Thickness = 0.7
			uiStroke2.Color = color(255, 255, 255)
			uiStroke2.Transparency = 0.35
			uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke2.Parent = frame3
			local uiCorner2 = Instance.new("UICorner")
			uiCorner2.CornerRadius = UDim.new(1, 0)
			uiCorner2.Parent = frame3

			silentAim.indicatorData = {
				billboard = billboardGui,
				container = frame,
				outer = frame2,
				outerStroke = uiStroke,
				inner = frame3,
				innerStroke = uiStroke2,
				hasTarget = false,
			}

			task.spawn(function()
				while silentAim.indicatorData and silentAim.indicatorData.billboard and silentAim.indicatorData.billboard.Parent do
					local hasTarget2 = silentAim.indicatorData.hasTarget
					local transparency = (math.sin(clock() * 4) + 1) / 2 * 0.2 + 0.15
					local transparency2 = (math.sin(clock() * 4 + 0.5) + 1) / 2 * 0.25 + 0.2

					if hasTarget2 then
						local value164 = color(0, floor((0.7 + (math.sin(clock() * 2) + 1) / 2 * 0.3) * 255), 80)

						if silentAim.indicatorData.outerStroke then
							silentAim.indicatorData.outerStroke.Color = value164
							silentAim.indicatorData.outerStroke.Transparency = transparency
						end

						if silentAim.indicatorData.innerStroke then
							silentAim.indicatorData.innerStroke.Color = value164
							silentAim.indicatorData.innerStroke.Transparency = transparency2
						end
					else
						local value165 = color(255, 255, 255)

						if silentAim.indicatorData.outerStroke then
							silentAim.indicatorData.outerStroke.Color = value165
							silentAim.indicatorData.outerStroke.Transparency = transparency
						end

						if silentAim.indicatorData.innerStroke then
							silentAim.indicatorData.innerStroke.Color = value165
							silentAim.indicatorData.innerStroke.Transparency = transparency2
						end
					end

					task.wait(0.02)
				end
			end)
		else
			if silentAim.indicatorData.billboard.Adornee ~= silentAim.indicatorPart then
				silentAim.indicatorData.billboard.Adornee = silentAim.indicatorPart
			end

			silentAim.indicatorData.hasTarget = hasTarget
		end
	end

	silentAim.hideIndicator = function()
		if silentAim.indicatorData then
			if silentAim.indicatorData.billboard then
				silentAim.indicatorData.billboard:Destroy()
			end

			silentAim.indicatorData = nil
		end

		if silentAim.indicatorPart then
			silentAim.indicatorPart:Destroy()
			silentAim.indicatorPart = nil
		end
	end

	silentAim.StartSilentAimLoop = function()
		if silentAim.SilentAimUpdateConn then
			return
		end

		silentAim.SilentAimUpdateConn = obj5.Heartbeat:Connect(function()
			if not (silentAim.Enabled and #silentAim.SilentAimSelectedTypes > 0) then
				silentAim.SilentAimCurrentTarget = nil
				silentAim.SilentAimCurrentModel = nil
				silentAim.hideIndicator()
				return
			end

			local tool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")

			if tool then
				local animations = tool:FindFirstChild("Animations")

				if animations then
					tool = tool.Animations:FindFirstChild("Aim") or tool.Animations:FindFirstChild("Aiming")
				else
					tool = animations
				end
			end

			if not tool then
				silentAim.SilentAimCurrentTarget = nil
				silentAim.SilentAimCurrentModel = nil
				silentAim.hideIndicator()
				return
			end

			if silentAim.SilentAimSelectedTypes and #silentAim.SilentAimSelectedTypes > 0 then
				local maxTargetRange = silentAim.MAX_TARGET_RANGE
				local result13 = func54()
				if not result13 then
					return
				end
				local result14 = func55()
				local n7 = maxTargetRange + 1
				local tbl32 = {}

				for _, silentAimSelectedType in silentAim.SilentAimSelectedTypes do
					tbl32[silentAimSelectedType] = true
				end

				local zombies = workspace:FindFirstChild("Zombies")
				local value166 = nil
				local n8 = nil
				local value167 = nil

				if zombies then
					value166 = nil
					value167 = nil
					n8 = nil

					for _, value168 in zombies:GetChildren() do
						if value168:IsA("Model") and not func60(value168) then
							local flag85 = func53(value168)

							if flag85 and tbl32[flag85] then
								local obj118 = func61(value168)

								if obj118 and obj118:IsA("BasePart") then
									local num29 = func62(obj118)

									if silentAim.SILENT_AIM_USE_FOV then
										if not silentAim.isWorldPosInSilentAimFov(num29) then
											continue
										end
									end

									local magnitude = (num29 - result13).Magnitude

									if magnitude < n7 and magnitude <= maxTargetRange then
										if silentAim.CHECK_WALLS then
											if not func59(result13, obj118, value168, result14) then
												continue
											end
										end

										if silentAim.PREDICTION_ENABLED then
											local n9 = magnitude / func51() + func52() / 1000
											local humanoidRootPart = value168:FindFirstChild("HumanoidRootPart")

											if humanoidRootPart then
												local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity

												if not (assemblyLinearVelocity.Magnitude > 0.05) then
													n7 = magnitude
													value166 = obj118
													value167 = value168
													n8 = num29
												else
													local num30 = (num29 - result13).Unit:Dot(assemblyLinearVelocity.Unit)
													local n10 = 1 - abs(num30) * 0.5
													local n11 = assemblyLinearVelocity * n9 * (0.2 + 0.8 * min(1.2, magnitude / 60)) * 1.2 * n10
													local num31 = min(magnitude * 0.15 + 2, 35)

													if num31 < n11.Magnitude then
														n11 = n11.Unit * num31
													end

													n8 = num29 + n11
													n7 = magnitude
													value166 = obj118
													value167 = value168
												end
											else
												n7 = magnitude
												value166 = obj118
												value167 = value168
												n8 = num29
											end
										else
											n7 = magnitude
											value166 = obj118
											value167 = value168
											n8 = num29
										end
									end
								end
							end
						end
					end
				end

				if list1.silentAim.headless then
					for _, getDescendant20 in workspace:GetDescendants() do
						if getDescendant20:IsA("Model") and list1.isHeadlessModel(getDescendant20) then
							local humanoid = getDescendant20:FindFirstChildOfClass("Humanoid")

							if humanoid and humanoid.Health > 0 then
								local torso = getDescendant20:FindFirstChild("Torso") or getDescendant20:FindFirstChild("UpperTorso") or getDescendant20:FindFirstChild("HumanoidRootPart")

								if torso and torso:IsA("BasePart") then
									local n9

									if torso.Name == "HumanoidRootPart" then
										n9 = torso.Position + Vector3.new(0, 2.5, 0)
									else
										n9 = torso.Position
									end

									if silentAim.SILENT_AIM_USE_FOV then
										if not silentAim.isWorldPosInSilentAimFov(n9) then
											continue
										end
									end

									local magnitude = (n9 - result13).Magnitude

									if magnitude < n7 and magnitude <= maxTargetRange then
										if silentAim.CHECK_WALLS then
											if not func59(result13, torso, getDescendant20, result14, n9) then
												continue
											end
										end

										if silentAim.PREDICTION_ENABLED then
											local n10 = magnitude / func51() + func52() / 1000
											local humanoidRootPart = getDescendant20:FindFirstChild("HumanoidRootPart")
											-- deobfuscated by 𝖲𝗈𝗎𝗋𝖼𝖾 𝖫𝖾𝖺𝗄 (𝖲𝖫) -> https://discord.gg/x7YbZeezpm

											if humanoidRootPart then
												local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity

												if assemblyLinearVelocity.Magnitude > 0.05 then
													local num32 = (n9 - result13).Unit:Dot(assemblyLinearVelocity.Unit)
													local n11 = 1 - abs(num32) * 0.5
													local n12 = assemblyLinearVelocity * n10 * (0.2 + 0.8 * min(1.2, magnitude / 60)) * 1.2 * n11
													local num33 = min(magnitude * 0.15 + 2, 35)

													if num33 < n12.Magnitude then
														n12 = n12.Unit * num33
													end

													n8 = n9 + n12
													n7 = magnitude
													value166 = torso
													value167 = getDescendant20
												else
													n7 = magnitude
													value166 = torso
													value167 = getDescendant20
													n8 = n9
												end
											else
												n7 = magnitude
												value166 = torso
												value167 = getDescendant20
												n8 = n9
											end
										else
											n7 = magnitude
											value166 = torso
											value167 = getDescendant20
											n8 = n9
										end
									end
								end
							end
						end
					end
				end

				if value166 then
					if silentAim.PREDICTION_ENABLED and n8 then
						silentAim.SilentAimCurrentTarget = { Position = n8, Parent = value166.Parent or nil, IsPredicted = true }
					else
						silentAim.SilentAimCurrentTarget = value166
					end

					silentAim.SilentAimCurrentModel = value167
					silentAim.updateIndicator(silentAim.PREDICTION_ENABLED and n8 or value166.Position, true)
				else
					silentAim.SilentAimCurrentTarget = nil
					silentAim.SilentAimCurrentModel = nil
					silentAim.hideIndicator()
				end
			end
		end)
	end

	silentAim.StopSilentAimLoop = function()
		if silentAim.SilentAimUpdateConn then
			silentAim.SilentAimUpdateConn:Disconnect()
			silentAim.SilentAimUpdateConn = nil
		end

		silentAim.SilentAimCurrentTarget = nil
		silentAim.SilentAimCurrentModel = nil
		silentAim.hideIndicator()
	end

	silentAim.SetupSilentAimHooks = function()
		if silentAim.oldFire then
			return
		end

		if type(hookmetamethod) ~= "function" then
			warn("Silent Aim: hookmetamethod not available")
			return
		end

		silentAim.oldFire = hookmetamethod(game, "__namecall", function(param42, ...)
			local packed3 = table.pack(...)

			if getnamecallmethod() == "FireServer" and silentAim.Enabled then
				local tbl33 = { ... }

				if tbl33[1] == "Fire" and silentAim.SilentAimCurrentTarget then
					local character = localPlayer.Character

					if character then
						local position

						if type(silentAim.SilentAimCurrentTarget) == "table" and silentAim.SilentAimCurrentTarget.IsPredicted then
							position = silentAim.SilentAimCurrentTarget.Position
						else
							if not silentAim.SilentAimCurrentTarget.Parent then
								return silentAim.oldFire(param42, table.unpack(packed3, 1, packed3.n))
							end
							position = silentAim.SilentAimCurrentTarget.Position
						end

						return silentAim.oldFire(param42, unpack({
							"Fire",
							tbl33[2] or character:FindFirstChild("Model") or character,
							position,
							tbl33[4] or workspace:GetServerTimeNow(),
						}))
					end
				end

				return silentAim.oldFire(param42, table.unpack(packed3, 1, packed3.n))
			end

			return silentAim.oldFire(param42, ...)
		end)
	end

	silentAim.RemoveSilentAimHooks = function()
		if silentAim.oldFire then
			hookmetamethod(game, "__namecall", silentAim.oldFire)
			silentAim.oldFire = nil
		end
	end

	list1.onCharacterAdded(function()
		if silentAim.Enabled then
			silentAim.RemoveSilentAimHooks()
			task.wait(0.1)
			silentAim.SetupSilentAimHooks()
		end
	end)

	list1.silentAim = list1.silentAim or {}
	list1.silentAim.bomber = false
	list1.silentAim.cuirassier = false
	list1.silentAim.runner = false
	list1.silentAim.zapper = false
	list1.silentAim.igniter = false
	list1.silentAim.shambler = false
	list1.silentAim.headless = false

	local function func63()
		local silentAimSelectedTypes = {}

		if list1.silentAim.bomber then
			table.insert(silentAimSelectedTypes, "Bomber")
		end

		if list1.silentAim.cuirassier then
			table.insert(silentAimSelectedTypes, "Cuirassier")
		end

		if list1.silentAim.runner then
			table.insert(silentAimSelectedTypes, "Runner")
		end

		if list1.silentAim.zapper then
			table.insert(silentAimSelectedTypes, "Zapper")
		end

		if list1.silentAim.igniter then
			table.insert(silentAimSelectedTypes, "Igniter")
		end

		if list1.silentAim.shambler then
			table.insert(silentAimSelectedTypes, "Shambler")
		end

		if list1.silentAim.headless then
			table.insert(silentAimSelectedTypes, "Headless")
		end

		silentAim.SilentAimSelectedTypes = silentAimSelectedTypes

		if #silentAimSelectedTypes > 0 then
			silentAim.Enabled = true
			silentAim.StartSilentAimLoop()
			silentAim.SetupSilentAimHooks()
		else
			silentAim.Enabled = false
			silentAim.StopSilentAimLoop()
			silentAim.RemoveSilentAimHooks()
		end
	end

	local obj119 = tbl2.Main:AddGroupbox({ Side = "Left", Name = "静默自瞄", IconName = "target", Description = "自动瞄准" })
	obj119:AddLabel("目标选择")

	obj119:AddToggle("SilentAimBomber", {
		Text = "自瞄自爆",
		Default = false,
		Tooltip = func6("开启后自瞄自爆僵尸"),
		Callback = function(bomber)
			list1.silentAim.bomber = bomber
			func63()
		end,
	})

	obj119:AddToggle("SilentAimCuirassier", {
		Text = "自瞄胸甲骑兵",
		Default = false,
		Tooltip = func6("开启后自瞄胸甲骑兵"),
		Callback = function(cuirassier)
			list1.silentAim.cuirassier = cuirassier
			func63()
		end,
	})

	obj119:AddToggle("SilentAimRunner", {
		Text = "自瞄红眼",
		Default = false,
		Tooltip = func6("开启后自瞄红眼僵尸"),
		Callback = function(runner)
			list1.silentAim.runner = runner
			func63()
		end,
	})

	obj119:AddToggle("SilentAimZapper", {
		Text = "自瞄斧头僵尸",
		Default = false,
		Tooltip = func6("开启后自瞄斧头僵尸"),
		Callback = function(zapper)
			list1.silentAim.zapper = zapper
			func63()
		end,
	})

	obj119:AddToggle("SilentAimIgniter", {
		Text = "自瞄点火者",
		Default = false,
		Tooltip = func6("开启后自瞄点火者"),
		Callback = function(igniter)
			list1.silentAim.igniter = igniter
			func63()
		end,
	})

	obj119:AddToggle("SilentAimShambler", {
		Text = "自瞄普通僵尸",
		Default = false,
		Tooltip = func6("开启后自瞄普通僵尸"),
		Callback = function(shambler)
			list1.silentAim.shambler = shambler
			func63()
		end,
	})

	obj119:AddToggle("SilentAimHeadless", {
		Text = "自瞄无头骑士",
		Default = false,
		Callback = function(headless)
			list1.silentAim.headless = headless

			if not headless then
				silentAim.hideIndicator()
			end

			func63()
		end,
	})

	obj119:AddDivider()
	obj119:AddLabel("攻击设置")

	obj119:AddToggle("SilentAimWallCheck", {
		Text = "墙体检测",
		Default = true,
		Tooltip = func6("开启后不会瞄准被墙体遮挡的僵尸"),
		Callback = function(checkWalls)
			silentAim.CHECK_WALLS = checkWalls
		end,
	})

	list1.noRecoilEnabled = false
	list1.disabledRecoilConnections = nil

	list1.toggleNoRecoil = function(param43)
		if param43 then
			if not list1.disabledRecoilConnections then
				local recoilEvent = obj7:FindFirstChild("RecoilEvent")
				if not recoilEvent then
					warn("请等待复活")
					return
				end

				if type(getconnections) ~= "function" then
					return
				end
				local disabledRecoilConnections = {}

				if not pcall(function()
					for _, getconnection in getconnections(recoilEvent.Event) do
						getconnection:Disable()
						table.insert(disabledRecoilConnections, getconnection)
					end
				end) or #disabledRecoilConnections == 0 then
					return
				end

				list1.disabledRecoilConnections = disabledRecoilConnections
				list1.noRecoilEnabled = true
			end
		else
			list1.noRecoilEnabled = false

			if list1.disabledRecoilConnections then
				for _, disabledRecoilConnection in list1.disabledRecoilConnections do
					pcall(function()
						disabledRecoilConnection:Enable()
					end)
				end

				list1.disabledRecoilConnections = nil
			end
		end
	end

	list1.onCharacterAdded(function()
		if list1.noRecoilEnabled and list1.disabledRecoilConnections then
			local recoilEvent = obj7:FindFirstChild("RecoilEvent")

			if recoilEvent then
				for _, getconnection2 in getconnections(recoilEvent.Event) do
					if getconnection2.Enabled then
						getconnection2:Disable()
						table.insert(list1.disabledRecoilConnections, getconnection2)
					end
				end
			end
		end
	end)

	obj119:AddToggle("NoRecoilToggle", {
		Text = "无后坐力",
		Default = false,
		Tooltip = func6("禁用枪械后坐力"),
		Callback = function(value)
			list1.toggleNoRecoil(value)
		end,
	})

	obj119:AddToggle("SilentAimPrediction", {
		Text = "预判射击",
		Default = false,
		Callback = function(predictionEnabled)
			silentAim.PREDICTION_ENABLED = predictionEnabled
		end,
	})

	obj119:AddSlider("SilentAimRange", {
		Text = "瞄准距离",
		Default = 200,
		Min = 50,
		Max = 600,
		Rounding = 0,
		Callback = function(maxTargetRange)
			silentAim.MAX_TARGET_RANGE = maxTargetRange
		end,
	})

	obj119:AddDivider()
	obj119:AddLabel("FOV 设置")

	obj119:AddToggle("SilentAimFOVToggle", {
		Text = "启用 FOV",
		Default = false,
		Tooltip = func6("只在 FOV 范围内自瞄"),
		Callback = function(silentAimUseFov)
			silentAim.SILENT_AIM_USE_FOV = silentAimUseFov
			silentAim.UpdateSilentAimFovCircle()
		end,
	})

	obj119:AddToggle("SilentAimShowFOV", {
		Text = "显示 FOV 圆圈",
		Default = false,
		Tooltip = func6("显示自瞄 FOV 范围"),
		Callback = function(silentAimShowFov)
			silentAim.SILENT_AIM_SHOW_FOV = silentAimShowFov
			silentAim.UpdateSilentAimFovCircle()
		end,
	})

	obj119:AddSlider("SilentAimFOVSize", {
		Text = "FOV 大小",
		Default = 50,
		Min = 10,
		Max = 120,
		Rounding = 0,
		Callback = function(silentAimFovSize)
			silentAim.SILENT_AIM_FOV_SIZE = silentAimFovSize
			silentAim.UpdateSilentAimFovCircle()
		end,
	})

	func63()
end

list1.engineerAutoRepairEnabled = false
list1.autoRepairLoop = nil
list1.repairCooldown = 0.05
list1.autoRepairTargetMode = "Closest"
list1.autoRepairRange = 25

do
	local remoteEvent = nil
	local n = 0
	local n2 = 2
	local value169 = nil
	local n3 = 0
	local n4 = 10

	list1.getLookedStructure = function()
		local character = localPlayer.Character
		if not character then
			return nil
		end

		if not character:FindFirstChild("HumanoidRootPart") then
			return nil
		end
		local currentCamera = workspace.CurrentCamera
		local position = currentCamera.CFrame.Position
		local n5 = currentCamera.CFrame.LookVector * 50
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = { character }
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local hit = workspace:Raycast(position, n5, raycastParams)
		if not hit then
			return nil
		end
		local model = hit.Instance:FindFirstAncestorOfClass("Model")
		if not model then
			return nil
		end
		return model:FindFirstChild("BuildingHealth") or model.Parent and model.Parent:FindFirstChild("BuildingHealth")
	end

	list1.getHammerRemote = function()
		local now = time()

		if remoteEvent and now - n < n2 then
			if remoteEvent.Parent then
				return remoteEvent
			end
			remoteEvent = nil
		end

		local value170 = localPlayer
		local backpack = localPlayer:FindFirstChild("Backpack")

		if backpack then
			local hammer = backpack:FindFirstChild("Hammer") or backpack:FindFirstChild("Claw Hammer")

			if hammer and hammer:FindFirstChild("RemoteEvent") then
				remoteEvent = hammer.RemoteEvent
				n = now
				return remoteEvent
			end
		end

		local character = value170.Character

		if character then
			local hammer = character:FindFirstChild("Hammer") or character:FindFirstChild("Claw Hammer")

			if hammer and hammer:FindFirstChild("RemoteEvent") then
				remoteEvent = hammer.RemoteEvent
				n = now
				return remoteEvent
			end
		end

		local players = workspace:FindFirstChild("Players")

		if players then
			local obj120 = players:FindFirstChild(value170.Name)

			if obj120 then
				local hammer = obj120:FindFirstChild("Hammer") or obj120:FindFirstChild("Claw Hammer")

				if hammer then
					local remoteEvent2 = hammer:FindFirstChild("RemoteEvent")

					if remoteEvent2 then
						remoteEvent = remoteEvent2
						n = now
						return remoteEvent2
					end
				end
			end
		end

		return nil
	end

	list1.getBuildableFolders = function()
		local now = time()
		if value169 and now - n3 < n4 then
			return value169
		end
		local list13 = {}

		for _, value171 in { "Buildables", "Stakes", "Barricades", "Structures", "Buildings" }, nil, nil do
			local value172 = workspace:FindFirstChild(value171)

			if value172 then
				list13[#list13 + 1] = value172
			end
		end

		for _, value173 in workspace:GetChildren() do
			if value173:IsA("Folder") or value173:IsA("Model") then
				local modes = value173:FindFirstChild("Modes")

				if modes then
					list13[#list13 + 1] = modes
				end
			end
		end

		value169 = list13
		n3 = now
		return list13
	end
end

do
	local tbl34 = {}
	local tbl35 = {}
	local n = 0
	local n2 = 40

	list1.getRichBuildables = function()
		local character = localPlayer.Character
		if not character then
			return tbl34, 0
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return tbl34, 0
		end
		local position = humanoidRootPart.Position
		local n3 = list1.autoRepairRange * list1.autoRepairRange
		n = 0

		for k in tbl35 do
			tbl35[k] = nil
		end

		local function func64(part6)
			if n2 <= n then
				return
			end
			local position2

			if part6:IsA("BasePart") then
				position2 = part6.Position
			else
				position2 = nil

				if part6:IsA("Model") then
					local primaryPart = part6.PrimaryPart or part6:FindFirstChildWhichIsA("BasePart")
					position2 = nil

					if primaryPart then
						position2 = primaryPart.Position
					end
				end
			end

			if not position2 then
				return
			end
			local n4 = position2.X - position.X
			local n5 = position2.Y - position.Y
			local n6 = position2.Z - position.Z
			local dist = n4 * n4 + n5 * n5 + n6 * n6
			if n3 < dist then
				return
			end
			local buildingHealth = part6:FindFirstChild("BuildingHealth") or part6:FindFirstChild("ConstructHealth")

			if not buildingHealth then
				local health = part6:FindFirstChild("Health")

				if health and health:IsA("NumberValue") then
					buildingHealth = health
				end
			end

			if not buildingHealth or tbl35[buildingHealth] then
				return
			end
			tbl35[buildingHealth] = true
			local cur = buildingHealth.Value
			if not cur then
				return
			end
			local attribute = buildingHealth:GetAttribute("MaxHealth") or buildingHealth:GetAttribute("Max") or 100
			if attribute == 0 then
				return
			end

			if cur >= attribute then
				return
			end
			n += 1
			local entry10 = tbl34[n]

			if entry10 then
				entry10.obj = buildingHealth
				entry10.cur = cur
				entry10.max = attribute
				entry10.ratio = cur / attribute
				entry10.dist = dist
			else
				tbl34[n] = { obj = buildingHealth, cur = cur, max = attribute, ratio = cur / attribute, dist = dist }
			end
		end

		for _, getBuildableFolder in list1.getBuildableFolders(), nil, nil do
			if not (n2 <= n) then
				for _, value174 in getBuildableFolder:GetChildren() do
					if not (n >= n2) then
						func64(value174)

						if value174:IsA("Model") or value174:IsA("Folder") then
							for _, value175 in value174:GetChildren() do
								if not (n2 <= n) then
									func64(value175)
									continue
								end
								break
							end
						end

						continue
					end

					break
				end

				continue
			end

			break
		end

		for i = n + 1, #tbl34 do
			tbl34[i] = nil
		end

		return tbl34, n
	end
end

list1.fireRepairSilent = function(flag86)
	if not flag86 then
		return
	end
	local obj121 = list1.getHammerRemote()
	if not obj121 then
		return
	end

	pcall(function()
		obj121:FireServer("Repair", flag86)
	end)
end

list1.doAutoRepair = function()
	if list1.autoRepairTargetMode == "Aimed" then
		local obj122 = list1.getLookedStructure()

		if obj122 then
			local value176 = obj122.Value
			local attribute = obj122:GetAttribute("MaxHealth")

			if attribute and value176 < attribute then
				list1.fireRepairSilent(obj122)
			end
		end

		return
	end

	if list1.autoRepairTargetMode == "None" then
		return
	end
	local tbl36, flag87 = list1.getRichBuildables()
	if flag87 == 0 then
		return
	end
	local obj

	if list1.autoRepairTargetMode == "Closest" then
		local dist = tbl36[1].dist
		obj = tbl36[1].obj

		for i = 2, flag87 do
			if tbl36[i].dist < dist then
				dist = tbl36[i].dist
				obj = tbl36[i].obj
			end
		end
	else
		obj = nil

		if list1.autoRepairTargetMode == "LowestHealth" then
			local ratio = tbl36[1].ratio
			local cur = tbl36[1].cur
			obj = tbl36[1].obj

			for i = 2, flag87 do
				local entry11 = tbl36[i]

				if entry11.ratio < ratio or entry11.ratio == ratio and entry11.cur < cur then
					ratio = entry11.ratio
					cur = entry11.cur
					obj = entry11.obj
				end
			end
		end
	end

	if obj then
		list1.fireRepairSilent(obj)
	end
end

list1.autoRepairLoopFunc = function()
	while list1.engineerAutoRepairEnabled do
		list1.doAutoRepair()
		task.wait(list1.repairCooldown)
	end
end

list1.toggleEngineerAutoRepair = function(engineerAutoRepairEnabled)
	list1.engineerAutoRepairEnabled = engineerAutoRepairEnabled

	if engineerAutoRepairEnabled then
		if list1.autoRepairLoop then
			task.cancel(list1.autoRepairLoop)
		end

		list1.autoRepairLoop = task.spawn(list1.autoRepairLoopFunc)
		list1.notify(func5("自动修复已开启（静默模式）"), 2)
	else
		if list1.autoRepairLoop then
			task.cancel(list1.autoRepairLoop)
			list1.autoRepairLoop = nil
		end

		list1.notify(func5("自动修复已关闭"), 2)
	end
end

obj105:AddToggle("AutoRepairToggle", {
	Text = "静默自动修建筑",
	Default = false,
	Tooltip = func6("自动修复瞄准的建筑（无需装备锤子）"),
	Callback = function(value)
		list1.toggleEngineerAutoRepair(value)
	end,
})

obj105:AddDropdown("AutoRepairMode", {
	Text = "修复目标模式",
	Values = { "瞄准建筑", "最近建筑", "最低生命值建筑" },
	Value = "最近建筑",
	FormatDisplayValue = function(param44)
		return flag1 == "English" and (tbl1[param44] or param44) or param44
	end,
	Callback = function(value)
		if value == "瞄准建筑" then
			list1.autoRepairTargetMode = "Aimed"
		elseif value == "最近建筑" then
			list1.autoRepairTargetMode = "Closest"
		elseif value == "最低生命值建筑" then
			list1.autoRepairTargetMode = "LowestHealth"
		end
	end,
})

list1.forceBrace = list1.forceBrace or {}
list1.forceBrace.enabled = false
list1.forceBrace.thread = nil

list1.forceBrace.getRemote = function()
	local backpack = localPlayer:FindFirstChild("Backpack")
	if not backpack then
		return nil
	end

	for _, value177 in { "Axe", "Pickaxe", "Baguette" }, nil, nil do
		local obj123 = backpack:FindFirstChild(value177)

		if obj123 then
			local remoteEvent = obj123:FindFirstChild("RemoteEvent")
			if remoteEvent then
				return remoteEvent
			end
		end
	end

	return nil
end

list1.forceBrace.sendBrace = function()
	local obj124 = list1.forceBrace.getRemote()

	if obj124 then
		pcall(function()
			obj124:FireServer("BraceBlock")
		end)
	end
end

list1.forceBrace.loop = function()
	while list1.forceBrace.enabled do
		list1.forceBrace.sendBrace()
		task.wait(0.2)
	end
end

list1.forceBrace.start = function()
	if list1.forceBrace.enabled then
		return
	end
	list1.forceBrace.enabled = true

	if list1.forceBrace.thread then
		task.cancel(list1.forceBrace.thread)
	end

	list1.forceBrace.thread = task.spawn(list1.forceBrace.loop)
	list1.notify(func5("静默格挡已开启"), 2)
end

list1.forceBrace.stop = function()
	list1.forceBrace.enabled = false

	if list1.forceBrace.thread then
		task.cancel(list1.forceBrace.thread)
		list1.forceBrace.thread = nil
	end

	list1.notify(func5("静默格挡已关闭"), 2)
end

obj105:AddToggle("ForceBraceToggle", {
	Text = "静默格挡",
	Default = false,
	Tooltip = func6("自动格挡劈砍（无需手持武器）"),
	Callback = function(value)
		if value then
			list1.forceBrace.start()
		else
			list1.forceBrace.stop()
		end
	end,
})

list1.axeStunActive = false
list1.axeStunConnection = nil
list1.axeStunRange = 15
list1.axeStunCount = 5
list1.axeStunDelay = 0
list1.axeStunLastFire = 0

do
	local function func65()
		local character = localPlayer.Character

		if character then
			for _, value178 in character:GetChildren() do
				if value178:GetAttribute("Melee") then
					return value178
				end
			end
		end

		local backpack = localPlayer:FindFirstChild("Backpack")

		if backpack then
			for _, value179 in backpack:GetChildren() do
				if value179:GetAttribute("Melee") then
					return value179
				end
			end
		end

		return nil
	end

	local byName = { Axe = true, Pickaxe = true, Baguette = true }

	local function func66(obj125, param45, param46)
		obj125:FireServer("BraceBlock")
		obj125:FireServer("StopBraceBlock")
		obj125:FireServer("FeedbackStun", param45, param46)
	end

	local function func67(instance25)
		local result15 = func65()
		if not result15 or not byName[result15.Name] then
			return
		end
		local state = instance25:FindFirstChild("State")
		if state and state.Value == "Stunned" then
			return
		end
		local humanoidRootPart = instance25:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local remoteEvent = result15:FindFirstChild("RemoteEvent")
		if not remoteEvent then
			return
		end
		func66(remoteEvent, instance25, humanoidRootPart.CFrame.Position)
	end

	list1.startAxeStun = function()
		if list1.axeStunConnection then
			return
		end
		list1.axeStunActive = true

		list1.axeStunConnection = obj5.Heartbeat:Connect(function()
			if not list1.axeStunActive then
				return
			end
			local axeStunLastFire = list1.axeStunLastFire
			if clock() - axeStunLastFire < list1.axeStunDelay then
				return
			end
			local character = localPlayer.Character
			if not character then
				return
			end
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return
			end
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoid or humanoid.Health <= 0 then
				return
			end
			local zombies = workspace:FindFirstChild("Zombies")
			if not zombies then
				return
			end
			local tbl37 = {}

			for _, value180 in zombies:GetChildren() do
				if value180:IsA("Model") and value180:FindFirstChild("HumanoidRootPart") then
					local magnitude = (value180.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude

					if magnitude <= list1.axeStunRange then
						table.insert(tbl37, { zombie = value180, dist = magnitude })
					end
				end
			end

			table.sort(tbl37, function(param47, param48)
				return param47.dist < param48.dist
			end)

			for i = 1, min(list1.axeStunCount, #tbl37) do
				func67(tbl37[i].zombie)
			end

			list1.axeStunLastFire = clock()
		end)
	end

	list1.stopAxeStun = function()
		list1.axeStunActive = false

		if list1.axeStunConnection then
			list1.axeStunConnection:Disconnect()
			list1.axeStunConnection = nil
		end
	end

	list1.onCharacterAdded(function()
		if list1.axeStunActive then
			list1.stopAxeStun()

			if toggles.AxeStunToggle then
				toggles.AxeStunToggle:SetValue(false)
			end
		end
	end)

	obj105:AddToggle("AxeStunToggle", {
		Text = "肘击",
		Default = false,
		Tooltip = func6("自动肘击范围15格内的僵尸"),
		Callback = function(value)
			if value then
				list1.startAxeStun()
			else
				list1.stopAxeStun()
			end
		end,
	})

	obj105:AddSlider("AxeStunRange", {
		Text = "肘击距离",
		Default = 15,
		Min = 5,
		Max = 35,
		Rounding = 0,
		Suffix = " 格",
		Callback = function(axeStunRange)
			list1.axeStunRange = axeStunRange
		end,
	})

	obj105:AddSlider("AxeStunCount", {
		Text = "肘击数量",
		Default = 5,
		Min = 1,
		Max = 5,
		Rounding = 0,
		Suffix = " 个",
		Callback = function(axeStunCount)
			list1.axeStunCount = axeStunCount
		end,
	})

	obj105:AddSlider("AxeStunDelay", {
		Text = "肘击间隔",
		Default = 0,
		Min = 0,
		Max = 1,
		Rounding = 2,
		Suffix = " 秒",
		Callback = function(axeStunDelay)
			list1.axeStunDelay = axeStunDelay
		end,
	})

	list1.engineerElbowEnabled = false
	list1.engineerAnimConnection = nil
	list1.engineerElbowRange = 50
	list1.engineerElbowCount = 5
	local tbl38 = { "rbxassetid://15345113937" }

	list1.getValidMelee = function()
		local character = localPlayer.Character
		if not character then
			return nil
		end
		local tool = character:FindFirstChildOfClass("Tool")
		if not tool then
			return nil
		end
		local name = tool.Name
		if name == "Pickaxe" or name == "Axe" or name == "Baguette" then
			return tool
		end
		return nil
	end

	list1.stunAroundPlayer = function()
		if not list1.engineerElbowEnabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local obj126 = list1.getValidMelee()
		if not obj126 then
			return
		end
		local remoteEvent = obj126:FindFirstChild("RemoteEvent")
		if not remoteEvent then
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local position = humanoidRootPart.Position
		local zombies = workspace:FindFirstChild("Zombies")
		if not zombies then
			return
		end
		local tbl39 = {}

		for _, value181 in zombies:GetChildren() do
			if value181:IsA("Model") and value181:FindFirstChild("HumanoidRootPart") then
				if value181:GetAttribute("Type") ~= "Barrel" then
					local state = value181:FindFirstChild("State")

					if not (state and state.Value == "Spawn") then
						local humanoidRootPart2 = value181:FindFirstChild("HumanoidRootPart")

						if humanoidRootPart2 then
							local magnitude = (humanoidRootPart2.Position - position).Magnitude

							if magnitude <= list1.engineerElbowRange then
								if value181:FindFirstChild("State") and value181.State.Value ~= "Stunned" then
									table.insert(tbl39, { zombie = value181, root = humanoidRootPart2, dist = magnitude })
								end
							end
						end
					end
				end
			end
		end

		table.sort(tbl39, function(param49, param50)
			return param49.dist < param50.dist
		end)

		for i = 1, min(list1.engineerElbowCount, #tbl39) do
			local entry12 = tbl39[i]

			pcall(function()
				func66(remoteEvent, entry12.zombie, entry12.root.Position)
			end)
		end
	end

	list1.onElbowAnimationPlayed = function(obj)
		if not list1.engineerElbowEnabled then
			return
		end
		local animationId = obj.Animation.AnimationId

		for _, value182 in tbl38 do
			if animationId == value182 then
				list1.stunAroundPlayer()
				break
			end
		end
	end
end

list1.updateEngineerAnimConnection = function()
	if list1.engineerElbowEnabled then
		if list1.engineerAnimConnection then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			list1.engineerAnimConnection = humanoid.AnimationPlayed:Connect(list1.onElbowAnimationPlayed)
		end
	elseif list1.engineerAnimConnection then
		list1.engineerAnimConnection:Disconnect()
		list1.engineerAnimConnection = nil
	end
end

list1.onCharacterAdded(list1.updateEngineerAnimConnection)

obj105:AddToggle("EngineerElbowToggle", {
	Text = "肘击范围扩大",
	Default = false,
	Tooltip = func6("扩大肘击生效范围"),
	Callback = function(engineerElbowEnabled)
		list1.engineerElbowEnabled = engineerElbowEnabled
		list1.updateEngineerAnimConnection()
	end,
})

obj105:AddSlider("EngineerElbowRange", {
	Text = "肘击扩大距离",
	Default = 50,
	Min = 5,
	Max = 50,
	Rounding = 0,
	Suffix = " 格",
	Callback = function(engineerElbowRange)
		list1.engineerElbowRange = engineerElbowRange
	end,
})

obj105:AddSlider("EngineerElbowCount", {
	Text = "肘击扩大数量",
	Default = 5,
	Min = 1,
	Max = 5,
	Rounding = 0,
	Suffix = " 个",
	Callback = function(engineerElbowCount)
		list1.engineerElbowCount = engineerElbowCount
	end,
})

list1.engineerRecycleEnabled = false
list1.recycleAnimConnection = nil

local tbl40 = {
	"rbxassetid://16663569329",
	"rbxassetid://16663563130",
	"rbxassetid://109975878922735",
	"rbxassetid://12638406999",
	"rbxassetid://94131315859283",
	"rbxassetid://12638412059",
}

list1.recycleWeapon = function()
	if not list1.engineerRecycleEnabled then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local tool = character:FindFirstChildOfClass("Tool")
	if not tool then
		return
	end
	local name = tool.Name
	if name ~= "Pickaxe" and name ~= "Axe" and name ~= "Baguette" then
		return
	end
	local backpack = localPlayer:FindFirstChild("Backpack")
	if not backpack then
		return
	end
	tool.Parent = backpack
	task.wait(0.1)

	if list1.engineerRecycleEnabled and tool.Parent == backpack then
		tool.Parent = character
	end
end

list1.onRecycleAnimationPlayed = function(obj)
	if not list1.engineerRecycleEnabled then
		return
	end
	local animationId = obj.Animation.AnimationId

	for _, value183 in tbl40 do
		if animationId == value183 then
			task.delay(animationId == "rbxassetid://12638412059" and 0.4 or 0.3, list1.recycleWeapon)
			break
		end
	end
end

list1.updateRecycleAnimConnection = function()
	if list1.engineerRecycleEnabled then
		if list1.recycleAnimConnection then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			list1.recycleAnimConnection = humanoid.AnimationPlayed:Connect(list1.onRecycleAnimationPlayed)
		end
	elseif list1.recycleAnimConnection then
		list1.recycleAnimConnection:Disconnect()
		list1.recycleAnimConnection = nil
	end
end

list1.onCharacterAdded(list1.updateRecycleAnimConnection)

obj105:AddToggle("EngineerRecycleToggle", {
	Text = "攻击武器回收",
	Default = false,
	Tooltip = func6("攻击后自动卸下并重新装备武器，取消后摇"),
	Callback = function(engineerRecycleEnabled)
		list1.engineerRecycleEnabled = engineerRecycleEnabled
		list1.updateRecycleAnimConnection()
	end,
})

do
	local obj127 = tbl2.Extra:AddGroupbox({ Side = "Right", Name = "医生", IconName = "cross", Description = "自动治疗" })
	list1.doctor = { enabled = false, threshold = 25, range = 10, cooldown = 2, lastRequest = {}, thread = nil }

	local function func68()
		local character = localPlayer.Character
		if not character then
			return nil
		end
		local medicalSupplies = character:FindFirstChild("Medical Supplies")
		if medicalSupplies then
			return medicalSupplies:FindFirstChild("RemoteEvent")
		end
		return nil
	end

	local function func69(flag88, humanoid4)
		if not flag88 or not humanoid4 then
			return
		end

		if humanoid4.Health / humanoid4.MaxHealth * 100 > list1.doctor.threshold then
			return
		end
		local result16 = clock()
		if result16 < (list1.doctor.lastRequest[flag88] or 0) + list1.doctor.cooldown then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local humanoidRootPart2 = humanoid4.Parent and (humanoid4.Parent:FindFirstChild("HumanoidRootPart") or humanoid4.Parent:FindFirstChild("Torso"))
		if not humanoidRootPart2 then
			return
		end

		if list1.doctor.range < (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude then
			return
		end
		local result17 = func68()
		if not result17 then
			return
		end
		list1.doctor.lastRequest[flag88] = result16

		pcall(function()
			result17:FireServer("SendRequest", humanoid4)
		end)
	end

	list1.doctor.loop = function()
		while list1.doctor.enabled do
			for _, getPlayer13 in obj4:GetPlayers() do
				if getPlayer13 ~= localPlayer and getPlayer13.Character then
					local humanoid = getPlayer13.Character:FindFirstChildOfClass("Humanoid")

					if humanoid and humanoid.Health > 0 then
						pcall(func69, getPlayer13, humanoid)
					end
				end
			end

			task.wait(0.5)
		end
	end

	list1.doctor.start = function()
		if list1.doctor.thread then
			return
		end
		list1.doctor.enabled = true
		list1.doctor.thread = task.spawn(list1.doctor.loop)
		list1.notify(func5("自动治疗已开启"), 2)
	end

	list1.doctor.stop = function()
		list1.doctor.enabled = false

		if list1.doctor.thread then
			task.cancel(list1.doctor.thread)
			list1.doctor.thread = nil
		end

		list1.doctor.lastRequest = {}
		list1.notify(func5("自动治疗已关闭"), 2)
	end

	list1.doctor.autoPickup = { enabled = false, thread = nil, range = 5 }

	list1.doctor.autoPickup.getHRP = function(instance26)
		return instance26 and instance26:FindFirstChild("HumanoidRootPart")
	end

	list1.doctor.autoPickup.findDrop = function(num34, num35)
		local n = num35 + 1
		local value184 = nil
		local value185 = nil

		for _, getDescendant21 in workspace:GetDescendants() do
			if getDescendant21:IsA("ProximityPrompt") and getDescendant21.Enabled and getDescendant21.Name == "ReplenishPrompt" then
				local parent = getDescendant21.Parent

				if parent and parent:IsA("BasePart") and parent.Name == "SupplyVisualizer" then
					local magnitude = (parent.Position - num34).Magnitude

					if magnitude < n then
						n = magnitude
						value184 = getDescendant21
						value185 = parent
					end
				end
			end
		end

		return value184, value185, n
	end

	list1.doctor.autoPickup.loop = function()
		while list1.doctor.autoPickup.enabled do
			local doct = list1.doctor.autoPickup.getHRP(localPlayer.Character)

			if doct then
				local flag89, value186, value187 = list1.doctor.autoPickup.findDrop(doct.Position, list1.doctor.autoPickup.range)

				if flag89 and value187 <= list1.doctor.autoPickup.range then
					pcall(function()
						fireproximityprompt(flag89)
					end)

					task.wait(0.05)
				end
			end

			task.wait(0.2)
		end
	end

	list1.doctor.autoPickup.start = function()
		if list1.doctor.autoPickup.thread then
			return
		end
		list1.doctor.autoPickup.enabled = true
		list1.doctor.autoPickup.thread = task.spawn(list1.doctor.autoPickup.loop)
		list1.notify(func5("自动拾取纱布已开启"), 2)
	end

	list1.doctor.autoPickup.stop = function()
		list1.doctor.autoPickup.enabled = false

		if list1.doctor.autoPickup.thread then
			task.cancel(list1.doctor.autoPickup.thread)
			list1.doctor.autoPickup.thread = nil
		end

		list1.notify(func5("自动拾取纱布已关闭"), 2)
	end

	obj127:AddToggle("DoctorAutoHealToggle", {
		Text = "自动治疗受伤玩家",
		Default = false,
		Tooltip = func6("自动向低血量玩家发送治疗请求"),
		Callback = function(value)
			if value then
				list1.doctor.start()
			else
				list1.doctor.stop()
			end
		end,
	})

	obj127:AddSlider("DoctorHealThreshold", {
		Text = "治疗阈值 (%)",
		Default = 25,
		Min = 1,
		Max = 100,
		Suffix = "%",
		Callback = function(threshold)
			list1.doctor.threshold = threshold
		end,
	})

	obj127:AddToggle("DoctorAutoPickupBandage", {
		Text = "自动拾取纱布",
		Default = false,
		Tooltip = func6("自动拾取附近的纱布补给"),
		Callback = function(value)
			if value then
				list1.doctor.autoPickup.start()
			else
				list1.doctor.autoPickup.stop()
			end
		end,
	})
end

do
	local obj128 = tbl2.Extra:AddGroupbox({ Side = "Right", Name = "牧师", IconName = "church", Description = "自动祝福" })
	list1.chaplain = { enabled = false, threshold = 50, cooldown = 2, range = 15, lastRequest = {}, thread = nil }

	local function func70()
		local character = localPlayer.Character
		if not character then
			return nil
		end
		local blessing = character:FindFirstChild("Blessing")
		if blessing and blessing:FindFirstChild("RemoteEvent") then
			return blessing.RemoteEvent
		end

		for _, value188 in character:GetChildren() do
			if value188:IsA("Tool") and value188.Name:lower():find("bless") and value188:FindFirstChild("RemoteEvent") then
				return value188.RemoteEvent
			end
		end

		return nil
	end

	local function func71(player2)
		local character = localPlayer.Character
		if not character then
			return false
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return false
		end

		if not player2.Character then
			return false
		end
		local humanoidRootPart2 = player2.Character:FindFirstChild("HumanoidRootPart") or player2.Character:FindFirstChild("Torso")
		if not humanoidRootPart2 then
			return false
		end
		return (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude <= list1.chaplain.range
	end

	local function func72(flag90, flag91)
		if not flag90 or not flag91 then
			return
		end
		local threshold = list1.chaplain.threshold
		if list1.getInfectionForPlayer(flag90) < threshold then
			return
		end
		local result18 = clock()
		if result18 < (list1.chaplain.lastRequest[flag90] or 0) + list1.chaplain.cooldown then
			return
		end

		if not func71(flag90) then
			return
		end
		local result19 = func70()
		if not result19 then
			return
		end

		pcall(function()
			result19:FireServer("SendRequest", flag91)
			list1.chaplain.lastRequest[flag90] = result18
		end)
	end

	list1.chaplain.loop = function()
		while list1.chaplain.enabled do
			for _, getPlayer14 in obj4:GetPlayers() do
				if getPlayer14 ~= localPlayer and getPlayer14.Character then
					local humanoid = getPlayer14.Character:FindFirstChildOfClass("Humanoid")

					if humanoid and humanoid.Health > 0 then
						pcall(func72, getPlayer14, humanoid)
					end
				end
			end

			task.wait(0.5)
		end
	end

	list1.chaplain.start = function()
		if list1.chaplain.thread then
			return
		end
		list1.chaplain.enabled = true
		list1.chaplain.thread = task.spawn(list1.chaplain.loop)
		list1.notify(func5("自动祝福已开启"), 2)
	end

	list1.chaplain.stop = function()
		list1.chaplain.enabled = false

		if list1.chaplain.thread then
			task.cancel(list1.chaplain.thread)
			list1.chaplain.thread = nil
		end

		list1.chaplain.lastRequest = {}
		list1.notify(func5("自动祝福已关闭"), 2)
	end

	obj128:AddToggle("ChaplainAutoBlessToggle", {
		Text = "自动祝福感染玩家",
		Default = false,
		Tooltip = func6("自动向感染值高的玩家发送祝福"),
		Callback = function(value)
			if value then
				list1.chaplain.start()
			else
				list1.chaplain.stop()
			end
		end,
	})

	obj128:AddSlider("ChaplainBlessThreshold", {
		Text = "祝福阈值 (%)",
		Default = 50,
		Min = 1,
		Max = 100,
		Suffix = "%",
		Callback = function(threshold)
			list1.chaplain.threshold = threshold
		end,
	})
end

if not list1.Fife then
	list1.Fife = {}
end

local obj129 = tbl2.Extra:AddGroupbox({ Side = "Left", Name = "音乐家", IconName = "music", Description = "自动演奏" })
list1.fifeAccuracyEnabled = false
list1.fifeOldNamecall = nil
list1.inFifeHook = false

list1.setupFifeHook = function()
	if list1.fifeOldNamecall then
		return
	end

	if type(hookmetamethod) ~= "function" then
		warn("Auto Fife: hookmetamethod not available")
		return
	end

	local func73 = checkcaller or function()
		return false
	end

	pcall(function()
		list1.fifeOldNamecall = hookmetamethod(game, "__namecall", function(param51, ...)
			if list1.inFifeHook then
				return list1.fifeOldNamecall(param51, ...)
			end

			if getnamecallmethod() == "FireServer" and not func73() then
				list1.inFifeHook = true
				local tbl41 = { ... }

				if tbl41[1] == "UpdateAccuracy" then
					tbl41[2] = 100
				end

				list1.inFifeHook = false
				return list1.fifeOldNamecall(param51, unpack(tbl41))
			end

			return list1.fifeOldNamecall(param51, ...)
		end)
	end)
end

list1.removeFifeHook = function()
	if list1.fifeOldNamecall then
		if type(list1.fifeOldNamecall) == "function" then
			pcall(function()
				hookmetamethod(game, "__namecall", list1.fifeOldNamecall)
			end)
		end

		list1.fifeOldNamecall = nil
	end
end
-- 𝚂𝚘𝚞𝚛𝚌𝚎 𝙻𝚎𝚊𝚔 (𝚂𝙻) // discord.gg/x7YbZeezpm

list1.toggleAutoFife = function(fifeAccuracyEnabled)
	list1.fifeAccuracyEnabled = fifeAccuracyEnabled

	if fifeAccuracyEnabled then
		list1.setupFifeHook()
	else
		list1.removeFifeHook()
	end
end

obj129:AddToggle("AutoFifeToggle", {
	Text = "自动演奏",
	Default = false,
	Tooltip = func6("演奏笛子时自动达到 100% 准确度"),
	Callback = function(value)
		list1.toggleAutoFife(value)
	end,
})

local obj130
obj130 = tbl2.LocalPlayer:AddGroupbox({ Side = "Left", Name = "主要功能", IconName = "user", Description = "速度跳跃" })

do
	local obj131 = tbl2.LocalPlayer:AddGroupbox({ Side = "Right", Name = "美化", IconName = "sparkles", Description = "外观特效" })

	obj131:AddInput("DisguiseAppearanceInput", {
		Default = "gay",
		Numeric = false,
		Finished = false,
		ClearTextOnFocus = true,
		Text = "替换玩家名字",
		Tooltip = func6("输入要复制装扮的玩家名"),
		Placeholder = "输入名字",
		Callback = function()
		end,
	})

	obj131:AddButton({
		Text = "替换装扮",
		Func = function()
			list1.disguise.applyAppearanceOnly(options.DisguiseAppearanceInput.Value)
		end,
		Tooltip = func6("替换玩家外观"),
	})

	obj131:AddInput("DisguiseNameInput", {
		Default = "gay",
		Numeric = false,
		Finished = false,
		ClearTextOnFocus = true,
		Text = "修改用户名",
		Tooltip = func6("输入要改为的用户名"),
		Placeholder = "输入用户名",
		Callback = function()
		end,
	})

	obj131:AddButton({
		Text = "修改名字",
		Func = function()
			list1.disguise.changeNameOnly(options.DisguiseNameInput.Value)
		end,
		Tooltip = func6("仅修改显示名字"),
	})

	local index = {}
	index.__index = index

	index.new = function()
		local obj = setmetatable({}, index)
		obj.Lighting = obj9
		obj.Workspace = obj106
		obj.TweenService = obj8
		obj.LocalPlayer = obj4.LocalPlayer

		obj.Config = {
			MaxParticles = 1200,
			SpawnInterval = 0.03,
			Radius = 60,
			WindX = -8,
			WindY = -12,
			WindZ = 6,
			TextureID = "rbxassetid://7456123890",
			NeonRatio = 0.35,
		}

		obj.Pool = {}
		obj.PoolIndex = 1
		obj.Folder = nil
		obj.IsRunning = false
		return obj
	end

	index.ClearSession = function(self)
		pcall(function()
			local cherryBlossomLayer = self.Workspace:FindFirstChild("CherryBlossom_Layer")

			if cherryBlossomLayer then
				cherryBlossomLayer:Destroy()
			end
		end)

		for _, value189 in self.Lighting:GetChildren() do
			if value189.Name:find("BlossomFX_") then
				pcall(function()
					value189:Destroy()
				end)
			end
		end
	end

	index.ApplyLightingPipeline = function(self)
		pcall(function()
			local level21 = Enum.QualityLevel.Level21
			settings().Rendering.QualityLevel = level21
			self.Lighting.Technology = Enum.Technology.Future
			self.Lighting.GlobalShadows = true
			self.Lighting.EnvironmentDiffuseScale = 0.55
			self.Lighting.EnvironmentSpecularScale = 0.55
		end)

		self.Lighting.ClockTime = 20.6
		self.Lighting.Brightness = 1.2
		self.Lighting.Ambient = color(55, 45, 55)
		self.Lighting.OutdoorAmbient = color(75, 65, 85)
		local atmosphere = self.Lighting:FindFirstChildOfClass("Atmosphere")

		if not atmosphere then
			atmosphere = Instance.new("Atmosphere")
			atmosphere.Parent = self.Lighting
		end

		atmosphere.Density = 0.38
		atmosphere.Haze = 2
		atmosphere.Color = color(255, 180, 195)
		atmosphere.Decay = color(80, 40, 55)
		atmosphere.Glare = 0.15
		local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
		colorCorrectionEffect.Name = "BlossomFX_Color"
		colorCorrectionEffect.Brightness = 0.02
		colorCorrectionEffect.Contrast = 0.12
		colorCorrectionEffect.Saturation = 0.25
		colorCorrectionEffect.TintColor = color(255, 240, 245)
		colorCorrectionEffect.Parent = self.Lighting
		local bloomEffect = Instance.new("BloomEffect")
		bloomEffect.Name = "BlossomFX_Bloom"
		bloomEffect.Intensity = 0.45
		bloomEffect.Size = 16
		bloomEffect.Threshold = 0.85
		bloomEffect.Parent = self.Lighting
		local sunRaysEffect = self.Lighting:FindFirstChildOfClass("SunRaysEffect")

		if sunRaysEffect then
			pcall(function()
				sunRaysEffect:Destroy()
			end)
		end
	end

	index.InitializeParticlePool = function(self)
		self.Folder = Instance.new("Folder")
		self.Folder.Name = "CherryBlossom_Layer"
		self.Folder.Parent = self.Workspace

		for i = 1, self.Config.MaxParticles do
			local part = Instance.new("Part")
			part.Size = Vector3.one
			part.CanCollide = false
			part.CanTouch = false
			part.CanQuery = false
			part.Anchored = true
			part.CastShadow = false
			part.Transparency = 1
			part.Position = Vector3.new(0, 9999, 0)
			part.Parent = self.Folder
			local neonRatio = self.Config.NeonRatio
			local flag92 = math.random() < neonRatio
			part.Material = flag92 and Enum.Material.Neon or Enum.Material.SmoothPlastic
			part.Color = flag92 and color(255, 200, 225) or color(235, 205, 215)
			local specialMesh = Instance.new("SpecialMesh")
			specialMesh.MeshType = Enum.MeshType.Sphere
			local n = math.random(4, 8) / 10
			specialMesh.Scale = vector(n * 0.65, 0.02, n)
			specialMesh.Parent = part
			local decal = Instance.new("Decal")
			decal.Texture = self.Config.TextureID
			decal.Face = Enum.NormalId.Top
			decal.Transparency = flag92 and 0.4 or 0.05
			decal.Parent = part
			local clone = decal:Clone()
			clone.Face = Enum.NormalId.Bottom
			clone.Parent = part
			self.Pool[i] = { Part = part, TweenMove = nil, TweenFade = nil, IsNeon = flag92 }
		end
	end

	index.EmitPetal = function(self, part7)
		if not part7 or not self.IsRunning then
			return
		end
		local value190 = self.Pool[self.PoolIndex]
		self.PoolIndex = self.PoolIndex % self.Config.MaxParticles + 1

		if value190.TweenMove then
			pcall(function()
				value190.TweenMove:Cancel()
			end)
		end

		if value190.TweenFade then
			pcall(function()
				value190.TweenFade:Cancel()
			end)
		end

		local part = value190.Part
		local radius = self.Config.Radius
		local position = part7.Position + vector(math.random(-radius * 10, radius * 10) / 10, math.random(150, 450) / 10, math.random(-radius * 10, radius * 10) / 10)
		local n = math.random(35, 60) / 10
		local windZ = self.Config.WindZ
		local n2 = position + vector(self.Config.WindX + math.random(-80, 80) / 10, self.Config.WindY - math.random(50, 100) / 10, windZ + math.random(-80, 80) / 10)
		part.Position = position
		local cframe2 = CFrame.Angles
		local random = math.random
		part.CFrame = cframe(position) * cframe2(rad(math.random(0, 360)), rad(math.random(0, 360)), rad(random(0, 360)))
		part.Transparency = 1
		local n3 = value190.IsNeon and 0.1 or math.random(5, 20) / 100
		value190.TweenFade = self.TweenService:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine), { Transparency = n3 })
		local cframe3 = CFrame.Angles
		local random2 = math.random

		value190.TweenMove = self.TweenService:Create(part, TweenInfo.new(n, Enum.EasingStyle.Linear), {
			CFrame = cframe(n2) * cframe3(rad(math.random(270, 720)), rad(math.random(180, 540)), rad(random2(270, 720))),
		})

		value190.TweenFade:Play()
		value190.TweenMove:Play()

		task.delay(n - 0.5, function()
			if self.IsRunning and part and part.Parent then
				pcall(function()
					self.TweenService:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine), { Transparency = 1 }):Play()
				end)
			end
		end)

		task.delay(n, function()
			if part and part.Parent then
				part.Transparency = 1
				part.Position = Vector3.new(0, 9999, 0)
			end
		end)
	end

	index.Start = function(self)
		self:ClearSession()
		self:ApplyLightingPipeline()
		self:InitializeParticlePool()
		self.IsRunning = true

		task.spawn(function()
			while self.IsRunning do
				local character = self.LocalPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					for i = 1, 4 do
						if self.IsRunning then
							self:EmitPetal(humanoidRootPart)
							continue
						end
						break
					end
				end

				task.wait(self.Config.SpawnInterval)
			end
		end)
	end

	index.Destroy = function(self)
		self.IsRunning = false

		for _, value191 in self.Pool do
			if value191.TweenMove then
				pcall(function()
					value191.TweenMove:Cancel()
				end)
			end

			if value191.TweenFade then
				pcall(function()
					value191.TweenFade:Cancel()
				end)
			end
		end

		self:ClearSession()
		self.Pool = {}
	end

	_G.CherryBlossomInstance = nil

	_G.StartCherryBlossom = function()
		if _G.CherryBlossomInstance then
			_G.CherryBlossomInstance:Destroy()
		end

		_G.CherryBlossomInstance = index.new()
		_G.CherryBlossomInstance:Start()
		shared.CherryBlossomActiveSession = _G.StartCherryBlossom
	end

	_G.StopCherryBlossom = function()
		if _G.CherryBlossomInstance then
			_G.CherryBlossomInstance:Destroy()
			_G.CherryBlossomInstance = nil
		end

		shared.CherryBlossomActiveSession = nil
	end

	if shared.CherryBlossomActiveSession then
		pcall(function()
			shared.CherryBlossomActiveSession()
		end)
	end

	obj131:AddToggle("CherryBlossomToggle", {
		Text = "樱花天空(无法恢复)",
		Tooltip = func6("飘落樱花花瓣 紫色天空 记住无法恢复"),
		Default = false,
		Callback = function(value)
			if value then
				_G.StartCherryBlossom()
			else
				_G.StopCherryBlossom()
			end
		end,
	})

	list1.francModifier = list1.francModifier or {}
	list1.francModifier.enabled = false
	list1.francModifier.targetValue = 99999999
	list1.francModifier.charAddedDisposer = nil

	list1.francModifier.apply = function()
		if not list1.francModifier.enabled then
			return
		end
		local leaderstats = localPlayer:FindFirstChild("leaderstats")

		if leaderstats then
			local francs = leaderstats:FindFirstChild("Francs")

			if francs and (francs:IsA("NumberValue") or francs:IsA("IntValue")) then
				francs.Value = list1.francModifier.targetValue
			end
		end
	end

	list1.francModifier.onCharacterAdded = function()
		task.wait(0.2)
		list1.francModifier.apply()
	end

	list1.francModifier.start = function()
		if list1.francModifier.enabled then
			return
		end
		list1.francModifier.enabled = true
		list1.francModifier.apply()

		if not list1.francModifier.charAddedDisposer then
			list1.francModifier.charAddedDisposer = list1.onCharacterAdded(list1.francModifier.onCharacterAdded)
		end
	end

	list1.francModifier.stop = function()
		list1.francModifier.enabled = false

		if list1.francModifier.charAddedDisposer then
			list1.francModifier.charAddedDisposer()
			list1.francModifier.charAddedDisposer = nil
		end
	end

	obj131:AddInput("FrancAmountInput", {
		Text = "法郎数量",
		Default = "柳叶",
		Numeric = true,
		Finished = true,
		Callback = function(value)
			local num36 = tonumber(value)

			if num36 then
				list1.francModifier.targetValue = floor(num36)
			else
				list1.francModifier.targetValue = 99999999
			end
		end,
	})

	obj131:AddToggle("FrancModifierToggle", {
		Text = "修改法郎数量",
		Tooltip = func6("开启后本地修改法郎"),
		Default = false,
		Callback = function(value)
			if value then
				list1.francModifier.start()
			else
				list1.francModifier.stop()
			end
		end,
	})

	list1.zeroBeauty = list1.zeroBeauty or {}
	list1.zeroBeauty.enabled = false
	list1.zeroBeauty.connection = nil

	list1.zeroBeauty.start = function()
		if list1.zeroBeauty.connection then
			return
		end
		list1.zeroBeauty.enabled = true

		list1.zeroBeauty.connection = obj5.Heartbeat:Connect(function()
			if not list1.zeroBeauty.enabled then
				return
			end
			local character = localPlayer.Character
			if not character then
				return
			end
			local humanoid = character:FindFirstChild("Humanoid")
			if not humanoid or humanoid.Health <= 0 then
				return
			end
			local face = character:FindFirstChild("Face")

			if face then
				local face2 = face:FindFirstChild("Face")

				if face2 and face2:IsA("Decal") then
					face2.Texture = "http://www.roblox.com/asset/?id=174259585"
				end
			end

			if character:FindFirstChild("Face") then
				character.Face.Color = color(121, 121, 121)
			end

			if character:FindFirstChild("Torso") then
				character.Torso.Color = color(121, 121, 121)
			end

			if character:FindFirstChild("Right Leg") then
				character["Right Leg"].Color = color(121, 121, 121)
			end

			if character:FindFirstChild("Right Arm") then
				character["Right Arm"].Color = color(121, 121, 121)
			end

			if character:FindFirstChild("Left Leg") then
				character["Left Leg"].Color = color(121, 121, 121)
			end

			if character:FindFirstChild("Left Arm") then
				character["Left Arm"].Color = color(121, 121, 121)
			end
		end)
	end

	list1.zeroBeauty.stop = function()
		list1.zeroBeauty.enabled = false

		if list1.zeroBeauty.connection then
			list1.zeroBeauty.connection:Disconnect()
			list1.zeroBeauty.connection = nil
		end

		local character = localPlayer.Character
		if not character then
			return
		end
		local face = character:FindFirstChild("Face")

		if face then
			local face2 = face:FindFirstChild("Face")

			if face2 and face2:IsA("Decal") then
				face2.Texture = "rbxassetid://13815097986"
			end
		end

		if character:FindFirstChild("Face") then
			character.Face.Color = color(255, 204, 153)
		end

		if character:FindFirstChild("Torso") then
			character.Torso.Color = color(255, 204, 153)
		end

		if character:FindFirstChild("Right Leg") then
			character["Right Leg"].Color = color(255, 204, 153)
		end

		if character:FindFirstChild("Right Arm") then
			character["Right Arm"].Color = color(255, 204, 153)
		end

		if character:FindFirstChild("Left Leg") then
			character["Left Leg"].Color = color(255, 204, 153)
		end

		if character:FindFirstChild("Left Arm") then
			character["Left Arm"].Color = color(255, 204, 153)
		end
	end

	obj131:AddToggle("ZeroBeautyToggle", {
		Text = "更改外观",
		Tooltip = func6("更改玩家肤色 面部表情"),
		Default = false,
		Callback = function(value)
			if value then
				list1.zeroBeauty.start()
			else
				list1.zeroBeauty.stop()
			end
		end,
	})

	obj131:AddLabel("服务器加入")

	obj131:AddInput("ServerTrackerInput", {
		Text = "玩家用户名",
		Default = "",
		Numeric = false,
		Finished = false,
		ClearTextOnFocus = true,
		Placeholder = "输入玩家名",
		Callback = function()
		end,
	})

	obj131:AddButton({
		Text = "加入",
		Func = function()
			local pendingSearch = options.ServerTrackerInput.Value
			if pendingSearch == "" then
				lib:Notify({ Title = func5("错误"), Description = func5("请输入玩家名"), Time = 3 })
				return
			end
			local serverBrowserEvent = obj7:FindFirstChild("ServerBrowserEvent")
			local serverBrowserFunc = obj7:FindFirstChild("ServerBrowserFunc")
			if not serverBrowserEvent then
				lib:Notify({ Title = func5("错误"), Description = func5("无法获取服务器事件"), Time = 3 })
				return
			end
			list1.serverTracker.pendingSearch = pendingSearch

			if serverBrowserFunc and serverBrowserFunc:IsA("RemoteEvent") then
				serverBrowserFunc:FireServer("RequestListing")
			else
				serverBrowserEvent:FireServer("RequestListing")
			end

			lib:Notify({ Title = func5("搜索中"), Description = func5("请耐心等待"), Time = 2 })
		end,
		Tooltip = func6("服务器加入"),
	})
end

if not list1.serverTracker then
	list1.serverTracker = { pendingSearch = nil, initialized = false }
end

local function func74()
	return obj7:FindFirstChild("ServerBrowserEvent"), (obj7:FindFirstChild("ServerBrowserFunc"))
end

list1.serverTracker.init = function()
	if list1.serverTracker.initialized then
		return
	end
	local result20 = func74()
	if not result20 then
		return
	end

	result20.OnClientEvent:Connect(function(flag93, param52)
		if flag93 == "ReturnListing" and param52 then
			local pendingSearch = list1.serverTracker.pendingSearch
			if not pendingSearch then
				return
			end
			list1.serverTracker.pendingSearch = nil

			local ok, result = pcall(function()
				return obj4:GetUserIdFromNameAsync(pendingSearch)
			end)

			if not (ok and result and result > 0) then
				local ok2, result2 = pcall(function()
					return obj2:GetAsync("https://users.roblox.com/v1/users/search?keyword=" .. obj2:UrlEncode(pendingSearch))
				end)

				local value192 = ok2 and result2
				local value193 = nil

				if value192 then
					local data = obj2:JSONDecode(result2)
					local flag94 = data and data.data and #data.data > 0
					local value194 = nil

					if flag94 then
						local id = nil

						for _, value195 in data.data do
							if string.lower(value195.name) == string.lower(pendingSearch) then
								id = value195.id
								break
							else
								id = nil
							end
						end

						result = id or data.data[1].id
					else
						result = value194
					end
				else
					result = value193
				end
			end

			if not result then
				lib:Notify({ Title = func5("未找到"), Description = func5("找不到玩家 ") .. pendingSearch, Time = 3 })
				return
			end
			local value196 = nil

			for _, value197 in param52 do
				if value197.PlayerListing then
					for _, value198 in value197.PlayerListing do
						if tonumber(value198) == result then
							value196 = value197
							break
						end
					end
				end

				if not value196 then
					continue
				end
				break
			end

			if value196 then
				local jobId = value196.JobId or value196.jobId

				if jobId then
					local placeId = game.PlaceId

					pcall(function()
						obj3:TeleportToPlaceInstance(placeId, jobId, localPlayer)
					end)

					lib:Notify({ Title = func5("加入"), Description = func5("正在传送至服务器..."), Time = 2 })
				else
					lib:Notify({ Title = func5("错误"), Description = func5("该服务器缺少 JobId"), Time = 3 })
				end
			else
				lib:Notify({ Title = func5("未找到"), Description = func5("玩家 ") .. pendingSearch .. func5(" 不在任何公开服务器中"), Time = 3 })
			end
		end
	end)

	list1.serverTracker.initialized = true
end

list1.serverTracker.init()

obj38:AddToggle("AnimPullGateToggle", {
	Text = "拉大门",
	Default = false,
	Tooltip = func6("拉大门动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			list1._animPullGate = list1.startIdleWalk(list1._animPullGate, "rbxassetid://101487438848164", "rbxassetid://109268182565437", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(list1._animPullGate)
		end
	end,
})

obj38:AddToggle("AnimFakeInjuredToggle", {
	Text = "残血",
	Default = false,
	Tooltip = func6("静止播放假残血动画，移动播放假残血走路动画"),
	Callback = function(value)
		if value then
			list1._animFakeInjured = list1.startIdleWalk(list1._animFakeInjured, "rbxassetid://14970034680", "rbxassetid://15530089342", Enum.AnimationPriority.Idle)
		else
			list1.stopIdleWalk(list1._animFakeInjured)
		end
	end,
})

obj38:AddToggle("AnimShamblerToggle", {
	Text = "山伯乐",
	Default = false,
	Tooltip = func6("山伯乐动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			list1._animShambler = list1.startIdleWalk(list1._animShambler, "rbxassetid://12333488814", "rbxassetid://14463730540", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(list1._animShambler)
		end
	end,
})

obj38:AddToggle("AnimRunnerToggle", {
	Text = "红眼",
	Default = false,
	Tooltip = func6("红眼动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			list1._animRunner = list1.startIdleWalk(list1._animRunner, "rbxassetid://12581784105", "rbxassetid://12581785298", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(list1._animRunner)
		end
	end,
})

obj38:AddToggle("AnimCuirassierToggle", {
	Text = "胸甲骑兵1",
	Default = false,
	Tooltip = func6("胸甲骑兵动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			list1._animCuirassier = list1.startIdleWalk(list1._animCuirassier, "rbxassetid://87579228279296", "rbxassetid://102081698785465", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(list1._animCuirassier)
		end
	end,
})

obj38:AddToggle("AnimCuirassier2Toggle", {
	Text = "胸甲僵尸2",
	Default = false,
	Tooltip = func6("静止播放动画，移动播放动画"),
	Callback = function(value)
		if value then
			list1._animCuirassier2 = list1.startIdleWalk(list1._animCuirassier2, "rbxassetid://82800474630427", "rbxassetid://118210337289087", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(list1._animCuirassier2)
		end
	end,
})

obj38:AddToggle("AnimCavalryChargeToggle", {
	Text = "胸甲骑兵冲锋快捷栏",
	Default = false,
	Tooltip = func6("打开小方块快捷栏执行冲锋"),
	Callback = function(value)
		if value then
			if _G.cavalryUI then
				_G.cavalryUI:Destroy()
			end

			local value199 = _G
			local value200 = _G

			local CavalryChargeUI, value201 = list1.createFloatingButton("CavalryChargeUI", "冲", UDim2.new(0.5, -105, 0.3, 0), 24, function()
				task.spawn(_G.cavalryCharge)
			end)

			value199.cavalryUI = CavalryChargeUI
			value200.cavalryBtn = value201
			_G.cavalryPlaying = false

			_G.cavalryCharge = function()
				if _G.cavalryPlaying then
					return
				end
				_G.cavalryPlaying = true

				if _G.cavalryBtn then
					_G.cavalryBtn.Text = "冲锋中"
				end

				local character = localPlayer.Character

				if not character then
					_G.cavalryPlaying = false

					if _G.cavalryBtn then
						_G.cavalryBtn.Text = "冲"
					end

					return
				end

				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if not humanoid then
					_G.cavalryPlaying = false

					if _G.cavalryBtn then
						_G.cavalryBtn.Text = "冲"
					end

					return
				end

				local animator = humanoid:FindFirstChildOfClass("Animator")

				if not animator then
					animator = Instance.new("Animator")
					animator.Parent = humanoid
				end

				for _, getPlayingAnimationTrack9 in humanoid:GetPlayingAnimationTracks() do
					getPlayingAnimationTrack9:Stop()
				end

				local function func75(str7)
					local animation = Instance.new("Animation")
					animation.AnimationId = "rbxassetid://" .. str7
					local value202 = animator:LoadAnimation(animation)
					value202.Priority = Enum.AnimationPriority.Action4
					return value202
				end

				local function func76(param53, param54)
					local flag95 = false

					local connection = param53.Stopped:Once(function()
						flag95 = true
					end)

					local result21 = clock2()

					while not flag95 and param53.IsPlaying and clock2() - result21 < param54 do
						task.wait(0.05)
					end

					pcall(function()
						connection:Disconnect()
					end)
				end

				local obj132 = func75("105118183189738")
				local obj133 = func75("17406602570")
				local walkSpeed = humanoid.WalkSpeed
				humanoid.WalkSpeed = 1
				obj132:Play()
				func76(obj132, 10)
				if not _G.cavalryPlaying then
					humanoid.WalkSpeed = walkSpeed
					return
				end
				humanoid.WalkSpeed = 28
				obj133:Play()
				local n = clock2() + 5

				while true do
					if clock2() < n and obj133.IsPlaying then
						task.wait()
						if _G.cavalryPlaying then
							continue
						end
					end

					break
				end

				obj133:Stop()
				humanoid.WalkSpeed = walkSpeed
				if not _G.cavalryPlaying then
					return
				end
				local flag96 = false

				for _, getPlayer15 in obj4:GetPlayers() do
					if getPlayer15 ~= localPlayer and getPlayer15.Character then
						local character2 = getPlayer15.Character
						local position = humanoid.RootPart.Position
						if (character2:GetPivot().Position - position).Magnitude < 10 then
							flag96 = true
							break
						end
					end
				end

				local obj134 = func75(flag96 and "102984581737936" or "139159672489901")

				if not flag96 then
					humanoid.WalkSpeed = 4
				end

				obj134:Play()
				func76(obj134, 15)
				humanoid.WalkSpeed = 16
				_G.cavalryPlaying = false

				if _G.cavalryBtn then
					_G.cavalryBtn.Text = "冲"
				end
			end
		else
			if _G.cavalryUI then
				_G.cavalryUI:Destroy()
				_G.cavalryUI = nil
			end

			_G.cavalryBtn = nil
			_G.cavalryPlaying = false
		end
	end,
})

obj38:AddToggle("AnimLanternToggle", {
	Text = "提灯人",
	Default = false,
	Tooltip = func6("提灯人动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			_G._animLantern = list1.startIdleWalk(_G._animLantern, "rbxassetid://14678879479", "rbxassetid://14678880308", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(_G._animLantern)
		end
	end,
})

obj38:AddToggle("AnimAxeToggle", {
	Text = "斧头僵尸",
	Default = false,
	Tooltip = func6("斧头僵尸动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			_G._animAxe = list1.startIdleWalk(_G._animAxe, "rbxassetid://14498563473", "rbxassetid://14498289874", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(_G._animAxe)
		end
	end,
})

obj38:AddToggle("AnimAxeSlashToggle", {
	Text = "斧头僵尸劈砍快捷栏",
	Default = false,
	Tooltip = func6("打开小方块快捷栏执行劈砍"),
	Callback = function(value)
		if value then
			if _G.zapperUI then
				_G.zapperUI:Destroy()
			end

			local value203 = _G
			local value204 = _G

			local ZapperEffectUI, value205 = list1.createFloatingButton("ZapperEffectUI", "劈砍", UDim2.new(0.5, -35, 0.4, 0), 18, function()
				task.spawn(_G.zapperSlash)
			end)

			value203.zapperUI = ZapperEffectUI
			value204.zapperBtn = value205
			_G.zapperBusy = false

			_G.zapperSlash = function()
				if _G.zapperBusy then
					return
				end
				_G.zapperBusy = true

				if _G.zapperBtn then
					_G.zapperBtn.Text = "劈砍中"
				end

				local character = localPlayer.Character

				if not character then
					_G.zapperBusy = false

					if _G.zapperBtn then
						_G.zapperBtn.Text = "劈砍"
					end

					return
				end

				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if not humanoid then
					_G.zapperBusy = false

					if _G.zapperBtn then
						_G.zapperBtn.Text = "劈砍"
					end

					return
				end

				local animator = humanoid:FindFirstChildOfClass("Animator")

				if not animator then
					local animator2 = Instance.new("Animator")
					animator2.Parent = humanoid
					animator = animator2
				end

				local animation = Instance.new("Animation")
				animation.AnimationId = "rbxassetid://14499470197"
				local obj135 = animator:LoadAnimation(animation)
				obj135.Priority = Enum.AnimationPriority.Action4
				obj135:Play()

				obj135.Stopped:Connect(function()
					_G.zapperBusy = false

					if _G.zapperBtn then
						_G.zapperBtn.Text = "劈砍"
					end
				end)

				task.delay(5, function()
					if _G.zapperBusy then
						_G.zapperBusy = false

						if _G.zapperBtn then
							_G.zapperBtn.Text = "劈砍"
						end
					end
				end)
			end
		else
			if _G.zapperUI then
				_G.zapperUI:Destroy()
				_G.zapperUI = nil
			end

			_G.zapperBtn = nil
			_G.zapperBusy = false
		end
	end,
})

obj38:AddToggle("AnimBarrelToggle", {
	Text = "自爆",
	Default = false,
	Tooltip = func6("自爆动画（待机/行走自动切换）"),
	Callback = function(value)
		if value then
			_G._animBarrel = list1.startIdleWalk(_G._animBarrel, "rbxassetid://13211198049", "rbxassetid://13211207597", Enum.AnimationPriority.Action3)
		else
			list1.stopIdleWalk(_G._animBarrel)
		end
	end,
})

obj38:AddToggle("AnimCrawlerToggle", {
	Text = "爬尸",
	Default = false,
	Tooltip = func6("爬尸动画（爬行模式）"),
	Callback = function(value)
		if value then
			_G._animCrawler = list1.startIdleWalk(_G._animCrawler, "rbxassetid://13726632691", "rbxassetid://13726634549", Enum.AnimationPriority.Action3, nil, "rbxassetid://130515356351734")
		else
			list1.stopIdleWalk(_G._animCrawler)
			_G._animCrawler = nil
		end
	end,
})

obj38:AddToggle("AnimHeavyChargeToggle", {
	Text = "重剑冲锋",
	Default = false,
	Tooltip = func6("重剑冲锋动画（开启速度24，关闭速度16）"),
	Callback = function(value)
		if value then
			_G._animHeavyCharge = list1.startIdleWalk(_G._animHeavyCharge, "rbxassetid://14284611111", "rbxassetid://17406602570", Enum.AnimationPriority.Action3, 24)
		else
			list1.stopIdleWalk(_G._animHeavyCharge, 16)
			_G._animHeavyCharge = nil
		end
	end,
})

obj38:AddToggle("AnimMusketChargeToggle", {
	Text = "滑膛枪冲锋",
	Default = false,
	Tooltip = func6("滑膛枪冲锋动画（开启速度24，关闭速度16）"),
	Callback = function(value)
		if value then
			_G._animMusketCharge = list1.startIdleWalk(_G._animMusketCharge, "rbxassetid://14292935158", "rbxassetid://14292937831", Enum.AnimationPriority.Action3, 24)
		else
			list1.stopIdleWalk(_G._animMusketCharge, 16)
			_G._animMusketCharge = nil
		end
	end,
})

obj38:AddToggle("AnimChargeToggle", {
	Text = "冲锋",
	Default = false,
	Tooltip = func6("冲锋动画（开启速度24，关闭速度16）"),
	Callback = function(value)
		if value then
			_G._animCharge = list1.startIdleWalk(_G._animCharge, "rbxassetid://14284611111", "rbxassetid://14284623849", Enum.AnimationPriority.Idle, 24)
		else
			list1.stopIdleWalk(_G._animCharge, 16)
			_G._animCharge = nil
		end
	end,
})

list1.onCharacterAdded(function()
	task.wait(0.2)

	local function func77(flag97)
		if not flag97 then
			return
		end

		if flag97.idle then
			pcall(function()
				flag97.idle:Stop()
			end)
		end

		if flag97.walk then
			pcall(function()
				flag97.walk:Stop()
			end)
		end

		if flag97.sit then
			pcall(function()
				flag97.sit:Stop()
			end)
		end

		if flag97.conn then
			pcall(function()
				flag97.conn:Disconnect()
			end)
		end
	end

	local function func78(param55)
		local entry13 = toggles[param55]

		if entry13 and entry13.SetValue then
			entry13:SetValue(false)
		end
	end

	local tbl42 = {
		{ "_animLantern", "AnimLanternToggle" },
		{ "_animAxe", "AnimAxeToggle" },
		{ "_animBarrel", "AnimBarrelToggle" },
		{ "_animCrawler", "AnimCrawlerToggle" },
		{ "_animHeavyCharge", "AnimHeavyChargeToggle" },
		{ "_animMusketCharge", "AnimMusketChargeToggle" },
		{ "_animCharge", "AnimChargeToggle" },
		{ "boxerCtrl", "AnimBoxerToggle" },
	}

	for _, value206 in {
		{ "_animPullGate", "AnimPullGateToggle" },
		{ "_animFakeInjured", "AnimFakeInjuredToggle" },
		{ "_animShambler", "AnimShamblerToggle" },
		{ "_animRunner", "AnimRunnerToggle" },
		{ "_animCuirassier", "AnimCuirassierToggle" },
		{ "_animCuirassier2", "AnimCuirassier2Toggle" },
	}, nil, nil do
		func77(list1[value206[1]])
		list1[value206[1]] = nil
		func78(value206[2])
	end

	for _, value207 in tbl42 do
		func77(_G[value207[1]])
		_G[value207[1]] = nil
		func78(value207[2])
	end
end)

obj38:AddToggle("AnimBoxerToggle", {
	Text = "拳击手",
	Default = false,
	Tooltip = func6("拳击手模式（行走/待机动画 + 左右拳按钮）"),
	Callback = function(value)
		if value then
			if _G.boxerActive then
				return
			end
			_G.boxerActive = true
			local character = localPlayer.Character
			if not character then
				_G.boxerActive = false
				return
			end
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				_G.boxerActive = false
				return
			end
			local animator = humanoid:FindFirstChildOfClass("Animator")

			if not animator then
				local animator2 = Instance.new("Animator")
				animator2.Parent = humanoid
				animator = animator2
			end

			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://124381258015151"
			local animation2 = Instance.new("Animation")
			animation2.AnimationId = "rbxassetid://127477273497271"
			local obj136 = animator:LoadAnimation(animation)
			local obj137 = animator:LoadAnimation(animation2)
			obj136.Priority = Enum.AnimationPriority.Action3
			obj137.Priority = Enum.AnimationPriority.Action3

			local function func79()
				if humanoid.MoveDirection.Magnitude > 0 then
					if obj137 and not obj137.IsPlaying then
						if obj136 and obj136.IsPlaying then
							obj136:Stop()
						end

						obj137:Play()
					end
				elseif obj136 and not obj136.IsPlaying then
					if obj137 and obj137.IsPlaying then
						obj137:Stop()
					end

					obj136:Play()
				end
			end

			local connection = humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(func79)
			func79()
			_G.boxerCtrl = { idle = obj136, walk = obj137, conn = connection }
			humanoid.WalkSpeed = 17
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://0"
			sound.Looped = true
			sound.Volume = 0
			sound.Parent = character:FindFirstChild("Head") or character
			sound:Play()
			_G.boxerSound = sound

			if _G.boxerShowUI == nil or _G.boxerShowUI then
				if _G.boxerUI then
					_G.boxerUI:Destroy()
				end

				_G.boxerUI = Instance.new("ScreenGui")
				_G.boxerUI.Name = "BoxerUI"
				_G.boxerUI.ResetOnSpawn = false
				_G.boxerUI.Parent = localPlayer:WaitForChild("PlayerGui")

				local function createTextButton(text, param56, backgroundColor3)
					local textButton = Instance.new("TextButton")
					textButton.Size = UDim2.new(0, 60, 0, 60)
					textButton.AnchorPoint = Vector2.new(0.5, 0.5)
					textButton.Position = UDim2.new(param56, 0, 0.5, 0)
					textButton.BackgroundColor3 = backgroundColor3
					textButton.BackgroundTransparency = 0.2
					textButton.BorderSizePixel = 0
					textButton.Text = text
					textButton.TextColor3 = Color3.new(1, 1, 1)
					textButton.TextSize = 20
					textButton.Font = Enum.Font.GothamBold
					textButton.Draggable = not (_G.boxerFixed == nil or _G.boxerFixed)
					textButton.Active = true
					textButton.Parent = _G.boxerUI
					local uiCorner = Instance.new("UICorner")
					uiCorner.CornerRadius = UDim.new(0, 12)
					uiCorner.Parent = textButton
					local uiStroke = Instance.new("UIStroke")
					uiStroke.Thickness = 2
					uiStroke.Color = color(100, 200, 255)
					uiStroke.Transparency = 0.3
					uiStroke.Parent = textButton
					local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
					uiAspectRatioConstraint.AspectRatio = 1
					uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
					uiAspectRatioConstraint.Parent = textButton
					return textButton
				end

				local textButton2 = createTextButton("左拳", 0.3, color(255, 100, 100))
				local textButton3 = createTextButton("右拳", 0.7, color(100, 100, 255))

				local function func80(animationId)
					if not _G.boxerActive then
						return
					end
					local character2 = localPlayer.Character
					if not character2 then
						return
					end
					local humanoid2 = character2:FindFirstChildOfClass("Humanoid")
					if not humanoid2 then
						return
					end
					local animator2 = humanoid2:FindFirstChildOfClass("Animator")

					if not animator2 then
						animator2 = Instance.new("Animator")
						animator2.Parent = humanoid2
					end

					local animation3 = Instance.new("Animation")
					animation3.AnimationId = animationId
					local obj138 = animator2:LoadAnimation(animation3)
					obj138.Priority = Enum.AnimationPriority.Action4
					obj138:Play()

					obj138.Stopped:Connect(function()
						animation3:Destroy()
					end)
				end

				textButton2.MouseButton1Click:Connect(function()
					task.spawn(function()
						func80("rbxassetid://100609705099226")
					end)
				end)

				textButton3.MouseButton1Click:Connect(function()
					task.spawn(function()
						func80("rbxassetid://137400696654354")
					end)
				end)

				_G.boxerUILeft = textButton2
				_G.boxerUIRight = textButton3
			end

			if _G.boxerDeathConn then
				_G.boxerDeathConn:Disconnect()
			end

			_G.boxerDeathConn = humanoid.Died:Connect(function()
				if _G.boxerActive then
					_G.boxerActive = false

					if _G.boxerCtrl then
						if _G.boxerCtrl.idle then
							pcall(function()
								_G.boxerCtrl.idle:Stop()
							end)
						end

						if _G.boxerCtrl.walk then
							pcall(function()
								_G.boxerCtrl.walk:Stop()
							end)
						end

						if _G.boxerCtrl.conn then
							pcall(function()
								_G.boxerCtrl.conn:Disconnect()
							end)
						end

						_G.boxerCtrl = nil
					end

					local humanoid2 = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

					if humanoid2 then
						humanoid2.WalkSpeed = 16
					end

					if _G.boxerSound then
						_G.boxerSound:Stop()
						_G.boxerSound:Destroy()
						_G.boxerSound = nil
					end

					if _G.boxerUI then
						_G.boxerUI:Destroy()
						_G.boxerUI = nil
					end

					_G.boxerUILeft = nil
					_G.boxerUIRight = nil

					if _G.boxerDeathConn then
						_G.boxerDeathConn:Disconnect()
						_G.boxerDeathConn = nil
					end
				end
			end)
		else
			_G.boxerActive = false

			if _G.boxerCtrl then
				if _G.boxerCtrl.idle then
					pcall(function()
						_G.boxerCtrl.idle:Stop()
					end)
				end

				if _G.boxerCtrl.walk then
					pcall(function()
						_G.boxerCtrl.walk:Stop()
					end)
				end

				if _G.boxerCtrl.conn then
					pcall(function()
						_G.boxerCtrl.conn:Disconnect()
					end)
				end

				_G.boxerCtrl = nil
			end

			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.WalkSpeed = 16
			end

			if _G.boxerSound then
				_G.boxerSound:Stop()
				_G.boxerSound:Destroy()
				_G.boxerSound = nil
			end

			if _G.boxerUI then
				_G.boxerUI:Destroy()
				_G.boxerUI = nil
			end

			_G.boxerUILeft = nil
			_G.boxerUIRight = nil

			if _G.boxerDeathConn then
				_G.boxerDeathConn:Disconnect()
				_G.boxerDeathConn = nil
			end
		end
	end,
})

obj38:AddToggle("AnimBoxerFixedToggle", {
	Text = "固定按钮",
	Default = true,
	Tooltip = func6("拳击按钮不可拖动"),
	Callback = function(boxerFixed)
		_G.boxerFixed = boxerFixed

		if _G.boxerUILeft and _G.boxerUIRight then
			local draggable = not boxerFixed
			_G.boxerUILeft.Draggable = draggable
			_G.boxerUIRight.Draggable = draggable
		end
	end,
})

obj38:AddToggle("AnimBoxerUIToggle", {
	Text = "显示拳击 UI",
	Default = true,
	Tooltip = func6("显示/隐藏拳击按钮界面"),
	Callback = function(boxerShowUI)
		_G.boxerShowUI = boxerShowUI

		if _G.boxerActive then
			if boxerShowUI then
				if not _G.boxerUI then
					if not localPlayer.Character then
						return
					end
					_G.boxerUI = Instance.new("ScreenGui")
					_G.boxerUI.Name = "BoxerUI"
					_G.boxerUI.ResetOnSpawn = false
					_G.boxerUI.Parent = localPlayer:WaitForChild("PlayerGui")

					local function createTextButton(text, param57, backgroundColor3)
						local textButton = Instance.new("TextButton")
						textButton.Size = UDim2.new(0, 60, 0, 60)
						textButton.AnchorPoint = Vector2.new(0.5, 0.5)
						textButton.Position = UDim2.new(param57, 0, 0.5, 0)
						textButton.BackgroundColor3 = backgroundColor3
						textButton.BackgroundTransparency = 0.2
						textButton.BorderSizePixel = 0
						textButton.Text = text
						textButton.TextColor3 = Color3.new(1, 1, 1)
						textButton.TextSize = 20
						textButton.Font = Enum.Font.GothamBold
						textButton.Draggable = not (_G.boxerFixed == nil or _G.boxerFixed)
						textButton.Active = true
						textButton.Parent = _G.boxerUI
						local uiCorner = Instance.new("UICorner")
						uiCorner.CornerRadius = UDim.new(0, 12)
						uiCorner.Parent = textButton
						local uiStroke = Instance.new("UIStroke")
						uiStroke.Thickness = 2
						uiStroke.Color = color(100, 200, 255)
						uiStroke.Transparency = 0.3
						uiStroke.Parent = textButton
						local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
						uiAspectRatioConstraint.AspectRatio = 1
						uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
						uiAspectRatioConstraint.Parent = textButton
						return textButton
					end

					local textButton4 = createTextButton("左拳", 0.3, color(255, 100, 100))
					local textButton5 = createTextButton("右拳", 0.7, color(100, 100, 255))

					local function func81(animationId)
						if not _G.boxerActive then
							return
						end
						local character = localPlayer.Character
						if not character then
							return
						end
						local humanoid = character:FindFirstChildOfClass("Humanoid")
						if not humanoid then
							return
						end
						local animator = humanoid:FindFirstChildOfClass("Animator")

						if not animator then
							animator = Instance.new("Animator")
							animator.Parent = humanoid
						end

						local animation = Instance.new("Animation")
						animation.AnimationId = animationId
						local obj139 = animator:LoadAnimation(animation)
						obj139.Priority = Enum.AnimationPriority.Action4
						obj139:Play()

						obj139.Stopped:Connect(function()
							animation:Destroy()
						end)
					end

					textButton4.MouseButton1Click:Connect(function()
						task.spawn(function()
							func81("rbxassetid://100609705099226")
						end)
					end)

					textButton5.MouseButton1Click:Connect(function()
						task.spawn(function()
							func81("rbxassetid://137400696654354")
						end)
					end)

					_G.boxerUILeft = textButton4
					_G.boxerUIRight = textButton5
				end

				_G.boxerUI.Enabled = true
			elseif _G.boxerUI then
				_G.boxerUI.Enabled = false
			end
		end
	end,
})

do
	local obj140 = tbl2.Main:AddGroupbox({ Side = "Right", Name = "杀戮光环", IconName = "circle-dot", Description = "自动攻击" })
	local str8 = "工兵"

	obj140:AddDropdown("AuraMode", {
		Values = { "工兵", "防封" },
		Default = 1,
		Multi = false,
		Text = "杀戮光环模式",
		Tooltip = func6("选择杀戮光环模式（实时切换）"),
		Callback = function(value)
			str8 = value

			if auraMasterEnabled then
				if list1.auraEnabled then
					list1.stopAura()
				end

				if list1.qingShuiAura and list1.qingShuiAura.enabled then
					list1.stopQingShuiAura()
				end

				if str8 == "工兵" then
					list1.startAura()
				elseif str8 == "防封" then
					list1.startQingShuiAura()
				end
			end
		end,
	})

	obj140:AddDivider()

	obj140:AddToggle("AuraToggle", {
		Text = "开启杀戮光环",
		Default = false,
		Tooltip = func6("开启/关闭杀戮光环（根据下拉框选择的模式）"),
		Callback = function(value)
			auraMasterEnabled = value

			if list1.auraEnabled then
				list1.stopAura()
			end

			if list1.qingShuiAura and list1.qingShuiAura.enabled then
				list1.stopQingShuiAura()
			end

			if value then
				if str8 == "工兵" then
					list1.startAura()
				elseif str8 == "防封" then
					list1.startQingShuiAura()
				end

				list1.startIndicatorUpdater()
			else
				list1.stopIndicatorUpdater()
			end
		end,
	})
end

local obj141 = tbl2.Main:AddGroupbox({ Side = "Left", Name = "飞行功能", IconName = "plane", Description = "飞行控制" })

obj141:AddButton({
	Text = "飞行-无相机锁定",
	Func = function()
		list1.FlyOriginal()
	end,
})

obj141:AddButton({
	Text = "飞行-优化",
	Func = function()
		list1.FlyNew()
	end,
})

obj141:AddDivider()
obj141:AddLabel("飞行-传送", true)

obj141:AddToggle("WarpFlyToggle", {
	Text = "飞行-传送",
	Default = false,
	Tooltip = func6("WASD移动，Space上升，LCtrl下降。"),
	Callback = function(value)
		if value then
			list1.warpFly.start()
		else
			list1.warpFly.stop()
		end
	end,
})

obj141:AddLabel("飞行-传送 快捷键"):AddKeyPicker("WarpFlyKeybind", {
	Default = "F",
	NoUI = false,
	Text = "飞行-传送 开关",
	Callback = function()
		local warpFlyToggle = toggles.WarpFlyToggle
		warpFlyToggle:SetValue(not warpFlyToggle.Value)
	end,
})

obj141:AddSlider("WarpFlySpeed", {
	Text = "飞行速度",
	Default = 35,
	Min = 10,
	Max = 200,
	Rounding = 0,
	Compact = false,
	Callback = function(flySpeed)
		list1.warpFly.flySpeed = flySpeed
	end,
})

obj141:AddButton({
	Text = "飞行-动画",
	Func = function()
		list1.FlyAnimation()
	end,
})

obj141:AddDivider()
obj141:AddLabel("自由视角传送", true)

obj141:AddToggle("TPFreecamToggle", {
	Text = "自由视角",
	Default = false,
	Tooltip = func6("自由视角锚定角色，原生视角跟随鼠标/触摸"),
	Callback = function(value)
		if value then
			list1.tpFreecam.start()
		else
			list1.tpFreecam.stop()
		end
	end,
})

obj141:AddLabel("自由视角传送 快捷键"):AddKeyPicker("TPFreecamKeybind", {
	Default = "G",
	NoUI = false,
	Text = "自由视角 开关",
	Callback = function()
		local tpFreecamToggle = toggles.TPFreecamToggle
		tpFreecamToggle:SetValue(not tpFreecamToggle.Value)
	end,
})

obj141:AddSlider("TPFreecamSpeed", {
	Text = "视角速度",
	Default = 50,
	Min = 5,
	Max = 150,
	Rounding = 0,
	Compact = false,
	Callback = function(speed)
		list1.tpFreecam.speed = speed
	end,
})

obj141:AddButton({
	Text = "传送到视角",
	Func = function()
		list1.tpFreecam.tpToCamera()
	end,
	Tooltip = func6("将角色传送到当前视角位置"),
})

obj141:AddInput("TPFreecamName", {
	Default = "",
	Numeric = false,
	Finished = false,
	ClearTextOnFocus = false,
	Text = "保存位置",
	Tooltip = func6("保存当前视角或位置"),
	Placeholder = "输入名字",
	Callback = function()
	end,
})

obj141:AddButton({
	Text = "保存位置",
	Func = function()
		list1.tpFreecam.saveFromInput()
	end,
	Tooltip = func6("保存当前视角或位置"),
})

obj141:AddDropdown("TPFreecamPoints", {
	Text = "存档点",
	Values = {},
	Tooltip = func6("选择已保存的位置"),
	Callback = function(selected)
		list1.tpFreecam.selected = selected
	end,
})

obj141:AddButton({
	Text = "传送到存档点",
	Func = function()
		list1.tpFreecam.tpToSelected()
	end,
})

obj141:AddButton({
	Text = "删除存档点",
	Func = function()
		list1.tpFreecam.deleteSelected()
	end,
})

obj141:AddButton({
	Text = "清空存档点",
	Func = function()
		list1.tpFreecam.clearPoints()
	end,
})

obj141:AddLabel("WASD/摇杆移动，空格/跳跃键上升，Ctrl下降。")

list1.FlyOriginal = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/wzhxll/stjnr/refs/heads/main/README.md"))()
end

list1.FlyNew = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/wzhxll/Sha-Bi/refs/heads/main/README.md"))()
end

list1.warpFly = {
	enabled = false,
	flySpeed = 35,
	hrp = nil,
	head = nil,
	hum = nil,
	serverPos = nil,
	isNoclipping = false,
	microStepConn = nil,
	healthLockConn = nil,
	diedConn = nil,
	originalCanCollide = {},
	descendantConnection = nil,
	_tmp = {},
}

list1.warpFly.detectWall = function()
	local hrp = list1.warpFly.hrp
	if not hrp then
		return false
	end
	local position = hrp.Position
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = { obj4.LocalPlayer.Character }

	for i = 1, 12 do
		local n = i / 12 * 2 * 3.1415926535897931
		local value208 = math.cos(n)
		local value209 = math.sin(n)

		for i2 = -1, 1 do
			local hit = workspace:Raycast(position, vector(value208, i2 * 0.5, value209).Unit * 3.5, raycastParams)

			if hit then
				local instance = hit.Instance
				if instance and instance.CanCollide and instance.Transparency < 0.9 then
					return true
				end
			end
		end
	end

	return false
end

list1.warpFly.enterNoClip = function()
	if list1.warpFly.isNoclipping then
		return
	end

	if not list1.warpFly.head or not list1.warpFly.hrp or not list1.warpFly.hum then
		return
	end
	list1.warpFly.head.Anchored = true
	list1.warpFly.hum.PlatformStand = true
	list1.warpFly.isNoclipping = true
end

list1.warpFly.exitNoClip = function()
	if not list1.warpFly.isNoclipping then
		return
	end

	if not list1.warpFly.head or not list1.warpFly.hrp or not list1.warpFly.hum then
		list1.warpFly.isNoclipping = false
		return
	end
	list1.warpFly.head.Anchored = false
	list1.warpFly.hum.PlatformStand = false
	list1.warpFly.isNoclipping = false
end

list1.warpFly.clear = function()
	pcall(function()
		for k, value210 in list1.warpFly.originalCanCollide do
			if k and k.Parent then
				k.CanCollide = value210
			end
		end

		table.clear(list1.warpFly.originalCanCollide)

		if list1.warpFly.descendantConnection then
			list1.warpFly.descendantConnection:Disconnect()
			list1.warpFly.descendantConnection = nil
		end

		if list1.warpFly.microStepConn then
			task.cancel(list1.warpFly.microStepConn)
			list1.warpFly.microStepConn = nil
		end

		if list1.warpFly.healthLockConn then
			task.cancel(list1.warpFly.healthLockConn)
			list1.warpFly.healthLockConn = nil
		end

		if list1.warpFly.diedConn then
			list1.warpFly.diedConn:Disconnect()
			list1.warpFly.diedConn = nil
		end

		if list1.warpFly.isNoclipping then
			list1.warpFly.exitNoClip()
		end

		if list1.warpFly.hrp and list1.warpFly.hum then
			list1.warpFly.hum:ChangeState(Enum.HumanoidStateType.Running)
		end
	end)
end

list1.warpFly.microStepLoop = function()
	if not list1.warpFly.hrp then
		return
	end
	list1.warpFly._tmp.targetPos = list1.warpFly.hrp.Position
	list1.warpFly._tmp.lastTime = clock()

	while list1.warpFly.enabled do
		if not list1.warpFly.hrp or not list1.warpFly.hrp.Parent or not list1.warpFly.hum or not list1.warpFly.hum.Parent then
			list1.warpFly.stop()
			break
		else
			list1.warpFly._tmp.now = clock()
			list1.warpFly._tmp.dt = list1.warpFly._tmp.now - list1.warpFly._tmp.lastTime
			list1.warpFly._tmp.lastTime = list1.warpFly._tmp.now
			local flag98 = list1.warpFly.detectWall()

			if flag98 and not list1.warpFly.isNoclipping then
				list1.warpFly.enterNoClip()
			elseif not flag98 and list1.warpFly.isNoclipping then
				list1.warpFly.exitNoClip()
			end

			if not list1.ControlModule then
				task.wait(0.1)
			else
				list1.warpFly._tmp.mv = list1.ControlModule:GetMoveVector()
				list1.warpFly._tmp.cf = workspace.CurrentCamera.CFrame
				list1.warpFly._tmp.moveDir = list1.warpFly._tmp.cf.LookVector * -list1.warpFly._tmp.mv.Z + list1.warpFly._tmp.cf.RightVector * list1.warpFly._tmp.mv.X
				list1.warpFly._tmp.vertical = 0

				if obj6:IsKeyDown(Enum.KeyCode.Space) then
					list1.warpFly._tmp.vertical = 1
				elseif obj6:IsKeyDown(Enum.KeyCode.LeftControl) then
					list1.warpFly._tmp.vertical = -1
				end

				local flySpeed = list1.warpFly.flySpeed
				list1.warpFly._tmp.totalDelta = (list1.warpFly._tmp.moveDir + vector(0, list1.warpFly._tmp.vertical, 0)) * flySpeed * list1.warpFly._tmp.dt
				list1.warpFly._tmp.targetPos = list1.warpFly._tmp.targetPos + list1.warpFly._tmp.totalDelta
				list1.warpFly._tmp.currentPos = list1.warpFly.hrp.Position
				list1.warpFly._tmp.remaining = list1.warpFly._tmp.targetPos - list1.warpFly._tmp.currentPos
				list1.warpFly._tmp.distance = list1.warpFly._tmp.remaining.Magnitude

				if list1.warpFly._tmp.distance > 0 then
					list1.warpFly._tmp.steps = ceil(list1.warpFly._tmp.distance / 10)
					list1.warpFly._tmp.stepVec = list1.warpFly._tmp.remaining / list1.warpFly._tmp.steps

					for i = 1, list1.warpFly._tmp.steps do
						if list1.warpFly.enabled then
							list1.warpFly._tmp.currentPos = list1.warpFly._tmp.currentPos + list1.warpFly._tmp.stepVec
							local rotation = list1.warpFly.hrp.CFrame.Rotation
							list1.warpFly.hrp.CFrame = cframe(list1.warpFly._tmp.currentPos) * rotation
							continue
						end

						break
					end
				else
					local rotation = list1.warpFly.hrp.CFrame.Rotation
					list1.warpFly.hrp.CFrame = cframe(list1.warpFly._tmp.targetPos) * rotation
				end

				list1.warpFly.hrp.AssemblyLinearVelocity = Vector3.zero
				list1.warpFly.enabled = true
				list1.warpFly.hum:ChangeState(Enum.HumanoidStateType.Climbing)
				task.wait()
			end
		end
	end
end

list1.warpFly.healthLockLoop = function()
	while list1.warpFly.enabled do
		if list1.warpFly.hum and list1.warpFly.hum.Health <= 0 then
			list1.warpFly.hum.Health = list1.warpFly.hum.MaxHealth
		end

		task.wait(0.1)
	end
end

list1.warpFly.onDied = function()
	if list1.warpFly.hum and list1.warpFly.enabled then
		list1.warpFly.hum.Health = list1.warpFly.hum.MaxHealth
		list1.warpFly.hum:ChangeState(Enum.HumanoidStateType.Running)

		pcall(function()
			list1.warpFly.hum.Parent = obj4.LocalPlayer.Character
		end)
	end
end

list1.warpFly.start = function()
	if list1.warpFly.enabled then
		return
	end

	if list1.tpFreecam and list1.tpFreecam.active then
		list1.tpFreecam.stop()
	end

	list1.warpFly._tmp.char = obj4.LocalPlayer.Character
	if not list1.warpFly._tmp.char then
		return
	end
	list1.warpFly.hrp = list1.warpFly._tmp.char:FindFirstChild("HumanoidRootPart")
	list1.warpFly.head = list1.warpFly._tmp.char:FindFirstChild("Head")
	list1.warpFly.hum = list1.warpFly._tmp.char:FindFirstChild("Humanoid")
	if not list1.warpFly.hrp or not list1.warpFly.head or not list1.warpFly.hum then
		return
	end

	for _, getDescendant22 in list1.warpFly._tmp.char:GetDescendants() do
		if getDescendant22:IsA("BasePart") and list1.warpFly.originalCanCollide[getDescendant22] == nil then
			list1.warpFly.originalCanCollide[getDescendant22] = getDescendant22.CanCollide
			getDescendant22.CanCollide = false
		end
	end

	list1.warpFly.descendantConnection = list1.warpFly._tmp.char.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("BasePart") and list1.warpFly.originalCanCollide[descendant] == nil then
			list1.warpFly.originalCanCollide[descendant] = descendant.CanCollide
			descendant.CanCollide = false
		end
	end)

	list1.warpFly.enabled = true
	list1.warpFly.isNoclipping = false
	list1.warpFly.hum:ChangeState(Enum.HumanoidStateType.Climbing)
	list1.warpFly.microStepConn = task.spawn(list1.warpFly.microStepLoop)
	list1.warpFly.healthLockConn = task.spawn(list1.warpFly.healthLockLoop)
	list1.warpFly.diedConn = list1.warpFly.hum.Died:Connect(list1.warpFly.onDied)
end

list1.warpFly.stop = function()
	list1.warpFly.enabled = false
	list1.warpFly.clear()

	if toggles.WarpFlyToggle and toggles.WarpFlyToggle.Value then
		toggles.WarpFlyToggle:SetValue(false)
	end
end

list1.warpFly.teleportAndFly = function(num37)
	list1.warpFly.start()
	list1.warpFly._tmp.char = obj4.LocalPlayer.Character

	if list1.warpFly._tmp.char then
		local humanoidRootPart = list1.warpFly._tmp.char:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart then
			humanoidRootPart.CFrame = cframe(num37 + Vector3.new(0, 5, 0))
		end
	end

	task.delay(0.5, function()
		list1.warpFly.stop()
	end)
end

list1.tpFreecam = {
	active = false,
	speed = 50,
	selected = nil,
	saved = {},
	nameList = {},
	conns = {},
	listenersInstalled = false,
	circle = nil,
	soul = nil,
	hoverPos = Vector3.zero,
	oldCamType = nil,
	oldCamSubject = nil,
	origCollide = {},
	jumpUpUntil = 0,
	moveDir = Vector3.zero,
}

local n = 0.1
list1.tpFreecam.saved = {}

pcall(function()
	if getgenv then
		getgenv().TPFreecamSaves = nil
		local cleanup = list1.tpFreecam.cleanup
		getgenv().TPFreecamCleanup = cleanup
	end
end)

list1.tpFreecam.getChar = function()
	local character = localPlayer.Character
	if not character then
		return nil
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not humanoidRootPart then
		return nil
	end
	return character, humanoid, humanoidRootPart
end

list1.tpFreecam.setNoclip = function(obj142)
	for _, getDescendant23 in obj142:GetDescendants() do
		if getDescendant23:IsA("BasePart") then
			if list1.tpFreecam.origCollide[getDescendant23] == nil then
				list1.tpFreecam.origCollide[getDescendant23] = getDescendant23.CanCollide
			end

			getDescendant23.CanCollide = false
		end
	end
end

list1.tpFreecam.restoreCollision = function()
	for k, value211 in list1.tpFreecam.origCollide do
		if k and k.Parent then
			pcall(function()
				k.CanCollide = value211
			end)
		end
	end

	table.clear(list1.tpFreecam.origCollide)
end

list1.tpFreecam.setCircleVisible = function(flag99)
	if list1.tpFreecam.circle then
		pcall(function()
			list1.tpFreecam.circle.Visible = (flag99 and list1.tpFreecam.active) == true
		end)
	end
end

list1.tpFreecam.restoreWorld = function()
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	character = character and character:FindFirstChild("HumanoidRootPart")
	local currentCamera = workspace.CurrentCamera

	if currentCamera then
		currentCamera.CameraType = list1.tpFreecam.oldCamType or Enum.CameraType.Custom

		if humanoid then
			currentCamera.CameraSubject = humanoid
		elseif list1.tpFreecam.oldCamSubject then
			currentCamera.CameraSubject = list1.tpFreecam.oldCamSubject
		end
	end
	--[[ 𝚂𝙻 :: discord.gg/x7YbZeezpm ]]

	if character then
		character.Anchored = false
	end

	list1.tpFreecam.restoreCollision()

	if list1.tpFreecam.soul then
		pcall(function()
			list1.tpFreecam.soul:Destroy()
		end)

		list1.tpFreecam.soul = nil
	end

	pcall(function()
		if obj6.MouseBehavior ~= Enum.MouseBehavior.Default then
			obj6.MouseBehavior = Enum.MouseBehavior.Default
		end
	end)
end

list1.tpFreecam.start = function()
	if list1.tpFreecam.active then
		return
	end
	local flag100, value212, value213 = list1.tpFreecam.getChar()
	if not flag100 then
		return
	end
	local currentCamera = workspace.CurrentCamera
	if not currentCamera then
		return
	end

	if toggles.WarpFlyToggle and toggles.WarpFlyToggle.Value then
		toggles.WarpFlyToggle:SetValue(false)
	end

	list1.tpFreecam.oldCamType = currentCamera.CameraType
	list1.tpFreecam.oldCamSubject = currentCamera.CameraSubject
	list1.tpFreecam.active = true
	value213.Anchored = true
	value213.AssemblyLinearVelocity = Vector3.zero
	value213.AssemblyAngularVelocity = Vector3.zero
	local part = Instance.new("Part")
	part.Name = "TPFreecamSoul"
	part.Size = Vector3.one
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Position = currentCamera.CFrame.Position
	part.Parent = workspace
	list1.tpFreecam.soul = part
	list1.tpFreecam.hoverPos = part.Position
	currentCamera.CameraType = Enum.CameraType.Custom
	currentCamera.CameraSubject = part
	list1.tpFreecam.installListeners()
	list1.tpFreecam.setCircleVisible(true)
end

list1.tpFreecam.stop = function()
	if not list1.tpFreecam.active then
		return
	end
	list1.tpFreecam.active = false
	list1.tpFreecam.moveDir = Vector3.zero
	list1.tpFreecam.restoreWorld()
	list1.tpFreecam.setCircleVisible(false)
	local tpFreecamToggle = toggles.TPFreecamToggle

	if tpFreecamToggle and tpFreecamToggle.Value then
		tpFreecamToggle:SetValue(false)
	end
end

list1.tpFreecam.tpTo = function(cFrame)
	if not cFrame then
		return
	end
	local flag101, value214, value215 = list1.tpFreecam.getChar()
	if not flag101 then
		return
	end
	value215.Anchored = true
	list1.tpFreecam.setNoclip(flag101)
	task.wait()
	value215.CFrame = cFrame
	local currentCamera = workspace.CurrentCamera

	if list1.tpFreecam.active and currentCamera then
		currentCamera.CFrame = cFrame
	end

	task.wait()

	if not list1.tpFreecam.active then
		value215.Anchored = false
		list1.tpFreecam.restoreCollision()
	end
end

list1.tpFreecam.tpToCamera = function()
	local currentCamera = workspace.CurrentCamera

	if currentCamera then
		list1.tpFreecam.tpTo(currentCamera.CFrame)
	end
end

list1.tpFreecam.pointNames = function()
	local tbl43 = {}

	for k, value216 in list1.tpFreecam.saved do
		if value216 and value216.CFrame then
			local position = value216.CFrame.Position
			local n2 = #tbl43 + 1
			local x = position.X
			local y = position.Y
			local z = position.Z
			tbl43[n2] = format("%d. %s (%.0f,%.0f,%.0f)", k, tostring(value216.Name), x, y, z)
		end
	end

	return tbl43
end

list1.tpFreecam.refreshDropdown = function()
	local tpFreecamPoints = options.TPFreecamPoints
	if not tpFreecamPoints then
		return
	end
	local list14 = list1.tpFreecam.pointNames()
	list1.tpFreecam.nameList = list14
	tpFreecamPoints:SetValues(list14)

	if #list14 > 0 then
		local selected = list1.tpFreecam.selected
		local flag102 = false

		for _, value217 in list14 do
			if value217 == selected then
				flag102 = true
				break
			end
		end

		if not flag102 then
			list1.tpFreecam.selected = list14[1]
		end

		tpFreecamPoints:SetValue(list1.tpFreecam.selected)
	else
		list1.tpFreecam.selected = nil
	end
end

list1.tpFreecam.saveCurrent = function(flag103)
	local currentCamera = workspace.CurrentCamera
	local cFrame

	if list1.tpFreecam.active and currentCamera then
		cFrame = currentCamera.CFrame
	else
		local value218, value219, value220 = list1.tpFreecam.getChar()
		cFrame = nil

		if value220 then
			cFrame = value220.CFrame
		end

		if not cFrame and currentCamera then
			cFrame = currentCamera.CFrame
		end
	end

	if not cFrame then
		return
	end
	local str9 = tostring(flag103 or ""):gsub("^%s+", ""):gsub("%s+$", "")

	if str9 == "" then
		str9 = "Pos" .. tostring(#list1.tpFreecam.saved + 1)
	end

	table.insert(list1.tpFreecam.saved, { Name = str9, CFrame = cFrame })
	list1.tpFreecam.refreshDropdown()
	list1.notify(func5("保存位置"), 2)
end

list1.tpFreecam.saveFromInput = function()
	local tpFreecamName = options.TPFreecamName
	list1.tpFreecam.saveCurrent(tpFreecamName and tpFreecamName.Value or "")

	if tpFreecamName and tpFreecamName.SetValue then
		pcall(function()
			tpFreecamName:SetValue("")
		end)
	end
end

list1.tpFreecam.tpToSelected = function()
	local selected = list1.tpFreecam.selected
	if not selected then
		return
	end

	for k, value221 in list1.tpFreecam.nameList do
		if value221 == selected then
			local flag104 = list1.tpFreecam.saved[k]

			if flag104 and flag104.CFrame then
				list1.tpFreecam.tpTo(flag104.CFrame)
			end

			return
		end
	end
end

list1.tpFreecam.deleteSelected = function()
	local selected = list1.tpFreecam.selected
	if not selected then
		return
	end

	for k, value222 in list1.tpFreecam.nameList do
		if value222 == selected then
			table.remove(list1.tpFreecam.saved, k)
			list1.tpFreecam.refreshDropdown()
			return
		end
	end
end

list1.tpFreecam.clearPoints = function()
	table.clear(list1.tpFreecam.saved)
	list1.tpFreecam.refreshDropdown()
end

list1.tpFreecam.getControls = function()
	local controlModule = list1.ControlModule
	if controlModule and controlModule.GetMoveVector then
		return controlModule
	end

	pcall(function()
		local playerScripts = localPlayer:FindFirstChildOfClass("PlayerScripts")
		local playerModule = playerScripts and playerScripts:FindFirstChild("PlayerModule")

		if playerModule then
			controlModule = require(playerModule):GetControls()

			if controlModule and controlModule.GetMoveVector then
				list1.ControlModule = controlModule
			end
		end
	end)

	return list1.ControlModule
end

list1.tpFreecam.updateMoveDir = function()
	local currentCamera = workspace.CurrentCamera
	if not currentCamera then
		list1.tpFreecam.moveDir = Vector3.zero
		return
	end
	local lookVector = currentCamera.CFrame.LookVector
	local rightVector = currentCamera.CFrame.RightVector
	local vector3 = Vector3.zero

	if obj6:IsKeyDown(Enum.KeyCode.W) then
		vector3 = Vector3.zero + lookVector
	end

	if obj6:IsKeyDown(Enum.KeyCode.S) then
		vector3 -= lookVector
	end

	if obj6:IsKeyDown(Enum.KeyCode.A) then
		vector3 -= rightVector
	end

	if obj6:IsKeyDown(Enum.KeyCode.D) then
		vector3 += rightVector
	end

	if obj6:IsKeyDown(Enum.KeyCode.Space) or obj6:IsKeyDown(Enum.KeyCode.E) then
		vector3 += Vector3.new(0, 1, 0)
	end

	if obj6:IsKeyDown(Enum.KeyCode.LeftControl) or obj6:IsKeyDown(Enum.KeyCode.Q) then
		vector3 -= Vector3.new(0, 1, 0)
	end

	if vector3.Magnitude < 0.1 and obj6.TouchEnabled then
		local obj143 = list1.tpFreecam.getControls()

		if obj143 then
			local ok, result = pcall(function()
				return obj143:GetMoveVector()
			end)

			if ok and typeof(result) == "Vector3" and result.Magnitude > 0.1 then
				vector3 += rightVector * result.X + lookVector * -result.Z
			end
		end
	end

	if clock2() < (list1.tpFreecam.jumpUpUntil or 0) then
		vector3 += Vector3.new(0, 1, 0)
	end

	if vector3.Magnitude > 0.1 then
		list1.tpFreecam.moveDir = vector3.Unit * list1.tpFreecam.speed
	else
		list1.tpFreecam.moveDir = Vector3.zero
	end
end

list1.tpFreecam.onHeartbeat = function(flag105)
	local n2 = type(flag105) == "number" and flag105 <= 0.1 and flag105 or 0.016
	local currentCamera = workspace.CurrentCamera

	if list1.tpFreecam.circle and currentCamera then
		pcall(function()
			list1.tpFreecam.circle.Position = currentCamera.ViewportSize / 2
		end)
	end

	if not list1.tpFreecam.active then
		return
	end
	list1.tpFreecam.updateMoveDir()
	local soul = list1.tpFreecam.soul

	if soul and soul.Parent then
		pcall(function()
			if list1.tpFreecam.moveDir.Magnitude > n then
				soul.CFrame = soul.CFrame + list1.tpFreecam.moveDir * n2
				list1.tpFreecam.hoverPos = soul.Position
			else
				local rotation = soul.CFrame.Rotation
				soul.CFrame = cframe(list1.tpFreecam.hoverPos) * rotation
			end
		end)
	end
end

list1.tpFreecam.installListeners = function()
	if list1.tpFreecam.listenersInstalled then
		return
	end
	list1.tpFreecam.listenersInstalled = true

	pcall(function()
		if Drawing and not list1.tpFreecam.circle then
			local circle = Drawing.new("Circle")
			circle.Visible = false
			circle.Radius = 25
			circle.Thickness = 2
			circle.Filled = false
			circle.Transparency = 1
			circle.Color = color(0, 255, 0)
			list1.tpFreecam.circle = circle
		end
	end)

	table.insert(list1.tpFreecam.conns, obj5.Heartbeat:Connect(function(deltaTime)
		list1.tpFreecam.onHeartbeat(deltaTime)
	end))

	table.insert(list1.tpFreecam.conns, obj6.JumpRequest:Connect(function()
		if not list1.tpFreecam.active then
			return
		end
		list1.tpFreecam.jumpUpUntil = clock2() + 0.3
	end))
end

list1.tpFreecam.cleanup = function()
	list1.tpFreecam.active = false
	list1.tpFreecam.restoreWorld()

	for _, conn2 in list1.tpFreecam.conns do
		pcall(function()
			conn2:Disconnect()
		end)
	end

	table.clear(list1.tpFreecam.conns)
	list1.tpFreecam.listenersInstalled = false

	if list1.tpFreecam.circle then
		pcall(function()
			list1.tpFreecam.circle:Remove()
		end)

		list1.tpFreecam.circle = nil
	end

	pcall(function()
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		local tpFreecamGui = playerGui and playerGui:FindFirstChild("TPFreecamGui")

		if tpFreecamGui then
			tpFreecamGui:Destroy()
		end
	end)

	pcall(function()
		local env = getgenv

		if env then
			local cleanup = list1.tpFreecam.cleanup
			env = getgenv().TPFreecamCleanup == cleanup
		end

		if env then
			getgenv().TPFreecamCleanup = nil
		end
	end)
end

list1.onCharacterAdded(function()
	if list1.tpFreecam.active then
		list1.tpFreecam.stop()
	end
end)

pcall(function()
	local playerGui = localPlayer:WaitForChild("PlayerGui")
	playerGui = playerGui and playerGui:FindFirstChild("TPFreecamGui")

	if playerGui then
		playerGui:Destroy()
	end
end)

pcall(function()
	if obj6.MouseBehavior ~= Enum.MouseBehavior.Default then
		obj6.MouseBehavior = Enum.MouseBehavior.Default
	end
end)

pcall(function()
	local env2 = getgenv and type(getgenv().TPFreecamCleanup) == "function"

	if env2 then
		local cleanup = list1.tpFreecam.cleanup
		env2 = getgenv().TPFreecamCleanup ~= cleanup
	end

	if env2 then
		getgenv().TPFreecamCleanup()
	end
end)

list1.tpFreecam.refreshDropdown()

list1.FlyAnimation = function()
	loadstring([[local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera
local ControlModule = require(lp.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

local flight = {
    isFlying = false,
    flySpeed = 40,
    bv = nil,
    animCache = nil,
    hrp = nil,
    hum = nil,
    hoverTrack = nil,
    animator = nil,
}

function flight:loadAndFreezeHover()
    if not self.hum then return end
    self.animator = self.hum:FindFirstChildOfClass("Animator")
    if not self.animator then
        self.animator = Instance.new("Animator")
        self.animator.Parent = self.hum
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://97171309"
    self.hoverTrack = self.animator:LoadAnimation(anim)
    self.hoverTrack.Priority = Enum.AnimationPriority.Action4
    self.hoverTrack:Play()
    self.hoverTrack:AdjustSpeed(0)
end

function flight:clearResources()
    local char = lp.Character
    if self.animCache and char then
        self.animCache.Parent = char
    end
    if self.bv then
        self.bv:Destroy()
        self.bv = nil
    end
    if self.lvAttachment then
        self.lvAttachment:Destroy()
        self.lvAttachment = nil
    end
    if self.hoverTrack then
        self.hoverTrack:Stop()
        self.hoverTrack = nil
    end
    if self.hum and self.hum.Parent then
        self.hum:ChangeState(Enum.HumanoidStateType.Running)
    end
    self.animator = nil
end

function flight:startFly()
    if self.isFlying then return end
    local char = lp.Character
    if not char then return end
    self.hrp = char:WaitForChild("HumanoidRootPart")
    self.hum = char:WaitForChild("Humanoid")
    local ani = char:FindFirstChild("Animate")
    if ani then
        self.animCache = ani
        ani.Parent = nil
    end
    if self.hrp:FindFirstChild("LeipzigBV") then
        self.hrp.LeipzigBV:Destroy()
    end
    local attachment = self.hrp:FindFirstChild("LeipzigAVAttachment")
    if not attachment then
        attachment = Instance.new("Attachment")
        attachment.Name = "LeipzigAVAttachment"
        attachment.Parent = self.hrp
    end
    local lv = Instance.new("LinearVelocity")
    lv.Name = "LeipzigBV"
    lv.Attachment0 = attachment
    lv.MaxForce = 1e6
    lv.RelativeTo = Enum.ActuatorRelativeTo.World
    lv.VectorVelocity = Vector3.zero
    lv.Parent = self.hrp
    self.bv = lv
    self.lvAttachment = attachment
    self:loadAndFreezeHover()
    self.isFlying = true
    task.spawn(function()
        while self.isFlying and char.Parent do
            local mv = ControlModule:GetMoveVector()
            local cf = camera.CFrame
            local dir = (cf.LookVector * -mv.Z) + (cf.RightVector * mv.X)
            if mv.Magnitude > 0 then
                self.bv.VectorVelocity = dir.Unit * self.flySpeed
            else
                self.bv.VectorVelocity = Vector3.zero
            end
            self.hum:ChangeState(Enum.HumanoidStateType.Climbing)
            RunService.RenderStepped:Wait()
        end
        self:clearResources()
    end)
end

function flight:stopFly()
    if not self.isFlying then return end
    self.isFlying = false
    self:clearResources()
end

function flight:setSpeed(speed)
    self.flySpeed = mathClamp(speed, 10, 100)
end

local function bindCharacter()
    local char = lp.Character or lp.CharacterAdded:Wait()
    flight.hrp = char:WaitForChild("HumanoidRootPart")
    flight.hum = char:WaitForChild("Humanoid")
    flight:clearResources()
    char.AncestryChanged:Connect(function(_, parent)
        if not parent then
            flight:clearResources()
            bindCharacter()
        end
    end)
end
bindCharacter()

local pgui = lp:WaitForChild("PlayerGui")
if pgui:FindFirstChild("OriginalFlightUI") then pgui.OriginalFlightUI:Destroy() end

local UI_BG = c3rgb(200, 230, 255)
local BTN_OFF = c3rgb(150, 200, 255)
local BTN_ON = c3rgb(70, 150, 255)
local DESTROY_BTN = c3rgb(110, 180, 255)
local TEXT_COLOR = c3rgb(0, 60, 120)
local SPEED_BG = c3rgb(180, 220, 255)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OriginalFlightUI"
ScreenGui.Parent = pgui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 150, 0, 145)
MainFrame.Position = UDim2.new(0.5, -75, 0.3, 0)
MainFrame.BackgroundColor3 = UI_BG
MainFrame.BackgroundTransparency = 0.4
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = MainFrame
    local stroke = Instance.new("UIStroke")
    stroke.Parent = MainFrame
    stroke.Color = c3rgb(120, 200, 255)
    stroke.Thickness = 3
    stroke.Transparency = 0.1

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1,0,0,20)
Title.BackgroundTransparency = 1
Title.Text = "飞行-动画"
Title.TextColor3 = TEXT_COLOR
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold

    local Tip = Instance.new("TextLabel")
    Tip.Parent = MainFrame
    Tip.Size = UDim2.new(1,0,0,14)
Tip.Position = UDim2.new(0,0,0,20)
Tip.BackgroundTransparency = 1
Tip.Text = "无相机锁定"
Tip.TextColor3 = Color3.new(0.9,0,0)
Tip.TextSize = 8

    local SpeedInput = Instance.new("TextBox")
    SpeedInput.Parent = MainFrame
    SpeedInput.Size = UDim2.new(0,120,0,24)
SpeedInput.Position = UDim2.new(0.5,-60,0, 38)
SpeedInput.BackgroundColor3 = SPEED_BG
SpeedInput.BackgroundTransparency = 0.3
SpeedInput.Text = tostring(flight.flySpeed)
SpeedInput.TextColor3 = TEXT_COLOR
SpeedInput.TextSize = 11
    do
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 7)
        inputCorner.Parent = SpeedInput
    end

    local FlyBtn = Instance.new("TextButton")
    FlyBtn.Parent = MainFrame
    FlyBtn.Size = UDim2.new(0,120,0,26)
FlyBtn.Position = UDim2.new(0.5,-60,0, 72)
FlyBtn.BackgroundColor3 = BTN_OFF
FlyBtn.BackgroundTransparency = 0.3
FlyBtn.Text = "飞行"
FlyBtn.TextColor3 = TEXT_COLOR
FlyBtn.TextSize = 11
    do
        local flyCorner = Instance.new("UICorner")
        flyCorner.CornerRadius = UDim.new(0, 8)
        flyCorner.Parent = FlyBtn
    end

    local DestroyUI = Instance.new("TextButton")
    DestroyUI.Parent = MainFrame
    DestroyUI.Size = UDim2.new(0,120,0,26)
DestroyUI.Position = UDim2.new(0.5,-60,0, 108)
DestroyUI.BackgroundColor3 = DESTROY_BTN
DestroyUI.BackgroundTransparency = 0.3
DestroyUI.Text = "销毁UI"
DestroyUI.TextColor3 = TEXT_COLOR
DestroyUI.TextSize = 11
    do
        local destroyCorner = Instance.new("UICorner")
        destroyCorner.CornerRadius = UDim.new(0, 8)
        destroyCorner.Parent = DestroyUI
    end

local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val then
        flight:setSpeed(val)
    else
        flight:setSpeed(40)
    end
    SpeedInput.Text = tostring(flight.flySpeed)
end)

FlyBtn.MouseButton1Click:Connect(function()
    if flight.isFlying then
        flight:stopFly()
        FlyBtn.Text = "飞行"
        FlyBtn.BackgroundColor3 = BTN_OFF
    else
        flight:startFly()
        FlyBtn.Text = "飞行开"
        FlyBtn.BackgroundColor3 = BTN_ON
    end
end)

DestroyUI.MouseButton1Click:Connect(function()
    flight:stopFly()
    ScreenGui:Destroy()
end)

MainFrame.Size = UDim2.new(0,0,0,0)
MainFrame:TweenSize(UDim2.new(0,150,0,145), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)
]])()
end

do
	local obj144 = tbl2.Auto:AddRightTabbox()
	local obj145 = obj144:AddTab("僵尸透视")

	obj145:AddToggle("ESPAxe", {
		Text = "透视斧头僵尸",
		Default = false,
		Callback = function(axe)
			list1.zombieEspEnabled.Axe = axe

			if axe then
				list1.startZombieESPHeartbeat()
			else
				list1.stopZombieESPHeartbeat()
			end
		end,
	})

	obj145:AddToggle("ESPEye", {
		Text = "透视红眼",
		Default = false,
		Callback = function(eye)
			list1.zombieEspEnabled.Eye = eye

			if eye then
				list1.startZombieESPHeartbeat()
			else
				list1.stopZombieESPHeartbeat()
			end
		end,
	})

	obj145:AddToggle("ESPSword", {
		Text = "透视胸甲骑兵",
		Default = false,
		Callback = function(sword)
			list1.zombieEspEnabled.Sword = sword

			if sword then
				list1.startZombieESPHeartbeat()
			else
				list1.stopZombieESPHeartbeat()
			end
		end,
	})

	obj145:AddToggle("ESPBarrel", {
		Text = "透视自爆",
		Default = false,
		Callback = function(barrel)
			list1.zombieEspEnabled.Barrel = barrel

			if barrel then
				list1.startZombieESPHeartbeat()
			else
				list1.stopZombieESPHeartbeat()
			end
		end,
	})

	obj145:AddToggle("ESPFTorso", {
		Text = "透视提灯人",
		Default = false,
		Callback = function(fTorso)
			list1.zombieEspEnabled.FTorso = fTorso

			if fTorso then
				list1.startZombieESPHeartbeat()
			else
				list1.stopZombieESPHeartbeat()
			end
		end,
	})

	obj145:AddToggle("ESPNormal", {
		Text = "透视山伯乐",
		Default = false,
		Callback = function(normal)
			list1.zombieEspEnabled.Normal = normal

			if normal then
				list1.startZombieESPHeartbeat()
			else
				list1.stopZombieESPHeartbeat()
			end
		end,
	})

	obj145:AddToggle("ESPHeadless", {
		Text = "透视无头士兵",
		Default = false,
		Callback = function(headless)
			list1.zombieEspEnabled.Headless = headless

			if headless then
				list1.startZombieESPHeartbeat()
			else
				list1.stopZombieESPHeartbeat()
			end
		end,
	})

	obj145:AddToggle("HeadlessHighlightToggle", {
		Text = "透视无头骑士",
		Default = false,
		Callback = function(value)
			list1.toggleHeadlessHighlight(value)
		end,
	})

	obj145:AddToggle("DraculaHighlightToggle", {
		Text = "透视德古拉",
		Default = false,
		Callback = function(value)
			list1.toggleDraculaHighlight(value)
		end,
	})

	obj145:AddToggle("BoomDrawToggle", {
		Text = "自爆倒计时显示",
		Default = false,
		Tooltip = func6("显示自爆僵尸爆炸剩余时间"),
		Callback = function(value)
			if value then
				list1.boomDraw.start()
			else
				list1.boomDraw.stop()
			end
		end,
	})

	local obj146 = obj144:AddTab("玩家透视")

	obj146:AddToggle("PlayerESPEnable", {
		Text = "启用玩家透视",
		Default = false,
		Tooltip = func6("开启后对玩家高亮"),
		Callback = function(espPlayerEnabled)
			list1.espPlayerEnabled = espPlayerEnabled

			if espPlayerEnabled then
				list1.refreshAllPlayers()
				list1.startPlayerESPRefresh()
			else
				list1.stopPlayerESPRefresh()

				for _, getPlayer16 in obj4:GetPlayers() do
					list1.destroyPlayerComponents(getPlayer16)
				end
			end
		end,
	})

	obj146:AddToggle("PlayerESPName", {
		Text = "显示玩家名称",
		Default = false,
		Tooltip = func6("开启显示玩家用户名"),
		Callback = function(espShowNames)
			list1.espShowNames = espShowNames
			list1.refreshAllPlayers()
		end,
	})

	obj146:AddToggle("PlayerESPHealth", {
		Text = "显示玩家血量",
		Default = false,
		Tooltip = func6("开启显示玩家血量数值"),
		Callback = function(espShowHealth)
			list1.espShowHealth = espShowHealth
			list1.refreshAllPlayers()
		end,
	})

	obj146:AddToggle("PlayerESPTeam", {
		Text = "队伍检测",
		Default = false,
		Tooltip = func6("开启后只高亮透视敌方队伍玩家"),
		Callback = function(espTeamCheckPlayer)
			list1.espTeamCheckPlayer = espTeamCheckPlayer
			list1.refreshAllPlayers()
		end,
	})

	obj146:AddToggle("PlayerESPInfection", {
		Text = "显示玩家感染值",
		Default = false,
		Tooltip = func6("开启后显示其他玩家感染值"),
		Callback = function(infectionEnabled)
			list1.infectionEnabled = infectionEnabled

			if infectionEnabled then
				list1.startInfectionUpdating()
			else
				list1.stopInfectionUpdating()
			end
		end,
	})

	obj146:AddToggle("PlayerESPJob", {
		Text = "显示玩家职业",
		Default = false,
		Callback = function(value)
			if value then
				list1.startJobUpdating()
			else
				list1.stopJobUpdating()
			end
		end,
	})
end

local obj147
obj147 = tbl2.Auto:AddGroupbox({ Side = "Left", Name = "其他功能", IconName = "settings", Description = "显示提示" })
local min5 = tbl2.Minor:AddGroupbox({ Side = "Left", Name = "防护功能", IconName = "shield", Description = "防坠自救" })

min5:AddToggle("AutoEscapeToggle", {
	Text = "红眼扑倒自救",
	Default = false,
	Callback = function(value)
		if value then
			list1.AutoEscape.enable()
		else
			list1.AutoEscape.disable()
		end
	end,
})

min5:AddToggle("FallProtectionToggle", {
	Text = "防骨折",
	Default = false,
	Callback = function(value)
		if value then
			list1.startFallProtection()
		else
			list1.stopFallProtection()
		end
	end,
})

min5:AddToggle("AntiVelocityToggle", {
	Text = "骨折可移动",
	Default = false,
	Callback = function(value)
		if value then
			list1.antiVelocityEnable()
		else
			list1.antiVelocityDisable()
		end
	end,
})

min5:AddToggle("AntiGrabToggle", {
	Text = "防抓取",
	Default = false,
	Callback = function(value)
		if value then
			list1.AntiGrab.start()
		else
			list1.AntiGrab.stop()
		end
	end,
})

min5:AddToggle("DamageDisplayToggle", {
	Text = "显示受伤伤害",
	Default = false,
	Callback = function(value)
		if value then
			list1.damageDisplay.start()
		else
			list1.damageDisplay.stop()
		end
	end,
})

min5:AddToggle("RescueTeammateToggle", {
	Text = "传送救援队友",
	Default = false,
	Callback = function(value)
		if value then
			list1.rescueTeammate.start()
		else
			list1.rescueTeammate.stop()
		end
	end,
})

min5:AddToggle("ElbowZombiesToggle", {
	Text = "肘击自救",
	Default = false,
	Callback = function(value)
		if value then
			list1.elbowZombies.start()
		else
			list1.elbowZombies.stop()
		end
	end,
})

min5:AddToggle("PushBarrelProtectToggle", {
	Text = "自爆拉扯（防护）",
	Default = false,
	Callback = function(value)
		if value then
			list1.pushBarrelProtect.start()
		else
			list1.pushBarrelProtect.stop()
		end
	end,
})

min5:AddSlider("PushBarrelProtectSize", {
	Text = "拉扯范围",
	Default = 10,
	Min = 1,
	Max = 15,
	Suffix = " 格",
	Callback = function(size)
		list1.pushBarrelProtect.size = size
	end,
})

min5:AddToggle("AutoHelpToggleMisc", {
	Text = "自动求救",
	Default = false,
	Callback = function(value)
		if value then
			list1.autoHelp.start()
		else
			list1.autoHelp.stop()
		end
	end,
})

local obj148 = tbl2.Misc:AddGroupbox({ Side = "Right", Name = "获取", IconName = "package", Description = "获取装备" })

obj148:AddButton({
	Text = "获取吸血鬼刀 (Voivode)",
	Func = function()
		local obj149 = list1.getPurchaseEvent()

		if obj149 then
			obj149:FireServer("Voivode")
			list1.notify(func5("已获取吸血鬼刀"), 2)
		end
	end,
})

obj148:AddButton({
	Text = "获取铁桩 (Iron Stake)",
	Func = function()
		local obj150 = list1.getPurchaseEvent()

		if obj150 then
			obj150:FireServer("Iron Stake")
			list1.notify(func5("已获取铁桩"), 2)
		end
	end,
})

list1.removeAllHats = function()
	for _, getPlayer17 in obj4:GetPlayers() do
		if getPlayer17.Character then
			for _, value223 in getPlayer17.Character:GetChildren() do
				if value223:IsA("Accessory") then
					value223:Destroy()
				end
			end
		end
	end
end

list1.removeAllShirts = function()
	for _, getPlayer18 in obj4:GetPlayers() do
		if getPlayer18.Character then
			for _, value224 in getPlayer18.Character:GetChildren() do
				if value224:IsA("Shirt") or value224:IsA("ShirtGraphic") then
					value224:Destroy()
				end
			end
		end
	end
end

list1.removeAllPants = function()
	for _, getPlayer19 in obj4:GetPlayers() do
		if getPlayer19.Character then
			for _, value225 in getPlayer19.Character:GetChildren() do
				if value225:IsA("Pants") then
					value225:Destroy()
				end
			end
		end
	end
end

list1.removeCarriages = function()
	for _, value226 in { "Carriage", "RearCarriage", "WagonPlatform", "FL_Wheel", "Horse", "Behind" }, nil, nil do
		for _, getDescendant24 in workspace:GetDescendants() do
			if getDescendant24.Name == value226 then
				pcall(function()
					getDescendant24:Destroy()
				end)
			end
		end
	end
end

obj147:AddToggle("BulletDisplay", {
	Text = "显示子弹数量",
	Default = false,
	Callback = function(value)
		if value then
			list1.bulletDisplay.start()
		else
			list1.bulletDisplay.stop()
		end
	end,
})

obj147:AddToggle("TracerToggle", {
	Text = "显示子弹轨迹",
	Default = false,
	Callback = function(value)
		list1.Tracer.toggle(value)
	end,
})

obj147:AddToggle("CannonSupplies", {
	Text = "火炮物资透视",
	Default = false,
	Callback = function(value)
		list1.cannonSupplies.toggle(value)
	end,
})

obj147:AddToggle("KillSound", {
	Text = "击杀音效",
	Default = false,
	Callback = function(value)
		if value then
			list1.killSound.start()
		else
			list1.killSound.stop()
		end
	end,
})

obj147:AddSlider("KillSoundVol", {
	Text = "音效音量",
	Default = 7,
	Min = 1,
	Max = 10,
	Callback = function(volume)
		list1.killSound.volume = volume
	end,
})

obj147:AddDivider()

obj147:AddToggle("PingDisplay", {
	Text = "显示网络延迟",
	Default = false,
	Callback = function(value)
		if value then
			list1.pingDisplay.start()
		else
			list1.pingDisplay.stop()
		end
	end,
})

list1.noFogEnabled = false
list1.noFogOriginal = {}
list1.noFogOriginalsSaved = false
list1.noFogAtmosphereBackup = {}
list1.noFogConns = {}
list1.noFogDebounce = false

list1.saveNoFogOriginal = function()
	if list1.noFogOriginalsSaved then
		return
	end

	pcall(function()
		list1.noFogOriginal = { FogEnd = obj9.FogEnd, FogStart = obj9.FogStart }
		list1.noFogOriginalsSaved = true
	end)
end

list1.saveNoFogOriginal()

list1.applyNoFog = function()
	pcall(function()
		obj9.FogEnd = 100000
		obj9.FogStart = 0
		list1.noFogAtmosphereBackup = {}

		for _, getDescendant25 in obj9:GetDescendants() do
			if getDescendant25:IsA("Atmosphere") then
				table.insert(list1.noFogAtmosphereBackup, { Instance = getDescendant25, Parent = getDescendant25.Parent })
				getDescendant25.Parent = nil
			end
		end
	end)
end

list1.restoreNoFog = function()
	pcall(function()
		obj9.FogEnd = list1.noFogOriginal.FogEnd or 100000
		obj9.FogStart = list1.noFogOriginal.FogStart or 0

		for _, value227 in list1.noFogAtmosphereBackup do
			if value227.Instance and value227.Parent then
				value227.Instance.Parent = value227.Parent
			end
		end

		list1.noFogAtmosphereBackup = {}
	end)
end

local function func82()
	if not list1.noFogEnabled or list1.noFogDebounce then
		return
	end
	list1.noFogDebounce = true

	task.delay(0.1, function()
		list1.noFogDebounce = false

		if list1.noFogEnabled then
			pcall(list1.applyNoFog)
		end
	end)
end

list1.startNoFogMonitor = function()
	for _, noFogConn in list1.noFogConns do
		pcall(function()
			noFogConn:Disconnect()
		end)
	end

	table.clear(list1.noFogConns)

	for _, value228 in { "FogEnd", "FogStart" }, nil, nil do
		pcall(function()
			table.insert(list1.noFogConns, obj9:GetPropertyChangedSignal(value228):Connect(func82))
		end)
	end

	pcall(function()
		table.insert(list1.noFogConns, obj9.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("Atmosphere") then
				func82()
			end
		end))
	end)
end

list1.stopNoFogMonitor = function()
	for _, noFogConn2 in list1.noFogConns do
		pcall(function()
			noFogConn2:Disconnect()
		end)
	end

	table.clear(list1.noFogConns)
	list1.noFogDebounce = false
end

obj147:AddToggle("InfectionRemover", {
	Text = "移除感染红色血液",
	Default = false,
	Callback = function(value)
		if value then
			list1.infectionRemover.start()
		else
			list1.infectionRemover.stop()
		end
	end,
})

obj147:AddToggle("BombRange", {
	Text = "自爆范围显示",
	Default = false,
	Callback = function(value)
		if value then
			list1.bombRange.start()
		else
			list1.bombRange.stop()
		end
	end,
})

obj147:AddToggle("HandMortar", {
	Text = "手炮爆炸倒计时",
	Default = false,
	Callback = function(value)
		list1.handMortar.setEnabled(value)
	end,
})

obj147:AddToggle("NoBarrelHit", {
	Text = "无法攻击自爆",
	Default = false,
	Callback = function(value)
		list1.noBarrelHit.toggle(value)
	end,
})

obj147:AddToggle("JumpLock", {
	Text = "移除跳跃限制",
	Default = false,
	Callback = function(value)
		list1.jumpLock.toggle(value)
	end,
})

list1.rollTiltEnabled = false
list1.rollTiltSpeed = 3
list1.rollTiltConn = nil
list1.rollTiltHrp = nil
list1.rollTiltRx = 0
list1.rollTiltRz = 0
list1.rollTiltLastUpdate = 0

list1.rollTiltStop = function()
	if list1.rollTiltConn then
		list1.rollTiltConn:Disconnect()
		list1.rollTiltConn = nil
	end

	list1.rollTiltEnabled = false
end

list1.rollTiltStart = function()
	if list1.rollTiltEnabled then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	list1.rollTiltHrp = character:FindFirstChild("HumanoidRootPart")
	if not list1.rollTiltHrp then
		return
	end
	list1.rollTiltEnabled = true
	list1.rollTiltLastUpdate = 0
	list1.rollTiltRx = 0
	list1.rollTiltRz = 0

	list1.rollTiltConn = obj5.RenderStepped:Connect(function()
		if not list1.rollTiltEnabled or not list1.rollTiltHrp or not list1.rollTiltHrp.Parent then
			list1.rollTiltStop()
			return
		end
		local rollTiltLastUpdate = list1.rollTiltLastUpdate

		if clock() - rollTiltLastUpdate > 0.05 then
			list1.rollTiltLastUpdate = clock()
			local rollTiltSpeed = list1.rollTiltSpeed
			list1.rollTiltRx = (math.random() - 0.5) * rollTiltSpeed * 0.15
			local rollTiltSpeed2 = list1.rollTiltSpeed
			list1.rollTiltRz = (math.random() - 0.5) * rollTiltSpeed2 * 0.15
		end

		list1.rollTiltHrp.CFrame = list1.rollTiltHrp.CFrame * CFrame.Angles(list1.rollTiltRx, 0, list1.rollTiltRz)
	end)
end

list1.spin = { enabled = false, speed = 5, connection = nil, animLockThread = nil }

list1.spin.applySpinAnimationLock = function(instance27)
	if not instance27 then
		return
	end
	local humanoid = instance27:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.AutoRotate = false
	end

	if list1.spin.animLockThread then
		task.cancel(list1.spin.animLockThread)
		list1.spin.animLockThread = nil
	end

	list1.spin.animLockThread = task.spawn(function()
		local animate = instance27:FindFirstChild("Animate")
		local n2 = 0

		while not animate and n2 < 3 do
			task.wait(0.1)
			n2 += 0.1
			animate = instance27:FindFirstChild("Animate")
		end

		while list1.spin.enabled and animate and animate.Parent do
			animate.Disabled = true
			task.wait(0.2)
		end
	end)
end

list1.spin.removeSpinAnimationLock = function(instance28)
	if not instance28 then
		return
	end
	local humanoid = instance28:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.AutoRotate = true
	end

	if list1.spin.animLockThread then
		task.cancel(list1.spin.animLockThread)
		list1.spin.animLockThread = nil
	end

	local animate = instance28:FindFirstChild("Animate")

	if animate then
		animate.Disabled = false
	end
end

list1.spin.start = function()
	if list1.spin.connection then
		return
	end

	list1.spin.connection = obj5.RenderStepped:Connect(function(deltaTime)
		if not list1.spin.enabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, rad(list1.spin.speed * 350) * deltaTime, 0)
	end)

	list1.spin.applySpinAnimationLock(localPlayer.Character)
end

list1.spin.stop = function()
	list1.spin.enabled = false

	if list1.spin.connection then
		list1.spin.connection:Disconnect()
		list1.spin.connection = nil
	end

	list1.spin.removeSpinAnimationLock(localPlayer.Character)
end

list1.thirdPerson = { enabled = false, connection = nil }

list1.thirdPerson.apply = function()
	pcall(function()
		local value229 = localPlayer

		if value229.CameraMode ~= Enum.CameraMode.Classic then
			value229.CameraMode = Enum.CameraMode.Classic
		end

		value229.CameraMinZoomDistance = 0.5
		value229.CameraMaxZoomDistance = 200
	end)
end

list1.thirdPerson.start = function()
	if list1.thirdPerson.connection then
		return
	end
	list1.thirdPerson.enabled = true
	list1.thirdPerson.apply()

	list1.thirdPerson.connection = obj5.RenderStepped:Connect(function()
		if not list1.thirdPerson.enabled then
			return
		end
		list1.thirdPerson.apply()
	end)
end

list1.thirdPerson.stop = function()
	list1.thirdPerson.enabled = false

	if list1.thirdPerson.connection then
		list1.thirdPerson.connection:Disconnect()
		list1.thirdPerson.connection = nil
	end
end

list1.animFreeze = {
	enabled = false,
	currentAnimTrack = nil,
	originalAnimateDisabled = false,
	loopThread = nil,
	charAddedConn = nil,
}

list1.animFreeze.cleanup = function()
	if list1.animFreeze.loopThread then
		task.cancel(list1.animFreeze.loopThread)
		list1.animFreeze.loopThread = nil
	end

	if list1.animFreeze.currentAnimTrack then
		list1.animFreeze.currentAnimTrack:Stop()
		list1.animFreeze.currentAnimTrack = nil
	end

	local character = localPlayer.Character

	if character and list1.animFreeze.originalAnimateDisabled then
		local animate = character:FindFirstChild("Animate")

		if animate then
			animate.Disabled = false
			list1.animFreeze.originalAnimateDisabled = false
		end
	end
end

list1.animFreeze.playOnce = function()
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	if not list1.animFreeze.originalAnimateDisabled then
		local animate = character:FindFirstChild("Animate")

		if animate and not animate.Disabled then
			animate.Disabled = true
			list1.animFreeze.originalAnimateDisabled = true
		end
	end

	local animationId = humanoid.RigType == Enum.HumanoidRigType.R6 and "rbxassetid://27432686" or "rbxassetid://507776043"
	local animation = Instance.new("Animation")
	animation.AnimationId = animationId
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local obj151 = animator:LoadAnimation(animation)
	obj151:Play()
	obj151:AdjustSpeed(0)

	if list1.animFreeze.currentAnimTrack then
		list1.animFreeze.currentAnimTrack:Stop()
	end

	list1.animFreeze.currentAnimTrack = obj151
end

list1.animFreeze.loop = function()
	while list1.animFreeze.enabled do
		pcall(function()
			list1.animFreeze.playOnce()
		end)

		task.wait(0.1)
	end
end

list1.animFreeze.start = function()
	if list1.animFreeze.enabled then
		return
	end
	list1.animFreeze.enabled = true
	list1.animFreeze.cleanup()
	list1.animFreeze.loopThread = task.spawn(list1.animFreeze.loop)
end

list1.animFreeze.stop = function()
	list1.animFreeze.enabled = false
	list1.animFreeze.cleanup()
end

list1.invert = { enabled = false, conn = nil, charConn = nil }

list1.invert.apply = function()
	if not list1.invert.enabled then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")

	if humanoidRootPart then
		humanoidRootPart.CFrame = cframe(humanoidRootPart.Position) * CFrame.Angles(3.1415926535897931, 0, 0)
	end
end

list1.invert.lockLoop = function()
	if list1.invert.conn then
		return
	end

	list1.invert.conn = obj5.RenderStepped:Connect(function()
		if list1.invert.enabled then
			list1.invert.apply()
		end
	end)
end

list1.invert.unlockLoop = function()
	if list1.invert.conn then
		list1.invert.conn:Disconnect()
		list1.invert.conn = nil
	end
end

list1.invert.setEnabled = function(enabled)
	list1.invert.enabled = enabled

	if enabled then
		list1.invert.apply()
		list1.invert.lockLoop()
	else
		list1.invert.unlockLoop()
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")

			if humanoidRootPart then
				local position = humanoidRootPart.Position
				local cFrame = humanoidRootPart.CFrame
				local num38 = math.atan2(-cFrame.LookVector.X, -cFrame.LookVector.Z)
				humanoidRootPart.CFrame = cframe(position) * CFrame.Angles(0, num38, 0)
			end
		end
	end
end

list1.bigHead = {
	enabled = false,
	headSize = 3,
	headTrans = 0.5,
	originalProps = {},
	watchedZombies = {},
	connection = nil,
	descendantDisposer = nil,
}

list1.bigHead.applyToZombie = function(instance29)
	local head = instance29:FindFirstChild("Head")
	if not head then
		return
	end

	if not list1.bigHead.originalProps[instance29] then
		list1.bigHead.originalProps[instance29] = { Size = head.Size, Transparency = head.Transparency }
	end

	head.Size = vector(list1.bigHead.headSize, list1.bigHead.headSize, list1.bigHead.headSize)
	head.Transparency = list1.bigHead.headTrans
end

list1.bigHead.restoreZombie = function(instance30)
	local value230 = list1.bigHead.originalProps[instance30]

	if value230 then
		local head = instance30:FindFirstChild("Head")

		if head then
			head.Size = value230.Size
			head.Transparency = value230.Transparency
		end

		list1.bigHead.originalProps[instance30] = nil
	end
end

list1.bigHead.clearAll = function()
	for k in list1.bigHead.originalProps do
		list1.bigHead.restoreZombie(k)
	end

	list1.bigHead.originalProps = {}
end

list1.bigHead.updateAllZombies = function()
	if not list1.bigHead.enabled then
		return
	end

	for k in list1.bigHead.watchedZombies do
		if k.Parent then
			list1.bigHead.applyToZombie(k)
		else
			list1.bigHead.watchedZombies[k] = nil
		end
	end
end

list1.bigHead.setupListener = function()
	if list1.bigHead.descendantDisposer then
		list1.bigHead.descendantDisposer()
		list1.bigHead.descendantDisposer = nil
	end

	table.clear(list1.bigHead.watchedZombies)
	list1.ZombieWatch.start()

	local function func83(obj152)
		local camera = workspace:FindFirstChild("Camera")
		if not camera or not obj152:IsDescendantOf(camera) then
			return
		end

		if not list1.bigHead.watchedZombies[obj152] then
			list1.bigHead.watchedZombies[obj152] = true

			if list1.bigHead.enabled then
				list1.bigHead.applyToZombie(obj152)
			end
		end
	end

	list1.ZombieWatch.forEach(func83)
	list1.bigHead.descendantDisposer = list1.ZombieWatch.onAdded(func83)
end

list1.bigHead.startLoop = function()
	if list1.bigHead.connection then
		return
	end
	local n2 = 0
	local n3 = 0

	list1.bigHead.connection = obj5.RenderStepped:Connect(function(deltaTime)
		if list1.bigHead.enabled then
			n2 += deltaTime

			if n2 >= 0.1 then
				n2 = 0
				list1.bigHead.updateAllZombies()
			end

			local result22 = clock2()

			if result22 - n3 > 5 then
				n3 = result22
				-- deobfuscated by 𝚂𝙻 -> https://discord.gg/x7YbZeezpm

				for k in list1.bigHead.originalProps do
					if not k.Parent then
						list1.bigHead.originalProps[k] = nil
					end
				end
			end
		end
	end)
end

list1.bigHead.stopLoop = function()
	if list1.bigHead.connection then
		list1.bigHead.connection:Disconnect()
		list1.bigHead.connection = nil
	end
end

list1.bigHead.enable = function()
	if list1.bigHead.enabled then
		return
	end
	list1.bigHead.enabled = true
	list1.bigHead.setupListener()
	list1.bigHead.updateAllZombies()
	list1.bigHead.startLoop()
end

list1.bigHead.disable = function()
	list1.bigHead.enabled = false
	list1.bigHead.clearAll()
	table.clear(list1.bigHead.watchedZombies)

	if list1.bigHead.descendantDisposer then
		list1.bigHead.descendantDisposer()
		list1.bigHead.descendantDisposer = nil
	end

	list1.bigHead.stopLoop()
end

list1.animLoop1205Enabled = false
list1.animLoop1205Track = nil
list1.animLoop1205Connection = nil

list1.startAnimLoop1205 = function()
	if list1.animLoop1205Connection then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://120593550434546"
	list1.animLoop1205Track = animator:LoadAnimation(animation)
	list1.animLoop1205Track.Priority = Enum.AnimationPriority.Action4

	list1.animLoop1205Connection = obj5.Heartbeat:Connect(function()
		if not list1.animLoop1205Enabled then
			return
		end
		local character2 = localPlayer.Character
		if not character2 or not character2:FindFirstChildOfClass("Humanoid") then
			list1.stopAnimLoop1205()
			return
		end

		pcall(function()
			if list1.animLoop1205Track then
				if list1.animLoop1205Track.IsPlaying then
					list1.animLoop1205Track:Stop()
				end

				list1.animLoop1205Track:Play()
			end
		end)
	end)
end

list1.stopAnimLoop1205 = function()
	list1.animLoop1205Enabled = false

	if list1.animLoop1205Connection then
		list1.animLoop1205Connection:Disconnect()
		list1.animLoop1205Connection = nil
	end

	if list1.animLoop1205Track then
		pcall(function()
			list1.animLoop1205Track:Stop()
		end)

		list1.animLoop1205Track = nil
	end
end

task.spawn(function()
	list1.ControlModule = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
end)

list1.AutoEscape = {
	enabled = false,
	active = false,
	checkThread = nil,
	heartbeatConn = nil,
	originalIndex = nil,
	camBindName = nil,
	offset = Vector3.zero,
	savedCF = nil,
	savedVel = nil,
}

list1.AutoEscape.updateOffset = function()
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end
	local head = character:FindFirstChild("Head")
	local y = humanoidRootPart.Position.Y

	if head then
		y = head.Position.Y
	end

	list1.AutoEscape.offset = vector(0, y - humanoidRootPart.Position.Y + 5680, 0)
end

list1.AutoEscape.start = function()
	if list1.AutoEscape.active then
		return
	end
	list1.AutoEscape.active = true
	local flag106 = localPlayer
	local obj153 = obj5
	local autoEscape = list1.AutoEscape

	autoEscape.heartbeatConn = obj153.Heartbeat:Connect(function()
		if not autoEscape.active then
			return
		end

		if not flag106.Character then
			return
		end
		local humanoidRootPart = flag106.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		list1.AutoEscape.updateOffset()
		autoEscape.savedCF = humanoidRootPart.CFrame
		autoEscape.savedVel = humanoidRootPart.AssemblyLinearVelocity
		humanoidRootPart.CFrame = humanoidRootPart.CFrame + autoEscape.offset
		humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		obj153.RenderStepped:Wait()

		if flag106.Character and flag106.Character:FindFirstChild("HumanoidRootPart") then
			flag106.Character.HumanoidRootPart.CFrame = autoEscape.savedCF
			flag106.Character.HumanoidRootPart.AssemblyLinearVelocity = autoEscape.savedVel
		end
	end)

	autoEscape.originalIndex = hookmetamethod(game, "__index", newcclosure(function(flag107, flag108)
		if autoEscape.active then
			if not checkcaller() then
				if flag108 == "CFrame" and flag106.Character and flag106.Character:FindFirstChild("HumanoidRootPart") and flag106.Character:FindFirstChild("Humanoid") and flag106.Character:FindFirstChild("Humanoid").Health > 0 then
					if flag107 == flag106.Character.HumanoidRootPart then
						return (autoEscape.savedCF or cframe()) + autoEscape.offset
					end

					if flag107 == flag106.Character.Head then
						return (autoEscape.savedCF or cframe()) + autoEscape.offset
					end
				end
			end
		end

		return autoEscape.originalIndex(flag107, flag108)
	end))

	autoEscape.camBindName = "AutoEscapeCamFix_" .. tostring(math.random(100000, 999999))

	obj153:BindToRenderStep(autoEscape.camBindName, Enum.RenderPriority.Camera.Value + 1, function()
		if autoEscape.active and flag106.Character then
			local currentCamera = workspace.CurrentCamera

			if currentCamera then
				currentCamera.CFrame = currentCamera.CFrame - autoEscape.offset
			end
		end
	end)
end

list1.AutoEscape.stop = function()
	if not list1.AutoEscape.active then
		return
	end
	list1.AutoEscape.active = false

	if list1.AutoEscape.heartbeatConn then
		pcall(function()
			list1.AutoEscape.heartbeatConn:Disconnect()
		end)

		list1.AutoEscape.heartbeatConn = nil
	end

	if list1.AutoEscape.originalIndex then
		pcall(function()
			hookmetamethod(game, "__index", list1.AutoEscape.originalIndex)
		end)

		list1.AutoEscape.originalIndex = nil
	end

	if list1.AutoEscape.camBindName then
		pcall(function()
			obj5:UnbindFromRenderStep(list1.AutoEscape.camBindName)
		end)

		list1.AutoEscape.camBindName = nil
	end

	list1.AutoEscape.savedCF = nil
	list1.AutoEscape.savedVel = nil
end

list1.AutoEscape.check = function()
	if not list1.AutoEscape.enabled then
		return
	end

	if not localPlayer.Character then
		if list1.AutoEscape.active then
			list1.AutoEscape.stop()
		end

		return
	end

	local players = workspace:FindFirstChild("Players")
	players = players and players:FindFirstChild(localPlayer.Name)
	local userStates = players and players:FindFirstChild("UserStates")
	local pin = userStates and userStates:FindFirstChild("Pin")
	pin = pin and tostring(pin.Value) ~= "None"

	if pin and not list1.AutoEscape.active then
		list1.AutoEscape.start()
	elseif not pin and list1.AutoEscape.active then
		list1.AutoEscape.stop()
	end
end

list1.AutoEscape.enable = function()
	if list1.AutoEscape.enabled then
		return
	end
	list1.AutoEscape.enabled = true

	list1.AutoEscape.checkThread = task.spawn(function()
		while list1.AutoEscape.enabled do
			pcall(list1.AutoEscape.check)
			task.wait(0.1)
		end
	end)
end

list1.AutoEscape.disable = function()
	list1.AutoEscape.enabled = false

	if list1.AutoEscape.checkThread then
		pcall(function()
			task.cancel(list1.AutoEscape.checkThread)
		end)

		list1.AutoEscape.checkThread = nil
	end

	list1.AutoEscape.stop()
end

list1.fallProtectionInstances = {}
list1.fallProtectionEnabled = false

list1.antiVelocity = list1.antiVelocity or {
	enabled = false,
	wasBroken = false,
	conn = nil,
	savedAnimateDisabled = nil,
	savedNormal = nil,
	lastNormalSave = 0,
	lastFix = 0,
}

local tbl44 = {
	["rbxassetid://12333490324"] = true,
	["12333490324"] = true,
	["rbxassetid://12333489072"] = true,
	["12333489072"] = true,
}

list1.antiVelocity.snapshotTracks = function(obj154)
	local tbl45 = {}

	pcall(function()
		for _, getPlayingAnimationTrack10 in obj154:GetPlayingAnimationTracks() do
			local animation = getPlayingAnimationTrack10.Animation
			animation = animation and animation.AnimationId

			if animation and animation ~= "" then
				table.insert(tbl45, {
					id = animation,
					name = getPlayingAnimationTrack10.Name,
					priority = getPlayingAnimationTrack10.Priority,
					speed = getPlayingAnimationTrack10.Speed,
					looped = getPlayingAnimationTrack10.Looped,
					weight = getPlayingAnimationTrack10.WeightCurrent,
				})
			end
		end
	end)

	return tbl45
end

list1.antiVelocity.isLimpTrack = function(obj, flag109)
	local ok, result = pcall(function()
		local animation = obj.Animation
		animation = animation and animation.AnimationId or ""
		if tbl44[animation] then
			return true
		end
		local match = tostring(animation):match("%d+")
		if match and tbl44[match] then
			return true
		end

		if flag109 and animation == flag109 then
			return true
		end
		local lowered3 = string.lower(obj.Name or "")
		if lowered3:find("limp") or lowered3:find("fracture") or lowered3:find("broken") or lowered3:find("cripple") then
			return true
		end
		return false
	end)

	return ok and result or false
end

list1.antiVelocity.restoreTracks = function(obj155, list15)
	if not list15 or #list15 == 0 then
		return
	end

	pcall(function()
		local humanoid = obj155:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		local animator = humanoid:FindFirstChildOfClass("Animator")

		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = humanoid
		end

		local tbl46 = {}

		pcall(function()
			for _, getPlayingAnimationTrack11 in humanoid:GetPlayingAnimationTracks() do
				local animationId = getPlayingAnimationTrack11.Animation and getPlayingAnimationTrack11.Animation.AnimationId

				if animationId then
					tbl46[animationId] = true
				end
			end
		end)

		for _, value231 in list15 do
			if not tbl46[value231.id] then
				local animation = Instance.new("Animation")
				animation.AnimationId = value231.id
				local obj156 = animator:LoadAnimation(animation)

				pcall(function()
					obj156.Priority = value231.priority
				end)

				pcall(function()
					obj156.Looped = value231.looped
				end)

				pcall(function()
					obj156:Play(0.15, value231.weight or 1, value231.speed or 1)
				end)
			end
		end
	end)
end

list1.antiVelocity.suppressLimp = function(obj157)
	pcall(function()
		local humanoid = obj157:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		for _, getPlayingAnimationTrack12 in humanoid:GetPlayingAnimationTracks() do
			if list1.antiVelocity.isLimpTrack(getPlayingAnimationTrack12) then
				pcall(function()
					getPlayingAnimationTrack12:Stop(0.15)
				end)
			end
		end
	end)
end

list1.antiVelocityEnable = function()
	if list1.antiVelocity.enabled then
		return
	end
	list1.antiVelocity.enabled = true
	list1.antiVelocity.wasBroken = false

	if list1.antiVelocity.conn then
		pcall(function()
			list1.antiVelocity.conn:Disconnect()
		end)

		list1.antiVelocity.conn = nil
	end

	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		pcall(function()
			humanoid.AutoRotate = true
		end)
	end

	list1.antiVelocity.conn = obj5.Heartbeat:Connect(function()
		if not list1.antiVelocity.enabled then
			return
		end
		local character2 = localPlayer.Character
		if not character2 then
			return
		end
		local humanoidRootPart = character2:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

		if humanoid2 and not humanoid2.AutoRotate then
			pcall(function()
				humanoid2.AutoRotate = true
			end)
		end

		local killVelocity = humanoidRootPart:FindFirstChild("KillVelocity") or humanoidRootPart:FindFirstChild("LinearVelocity")

		if killVelocity and (killVelocity:IsA("BodyVelocity") or killVelocity:IsA("LinearVelocity")) then
			killVelocity.Enabled = false
		end

		local userStates = character2:FindFirstChild("UserStates")

		if userStates then
			local brokenLegs = userStates:FindFirstChild("BrokenLegs")

			if brokenLegs then
				local value232 = brokenLegs.Value == true
				local result23 = clock2()
				local flag110 = not value232

				if flag110 then
					if result23 - (list1.antiVelocity.lastNormalSave or 0) > 2 then
						local humanoid3 = character2:FindFirstChildOfClass("Humanoid")

						if humanoid3 then
							local savedNormal = {}

							for _, snapshotTrack in list1.antiVelocity.snapshotTracks(humanoid3), nil, nil do
								if not tbl44[snapshotTrack.id] then
									local lowered4 = string.lower(snapshotTrack.name or "")

									if not (lowered4:find("limp") or lowered4:find("fracture") or lowered4:find("broken") or lowered4:find("cripple")) then
										table.insert(savedNormal, snapshotTrack)
									end
								end
							end

							if #savedNormal > 0 then
								list1.antiVelocity.savedNormal = savedNormal
								list1.antiVelocity.lastNormalSave = result23
							end
						end
					end
				end

				if value232 and not list1.antiVelocity.wasBroken then
					list1.antiVelocity.wasBroken = true
					list1.antiVelocity.lastFix = 0
					local animate = character2:FindFirstChild("Animate")

					if animate and list1.antiVelocity.savedAnimateDisabled == nil then
						list1.antiVelocity.savedAnimateDisabled = animate.Disabled
					end

					task.spawn(function()
						local humanoid3 = character2:FindFirstChildOfClass("Humanoid")
						if not humanoid3 then
							return
						end

						pcall(function()
							humanoid3.AutoRotate = true
						end)

						local animate2 = character2:FindFirstChild("Animate")

						if animate2 and animate2.Disabled then
							pcall(function()
								animate2.Disabled = false
							end)
						end

						pcall(function()
							humanoid3:ChangeState(Enum.HumanoidStateType.Running)
						end)

						task.wait(0.3)
						if not list1.antiVelocity.enabled or not character2.Parent then
							return
						end
						local userStates2 = character2:FindFirstChild("UserStates")
						userStates2 = userStates2 and userStates2:FindFirstChild("BrokenLegs")
						if not (userStates2 and userStates2.Value == true) then
							return
						end
						list1.antiVelocity.suppressLimp(character2)
						list1.antiVelocity.restoreTracks(character2, list1.antiVelocity.savedNormal)
					end)
				end

				if value232 and list1.antiVelocity.wasBroken then
					if result23 - (list1.antiVelocity.lastFix or 0) > 0.3 then
						list1.antiVelocity.lastFix = result23
						list1.antiVelocity.suppressLimp(character2)
						local humanoid3 = character2:FindFirstChildOfClass("Humanoid")

						if humanoid3 and list1.antiVelocity.savedNormal and #list1.antiVelocity.savedNormal > 0 then
							local flag111 = false

							pcall(function()
								for _, getPlayingAnimationTrack13 in humanoid3:GetPlayingAnimationTracks() do
									local animationId = getPlayingAnimationTrack13.Animation and getPlayingAnimationTrack13.Animation.AnimationId

									if animationId and getPlayingAnimationTrack13.IsPlaying then
										for _, value233 in list1.antiVelocity.savedNormal do
											if value233.id == animationId then
												flag111 = true
												break
											end
										end
									end

									if not flag111 then
										continue
									end
									break
								end
							end)

							if not flag111 then
								list1.antiVelocity.restoreTracks(character2, list1.antiVelocity.savedNormal)
							end
						end

						if humanoid3 then
							pcall(function()
								local state = humanoid3:GetState()

								if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Ragdoll then
									humanoid3:ChangeState(Enum.HumanoidStateType.Running)
								end

								if humanoid3.PlatformStand or humanoid3.Sit then
									humanoid3:ChangeState(Enum.HumanoidStateType.Running)
								end
							end)
						end
					end
				end

				if flag110 and list1.antiVelocity.wasBroken then
					list1.antiVelocity.wasBroken = false

					task.spawn(function()
						local humanoid3 = character2:FindFirstChildOfClass("Humanoid")
						local animate = character2:FindFirstChild("Animate")

						if animate and list1.antiVelocity.savedAnimateDisabled ~= nil then
							pcall(function()
								animate.Disabled = list1.antiVelocity.savedAnimateDisabled
							end)

							list1.antiVelocity.savedAnimateDisabled = nil
						end

						if humanoid3 then
							pcall(function()
								humanoid3:ChangeState(Enum.HumanoidStateType.Running)
							end)
						end
					end)
				end
			else
				list1.antiVelocity.wasBroken = false
			end
		else
			list1.antiVelocity.wasBroken = false
		end
	end)
end

list1.antiVelocityDisable = function()
	list1.antiVelocity.enabled = false
	list1.antiVelocity.wasBroken = false

	if list1.antiVelocity.conn then
		pcall(function()
			list1.antiVelocity.conn:Disconnect()
		end)

		list1.antiVelocity.conn = nil
	end

	pcall(function()
		local character = localPlayer.Character

		if character then
			local animate = character:FindFirstChild("Animate")

			if animate and list1.antiVelocity.savedAnimateDisabled ~= nil then
				animate.Disabled = list1.antiVelocity.savedAnimateDisabled
			end

			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end
		end
	end)

	list1.antiVelocity.savedAnimateDisabled = nil
	list1.antiVelocity.savedNormal = nil
end

do
	local n2 = 0.02
	local n3 = -5
	local n4 = 0
	local connection = nil

	local function func84(deltaTime)
		if not list1.fallProtectionEnabled then
			return
		end
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not character or humanoid.Health <= 0 then
			n4 = 0
			return
		end

		if not (character.AssemblyLinearVelocity.Y < n3 and not obj6:IsKeyDown(Enum.KeyCode.Space)) then
			n4 = 0
			return
		end
		n4 += deltaTime

		if n2 <= n4 then
			n4 = 0

			pcall(function()
				humanoid:ChangeState(Enum.HumanoidStateType.Climbing)
			end)
		end
	end

	list1.startFallProtection = function()
		if list1.fallProtectionEnabled then
			return
		end
		list1.fallProtectionEnabled = true

		if not connection then
			connection = obj5.Heartbeat:Connect(func84)
		end
	end

	list1.stopFallProtection = function()
		list1.fallProtectionEnabled = false
		n4 = 0

		if connection then
			connection:Disconnect()
			connection = nil
		end
	end
end

list1.AntiGrab = { enabled = false, connection = nil }

list1.AntiGrab.start = function()
	if list1.AntiGrab.connection then
		return
	end
	list1.AntiGrab.enabled = true

	list1.AntiGrab.connection = obj5.Heartbeat:Connect(function()
		if not list1.AntiGrab.enabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			pcall(function()
				humanoid:Move(Vector3.new(0, 100000, 0))
			end)
		end
	end)
end

list1.AntiGrab.stop = function()
	list1.AntiGrab.enabled = false

	if list1.AntiGrab.connection then
		list1.AntiGrab.connection:Disconnect()
		list1.AntiGrab.connection = nil
	end
end

list1.damageDisplay = {
	enabled = false,
	damageQueue = {},
	isPlaying = false,
	billboard = nil,
	textLabel = nil,
	fadeTween = nil,
	fadeOutTween = nil,
	lastHealth = nil,
	healthConn = nil,
	charConn = nil,
}

list1.damageDisplay.ensureBillboard = function()
	if list1.damageDisplay.billboard and list1.damageDisplay.billboard.Parent then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local head = character:FindFirstChild("Head")
	if not head then
		return
	end
	list1.damageDisplay.billboard = Instance.new("BillboardGui")
	list1.damageDisplay.billboard.Size = UDim2.new(0, 100, 0, 50)
	list1.damageDisplay.billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	list1.damageDisplay.billboard.AlwaysOnTop = true
	list1.damageDisplay.billboard.Adornee = head
	list1.damageDisplay.billboard.Parent = character
	list1.damageDisplay.textLabel = Instance.new("TextLabel")
	list1.damageDisplay.textLabel.Size = UDim2.new(1, 0, 1, 0)
	list1.damageDisplay.textLabel.BackgroundTransparency = 1
	list1.damageDisplay.textLabel.Text = ""
	list1.damageDisplay.textLabel.TextSize = 30
	list1.damageDisplay.textLabel.Font = Enum.Font.GothamBold
	list1.damageDisplay.textLabel.TextStrokeTransparency = 0.2
	list1.damageDisplay.textLabel.TextStrokeColor3 = color(0, 0, 0)
	list1.damageDisplay.textLabel.Parent = list1.damageDisplay.billboard
	list1.damageDisplay.billboard.Enabled = false
end

list1.damageDisplay.destroyBillboard = function()
	if list1.damageDisplay.billboard then
		list1.damageDisplay.billboard:Destroy()
	end

	list1.damageDisplay.billboard = nil
	list1.damageDisplay.textLabel = nil

	if list1.damageDisplay.fadeTween then
		list1.damageDisplay.fadeTween:Cancel()
	end

	list1.damageDisplay.fadeTween = nil
end

list1.damageDisplay.showDamage = function(flag112)
	if not list1.damageDisplay.enabled then
		return
	end
	list1.damageDisplay.ensureBillboard()
	if not list1.damageDisplay.billboard then
		return
	end
	local flag113 = flag112 < 20 and color(0, 255, 0)
	local textColor3

	if flag113 then
		textColor3 = flag113
	else
		textColor3 = flag112 < 50 and color(255, 255, 0) or color(255, 0, 0)
	end

	list1.damageDisplay.textLabel.Text = tostring(floor(flag112))
	list1.damageDisplay.textLabel.TextColor3 = textColor3
	list1.damageDisplay.billboard.Enabled = true

	if list1.damageDisplay.fadeTween then
		list1.damageDisplay.fadeTween:Cancel()
	end

	if list1.damageDisplay.fadeOutTween then
		list1.damageDisplay.fadeOutTween:Cancel()
		list1.damageDisplay.fadeOutTween = nil
	end

	list1.damageDisplay.textLabel.TextTransparency = 1
	list1.damageDisplay.fadeTween = obj8:Create(list1.damageDisplay.textLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), { TextTransparency = 0 })
	list1.damageDisplay.fadeTween:Play()

	task.delay(1, function()
		if list1.damageDisplay.textLabel then
			local tween = obj8:Create(list1.damageDisplay.textLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { TextTransparency = 1 })
			list1.damageDisplay.fadeOutTween = tween
			tween:Play()
			tween.Completed:Wait()

			if list1.damageDisplay.fadeOutTween == tween then
				list1.damageDisplay.fadeOutTween = nil
			end

			if list1.damageDisplay.billboard then
				list1.damageDisplay.billboard.Enabled = false
			end
		end

		list1.damageDisplay.isPlaying = false

		if #list1.damageDisplay.damageQueue > 0 then
			local value234 = table.remove(list1.damageDisplay.damageQueue, 1)
			list1.damageDisplay.isPlaying = true
			list1.damageDisplay.showDamage(value234)
		end

		list1.damageDisplay.fadeTween = nil
	end)
end

list1.damageDisplay.queueDamage = function(param58)
	if not list1.damageDisplay.enabled then
		return
	end
	table.insert(list1.damageDisplay.damageQueue, param58)

	if not list1.damageDisplay.isPlaying then
		list1.damageDisplay.isPlaying = true
		local value235 = table.remove(list1.damageDisplay.damageQueue, 1)
		list1.damageDisplay.showDamage(value235)
	end
end

list1.damageDisplay.onHealthChanged = function()
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local health = humanoid.Health
	if list1.damageDisplay.lastHealth == nil then
		list1.damageDisplay.lastHealth = health
		return
	end
	local n2 = list1.damageDisplay.lastHealth - health

	if n2 > 0 then
		list1.damageDisplay.queueDamage(n2)
	end

	list1.damageDisplay.lastHealth = health
end

list1.damageDisplay.start = function()
	if list1.damageDisplay.healthConn then
		list1.damageDisplay.healthConn:Disconnect()
	end

	if list1.damageDisplay.charConn then
		list1.damageDisplay.charConn()
		list1.damageDisplay.charConn = nil
	end

	local character = localPlayer.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			list1.damageDisplay.lastHealth = humanoid.Health
			list1.damageDisplay.healthConn = humanoid:GetPropertyChangedSignal("Health"):Connect(list1.damageDisplay.onHealthChanged)
		end
	end

	list1.damageDisplay.charConn = list1.onCharacterAdded(function(obj158)
		task.wait(0.2)
		local humanoid = obj158:FindFirstChildOfClass("Humanoid")

		if humanoid then
			if list1.damageDisplay.healthConn then
				list1.damageDisplay.healthConn:Disconnect()
			end

			list1.damageDisplay.lastHealth = humanoid.Health
			list1.damageDisplay.healthConn = humanoid:GetPropertyChangedSignal("Health"):Connect(list1.damageDisplay.onHealthChanged)
		end

		list1.damageDisplay.destroyBillboard()
		list1.damageDisplay.ensureBillboard()
		list1.damageDisplay.damageQueue = {}
		list1.damageDisplay.isPlaying = false
	end)

	list1.damageDisplay.ensureBillboard()
end

list1.damageDisplay.stop = function()
	if list1.damageDisplay.healthConn then
		list1.damageDisplay.healthConn:Disconnect()
	end

	if list1.damageDisplay.charConn then
		list1.damageDisplay.charConn()
		list1.damageDisplay.charConn = nil
	end

	list1.damageDisplay.destroyBillboard()
	list1.damageDisplay.damageQueue = {}
	list1.damageDisplay.isPlaying = false
	list1.damageDisplay.lastHealth = nil

	if list1.damageDisplay.fadeTween then
		list1.damageDisplay.fadeTween:Cancel()
	end
end

list1.rescueTeammate = { enabled = false, thread = nil, inf = {}, busy = false }

list1.rescueTeammate.getHRP = function(instance31)
	return instance31 and instance31:FindFirstChild("HumanoidRootPart")
end

list1.rescueTeammate.getPin = function(obj)
	local ok, result = pcall(function()
		return workspace:FindFirstChild("Players")[obj.Name].UserStates.Pin.Value
	end)

	return ok and tostring(result) ~= "None"
end

list1.rescueTeammate.getInf = function(obj)
	local ok, result = pcall(function()
		return workspace:FindFirstChild("Players")[obj.Name].UserStates.Infected.Value
	end)

	return ok and result or 0
end

list1.rescueTeammate.hasZombie = function(num39, param59)
	for _, getDescendant26 in workspace:GetDescendants() do
		if getDescendant26:IsA("Model") and getDescendant26.Name == "m_Zombie" then
			local humanoidRootPart = getDescendant26:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart and (humanoidRootPart.Position - num39).Magnitude <= param59 then
				return true
			end
		end
	end

	return false
end

list1.rescueTeammate.loop = function()
	while list1.rescueTeammate.enabled do
		task.wait(0.25)

		if not list1.rescueTeammate.busy then
			for _, getPlayer20 in obj4:GetPlayers() do
				if getPlayer20 == localPlayer then
					continue
				elseif list1.rescueTeammate.enabled then
					if list1.rescueTeammate.inf[getPlayer20.Name] == nil then
						list1.rescueTeammate.inf[getPlayer20.Name] = list1.rescueTeammate.getInf(getPlayer20)
					end

					local flag114

					if list1.rescueTeammate.getPin(getPlayer20) then
						flag114 = true
					else
						local flag115 = list1.rescueTeammate.getInf(getPlayer20)
						local flag116 = flag115 > (list1.rescueTeammate.inf[getPlayer20.Name] or flag115) and flag115 > 0
						flag114 = false

						if flag116 then
							local character = getPlayer20.Character
							character = character and list1.rescueTeammate.getHRP(character)
							character = character and list1.rescueTeammate.hasZombie(character.Position, 2)
							flag114 = false

							if character then
								local str10 = "感染" .. floor(flag115) .. "%"
								flag114 = true
							end
						end

						list1.rescueTeammate.inf[getPlayer20.Name] = flag115
					end

					if flag114 then
						list1.rescueTeammate.busy = true
						list1.rescueTeammate.inf[getPlayer20.Name] = list1.rescueTeammate.getInf(getPlayer20)
						local character = localPlayer.Character
						local flag117 = character and list1.rescueTeammate.getHRP(character)

						if not flag117 then
							list1.rescueTeammate.busy = false
						else
							local position = flag117.Position
							local character2 = getPlayer20.Character
							local flag118 = character2 and list1.rescueTeammate.getHRP(character2)

							if not flag118 then
								list1.rescueTeammate.busy = false
							else
								pcall(function()
									flag117.CFrame = cframe(flag118.Position + Vector3.new(0, 0.5, 0))
								end)

								local result24 = clock()

								while true do
									if list1.rescueTeammate.enabled and clock() - result24 < 6 then
										task.wait(0.2)

										if clock() - result24 >= 0.8 then
											if not list1.rescueTeammate.getPin(getPlayer20) then
												local character3 = getPlayer20.Character
												local flag119 = character3 and list1.rescueTeammate.getHRP(character3)
												if not (flag119 and not list1.rescueTeammate.hasZombie(flag119.Position, 2)) then
													continue
												end
											else
												continue
											end
										else
											continue
										end
									end

									break
								end

								task.wait(0.15)
								local character3 = localPlayer.Character
								character3 = character3 and list1.rescueTeammate.getHRP(character3)

								if character3 then
									pcall(function()
										character3.CFrame = cframe(position + Vector3.new(0, 1, 0))
									end)
								end

								list1.rescueTeammate.busy = false
								task.wait(0.5)
							end
						end
					end

					continue
				end

				break
			end
		end
	end
end

list1.rescueTeammate.start = function()
	if list1.rescueTeammate.thread then
		return
	end
	list1.rescueTeammate.enabled = true
	list1.rescueTeammate.inf = {}
	list1.rescueTeammate.busy = false
	list1.rescueTeammate.thread = task.spawn(list1.rescueTeammate.loop)
	lib:Notify(func5("🆘 传送救援已开启"), 2)
end

list1.rescueTeammate.stop = function()
	list1.rescueTeammate.enabled = false

	if list1.rescueTeammate.thread then
		task.cancel(list1.rescueTeammate.thread)
		list1.rescueTeammate.thread = nil
	end

	list1.rescueTeammate.inf = {}
	list1.rescueTeammate.busy = false
	lib:Notify(func5("🆘 传送救援已关闭"), 2)
end

list1.elbowZombies = {
	enabled = false,
	thread = nil,
	connections = {},
	currentWeapon = nil,
	WEAPON_LIST = { "Axe", "Baguette", "Pickaxe" },
	DETECT_RANGE = 6,
	CHECK_INTERVAL = 0.3,
}

list1.elbowZombies.isZombie = function(instance32)
	if not instance32:IsA("Model") then
		return false
	end
	return instance32:FindFirstChild("HumanoidRootPart") ~= nil
end

list1.elbowZombies.getZombiesInRange = function()
	local character = localPlayer.Character
	if not character then
		return {}
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return {}
	end
	local position = humanoidRootPart.Position
	local zombies = workspace:FindFirstChild("Zombies")
	if not zombies then
		return {}
	end
	local tbl47 = {}

	for _, value236 in zombies:GetChildren() do
		if list1.elbowZombies.isZombie(value236) then
			local humanoidRootPart2 = value236:FindFirstChild("HumanoidRootPart") or value236:FindFirstChild("Torso")

			if humanoidRootPart2 and (humanoidRootPart2.Position - position).Magnitude <= list1.elbowZombies.DETECT_RANGE then
				table.insert(tbl47, value236)
			end
		end
	end

	return tbl47
end

list1.elbowZombies.getBestWeapon = function()
	local backpack = localPlayer:FindFirstChild("Backpack")
	if not backpack then
		return nil
	end

	for _, value237 in list1.elbowZombies.WEAPON_LIST do
		local obj159 = backpack:FindFirstChild(value237)
		if obj159 and obj159:IsA("Tool") then
			return obj159
		end
	end

	return nil
end

list1.elbowZombies.equipWeapon = function(obj)
	if not obj then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end

	if obj.Parent ~= character then
		obj.Parent = character
		task.wait(0.02)
	end
end

list1.elbowZombies.unequipWeapon = function(obj)
	if not obj then
		return
	end

	if obj.Parent == localPlayer.Character then
		obj.Parent = localPlayer.Backpack
	end
end

list1.elbowZombies.elbowZombie = function(instance33)
	local humanoidRootPart = instance33:FindFirstChild("HumanoidRootPart") or instance33:FindFirstChild("Torso")
	if not humanoidRootPart then
		return
	end
	local tool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")
	if not tool then
		return
	end
	local remoteEvent = tool:FindFirstChild("RemoteEvent")
	if not remoteEvent then
		return
	end

	pcall(function()
		remoteEvent:FireServer("BraceBlock")
		remoteEvent:FireServer("StopBraceBlock")
		remoteEvent:FireServer("FeedbackStun", instance33, humanoidRootPart.Position)
	end)
end

list1.elbowZombies.elbowAll = function(param60)
	for _, value238 in param60 do
		list1.elbowZombies.elbowZombie(value238)
	end
end

list1.elbowZombies.mainLoop = function()
	while list1.elbowZombies.enabled do
		local list16 = list1.elbowZombies.getZombiesInRange()

		if #list16 > 0 then
			local value239 = list1.elbowZombies.getBestWeapon()

			if value239 then
				list1.elbowZombies.equipWeapon(value239)
				list1.elbowZombies.currentWeapon = value239
			end

			list1.elbowZombies.elbowAll(list16)
		else
			if list1.elbowZombies.currentWeapon and list1.elbowZombies.currentWeapon.Parent == localPlayer.Character then
				list1.elbowZombies.unequipWeapon(list1.elbowZombies.currentWeapon)
			end

			list1.elbowZombies.currentWeapon = nil
		end

		task.wait(list1.elbowZombies.CHECK_INTERVAL)
	end
end

list1.elbowZombies.start = function()
	if list1.elbowZombies.thread then
		return
	end
	list1.elbowZombies.enabled = true
	list1.elbowZombies.thread = task.spawn(list1.elbowZombies.mainLoop)
end

list1.elbowZombies.stop = function()
	list1.elbowZombies.enabled = false

	if list1.elbowZombies.thread then
		task.cancel(list1.elbowZombies.thread)
		list1.elbowZombies.thread = nil
	end

	local character = localPlayer.Character

	if character then
		for _, value240 in list1.elbowZombies.WEAPON_LIST do
			local value241 = character:FindFirstChild(value240)

			if value241 then
				value241.Parent = localPlayer.Backpack
			end
		end
	end

	list1.elbowZombies.currentWeapon = nil
end

list1.pushBarrelProtect = {
	enabled = false,
	size = 10,
	normalForce = 45,
	normalUp = 15,
	slideForce = 85,
	verticalThreshold = 3,
	thread = nil,
}

list1.pushBarrelProtect.getRadii = function()
	local n2 = list1.pushBarrelProtect.size / 10
	return clamp(16 * n2, 5, 25), (clamp(5 * n2, 2, 8))
end

list1.pushBarrelProtect.isBarrel = function(instance34)
	return instance34:GetAttribute("Type") == "Barrel" or instance34:FindFirstChild("Barrel")
end

list1.pushBarrelProtect.getActiveBarrels = function()
	local tbl48 = {}
	local zombies = workspace:FindFirstChild("Zombies")
	if not zombies then
		return tbl48
	end

	for _, value242 in zombies:GetChildren() do
		if value242:IsA("Model") and list1.pushBarrelProtect.isBarrel(value242) then
			local humanoidRootPart = value242:FindFirstChild("HumanoidRootPart") or value242:FindFirstChild("Torso") or value242:FindFirstChild("Head")

			if humanoidRootPart then
				table.insert(tbl48, humanoidRootPart.Position)
			end
		end
	end

	return tbl48
end

list1.pushBarrelProtect.isPointInEllipsoid = function(obj, num40, num41, num42)
	local n2 = obj.X - num40.X
	local n3 = obj.Y - num40.Y
	local n4 = obj.Z - num40.Z
	return (n2 * n2 + n4 * n4) / num41 * num41 + n3 * n3 / num42 * num42 < 1
end

list1.pushBarrelProtect.applyPush = function()
	if not list1.pushBarrelProtect.enabled then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end
	local position = humanoidRootPart.Position
	local value243, value244 = list1.pushBarrelProtect.getRadii()

	for _, getActiveBarrel in list1.pushBarrelProtect.getActiveBarrels(), nil, nil do
		if list1.pushBarrelProtect.isPointInEllipsoid(position, getActiveBarrel, value243, value244) then
			local n2 = position - getActiveBarrel

			if list1.pushBarrelProtect.verticalThreshold < abs(n2.Y) then
				local x3 = vector(n2.X, 0, n2.Z)
				local vector3

				if x3.Magnitude < 0.001 then
					vector3 = Vector3.new(1, 0, 0)
				else
					vector3 = x3.Unit
				end

				local n3 = vector3 * list1.pushBarrelProtect.slideForce
				humanoidRootPart.AssemblyLinearVelocity = vector(n3.X, humanoidRootPart.AssemblyLinearVelocity.Y, n3.Z)
			else
				local unit = n2.Unit

				if unit.Magnitude < 0.001 then
					unit = Vector3.new(1, 0, 0)
				end

				humanoidRootPart.AssemblyLinearVelocity = unit * list1.pushBarrelProtect.normalForce + vector(0, list1.pushBarrelProtect.normalUp, 0)
			end

			break
		end
	end
end

list1.pushBarrelProtect.loop = function()
	while list1.pushBarrelProtect.enabled do
		list1.pushBarrelProtect.applyPush()
		task.wait(0.05)
	end
end

list1.pushBarrelProtect.start = function()
	if list1.pushBarrelProtect.thread then
		return
	end
	list1.pushBarrelProtect.enabled = true
	list1.pushBarrelProtect.thread = task.spawn(list1.pushBarrelProtect.loop)
end

list1.pushBarrelProtect.stop = function()
	list1.pushBarrelProtect.enabled = false

	if list1.pushBarrelProtect.thread then
		task.cancel(list1.pushBarrelProtect.thread)
		list1.pushBarrelProtect.thread = nil
	end
end

list1.autoHelp = { enabled = false, thread = nil }

list1.autoHelp.getHealth = function()
	local character = localPlayer.Character
	character = character and character:FindFirstChildOfClass("Humanoid")
	return character and character.Health or 0
end

list1.autoHelp.getMaxHealth = function()
	local character = localPlayer.Character
	character = character and character:FindFirstChildOfClass("Humanoid")
	return character and character.MaxHealth or 100
end

list1.autoHelp.triggerHelp = function()
	local character = localPlayer.Character
	if not character then
		return false
	end
	local triggerVoice = character:FindFirstChild("TriggerVoice")

	if triggerVoice and triggerVoice:IsA("RemoteEvent") then
		pcall(function()
			triggerVoice:FireServer("CalloutGeneral", "Help")
		end)

		return true
	end

	return false
end

list1.autoHelp.loop = function()
	while list1.autoHelp.enabled do
		task.wait(3)

		if not (list1.autoHelp.getHealth() / list1.autoHelp.getMaxHealth() * 100 >= 80) then
			list1.autoHelp.triggerHelp()
		end
	end
end

list1.autoHelp.start = function()
	if list1.autoHelp.thread then
		return
	end
	list1.autoHelp.enabled = true
	list1.autoHelp.thread = task.spawn(list1.autoHelp.loop)
end

list1.autoHelp.stop = function()
	list1.autoHelp.enabled = false

	if list1.autoHelp.thread then
		task.cancel(list1.autoHelp.thread)
		list1.autoHelp.thread = nil
	end
end

list1.playerESPInstances = {}
list1.playerESPModels = {}
list1.espPlayerEnabled = false
list1.espShowNames = false
list1.espShowHealth = false
list1.espTeamCheckPlayer = false
list1.playerESPRefreshThread = nil
list1.playerESPCharAddedConn = nil

list1.getPlayerTeam = function(obj)
	if obj.Team then
		return obj.Team
	end
	local attribute = obj:GetAttribute("Team")
	if attribute then
		return attribute
	end
	local character = obj.Character

	if character then
		local teamTag = character:FindFirstChild("TeamTag") or character:FindFirstChild("Team")
		if teamTag then
			return teamTag.Value
		end
	end

	return nil
end

list1.isSameTeam = function(param61)
	if not list1.espTeamCheckPlayer then
		return false
	end
	local flag120 = list1.getPlayerTeam(localPlayer)
	local value245 = list1.getPlayerTeam(param61)
	if flag120 and value245 then
		return flag120 == value245
	end
	return false
end

list1.getColorsForPlayer = function(param62)
	if not list1.espTeamCheckPlayer then
		return { highlight = color(255, 255, 255), dot = color(160, 160, 160), name = color(255, 255, 255) }
	end

	if list1.isSameTeam(param62) then
		return { highlight = color(100, 150, 255), dot = color(0, 30, 180), name = color(100, 150, 255) }
	end
	return { highlight = color(255, 100, 100), dot = color(180, 0, 0), name = color(255, 100, 100) }
end

list1.destroyPlayerComponents = function(param63)
	local flag121 = list1.playerESPInstances[param63]

	if flag121 ~= nil then
		list1.destroyESP(flag121)
		list1.playerESPInstances[param63] = nil
	end

	list1.playerESPModels[param63] = nil
end

list1.buildPlayerESPName = function(obj, obj160)
	local list17 = {}

	if list1.espShowNames then
		list17[#list17 + 1] = obj.Name
	end

	if list1.espShowHealth then
		local humanoid = obj160:FindFirstChildOfClass("Humanoid")
		list17[#list17 + 1] = (humanoid and floor(humanoid.Health / humanoid.MaxHealth * 100) or 100) .. "%"
	end

	if list1.infectionEnabled then
		list17[#list17 + 1] = format(flag1 == "English" and "Infection: %d%%" or "感染: %d%%", list1.getInfectionForPlayer(obj))
	end

	if list1.jobEnabled then
		list17[#list17 + 1] = func5(list1.getPlayerClass(obj))
	end

	if #list17 == 0 then
		return ""
	end
	return table.concat(list17, " | ")
end

list1.updatePlayerESP = function(obj)
	local flag122 = list1.playerESPInstances[obj]

	if not list1.espPlayerEnabled then
		if flag122 ~= nil then
			list1.destroyESP(flag122)
			list1.playerESPInstances[obj] = nil
			list1.playerESPModels[obj] = nil
		end

		return
	end

	local character = obj.Character

	if not character or character == localPlayer.Character then
		if flag122 ~= nil then
			list1.destroyESP(flag122)
			list1.playerESPInstances[obj] = nil
			list1.playerESPModels[obj] = nil
		end

		return
	end

	if not character:FindFirstChild("HumanoidRootPart") then
		return
	end

	if flag122 ~= nil and (flag122.Deleted or list1.playerESPModels[obj] ~= character) then
		list1.destroyESP(flag122)
		list1.playerESPInstances[obj] = nil
		list1.playerESPModels[obj] = nil
		flag122 = nil
	end

	local value246 = list1.getColorsForPlayer(obj)
	local value247 = list1.buildPlayerESPName(obj, character)

	if flag122 == nil then
		local flag123 = list1.addESP({
			Name = value247,
			Model = character,
			Color = value246.highlight,
			MaxDistance = 300,
			TextSize = 14,
			ESPType = "Highlight",
			FillColor = value246.highlight,
			OutlineColor = value246.highlight,
			FillTransparency = 0.5,
			OutlineTransparency = 0,
		})

		if flag123 == nil then
			return
		end
		list1.playerESPInstances[obj] = flag123
		list1.playerESPModels[obj] = character
		return
	end

	local currentSettings = flag122.CurrentSettings
	currentSettings.Name = value247
	currentSettings.Color = value246.highlight
	currentSettings.FillColor = value246.highlight
	currentSettings.OutlineColor = value246.highlight
end

list1.refreshAllPlayers = function()
	for _, getPlayer21 in obj4:GetPlayers() do
		list1.updatePlayerESP(getPlayer21)
	end
end

list1.startPlayerESPRefresh = function()
	if list1.playerESPRefreshThread then
		return
	end

	list1.playerESPRefreshThread = task.spawn(function()
		while list1.espPlayerEnabled do
			task.wait(0.2)

			for _, getPlayer22 in obj4:GetPlayers() do
				list1.updatePlayerESP(getPlayer22)
			end
		end

		list1.playerESPRefreshThread = nil
	end)
end

list1.stopPlayerESPRefresh = function()
	if list1.playerESPRefreshThread then
		task.cancel(list1.playerESPRefreshThread)
		list1.playerESPRefreshThread = nil
	end
end

local function func85()
	obj4.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			task.wait(0.2)

			if list1.espPlayerEnabled then
				list1.updatePlayerESP(player)
			end
		end)

		player.CharacterRemoving:Connect(function()
			list1.destroyPlayerComponents(player)
		end)

		if list1.espPlayerEnabled then
			list1.updatePlayerESP(player)
		end
	end)

	obj4.PlayerRemoving:Connect(function(player)
		list1.destroyPlayerComponents(player)
	end)

	list1.onCharacterAdded(function()
		task.wait(0.5)

		if list1.espPlayerEnabled then
			list1.refreshAllPlayers()
		end
	end)
end

func85()
list1.infectionEnabled = false
list1.infectionUpdateConn = nil
list1.jobEnabled = false
list1.jobUpdateConn = nil

list1.createInfectionUI = function()
	return nil
end

list1.removeInfectionUI = function()
end

list1.updateAllInfection = function()
	list1.refreshAllPlayers()
end

list1.startInfectionUpdating = function()
	list1.refreshAllPlayers()
end

list1.getInfectionForPlayer = function(obj)
	if not obj then
		return 0
	end
	local n2 = 0

	pcall(function()
		local players = workspace:FindFirstChild("Players")

		if players then
			local obj161 = players:FindFirstChild(obj.Name)

			if obj161 and obj161:FindFirstChild("UserStates") then
				local infected = obj161.UserStates:FindFirstChild("Infected")
				if infected then
					n2 = tonumber(infected.Value) or 0
					return
				end
			end
		end

		if obj:FindFirstChild("UserStates") then
			local infected = obj.UserStates:FindFirstChild("Infected")

			if infected then
				n2 = tonumber(infected.Value) or 0
			end
		end
	end)

	return n2
end

list1.getPlayerClass = function(obj)
	if not obj then
		return "未知"
	end
	local character = obj.Character
	local attribute = obj:GetAttribute("CurrentClass")
	local attribute2

	if not attribute or attribute == "" then
		if character then
			attribute2 = character:GetAttribute("CurrentClass")
		else
			attribute2 = attribute
		end
	else
		attribute2 = attribute
	end

	local tbl49 = {
		Officer = "军官",
		LineInfantry = "线列",
		Sapper = "工兵",
		Surgeon = "医生",
		Chaplain = "牧师",
		Musician = "乐手",
		Seaman = "水手",
		Lancer = "枪骑兵",
		Artillerist = "炮兵",
	}

	if attribute2 and tbl49[attribute2] then
		return tbl49[attribute2]
	end

	if character then
		if character:FindFirstChild("MedicalSupplies") or character:FindFirstChild("Meter") then
			return "医生"
		end

		if character:FindFirstChild("Blessing") then
			return "牧师"
		end

		if character:FindFirstChild("Hammer") or character:FindFirstChild("Pickaxe") or character:FindFirstChild("Axe") then
			return "工兵"
		end

		if character:FindFirstChild("Sabre") then
			return "军官"
		end

		if character:FindFirstChild("Musket") or character:FindFirstChild("Carbine") then
			return "线列"
		end

		if character:FindFirstChild("Fife") or character:FindFirstChild("Drum") then
			return "乐手"
		end
	end

	return "这个是gay"
end

list1.createJobUI = function()
	return nil
end

list1.removeJobUI = function()
end

list1.updateAllJob = function()
	list1.refreshAllPlayers()
end

list1.startJobUpdating = function()
	list1.jobEnabled = true
	list1.refreshAllPlayers()
end

list1.stopJobUpdating = function()
	list1.jobEnabled = false
	list1.refreshAllPlayers()
end

list1.stopInfectionUpdating = function()
	list1.refreshAllPlayers()
end

list1.boomDraw = list1.boomDraw or {}
list1.boomDraw.enabled = false
list1.boomDraw.markers = {}
list1.boomDraw.zombieConns = {}
list1.boomDraw.connection = nil
list1.boomDraw.zombieAddedDisposer = nil

list1.boomDraw.unwatchZombie = function(param64)
	local value248 = list1.boomDraw.zombieConns[param64]

	if value248 then
		for _, value249 in value248 do
			pcall(function()
				value249:Disconnect()
			end)
		end

		list1.boomDraw.zombieConns[param64] = nil
	end
end

list1.boomDraw.addMarker = function(instance35)
	if list1.boomDraw.markers[instance35] then
		return
	end

	if not instance35:IsA("Model") then
		return
	end

	local flag124 = list1.addESP({
		Name = "3.50",
		Model = instance35,
		Color = color(255, 200, 0),
		MaxDistance = 1000,
		TextSize = 20,
		ESPType = "Text",
	})

	if flag124 == nil then
		return
	end
	list1.boomDraw.markers[instance35] = { esp = flag124, start = clock() }
end

list1.boomDraw.removeMarker = function(param65)
	local value250 = list1.boomDraw.markers[param65]

	if value250 then
		list1.destroyESP(value250.esp)
		list1.boomDraw.markers[param65] = nil
	end

	list1.boomDraw.unwatchZombie(param65)
end

list1.boomDraw.clearAllMarkers = function()
	for k, marker2 in list1.boomDraw.markers do
		list1.destroyESP(marker2.esp)
		list1.boomDraw.markers[k] = nil
	end

	list1.boomDraw.markers = {}

	for k in list1.boomDraw.zombieConns do
		list1.boomDraw.unwatchZombie(k)
	end
end

list1.boomDraw.watchZombie = function(instance36)
	if not instance36:IsA("Model") then
		return
	end

	if list1.boomDraw.zombieConns[instance36] then
		return
	end
	local state = instance36:FindFirstChild("State")

	if not state then
		local n2 = 0

		while not state and n2 < 5 do
			task.wait(0.25)
			n2 += 0.25
			state = instance36:FindFirstChild("State")
		end

		if not state then
			return
		end
	end

	if not list1.boomDraw.enabled or list1.boomDraw.zombieConns[instance36] then
		return
	end
	local list18 = {}

	list18[#list18 + 1] = state.ChildAdded:Connect(function(child)
		if child.Name == "Lit" and child:IsA("BoolValue") and list1.boomDraw.enabled then
			list1.boomDraw.addMarker(instance36)
		end
	end)

	list18[#list18 + 1] = state.ChildRemoved:Connect(function(child)
		if child.Name == "Lit" then
			list1.boomDraw.removeMarker(instance36)
		end
	end)

	list1.boomDraw.zombieConns[instance36] = list18

	if state:FindFirstChild("Lit") and list1.boomDraw.enabled then
		list1.boomDraw.addMarker(instance36)
	end
end

list1.boomDraw.setupWatchers = function()
	list1.ZombieWatch.start()
	local zombies = workspace:FindFirstChild("Zombies")

	local function func86(instance37)
		if zombies and instance37.Parent ~= zombies then
			return
		end
		task.spawn(list1.boomDraw.watchZombie, instance37)
	end

	list1.ZombieWatch.forEach(func86)

	if not list1.boomDraw.zombieAddedDisposer then
		list1.boomDraw.zombieAddedDisposer = list1.ZombieWatch.onAdded(func86)
	end
end

list1.boomDraw.start = function()
	if list1.boomDraw.enabled then
		return
	end
	list1.boomDraw.enabled = true
	list1.boomDraw.clearAllMarkers()
	list1.boomDraw.setupWatchers()

	if list1.boomDraw.connection then
		list1.boomDraw.connection:Disconnect()
	end

	list1.boomDraw.connection = obj5.RenderStepped:Connect(function()
		if not list1.boomDraw.enabled then
			return
		end

		for k, marker3 in list1.boomDraw.markers do
			if not k or not k.Parent then
				list1.boomDraw.removeMarker(k)
			elseif marker3.esp == nil or marker3.esp.Deleted then
				list1.boomDraw.removeMarker(k)
			else
				local start = marker3.start
				local n2 = 3.5 - clock() - start

				if n2 <= 0 then
					list1.boomDraw.removeMarker(k)
				else
					local currentSettings = marker3.esp.CurrentSettings
					currentSettings.Name = format("%.2f", n2)
					currentSettings.Color = color(255, floor(200 * n2 / 4), 0)
				end
			end
		end
	end)
end

list1.boomDraw.stop = function()
	list1.boomDraw.enabled = false

	if list1.boomDraw.connection then
		list1.boomDraw.connection:Disconnect()
		list1.boomDraw.connection = nil
	end

	if list1.boomDraw.zombieAddedDisposer then
		list1.boomDraw.zombieAddedDisposer()
		list1.boomDraw.zombieAddedDisposer = nil
	end

	list1.boomDraw.clearAllMarkers()
end

list1.bulletDisplay = {
	enabled = false,
	billboardGui = nil,
	screenGui = nil,
	billLabel = nil,
	screenLabel = nil,
	connection = nil,
	cameraConn = nil,
}

list1.bulletDisplay.isFirstPerson = function()
	local currentCamera = workspace.CurrentCamera
	if not currentCamera then
		return false
	end
	local character = localPlayer.Character
	if not character then
		return false
	end
	local head = character:FindFirstChild("Head")
	if not head or not head:IsA("BasePart") then
		return false
	end
	return (currentCamera.CFrame.Position - head.Position).Magnitude < 0.7
end

list1.bulletDisplay.createUI = function()
	if list1.bulletDisplay.billboardGui and list1.bulletDisplay.screenGui then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
	if not head then
		return
	end
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "BulletDisplay_Billboard"
	billboardGui.Size = UDim2.new(0, 100, 0, 30)
	billboardGui.StudsOffset = Vector3.new(-3, 0.3, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.MaxDistance = 50
	billboardGui.Adornee = head
	billboardGui.Parent = character
	billboardGui.Enabled = false
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = func5("子弹: 0")
	textLabel.TextColor3 = color(0, 255, 0)
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextStrokeTransparency = 0.3
	textLabel.TextStrokeColor3 = color(0, 0, 0)
	textLabel.Parent = billboardGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "BulletDisplay_Screen"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
	screenGui.Enabled = false
	local textLabel2 = Instance.new("TextLabel")
	textLabel2.Size = UDim2.new(0, 120, 0, 40)
	textLabel2.Position = UDim2.new(0.02, 0, 0.48, 0)
	textLabel2.AnchorPoint = Vector2.new(0, 0)
	textLabel2.BackgroundTransparency = 1
	textLabel2.Text = func5("子弹: 0")
	textLabel2.TextColor3 = color(0, 255, 0)
	textLabel2.TextSize = 20
	textLabel2.Font = Enum.Font.GothamBold
	textLabel2.TextStrokeTransparency = 0.3
	textLabel2.TextStrokeColor3 = color(0, 0, 0)
	textLabel2.Parent = screenGui
	list1.bulletDisplay.billboardGui = billboardGui
	list1.bulletDisplay.screenGui = screenGui
	list1.bulletDisplay.billLabel = textLabel
	list1.bulletDisplay.screenLabel = textLabel2
end

list1.bulletDisplay.destroyUI = function()
	if list1.bulletDisplay.billboardGui then
		list1.bulletDisplay.billboardGui:Destroy()
	end

	if list1.bulletDisplay.screenGui then
		list1.bulletDisplay.screenGui:Destroy()
	end

	list1.bulletDisplay.billboardGui = nil
	list1.bulletDisplay.screenGui = nil
	list1.bulletDisplay.billLabel = nil
	list1.bulletDisplay.screenLabel = nil
end

list1.bulletDisplay.updateVisibility = function()
	if not list1.bulletDisplay.enabled then
		return
	end

	if not list1.bulletDisplay.billboardGui or not list1.bulletDisplay.screenGui then
		return
	end
	local flag125 = list1.bulletDisplay.isFirstPerson()
	list1.bulletDisplay.billboardGui.Enabled = not flag125
	list1.bulletDisplay.screenGui.Enabled = flag125
end

list1.bulletDisplay.isGun = list1.sharedIsGun

list1.bulletDisplay.getBullets = function()
	local character = localPlayer.Character
	if not character then
		return 0
	end
	local tool = character:FindFirstChildOfClass("Tool")
	local n2

	if tool and list1.bulletDisplay.isGun(tool) then
		local shotsLoaded = tool:FindFirstChild("ShotsLoaded")
		local isIntValue = shotsLoaded and (shotsLoaded:IsA("IntValue") or shotsLoaded:IsA("NumberValue"))
		n2 = 0

		if isIntValue then
			n2 = shotsLoaded.Value
		end
	else
		local backpack = localPlayer:FindFirstChild("Backpack")
		n2 = 0

		if backpack then
			for _, value251 in backpack:GetChildren() do
				if value251:IsA("Tool") and list1.bulletDisplay.isGun(value251) then
					local shotsLoaded = value251:FindFirstChild("ShotsLoaded")

					if shotsLoaded and (shotsLoaded:IsA("IntValue") or shotsLoaded:IsA("NumberValue")) then
						local value252 = shotsLoaded.Value

						if n2 < value252 then
							n2 = value252
						end
					end
				end
			end
		end
	end

	return n2
end

list1.bulletDisplay.updateLabels = function()
	if not list1.bulletDisplay.enabled then
		return
	end
	local flag126 = list1.bulletDisplay.getBullets()
	local text = (flag1 == "English" and "Bullets: " or "子弹: ") .. tostring(flag126)
	local textColor3 = flag126 > 0 and color(0, 255, 0) or color(255, 0, 0)

	if list1.bulletDisplay.billLabel then
		list1.bulletDisplay.billLabel.Text = text
		list1.bulletDisplay.billLabel.TextColor3 = textColor3
	end

	if list1.bulletDisplay.screenLabel then
		list1.bulletDisplay.screenLabel.Text = text
		list1.bulletDisplay.screenLabel.TextColor3 = textColor3
	end
end

list1.bulletDisplay.update = function()
	if not list1.bulletDisplay.enabled then
		if list1.bulletDisplay.connection then
			list1.bulletDisplay.connection:Disconnect()
		end

		if list1.bulletDisplay.cameraConn then
			list1.bulletDisplay.cameraConn:Disconnect()
		end

		return
	end

	local character = localPlayer.Character

	if not character then
		list1.bulletDisplay.destroyUI()
		list1.bulletDisplay.createUI()
		return
	end

	local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")

	if list1.bulletDisplay.billboardGui and list1.bulletDisplay.billboardGui.Adornee ~= head then
		list1.bulletDisplay.destroyUI()
		list1.bulletDisplay.createUI()
	end

	if not list1.bulletDisplay.billboardGui or not list1.bulletDisplay.screenGui then
		list1.bulletDisplay.createUI()
	end

	list1.bulletDisplay.updateLabels()
	list1.bulletDisplay.updateVisibility()
end

list1.bulletDisplay.start = function()
	if list1.bulletDisplay.enabled then
		return
	end
	list1.bulletDisplay.enabled = true
	list1.bulletDisplay.createUI()

	if list1.bulletDisplay.connection then
		list1.bulletDisplay.connection:Disconnect()
	end

	list1.bulletDisplay.connection = obj5.Heartbeat:Connect(list1.bulletDisplay.update)

	if list1.bulletDisplay.cameraConn then
		list1.bulletDisplay.cameraConn:Disconnect()
	end

	list1.bulletDisplay.cameraConn = obj5.RenderStepped:Connect(function()
		if list1.bulletDisplay.enabled then
			list1.bulletDisplay.updateVisibility()
		end
	end)

	list1.bulletDisplay.update()
end

list1.bulletDisplay.stop = function()
	list1.bulletDisplay.enabled = false

	if list1.bulletDisplay.connection then
		list1.bulletDisplay.connection:Disconnect()
	end

	if list1.bulletDisplay.cameraConn then
		list1.bulletDisplay.cameraConn:Disconnect()
	end

	list1.bulletDisplay.destroyUI()
end

list1.Tracer = { enabled = false, conn = nil, tracking = {} }

list1.Tracer.toggle = function(enabled)
	list1.Tracer.enabled = enabled

	if enabled then
		if list1.Tracer.conn then
			list1.Tracer.conn:Disconnect()
		end

		list1.Tracer.conn = workspace.DescendantAdded:Connect(function(descendant)
			if not list1.Tracer.enabled then
				return
			end

			if not descendant:IsA("PointLight") then
				return
			end

			if list1.Tracer.tracking[descendant] then
				return
			end
			local parent = descendant.Parent
			if not parent or not parent:IsA("BasePart") then
				return
			end
			local position = parent.Position
			list1.Tracer.tracking[descendant] = { obj = parent, pos1 = position }

			task.spawn(function()
				task.wait(0.1)
				local flag127 = list1.Tracer.tracking[descendant]
				if not flag127 then
					return
				end
				local obj = flag127.obj
				if not obj or not obj.Parent or not descendant.Parent then
					list1.Tracer.tracking[descendant] = nil
					return
				end
				local position2 = obj.Position
				local n2 = position2 - position
				if n2.Magnitude < 0.3 then
					list1.Tracer.tracking[descendant] = nil
					return
				end
				local unit = n2.Unit
				list1.Tracer.tracking[descendant] = nil
				local raycastParams = RaycastParams.new()
				raycastParams.FilterType = Enum.RaycastFilterType.Exclude
				local filterDescendantsInstances = { obj }

				while obj.Parent and not obj.Parent:IsA("Workspace") do
					obj = obj.Parent
					table.insert(filterDescendantsInstances, obj)
				end

				raycastParams.FilterDescendantsInstances = filterDescendantsInstances
				local hit = workspace:Raycast(position2 + unit * 2, unit * 500, raycastParams)
				hit = hit and hit.Position or position + unit * 500
				local n3 = hit - position
				local magnitude = n3.Magnitude
				if magnitude < 0.1 then
					return
				end
				local part = Instance.new("Part")
				part.Name = "_Tracer"
				part.Size = vector(0.05, 0.05, magnitude)
				part.Color = color(255, 255, 0)
				part.Material = Enum.Material.Neon
				part.Anchored = true
				part.CanCollide = false
				part.CFrame = CFrame.lookAt(position + n3 * 0.5, hit)
				part.Parent = workspace
				local result25 = clock()

				while clock() - result25 < 3 and part.Parent do
					part.Transparency = (clock() - result25) / 3
					task.wait(0.05)
				end

				pcall(part.Destroy, part)
			end)
		end)
	else
		if list1.Tracer.conn then
			list1.Tracer.conn:Disconnect()
			list1.Tracer.conn = nil
		end

		list1.Tracer.tracking = {}
	end
end

list1.cannonSupplies = { enabled = false, highlights = {} }

list1.cannonSupplies.createHighlightForPart = function(param66, param67)
	local flag128 = list1.addESP({
		Name = param67,
		Model = param66,
		Color = color(0, 255, 255),
		MaxDistance = 1000,
		TextSize = 14,
		ESPType = "Highlight",
		FillColor = color(0, 255, 255),
		OutlineColor = color(255, 255, 255),
		FillTransparency = 0.5,
		OutlineTransparency = 0.3,
	})

	if flag128 ~= nil then
		table.insert(list1.cannonSupplies.highlights, flag128)
	end
end

list1.cannonSupplies.createHighlights = function()
	list1.cannonSupplies.removeHighlights()
	local vardohusFortress = workspace:FindFirstChild("Vardohus Fortress")
	local modes = vardohusFortress and vardohusFortress:FindFirstChild("Modes")
	modes = modes and modes:FindFirstChild("Objective")
	modes = modes and modes:FindFirstChild("CannonSupplies")
	if not modes then
		return
	end

	for _, value253 in modes:GetChildren() do
		if value253:IsA("Folder") then
			local swab = value253:FindFirstChild("Swab")
			local n12LbRoundshots = value253:FindFirstChild("12 lb. Roundshots")

			if swab then
				list1.cannonSupplies.createHighlightForPart(swab, "Swab")
			end

			if n12LbRoundshots then
				list1.cannonSupplies.createHighlightForPart(n12LbRoundshots, "12 lb. Roundshots")
			end
		end
	end
end

list1.cannonSupplies.removeHighlights = function()
	for _, highlight2 in list1.cannonSupplies.highlights do
		list1.destroyESP(highlight2)
	end

	list1.cannonSupplies.highlights = {}
end

list1.cannonSupplies.toggle = function(enabled)
	list1.cannonSupplies.enabled = enabled

	if enabled then
		list1.cannonSupplies.createHighlights()
	else
		list1.cannonSupplies.removeHighlights()
	end
end
-- join us: https://discord.gg/x7YbZeezpm

list1.killSound = { selectedId = "5700183626", volume = 7, enabled = false, thread = nil, lastCount = 0 }

list1.killSound.getCurrentCount = function()
	local leaderstats = localPlayer:FindFirstChild("leaderstats")

	if leaderstats then
		local kills = leaderstats:FindFirstChild("Kills")
		if kills and (kills:IsA("IntValue") or kills:IsA("NumberValue")) then
			return kills.Value
		end
	end

	return 0
end

list1.killSound.play = function()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. list1.killSound.selectedId
	sound.Volume = list1.killSound.volume / 10
	sound.Parent = workspace
	sound:Play()

	sound.Ended:Once(function()
		sound:Destroy()
	end)

	task.delay(0.5, function()
		if sound and sound.Parent then
			sound:Destroy()
		end
	end)
end

list1.killSound.loop = function()
	while list1.killSound.enabled do
		local num43 = list1.killSound.getCurrentCount()

		if list1.killSound.lastCount < num43 then
			for i = 1, num43 - list1.killSound.lastCount do
				list1.killSound.play()
			end

			list1.killSound.lastCount = num43
		elseif num43 < list1.killSound.lastCount then
			list1.killSound.lastCount = num43
		end

		task.wait(0.1)
	end
end

list1.killSound.start = function()
	if list1.killSound.thread then
		return
	end
	list1.killSound.enabled = true
	list1.killSound.lastCount = list1.killSound.getCurrentCount()
	list1.killSound.thread = task.spawn(list1.killSound.loop)
end

list1.killSound.stop = function()
	list1.killSound.enabled = false

	if list1.killSound.thread then
		task.cancel(list1.killSound.thread)
		list1.killSound.thread = nil
	end
end

list1.pingDisplay = { gui = nil, label = nil, conn = nil }

list1.pingDisplay.start = function()
	if list1.pingDisplay.gui then
		return
	end
	list1.pingDisplay.gui = Instance.new("ScreenGui")
	list1.pingDisplay.gui.Name = "PingDisplay"
	list1.pingDisplay.gui.ResetOnSpawn = false
	list1.pingDisplay.gui.Parent = localPlayer:WaitForChild("PlayerGui")
	local frame = Instance.new("Frame")
	frame.Parent = list1.pingDisplay.gui
	frame.Size = UDim2.new(0, 120, 0, 30)
	frame.Position = UDim2.new(1, -130, 0, 10)
	frame.BackgroundColor3 = color(0, 0, 0)
	frame.BackgroundTransparency = 0.5
	frame.BorderSizePixel = 0
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = frame
	list1.pingDisplay.label = Instance.new("TextLabel")
	list1.pingDisplay.label.Parent = frame
	list1.pingDisplay.label.Size = UDim2.new(1, 0, 1, 0)
	list1.pingDisplay.label.BackgroundTransparency = 1
	list1.pingDisplay.label.Text = func5("延迟: -- ms")
	list1.pingDisplay.label.TextColor3 = color(255, 255, 255)
	list1.pingDisplay.label.TextSize = 14
	list1.pingDisplay.label.Font = Enum.Font.GothamBold

	list1.pingDisplay.conn = obj5.Heartbeat:Connect(function()
		if not list1.pingDisplay.gui then
			return
		end

		local ok, result = pcall(function()
			return obj10.Network.ServerStatsItem["Data Ping"]:GetValue()
		end)

		if ok and result then
			list1.pingDisplay.label.Text = (flag1 == "English" and "Ping: " or "延迟: ") .. floor(result) .. " ms"

			if result >= 120 then
				list1.pingDisplay.label.TextColor3 = color(255, 80, 80)
			elseif result >= 80 then
				list1.pingDisplay.label.TextColor3 = color(255, 255, 0)
			else
				list1.pingDisplay.label.TextColor3 = color(0, 255, 0)
			end
		end
	end)
end

list1.pingDisplay.stop = function()
	if list1.pingDisplay.conn then
		list1.pingDisplay.conn:Disconnect()
		list1.pingDisplay.conn = nil
	end

	if list1.pingDisplay.gui then
		list1.pingDisplay.gui:Destroy()
		list1.pingDisplay.gui = nil
	end

	list1.pingDisplay.label = nil
end

list1.infectionRemover = { enabled = false, conn = nil }

list1.infectionRemover.start = function()
	if list1.infectionRemover.conn then
		return
	end
	list1.infectionRemover.enabled = true

	list1.infectionRemover.conn = obj5.Heartbeat:Connect(function()
		if not list1.infectionRemover.enabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local userStates = character:FindFirstChild("UserStates")

		if userStates then
			local infected = userStates:FindFirstChild("Infected")

			if infected then
				infected.Value = "0"
			end
		end
	end)
end

list1.infectionRemover.stop = function()
	list1.infectionRemover.enabled = false

	if list1.infectionRemover.conn then
		list1.infectionRemover.conn:Disconnect()
		list1.infectionRemover.conn = nil
	end
end

list1.bombRange = { enabled = false, spheres = {}, conn = nil, warned = false, damageDisplay = nil }

do
	local n2 = 10
	local value254 = color(255, 80, 80)
	local transparency = 0.6
	local n3 = 20
	local n4 = -1.5

	list1.bombRange.getBarrelZombies = function()
		local tbl50 = {}
		local zombies = workspace:FindFirstChild("Zombies")
		if not zombies then
			return tbl50
		end

		for _, value255 in zombies:GetChildren() do
			if value255:IsA("Model") and value255:GetAttribute("Type") == "Barrel" then
				table.insert(tbl50, value255)
			end
		end

		return tbl50
	end

	list1.bombRange.getSphereCenter = function(instance38)
		local humanoidRootPart = instance38:FindFirstChild("HumanoidRootPart") or instance38:FindFirstChild("Torso") or instance38:FindFirstChild("Head")
		if humanoidRootPart then
			return humanoidRootPart.Position + vector(0, n4, 0)
		end
		return nil
	end

	list1.bombRange.createSphere = function(param68)
		local flag129 = list1.bombRange.getSphereCenter(param68)
		if not flag129 then
			return nil
		end
		local part = Instance.new("Part")
		part.Name = "BombRangeSphere"
		part.Shape = Enum.PartType.Ball
		part.Size = vector(n2 * 2, n2 * 2, n2 * 2)
		part.Color = value254
		part.Material = Enum.Material.Neon
		part.Transparency = transparency
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.CastShadow = false
		part.Position = flag129
		part.Parent = workspace
		return part
	end

	list1.bombRange.updateSphere = function(obj, flag130)
		if not obj or not flag130 then
			return
		end
		local num44 = list1.bombRange.getSphereCenter(flag130)

		if num44 then
			obj.Position = num44

			if obj.Size.X ~= n2 * 2 then
				obj.Size = vector(n2 * 2, n2 * 2, n2 * 2)
			end

			local character = localPlayer.Character

			if character then
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					if (humanoidRootPart.Position - num44).Magnitude <= n2 then
						obj.Color = color(255, 0, 0)
					else
						obj.Color = color(120, 200, 120)
					end
				end
			end
		end
	end

	list1.bombRange.updateAllSpheres = function()
		if not list1.bombRange.enabled then
			return
		end
		local value256 = list1.bombRange.getBarrelZombies()
		local tbl51 = {}

		for _, value257 in value256 do
			tbl51[value257] = true
		end

		for k, sphere in list1.bombRange.spheres do
			if not k.Parent or not tbl51[k] then
				if sphere then
					sphere:Destroy()
				end

				list1.bombRange.spheres[k] = nil
			end
		end

		for _, value258 in value256 do
			if not list1.bombRange.spheres[value258] then
				local value259 = list1.bombRange.createSphere(value258)

				if value259 then
					list1.bombRange.spheres[value258] = value259
				end
			else
				list1.bombRange.updateSphere(list1.bombRange.spheres[value258], value258)
			end
		end
	end

	list1.bombRange.getMinDistanceToBarrelCenter = function()
		local character = localPlayer.Character
		if not character then
			return math.huge
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return math.huge
		end
		local huge = math.huge

		for _, getBarrelZomby2 in list1.bombRange.getBarrelZombies(), nil, nil do
			local num45 = list1.bombRange.getSphereCenter(getBarrelZomby2)

			if num45 then
				local magnitude = (num45 - humanoidRootPart.Position).Magnitude

				if magnitude < huge then
					huge = magnitude
				end
			end
		end

		return huge
	end

	list1.bombRange.calculateDamage = function(num46)
		if num46 >= n2 then
			return 0
		end
		return floor(10 + 90 * (1 - num46 / n2))
	end

	list1.bombRange.updateDamageDisplay = function()
		if not list1.bombRange.enabled then
			if list1.bombRange.damageDisplay then
				list1.bombRange.damageDisplay:Destroy()
				list1.bombRange.damageDisplay = nil
			end

			return
		end

		local character = localPlayer.Character

		if not character then
			if list1.bombRange.damageDisplay then
				list1.bombRange.damageDisplay:Destroy()
				list1.bombRange.damageDisplay = nil
			end

			return
		end

		local value260 = list1.bombRange.getMinDistanceToBarrelCenter()
		local n5 = 0

		if value260 <= n2 then
			n5 = list1.bombRange.calculateDamage(value260)
		end

		if n5 > 0 then
			if list1.bombRange.damageDisplay and not list1.bombRange.damageDisplay.Parent then
				list1.bombRange.damageDisplay = nil
			end

			if not list1.bombRange.damageDisplay then
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
				if not humanoidRootPart then
					return
				end
				local billboardGui = Instance.new("BillboardGui")
				billboardGui.Name = "DamageDisplay"
				billboardGui.Size = UDim2.new(0, 100, 0, 40)
				billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
				billboardGui.AlwaysOnTop = true
				billboardGui.Adornee = humanoidRootPart
				billboardGui.Parent = character
				local textLabel = Instance.new("TextLabel")
				textLabel.Size = UDim2.new(1, 0, 1, 0)
				textLabel.BackgroundTransparency = 1
				textLabel.TextSize = 24
				textLabel.Font = Enum.Font.GothamBold
				textLabel.TextStrokeTransparency = 0.2
				textLabel.TextStrokeColor3 = color(0, 0, 0)
				textLabel.Parent = billboardGui
				list1.bombRange.damageDisplay = billboardGui
			end

			local textLabel = list1.bombRange.damageDisplay:FindFirstChildOfClass("TextLabel")

			if textLabel then
				textLabel.Text = tostring(n5)

				if n5 <= n3 then
					textLabel.TextColor3 = color(255, 255, 0)
				else
					textLabel.TextColor3 = color(255, 0, 0)
				end
			end
		elseif list1.bombRange.damageDisplay then
			list1.bombRange.damageDisplay:Destroy()
			list1.bombRange.damageDisplay = nil
		end
	end

	list1.bombRange.onHeartbeat = function()
		if not list1.bombRange.enabled then
			return
		end
		list1.bombRange.updateAllSpheres()
		list1.bombRange.updateDamageDisplay()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")

		if character then
			local flag131 = false

			for _, sphere2 in list1.bombRange.spheres do
				if sphere2 and sphere2.Parent then
					if (character.Position - sphere2.Position).Magnitude <= n2 then
						flag131 = true
						break
					end
				end
			end

			if flag131 and not list1.bombRange.warned then
				list1.bombRange.warned = true
				list1.notify(func5("爆炸范围: 已进入爆炸范围内"), 3)
			elseif not flag131 then
				list1.bombRange.warned = false
			end
		end
	end
end

list1.bombRange.start = function()
	if list1.bombRange.conn then
		return
	end
	list1.bombRange.enabled = true
	list1.bombRange.warned = false
	list1.bombRange.conn = obj5.Heartbeat:Connect(list1.bombRange.onHeartbeat)
end

list1.bombRange.stop = function()
	list1.bombRange.enabled = false

	if list1.bombRange.conn then
		list1.bombRange.conn:Disconnect()
		list1.bombRange.conn = nil
	end

	for _, sphere3 in list1.bombRange.spheres do
		pcall(sphere3.Destroy, sphere3)
	end

	list1.bombRange.spheres = {}

	if list1.bombRange.damageDisplay then
		list1.bombRange.damageDisplay:Destroy()
		list1.bombRange.damageDisplay = nil
	end

	list1.bombRange.warned = false
end

list1.handMortar = {
	enabled = false,
	animIds = { ["rbxassetid://117522716162453"] = true, ["rbxassetid://83761082384320"] = true },
	gui = nil,
	conn = nil,
	cameraConn = nil,
	animConn = nil,
	endtick_ = nil,
	running = false,
}

list1.handMortar.isFirstPerson = function()
	local currentCamera = workspace.CurrentCamera
	if not currentCamera then
		return false
	end
	local character = localPlayer.Character
	if not character then
		return false
	end
	local head = character:FindFirstChild("Head")
	if not head or not head:IsA("BasePart") then
		return false
	end
	return (currentCamera.CFrame.Position - head.Position).Magnitude < 0.7
end

list1.handMortar.createUI = function()
	if list1.handMortar.gui then
		return
	end
	local playerGui = localPlayer:WaitForChild("PlayerGui")
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "HandMortarTimer_Billboard"
	billboardGui.Size = UDim2.new(0, 80, 0, 40)
	billboardGui.StudsOffset = Vector3.new(2.2, 0, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.MaxDistance = 200
	billboardGui.Parent = playerGui
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextStrokeTransparency = 0.2
	textLabel.Font = Enum.Font.SourceSansBold
	textLabel.TextSize = 20
	textLabel.Text = ""
	textLabel.Parent = billboardGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "HandMortarTimer_Screen"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	local textLabel2 = Instance.new("TextLabel")
	textLabel2.Size = UDim2.new(0, 120, 0, 50)
	textLabel2.Position = UDim2.new(0.55, 0, 0.45, 0)
	textLabel2.AnchorPoint = Vector2.new(0, 0)
	textLabel2.BackgroundTransparency = 1
	textLabel2.TextColor3 = Color3.new(1, 1, 1)
	textLabel2.TextStrokeTransparency = 0.2
	textLabel2.Font = Enum.Font.SourceSansBold
	textLabel2.TextSize = 28
	textLabel2.Text = ""
	textLabel2.Parent = screenGui
	list1.handMortar.gui = { billboard = billboardGui, screen = screenGui, billLabel = textLabel, screenLabel = textLabel2 }
	billboardGui.Enabled = false
	screenGui.Enabled = false
end

list1.handMortar.destroyUI = function()
	if list1.handMortar.gui then
		if list1.handMortar.gui.billboard then
			list1.handMortar.gui.billboard:Destroy()
		end

		if list1.handMortar.gui.screen then
			list1.handMortar.gui.screen:Destroy()
		end

		list1.handMortar.gui = nil
	end
end

list1.handMortar.startTimer = function()
	if not list1.handMortar.enabled then
		return
	end

	if list1.handMortar.conn then
		list1.handMortar.conn:Disconnect()
	end

	if list1.handMortar.cameraConn then
		list1.handMortar.cameraConn:Disconnect()
	end

	list1.handMortar.destroyUI()
	list1.handMortar.createUI()
	local character = localPlayer.Character

	if character and list1.handMortar.gui and list1.handMortar.gui.billboard then
		local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")

		if head then
			list1.handMortar.gui.billboard.Adornee = head
		end
	end

	list1.handMortar.endtick_ = clock() + 5
	list1.handMortar.running = true

	local function func87()
		if not list1.handMortar.gui then
			return
		end
		local flag132 = list1.handMortar.isFirstPerson()
		list1.handMortar.gui.billboard.Enabled = not flag132
		list1.handMortar.gui.screen.Enabled = flag132
	end

	func87()

	list1.handMortar.cameraConn = obj5.RenderStepped:Connect(function()
		if not list1.handMortar.running then
			return
		end

		if list1.handMortar.gui then
			local flag133 = list1.handMortar.isFirstPerson()
			list1.handMortar.gui.billboard.Enabled = not flag133
			list1.handMortar.gui.screen.Enabled = flag133
		end
	end)

	list1.handMortar.conn = obj5.RenderStepped:Connect(function()
		if not list1.handMortar.running or not list1.handMortar.gui then
			if list1.handMortar.conn then
				list1.handMortar.conn:Disconnect()
			end

			if list1.handMortar.cameraConn then
				list1.handMortar.cameraConn:Disconnect()
			end

			list1.handMortar.destroyUI()
			list1.handMortar.running = false
			return
		end

		local num47 = max(0, list1.handMortar.endtick_ - clock())
		local num48 = floor(num47 * 1000 + 0.5)
		local num49 = floor(num48 / 1000)
		local num50 = format("%d.%03ds", num49, num48 - num49 * 1000)

		if list1.handMortar.gui.billLabel then
			list1.handMortar.gui.billLabel.Text = num50
		end

		if list1.handMortar.gui.screenLabel then
			list1.handMortar.gui.screenLabel.Text = num50
		end

		if num47 <= 0 then
			if list1.handMortar.conn then
				list1.handMortar.conn:Disconnect()
			end

			if list1.handMortar.cameraConn then
				list1.handMortar.cameraConn:Disconnect()
			end

			list1.handMortar.destroyUI()
			list1.handMortar.running = false
		end
	end)
end

list1.handMortar.onAnimationPlayed = function(obj)
	if not list1.handMortar.enabled then
		return
	end
	obj = obj and obj.Animation
	if not obj then
		return
	end

	if list1.handMortar.animIds[obj.AnimationId] then
		task.delay(1, function()
			if list1.handMortar.enabled then
				list1.handMortar.startTimer()
			end
		end)
	end
end

list1.handMortar.attachAnimWatcher = function()
	if list1.handMortar.animConn then
		list1.handMortar.animConn:Disconnect()
	end

	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		list1.handMortar.animConn = humanoid.AnimationPlayed:Connect(list1.handMortar.onAnimationPlayed)
	end
end

list1.handMortar.setEnabled = function(enabled)
	list1.handMortar.enabled = enabled

	if enabled then
		list1.handMortar.attachAnimWatcher()
	else
		if list1.handMortar.animConn then
			list1.handMortar.animConn:Disconnect()
			list1.handMortar.animConn = nil
		end

		if list1.handMortar.conn then
			list1.handMortar.conn:Disconnect()
			list1.handMortar.conn = nil
		end

		if list1.handMortar.cameraConn then
			list1.handMortar.cameraConn:Disconnect()
			list1.handMortar.cameraConn = nil
		end

		list1.handMortar.destroyUI()
		list1.handMortar.running = false
	end
end

list1.noBarrelHit = { enabled = false, conn = nil }

list1.noBarrelHit.toggle = function(enabled)
	list1.noBarrelHit.enabled = enabled

	if enabled then
		local function func88(instance39)
			if not instance39 or not instance39.Parent then
				return
			end

			for _, getDescendant27 in instance39:GetDescendants() do
				if getDescendant27:IsA("BasePart") then
					getDescendant27.CanCollide = false
					getDescendant27.CanTouch = false
					getDescendant27.CanQuery = false
				end
			end
		end

		local zombies = workspace:FindFirstChild("Zombies")

		if zombies then
			for _, value261 in zombies:GetChildren() do
				if value261:IsA("Model") and (value261:GetAttribute("Type") == "Barrel" or value261:FindFirstChild("Barrel")) then
					func88(value261)
				end
			end
		end

		task.spawn(function()
			while list1.noBarrelHit.enabled do
				local zombies2 = workspace:FindFirstChild("Zombies")

				if zombies2 then
					for _, value262 in zombies2:GetChildren() do
						if value262:IsA("Model") and (value262:GetAttribute("Type") == "Barrel" or value262:FindFirstChild("Barrel")) then
							func88(value262)
						end
					end
				end

				task.wait()
			end
		end)

		if list1.noBarrelHit.conn then
			list1.noBarrelHit.conn:Disconnect()
		end

		list1.noBarrelHit.conn = workspace.DescendantAdded:Connect(function(descendant)
			if list1.noBarrelHit.enabled and descendant:IsA("Model") and (descendant:GetAttribute("Type") == "Barrel" or descendant:FindFirstChild("Barrel")) then
				func88(descendant)
			end
		end)
	elseif list1.noBarrelHit.conn then
		list1.noBarrelHit.conn:Disconnect()
		list1.noBarrelHit.conn = nil
	end
end

list1.jumpLock = { active = false, conn = nil }

list1.jumpLock.toggle = function(active)
	list1.jumpLock.active = active

	if active then
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.JumpPower = 30

			if list1.jumpLock.conn then
				list1.jumpLock.conn:Disconnect()
			end

			list1.jumpLock.conn = humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
				if humanoid.JumpPower ~= 30 then
					humanoid.JumpPower = 30
				end
			end)
		end
	else
		if list1.jumpLock.conn then
			list1.jumpLock.conn:Disconnect()
			list1.jumpLock.conn = nil
		end

		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.JumpPower = 16
		end
	end
end

list1.onCharacterAdded(function()
	if list1.jumpLock and list1.jumpLock.active then
		task.wait(0.2)
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.JumpPower = 30

			if list1.jumpLock.conn then
				list1.jumpLock.conn:Disconnect()
			end

			list1.jumpLock.conn = humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
				if humanoid.JumpPower ~= 30 then
					humanoid.JumpPower = 30
				end
			end)
		end
	end
end)

list1.hitboxHighlight = {
	enabled = false,
	box = nil,
	containerPart = nil,
	charConn = nil,
	diedConn = nil,
	loopThread = nil,
	history = {},
	maxHistory = 60,
}

do
	local n2 = 0
	local n3 = 0

	local function func89()
		local result26 = clock2()

		if result26 - n3 >= 1 then
			n3 = result26

			local ok, result = pcall(function()
				return obj10.Network.ServerStatsItem["Data Ping"]:GetValue()
			end)

			if ok and result then
				n2 = result
			end
		end

		return n2
	end

	local function func90()
		if list1.hitboxHighlight.box then
			pcall(function()
				list1.hitboxHighlight.box:Destroy()
			end)

			list1.hitboxHighlight.box = nil
		end

		if list1.hitboxHighlight.containerPart then
			pcall(function()
				list1.hitboxHighlight.containerPart:Destroy()
			end)

			list1.hitboxHighlight.containerPart = nil
		end

		if list1.hitboxHighlight.loopThread then
			task.cancel(list1.hitboxHighlight.loopThread)
			list1.hitboxHighlight.loopThread = nil
		end

		table.clear(list1.hitboxHighlight.history)
	end

	list1.hitboxHighlight.enable = function()
		if list1.hitboxHighlight.enabled then
			return
		end
		list1.hitboxHighlight.enabled = true
		func90()
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local part = Instance.new("Part")
		part.Name = "HitboxContainer"
		part.Size = humanoidRootPart.Size
		part.CFrame = humanoidRootPart.CFrame
		part.Anchored = true
		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = false
		part.Transparency = 1
		part.Parent = workspace
		list1.hitboxHighlight.containerPart = part
		list1.hitboxHighlight.box = Instance.new("SelectionBox")
		list1.hitboxHighlight.box.Adornee = part
		list1.hitboxHighlight.box.Color3 = color(255, 0, 0)
		list1.hitboxHighlight.box.LineThickness = 0.15
		list1.hitboxHighlight.box.Transparency = 0.3
		list1.hitboxHighlight.box.Parent = part
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			if list1.hitboxHighlight.diedConn then
				list1.hitboxHighlight.diedConn:Disconnect()
			end

			list1.hitboxHighlight.diedConn = humanoid.Died:Connect(function()
				func90()
			end)
		end

		local n4 = 10
		local value263 = obj5

		list1.hitboxHighlight.loopThread = task.spawn(function()
			local result27 = clock2()

			while list1.hitboxHighlight.enabled do
				local result28 = clock2()
				local num51 = min(result28 - result27, 0.1)
				local character2 = localPlayer.Character

				if character2 then
					local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart2 and list1.hitboxHighlight.containerPart then
						local history = list1.hitboxHighlight.history
						table.insert(history, { time = result28, cframe = humanoidRootPart2.CFrame, size = humanoidRootPart2.Size })

						while #history > list1.hitboxHighlight.maxHistory do
							table.remove(history, 1)
						end

						local n5 = result28 - func89() / 1000
						local cframe2 = history[1].cframe
						local size = history[1].size

						for i = 1, #history do
							if n5 <= history[i].time then
								cframe2 = history[i].cframe
								size = history[i].size
								break
							end
						end

						local cFrame = list1.hitboxHighlight.containerPart.CFrame
						local num52 = min(n4 * num51, 1)
						list1.hitboxHighlight.containerPart.CFrame = cFrame:Lerp(cframe2, num52)
						list1.hitboxHighlight.containerPart.Size = list1.hitboxHighlight.containerPart.Size:Lerp(size, num52)
					end
				end

				value263.Heartbeat:Wait()
				result27 = result28
			end
		end)
	end

	list1.hitboxHighlight.disable = function()
		if not list1.hitboxHighlight.enabled then
			return
		end
		list1.hitboxHighlight.enabled = false

		if list1.hitboxHighlight.diedConn then
			list1.hitboxHighlight.diedConn:Disconnect()
			list1.hitboxHighlight.diedConn = nil
		end

		func90()
	end

	list1.hitboxHighlight.toggle = function()
		if list1.hitboxHighlight.enabled then
			list1.hitboxHighlight.disable()
		else
			list1.hitboxHighlight.enable()
		end
	end

	if list1.hitboxHighlight.charConn then
		list1.hitboxHighlight.charConn()
	end

	list1.hitboxHighlight.charConn = list1.onCharacterAdded(function()
		task.wait(0.3)

		if list1.hitboxHighlight.enabled then
			func90()
			task.wait(0.1)
			list1.hitboxHighlight.enabled = false
			list1.hitboxHighlight.enable()
		end
	end)
end

obj147:AddToggle("HitboxHighlightToggle", {
	Text = "玩家碰撞箱显示",
	Default = false,
	Tooltip = func6("显示玩家碰撞箱"),
	Callback = function(value)
		if value then
			list1.hitboxHighlight.enable()
		else
			list1.hitboxHighlight.disable()
		end
	end,
})

list1.legionPack = {
	selectedLegion = "法兰西第一掷弹兵",
	selectedClass = "线列步兵",
	legionMap = {
		["法兰西第一掷弹兵"] = { nation = "French", regimentId = 2, branch = "Infantry" },
		["英国冷溪近卫军"] = { nation = "British", regimentId = 4, branch = "Infantry" },
		["老敬卫"] = { nation = "French", regimentId = 5, branch = "Infantry" },
	},
	classMap = {
		["线列步兵"] = "LineInfantry",
		["军官"] = "Officer",
		["工兵"] = "Sapper",
		["乐手"] = "Musician",
		["水手"] = "Seaman",
	},
}

list1.legionPack.getRemote = function()
	local events = obj7 and obj7:FindFirstChild("Events")
	if not events then
		return nil
	end
	local regiment = events:FindFirstChild("Regiment")
	if not regiment then
		return nil
	end
	return regiment:FindFirstChild("ChangeClass")
end

list1.legionPack.unlock = function()
	local obj162 = list1.legionPack.getRemote()
	if not obj162 then
		list1.notify(func5("解锁失败: 找不到ChangeClass"), 3)
		return false
	end
	local flag134 = list1.legionPack.legionMap[list1.legionPack.selectedLegion]
	local flag135 = list1.legionPack.classMap[list1.legionPack.selectedClass]
	if not flag134 or not flag135 then
		list1.notify(func5("解锁失败: 配置错误"), 3)
		return false
	end

	pcall(function()
		obj162:FireServer(flag135, flag134.regimentId, flag134.nation, flag134.branch)
	end)

	local str11 = ": " .. list1.legionPack.selectedLegion .. " - " .. list1.legionPack.selectedClass
	list1.notify(func5("已解锁替换") .. str11, 3)
	return true
end

list1.ZOMBIE_ESP_RANGE = 200

list1.lightenColor = function(obj, flag136)
	local n2 = flag136 or 0.5
	return Color3.new(obj.R + (1 - obj.R) * n2, obj.G + (1 - obj.G) * n2, obj.B + (1 - obj.B) * n2)
end

list1.ZOMBIE_TYPES = {
	Axe = {
		name = "斧头僵尸",
		color = color(180, 0, 250),
		highlightColor = list1.lightenColor(color(180, 0, 250)),
		part = "Axe",
	},
	Eye = {
		name = "红眼",
		color = color(255, 50, 50),
		highlightColor = list1.lightenColor(color(255, 50, 50)),
		part = "Eye",
	},
	Sword = {
		name = "胸甲骑兵",
		color = color(255, 0, 255),
		highlightColor = list1.lightenColor(color(255, 0, 255)),
		part = "Sword",
	},
	Barrel = {
		name = "自爆",
		color = color(250, 250, 0),
		highlightColor = list1.lightenColor(color(250, 250, 0)),
		part = "Barrel",
	},
	FTorso = {
		name = "提灯人",
		color = color(255, 120, 0),
		highlightColor = list1.lightenColor(color(255, 120, 0)),
		part = "FTorso",
	},
	Normal = { name = "山伯乐", color = color(144, 238, 144), highlightColor = color(144, 238, 144), part = nil },
	Headless = {
		name = "无头士兵",
		color = color(255, 215, 0),
		highlightColor = color(255, 215, 0),
		matchName = "HeadlessHorseman",
	},
}

list1.headlessHighlightEnabled = false
list1.draculaHighlightEnabled = false
list1.headlessHighlights = {}
list1.headlessDescendantConn = nil

list1.clearHeadlessHighlights = function()
	for _, headlessHighlight in list1.headlessHighlights do
		list1.destroyESP(headlessHighlight)
	end

	list1.headlessHighlights = {}
end

list1.isHeadlessModel = function(obj)
	if not obj or not obj:IsA("Model") then
		return false
	end
	local name = obj.Name
	if name == "HeadlessHorseman" then
		return true
	end

	if name:find("Horse") or name:find("Steed") or name:find("Mount") then
		local parent = obj.Parent
		if parent and parent:IsA("Model") and parent.Name == "HeadlessHorseman" then
			return true
		end

		if name:find("Headless") then
			return true
		end
	end

	return false
end

list1.getAttachPart = function(obj)
	return obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj:FindFirstChild("Torso")
end

list1.createHeadlessHighlight = function(instance40)
	if not instance40 or not instance40:IsA("Model") then
		return
	end

	if not list1.isHeadlessModel(instance40) then
		return
	end

	if list1.headlessHighlights[instance40] then
		return
	end

	local flag137 = list1.addESP({
		Name = func5("无头骑士"),
		Model = instance40,
		Color = color(255, 50, 50),
		MaxDistance = 1000,
		TextSize = 14,
		ESPType = "Highlight",
		FillColor = color(255, 50, 50),
		OutlineColor = color(255, 50, 50),
		FillTransparency = 0.5,
		OutlineTransparency = 0,
	})

	if flag137 == nil then
		return
	end
	list1.headlessHighlights[instance40] = flag137
end

list1.updateHeadlessHighlights = function()
	if not list1.headlessHighlightEnabled then
		list1.clearHeadlessHighlights()
		return
	end

	for k, headlessHighlight2 in list1.headlessHighlights do
		if not k.Parent or headlessHighlight2.Deleted then
			list1.destroyESP(headlessHighlight2)
			list1.headlessHighlights[k] = nil
		else
			headlessHighlight2.CurrentSettings.Name = func5("无头骑士")
		end
	end

	for _, getDescendant28 in workspace:GetDescendants() do
		if getDescendant28:IsA("Model") and list1.isHeadlessModel(getDescendant28) then
			list1.createHeadlessHighlight(getDescendant28)
		end
	end
end

list1.startHeadlessListener = function()
	if list1.headlessDescendantConn then
		return
	end

	list1.headlessDescendantConn = workspace.DescendantAdded:Connect(function(descendant)
		if list1.headlessHighlightEnabled and descendant:IsA("Model") and list1.isHeadlessModel(descendant) then
			task.spawn(function()
				task.wait()
				list1.createHeadlessHighlight(descendant)
			end)
		end
	end)
end

list1.stopHeadlessListener = function()
	if list1.headlessDescendantConn then
		list1.headlessDescendantConn:Disconnect()
		list1.headlessDescendantConn = nil
	end
end

list1.toggleHeadlessHighlight = function(headlessHighlightEnabled)
	list1.headlessHighlightEnabled = headlessHighlightEnabled

	if headlessHighlightEnabled then
		list1.updateHeadlessHighlights()
		list1.startHeadlessListener()
	else
		list1.clearHeadlessHighlights()
		list1.stopHeadlessListener()
	end
end

list1.draculaHighlights = {}
list1.draculaDescendantConn = nil

list1.clearDraculaHighlights = function()
	for _, draculaHighlight in list1.draculaHighlights do
		list1.destroyESP(draculaHighlight)
	end

	list1.draculaHighlights = {}
end

list1.getDraculaModel = function()
	local transylvania = workspace:FindFirstChild("Transylvania")
	return transylvania and transylvania:FindFirstChild("Modes") and transylvania.Modes:FindFirstChild("Boss") and transylvania.Modes.Boss:FindFirstChild("Dracula")
end

list1.createDraculaHighlight = function(instance41)
	if not instance41 or not instance41:IsA("Model") then
		return
	end

	if list1.draculaHighlights[instance41] then
		return
	end

	local flag138 = list1.addESP({
		Name = func5("德古拉"),
		Model = instance41,
		Color = color(255, 50, 50),
		MaxDistance = 1000,
		TextSize = 14,
		ESPType = "Highlight",
		FillColor = color(255, 50, 50),
		OutlineColor = color(255, 50, 50),
		FillTransparency = 0.5,
		OutlineTransparency = 0,
	})

	if flag138 == nil then
		return
	end
	list1.draculaHighlights[instance41] = flag138
end

list1.updateDraculaHighlight = function()
	if not list1.draculaHighlightEnabled then
		list1.clearDraculaHighlights()
		return
	end

	for k, draculaHighlight2 in list1.draculaHighlights do
		if not k.Parent or draculaHighlight2.Deleted then
			list1.destroyESP(draculaHighlight2)
			list1.draculaHighlights[k] = nil
		else
			draculaHighlight2.CurrentSettings.Name = func5("德古拉")
		end
	end

	local value264 = list1.getDraculaModel()

	if value264 then
		list1.createDraculaHighlight(value264)
	end
end

list1.startDraculaListener = function()
	if list1.draculaDescendantConn then
		return
	end

	list1.draculaDescendantConn = workspace.DescendantAdded:Connect(function(descendant)
		if list1.draculaHighlightEnabled and descendant:IsA("Model") and descendant.Name == "Dracula" then
			task.spawn(function()
				task.wait()
				list1.createDraculaHighlight(descendant)
			end)
		end
	end)
end

list1.stopDraculaListener = function()
	if list1.draculaDescendantConn then
		list1.draculaDescendantConn:Disconnect()
		list1.draculaDescendantConn = nil
	end
end

list1.toggleDraculaHighlight = function(draculaHighlightEnabled)
	list1.draculaHighlightEnabled = draculaHighlightEnabled

	if draculaHighlightEnabled then
		list1.updateDraculaHighlight()
		list1.startDraculaListener()
	else
		list1.clearDraculaHighlights()
		list1.stopDraculaListener()
	end
end

list1.zombieEspEnabled = {
	Axe = false,
	Eye = false,
	Sword = false,
	Barrel = false,
	FTorso = false,
	Normal = false,
	Headless = false,
}

list1.zombieEffects = {}

list1.getZombieTypeKey = function(obj)
	for k, value265 in list1.ZOMBIE_TYPES do
		if value265.part and obj:FindFirstChild(value265.part) then
			return k
		end
	end

	for k, value266 in list1.ZOMBIE_TYPES do
		if value266.matchName and obj.Name == value266.matchName then
			return k
		end
	end

	if not obj:FindFirstChild("Head") then
		return "Headless"
	end
	return "Normal"
end

list1.createZombieESP = function(param69, param70)
	local flag139 = list1.ZOMBIE_TYPES[param70]
	if not flag139 then
		return nil
	end

	return list1.addESP({
		Name = func5(flag139.name),
		Model = param69,
		Color = flag139.highlightColor,
		MaxDistance = list1.ZOMBIE_ESP_RANGE,
		TextSize = 14,
		ESPType = "Highlight",
		FillColor = flag139.highlightColor,
		OutlineColor = flag139.highlightColor,
		FillTransparency = 0.5,
		OutlineTransparency = 0,
	})
end

list1.removeZombieEffects = function(param71)
	local value267 = list1.zombieEffects[param71]

	if value267 then
		list1.destroyESP(value267.esp)
		list1.zombieEffects[param71] = nil
	end
end

list1.clearAllZombieEffects = function()
	for k in list1.zombieEffects do
		list1.removeZombieEffects(k)
	end
end

list1.updateZombieESP = function()
	local flag140 = false

	for _, value268 in list1.zombieEspEnabled do
		if value268 then
			flag140 = true
			break
		end
	end

	if not flag140 then
		list1.clearAllZombieEffects()
		return
	end
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	character = character and character.Position
	if not character then
		list1.clearAllZombieEffects()
		return
	end

	for k, zombieEffect in list1.zombieEffects do
		if not k.Parent or zombieEffect.esp == nil or zombieEffect.esp.Deleted then
			list1.removeZombieEffects(k)
		end
	end

	local tbl52 = {}
	local camera = workspace:FindFirstChild("Camera")

	if camera then
		for _, getDescendant29 in camera:GetDescendants() do
			if getDescendant29:IsA("Model") and getDescendant29.Name:find("Zombie") then
				table.insert(tbl52, getDescendant29)
			end
		end
	end

	local zombies = workspace:FindFirstChild("Zombies")

	if zombies then
		for _, value269 in zombies:GetChildren() do
			if value269:IsA("Model") and value269.Name:find("Zombie") then
				table.insert(tbl52, value269)
			end
		end
	end

	for _, value270 in tbl52 do
		local humanoidRootPart = value270:FindFirstChild("HumanoidRootPart") or value270:FindFirstChild("Head") or value270:FindFirstChild("Torso")

		if humanoidRootPart then
			local magnitude = (humanoidRootPart.Position - character).Magnitude
			local value271 = list1.getZombieTypeKey(value270)
			local flag141 = list1.zombieEspEnabled[value271]
			local flag142 = list1.zombieEffects[value270]

			if flag141 and magnitude <= list1.ZOMBIE_ESP_RANGE then
				local flag143 = flag142 ~= nil
				local deleted

				if flag143 then
					deleted = flag142.esp == nil or flag142.esp.Deleted or flag142.typeKey ~= value271
				else
					deleted = flag143
				end

				if deleted then
					list1.removeZombieEffects(value270)
					flag142 = nil
				end

				local flag144

				if flag142 == nil then
					local flag145 = list1.createZombieESP(value270, value271)

					if flag145 == nil then
						flag144 = flag142
					else
						list1.zombieEffects[value270] = { esp = flag145, typeKey = value271 }
						flag144 = list1.zombieEffects[value270]
					end
				else
					flag144 = flag142
				end

				if flag144 ~= nil then
					flag144.esp.CurrentSettings.Name = func5(list1.ZOMBIE_TYPES[value271].name)
				end
			elseif flag142 ~= nil then
				list1.removeZombieEffects(value270)
			end
		end
	end
end

list1.lastZombieESPUpdate = 0
list1.zombieESPHeartbeatConn = nil

list1.startZombieESPHeartbeat = function()
	if list1.zombieESPHeartbeatConn then
		return
	end

	list1.zombieESPHeartbeatConn = obj5.Heartbeat:Connect(function()
		local result29 = clock()

		if result29 - list1.lastZombieESPUpdate >= 0.2 then
			list1.lastZombieESPUpdate = result29
			list1.updateZombieESP()
		end
	end)
end

list1.stopZombieESPHeartbeat = function()
	if list1.zombieESPHeartbeatConn then
		list1.zombieESPHeartbeatConn:Disconnect()
		list1.zombieESPHeartbeatConn = nil
	end

	list1.clearAllZombieEffects()
end

list1.onCharacterAdded(function()
	task.wait(0.5)
	list1.updateZombieESP()
end)

list1.CoordSpeed = { Enabled = false, Speed = 16, Connection = nil }

do
	local function func91()
		if list1.CoordSpeed.Connection then
			return
		end

		list1.CoordSpeed.Connection = obj5.Heartbeat:Connect(function(deltaTime)
			if not list1.CoordSpeed.Enabled then
				return
			end
			local character = localPlayer.Character
			if not character then
				return
			end
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			local humanoid = character:FindFirstChild("Humanoid")
			if not humanoidRootPart or not humanoid then
				return
			end
			local moveDirection = humanoid.MoveDirection

			if moveDirection.Magnitude > 0 then
				humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveDirection.Unit * list1.CoordSpeed.Speed * deltaTime
			end
		end)
	end

	local function func92()
		if list1.CoordSpeed.Connection then
			list1.CoordSpeed.Connection:Disconnect()
			list1.CoordSpeed.Connection = nil
		end
	end

	obj130:AddToggle("CoordSpeedToggle", {
		Text = "启用坐标加速",
		Default = false,
		Tooltip = func6("通过CFrame实现位移"),
		Callback = function(enabled)
			list1.CoordSpeed.Enabled = enabled

			if enabled then
				func91()
			else
				func92()
			end
		end,
	})
end

obj130:AddSlider("CoordSpeedSlider", {
	Text = "坐标加速速度",
	Default = 16,
	Min = 1,
	Max = 150,
	Rounding = 0,
	Suffix = " 速度",
	Callback = function(speed)
		list1.CoordSpeed.Speed = speed
	end,
})

local connection

do
	local flag146 = false
	local n2 = 25
	connection = nil
	local tbl53 = {}

	local function func93(humanoid5, walkSpeed)
		if humanoid5 and humanoid5.Parent then
			pcall(function()
				humanoid5.WalkSpeed = walkSpeed
			end)
		end
	end

	local function func94(obj163)
		return obj163:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if flag146 then
				func93(obj163, n2)
			end
		end)
	end

	local function func95(obj164)
		if not obj164 then
			return
		end
		local humanoid = obj164:FindFirstChildOfClass("Humanoid")

		if humanoid then
			if tbl53[humanoid] then
				tbl53[humanoid]:Disconnect()
			end

			tbl53[humanoid] = func94(humanoid)
			func93(humanoid, n2)
		end
	end

	local function func96()
		if connection then
			return
		end

		connection = obj5.Heartbeat:Connect(function()
			if not flag146 then
				return
			end
			local character = localPlayer.Character

			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					func93(humanoid, n2)

					if not tbl53[humanoid] then
						tbl53[humanoid] = func94(humanoid)
					end
				end
			end
		end)
	end

	local function func97()
		if connection then
			connection:Disconnect()
			connection = nil
		end

		for _, value272 in tbl53 do
			pcall(function()
				value272:Disconnect()
			end)
		end

		tbl53 = {}
		local character = localPlayer.Character

		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				func93(humanoid, 16)
			end
		end
	end

	setWalkSpeedEnabled = function(param72)
		flag146 = param72

		if param72 then
			func96()

			if localPlayer.Character then
				func95(localPlayer.Character)
			end
		else
			func97()
		end
	end

	setWalkSpeedValue = function(param73)
		n2 = clamp(param73, 16, 45)

		if flag146 then
			local character = localPlayer.Character

			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					func93(humanoid, n2)
				end
			end
		end
	end

	list1.onCharacterAdded(function(param74)
		if flag146 then
			task.wait(0.1)
			func95(param74)
		end
	end)
end

obj130:AddToggle("SpeedToggle", {
	Text = "启用速度调整",
	Default = false,
	Callback = function(value)
		setWalkSpeedEnabled(value)
	end,
})

obj130:AddSlider("SpeedSlider", {
	Text = "玩家速度",
	Default = 25,
	Min = 16,
	Max = 45,
	Rounding = 0,
	Suffix = " 速度",
	Callback = function(value)
		setWalkSpeedValue(value)
	end,
})

list1.AutoFace = { Enabled = false, Range = 17, SkipBarrel = false, Connection = nil }

do
	local function func98()
		local character = localPlayer.Character
		if not character then
			return nil
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil
		end
		local zombies = workspace:FindFirstChild("Zombies")
		if not zombies then
			return nil
		end
		local huge = math.huge
		local value273 = nil

		for _, value274 in zombies:GetChildren() do
			if value274:IsA("Model") and value274:FindFirstChild("HumanoidRootPart") then
				if not (list1.AutoFace.SkipBarrel and (value274:GetAttribute("Type") == "Barrel" or value274:FindFirstChild("Barrel"))) then
					local state = value274:FindFirstChild("State")

					if not (state and state.Value == "Spawn") then
						local magnitude = (value274.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude

						if magnitude <= list1.AutoFace.Range and magnitude < huge then
							huge = magnitude
							value273 = value274
						end
					end
				end
			end
		end

		return value273
	end

	local function func99()
		while list1.AutoFace.Enabled do
			local result30 = func98()

			if result30 then
				local character = localPlayer.Character

				if character then
					local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
					local humanoid = character:FindFirstChildOfClass("Humanoid")

					if humanoidRootPart and humanoid then
						local autoRotate = humanoid.AutoRotate
						humanoid.AutoRotate = false
						local position = result30.HumanoidRootPart.Position
						humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, vector(position.X, humanoidRootPart.Position.Y, position.Z))
						humanoid.AutoRotate = autoRotate
					end
				end
			end

			task.wait(0.1)
		end
	end

	obj130:AddSlider("AutoFaceRange", {
		Text = "自动转向范围",
		Default = 17,
		Min = 5,
		Max = 30,
		Rounding = 0,
		Suffix = " 格",
		Callback = function(range)
			list1.AutoFace.Range = range
		end,
	})

	obj130:AddToggle("AutoFaceToggle", {
		Text = "自动转向",
		Default = false,
		Callback = function(enabled)
			list1.AutoFace.Enabled = enabled

			if enabled then
				if list1.AutoFace.Connection then
					task.cancel(list1.AutoFace.Connection)
				end

				list1.AutoFace.Connection = task.spawn(func99)
			elseif list1.AutoFace.Connection then
				task.cancel(list1.AutoFace.Connection)
				list1.AutoFace.Connection = nil
			end
		end,
	})
end

obj130:AddToggle("SkipBarrelToggle", {
	Text = "跳过自爆僵尸",
	Default = false,
	Tooltip = func6("开启后不会转向自爆"),
	Callback = function(skipBarrel)
		list1.AutoFace.SkipBarrel = skipBarrel
	end,
})

list1.GroundJump = { Enabled = false, Power = 60, JumpReqConn = nil }

do
	local function func100()
		if not list1.GroundJump.Enabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

		if humanoid and humanoidRootPart and humanoid.FloorMaterial ~= Enum.Material.Air then
			humanoidRootPart.AssemblyLinearVelocity = vector(humanoidRootPart.AssemblyLinearVelocity.X, list1.GroundJump.Power, humanoidRootPart.Velocity.Z)
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end

	local function func101()
		if list1.GroundJump.Enabled then
			if not list1.GroundJump.JumpReqConn then
				list1.GroundJump.JumpReqConn = obj6.JumpRequest:Connect(func100)
			end
		elseif list1.GroundJump.JumpReqConn then
			list1.GroundJump.JumpReqConn:Disconnect()
			list1.GroundJump.JumpReqConn = nil
		end
	end

	obj130:AddToggle("GroundJumpToggle", {
		Text = "控制玩家跳跃高度",
		Default = false,
		Callback = function(enabled)
			list1.GroundJump.Enabled = enabled
			func101()
		end,
	})
end

obj130:AddSlider("GroundJumpSlider", {
	Text = "跳跃高度",
	Default = 60,
	Min = 30,
	Max = 95,
	Rounding = 0,
	Suffix = " 高度",
	Callback = function(power)
		list1.GroundJump.Power = power
	end,
})

list1.AutoJump = { Enabled = false, Height = 60, Connection = nil }

local function func102()
	if list1.AutoJump.Connection then
		list1.AutoJump.Connection:Disconnect()
	end

	list1.AutoJump.Connection = obj5.Heartbeat:Connect(function()
		if not list1.AutoJump.Enabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

		if humanoid and humanoidRootPart and humanoid.FloorMaterial ~= Enum.Material.Air then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			humanoidRootPart.AssemblyLinearVelocity = vector(humanoidRootPart.AssemblyLinearVelocity.X, list1.AutoJump.Height, humanoidRootPart.Velocity.Z)
		end
	end)
end

obj130:AddToggle("AutoJumpToggle", {
	Text = "自动跳跃",
	Default = false,
	Callback = function(enabled)
		list1.AutoJump.Enabled = enabled

		if enabled then
			func102()
		elseif list1.AutoJump.Connection then
			list1.AutoJump.Connection:Disconnect()
			list1.AutoJump.Connection = nil
		end
	end,
})
-- 𝚂𝙻 | 𝚂𝚘𝚞𝚛𝚌𝚎 𝙻𝚎𝚊𝚔 // discord.gg/x7YbZeezpm

obj130:AddSlider("AutoJumpHeight", {
	Text = "自动跳跃高度",
	Default = 60,
	Min = 30,
	Max = 60,
	Rounding = 0,
	Suffix = " 高度",
	Callback = function(height)
		list1.AutoJump.Height = height
	end,
})

list1.JumpMod = {
	Enabled = false,
	Height = 60,
	Cooldown = 0.6,
	LastJump = 0,
	AntiFallConn = nil,
	JumpReqConn = nil,
}

do
	local function func103()
		if list1.JumpMod.AntiFallConn then
			return
		end

		list1.JumpMod.AntiFallConn = obj5.Heartbeat:Connect(function()
			if not list1.JumpMod.Enabled then
				return
			end
			local character = localPlayer.Character
			if not character then
				return
			end
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoidRootPart or not humanoid then
				return
			end

			if humanoidRootPart.AssemblyLinearVelocity.Y < -5 and not obj6:IsKeyDown(Enum.KeyCode.Space) then
				humanoid:ChangeState(Enum.HumanoidStateType.Climbing)
			end

			local userStates = localPlayer:FindFirstChild("UserStates")

			if userStates then
				local brokenLegs = userStates:FindFirstChild("BrokenLegs")

				if brokenLegs then
					brokenLegs.Value = false
				end
			end
		end)
	end

	local function func104()
		if not list1.JumpMod.Enabled then
			return
		end
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		local flag147 = humanoid and humanoidRootPart

		if flag147 then
			local lastJump = list1.JumpMod.LastJump
			flag147 = clock() - lastJump >= list1.JumpMod.Cooldown
		end

		if flag147 then
			list1.JumpMod.LastJump = clock()
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			humanoidRootPart.AssemblyLinearVelocity = vector(humanoidRootPart.AssemblyLinearVelocity.X, list1.JumpMod.Height, humanoidRootPart.Velocity.Z)
		end
	end

	local function func105()
		if list1.JumpMod.Enabled then
			if not list1.JumpMod.JumpReqConn then
				list1.JumpMod.JumpReqConn = obj6.JumpRequest:Connect(func104)
			end

			func103()
		else
			if list1.JumpMod.JumpReqConn then
				list1.JumpMod.JumpReqConn:Disconnect()
				list1.JumpMod.JumpReqConn = nil
			end

			if list1.JumpMod.AntiFallConn then
				list1.JumpMod.AntiFallConn:Disconnect()
				list1.JumpMod.AntiFallConn = nil
			end

			local character = localPlayer.Character

			if character then
				local animate = character:FindFirstChild("Animate")

				if animate then
					animate.Parent = character
				end
			end
		end
	end

	obj130:AddToggle("JumpModToggle", {
		Text = "无限连跳（含防骨折）",
		Default = false,
		Callback = function(enabled)
			list1.JumpMod.Enabled = enabled
			func105()
		end,
	})
end

obj130:AddSlider("JumpModHeight", {
	Text = "跳跃高度",
	Default = 60,
	Min = 30,
	Max = 90,
	Rounding = 0,
	Suffix = " 高度",
	Callback = function(height)
		list1.JumpMod.Height = height
	end,
})

list1.NoSlow = { Enabled = false, WalkSpeedConn = nil, CharAddedConn = nil }

do
	local function func106()
		local character = localPlayer.Character
		if not character then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.WalkSpeed < 16 then
			humanoid.WalkSpeed = 16
		end
	end

	local value275 = nil

	value275 = function()
		if list1.NoSlow.Enabled then
			local character = localPlayer.Character

			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					if list1.NoSlow.WalkSpeedConn then
						list1.NoSlow.WalkSpeedConn:Disconnect()
					end

					list1.NoSlow.WalkSpeedConn = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(func106)
					func106()
				end
			end

			if not list1.NoSlow.CharAddedConn then
				list1.NoSlow.CharAddedConn = list1.onCharacterAdded(function()
					task.wait(0.5)
					value275()
				end)
			end
		else
			if list1.NoSlow.WalkSpeedConn then
				list1.NoSlow.WalkSpeedConn:Disconnect()
				list1.NoSlow.WalkSpeedConn = nil
			end

			if list1.NoSlow.CharAddedConn then
				list1.NoSlow.CharAddedConn()
				list1.NoSlow.CharAddedConn = nil
			end
		end
	end

	obj130:AddToggle("NoSlowToggle", {
		Text = "无减速",
		Default = false,
		Tooltip = func6("移除减速效果（重生后需重新开启）"),
		Callback = function(enabled)
			list1.NoSlow.Enabled = enabled
			value275()
		end,
	})
end

list1.NoFall = { Enabled = false, Connection = nil }

local function func107()
	while list1.NoFall.Enabled do
		local character = localPlayer.Character

		if character then
			local health = character:FindFirstChild("Health")

			if health then
				local forceSelfDamage = health:FindFirstChild("ForceSelfDamage")

				if forceSelfDamage then
					pcall(function()
						forceSelfDamage:FireServer(0)
					end)
				end
			end
		end

		task.wait(1)
	end
end

obj130:AddToggle("NoFallToggle", {
	Text = "移除摔伤",
	Default = false,
	Tooltip = func6("移除摔落伤害（注意不防骨折）"),
	Callback = function(enabled)
		list1.NoFall.Enabled = enabled

		if enabled then
			if list1.NoFall.Connection then
				task.cancel(list1.NoFall.Connection)
			end

			list1.NoFall.Connection = task.spawn(func107)
		elseif list1.NoFall.Connection then
			task.cancel(list1.NoFall.Connection)
			list1.NoFall.Connection = nil
		end
	end,
})

list1.Backpack = { Enabled = false, ToggleConn = nil }

obj130:AddToggle("BackpackToggle", {
	Text = "显示物品栏",
	Default = false,
	Tooltip = func6("强制显示物品栏"),
	Callback = function(enabled)
		list1.Backpack.Enabled = enabled
		local backpackGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("BackpackGui")

		if enabled then
			backpackGui.Enabled = true

			if list1.Backpack.ToggleConn then
				list1.Backpack.ToggleConn:Disconnect()
			end

			list1.Backpack.ToggleConn = backpackGui:GetPropertyChangedSignal("Enabled"):Connect(function()
				if not backpackGui.Enabled then
					backpackGui.Enabled = true
				end
			end)
		elseif list1.Backpack.ToggleConn then
			list1.Backpack.ToggleConn:Disconnect()
			list1.Backpack.ToggleConn = nil
		end
	end,
})

list1.auraEnabled = false
list1.attackThread = nil
list1.attackCount = 2
list1.displayRange = 17
list1.autoEquipWeaponEnabled = false
list1.attackAngle = 180
list1.showRangeVisuals = false
list1.INNER_RING_FIXED_RADIUS = 13

list1.smartAura = {
	enabled = false,
	auraClosed = false,
	innerEntryKills = {},
	checkInterval = 0.5,
	killTimeout = 2,
	retryInterval = 2,
	retryTimer = 0,
	probeMode = false,
}

list1.attackBarrelEnabled = false
list1.attackDraculaEnabled = false
list1.skipSpawningEnabled = true
list1.currentAttackTargets = {}
list1.indicatorData = {}
list1.indicatorUpdateConn = nil

list1.isHoldingMelee = function()
	local character = localPlayer.Character
	if not character then
		return false
	end

	for _, value276 in character:GetChildren() do
		if value276:IsA("Tool") then
			local obj165 = value276.Name:lower()
			if obj165:find("axe") or obj165:find("pickaxe") or obj165:find("shovel") or obj165:find("spade") or obj165:find("稿") or obj165:find("铲") or obj165:find("镐") then
				return true
			end

			if obj165:find("musket") or obj165:find("flintlock") or obj165:find("bayonet") then
				return true
			end
		end
	end

	return false
end

list1.getNearestNonBarrelZombie = function()
	local character = localPlayer.Character
	if not character then
		return nil
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return nil
	end
	local position = humanoidRootPart.Position
	local displayRange = list1.displayRange
	local zombies = workspace:FindFirstChild("Zombies")
	if not zombies then
		return nil
	end
	local huge = math.huge
	local value277 = nil

	for _, value278 in zombies:GetChildren() do
		if value278:IsA("Model") and value278:FindFirstChild("HumanoidRootPart") then
			if not (value278:GetAttribute("Type") == "Barrel" or value278:FindFirstChild("Barrel")) then
				local state = value278:FindFirstChild("State")

				if not (state and tostring(state.Value) == "Spawn") then
					local magnitude = (value278.HumanoidRootPart.Position - position).Magnitude

					if magnitude <= displayRange and magnitude < huge then
						huge = magnitude
						value277 = value278
					end
				end
			end
		end
	end

	return value277
end

list1.getZombiesInRadius = function(param75)
	local character = localPlayer.Character
	if not character then
		return {}
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return {}
	end
	local position = humanoidRootPart.Position
	local zombies = workspace:FindFirstChild("Zombies")
	if not zombies then
		return {}
	end
	local tbl54 = {}

	for _, value279 in zombies:GetChildren() do
		if value279:IsA("Model") and value279:FindFirstChild("HumanoidRootPart") then
			local state = value279:FindFirstChild("State")

			if not (state and tostring(state.Value) == "Spawn") then
				if (value279.HumanoidRootPart.Position - position).Magnitude <= param75 then
					table.insert(tbl54, value279)
				end
			end
		end
	end

	return tbl54
end

list1.fireMeleeHit = function(obj166, param76, instance42, param77, num53)
	if not obj166 or not instance42 or not instance42.Parent then
		return
	end

	if param76 then
		local orig = instance42:FindFirstChild("Orig")
		orig = orig and orig.Value or instance42
		obj166:FireServer("ThrustBayonet")
		obj166:FireServer("Bayonet_HitZombie", orig, param77, true, "Head", "Down")
		orig:SetAttribute("WepHitID", clock2())
		orig:SetAttribute("WepHitDirection", num53 * 10)
		orig:SetAttribute("WepHitPos", param77)
	else
		obj166:FireServer("Swing", "Thrust")
		obj166:FireServer("PrepareSwing")
		obj166:FireServer("HitZombieM", instance42, param77, true, param77, "Head", num53)
	end
end

list1.sendSingleAttack = function(obj)
	if not obj or not obj.Parent then
		return false
	end
	local character = localPlayer.Character
	if not character then
		return false
	end
	local value280 = nil

	for _, value281 in character:GetChildren() do
		if value281:IsA("Tool") then
			local obj167 = value281.Name:lower()

			if value281:GetAttribute("Melee") or obj167:find("musket") or obj167:find("flintlock") or obj167:find("bayonet") then
				value280 = value281
				break
			else
				value280 = nil
			end
		else
			value280 = nil
		end
	end

	if not value280 then
		return false
	end
	local remoteEvent = value280:FindFirstChild("RemoteEvent")
	if not remoteEvent then
		return false
	end
	local obj168 = value280.Name:lower()
	local pos = obj168:find("musket") or obj168:find("flintlock") or obj168:find("bayonet")
	local head = obj:FindFirstChild("Head")
	if not head then
		return false
	end
	local head2 = character:FindFirstChild("Head")
	local position = head.Position
	local unit = head2 and (position - head2.Position).Unit or Vector3.new(0, 1, 0)

	pcall(function()
		list1.fireMeleeHit(remoteEvent, pos, obj, position, unit)
	end)

	return true
end

list1.getCurrentKills = function()
	local leaderstats = localPlayer:FindFirstChild("leaderstats")

	if leaderstats then
		local kills = leaderstats:FindFirstChild("Kills")
		if kills and (kills:IsA("IntValue") or kills:IsA("NumberValue")) then
			return kills.Value
		end
	end

	return 0
end

list1.updateSmartAura = function()
	if not list1.smartAura.enabled then
		return
	end

	if not list1.isHoldingMelee() then
		if list1.smartAura.auraClosed then
			list1.smartAura.auraClosed = false
			list1.smartAura.probeMode = false
			list1.smartAura.innerEntryKills = {}

			if not list1.auraEnabled then
				list1.startAura()
			end
		end

		return
	end

	local value282 = min(list1.displayRange, list1.INNER_RING_FIXED_RADIUS)
	local value283 = list1.getZombiesInRadius(value282)
	local result31 = clock()
	local value284 = list1.getCurrentKills()

	if not list1.smartAura.auraClosed then
		local tbl55 = {}

		for _, value285 in value283 do
			tbl55[value285] = true

			if not list1.smartAura.innerEntryKills[value285] then
				list1.smartAura.innerEntryKills[value285] = { time = result31, kills = value284 }
			end
		end

		for k in list1.smartAura.innerEntryKills do
			if not tbl55[k] or not k.Parent then
				list1.smartAura.innerEntryKills[k] = nil
			end
		end

		for k, innerEntryKill in list1.smartAura.innerEntryKills do
			if k and k.Parent then
				local humanoid = k:FindFirstChildOfClass("Humanoid")

				if humanoid and humanoid.Health > 0 then
					if list1.smartAura.killTimeout <= result31 - innerEntryKill.time then
						local kills = innerEntryKill.kills

						if list1.getCurrentKills() == kills then
							list1.smartAura.auraClosed = true
							list1.smartAura.probeMode = true
							list1.smartAura.retryTimer = 0
							list1.smartAura.innerEntryKills = {}

							if list1.auraEnabled then
								list1.stopAura()
							end

							break
						else
							list1.smartAura.innerEntryKills[k] = nil
						end
					end
				else
					list1.smartAura.innerEntryKills[k] = nil
				end
			else
				list1.smartAura.innerEntryKills[k] = nil
			end
		end

		return
	end

	if list1.smartAura.probeMode then
		if result31 - list1.smartAura.retryTimer >= list1.smartAura.retryInterval then
			list1.smartAura.retryTimer = result31
			local value286 = list1.getNearestNonBarrelZombie()

			if value286 then
				local flag148 = list1.getCurrentKills()
				list1.sendSingleAttack(value286)
				task.wait(2)

				if flag148 < list1.getCurrentKills() then
					list1.smartAura.auraClosed = false
					list1.smartAura.probeMode = false
					list1.smartAura.innerEntryKills = {}

					if not list1.auraEnabled then
						list1.startAura()
					end
				end
			else
				list1.smartAura.auraClosed = false
				list1.smartAura.probeMode = false

				if not list1.auraEnabled then
					list1.startAura()
				end
			end
		end
	end
end

list1.smartAuraThread = nil

list1.startSmartAuraThread = function()
	if list1.smartAuraThread then
		return
	end

	list1.smartAuraThread = task.spawn(function()
		while list1.smartAura.enabled do
			pcall(list1.updateSmartAura)
			task.wait(list1.smartAura.checkInterval)
		end
	end)
end

list1.stopSmartAuraThread = function()
	if list1.smartAuraThread then
		task.cancel(list1.smartAuraThread)
		list1.smartAuraThread = nil
	end

	list1.smartAura.auraClosed = false
	list1.smartAura.probeMode = false
	list1.smartAura.innerEntryKills = {}
	list1.smartAura.retryTimer = 0
end

list1.attackLoop = function()
	while list1.auraEnabled do
		if list1.smartAura.enabled and list1.smartAura.auraClosed then
			task.wait(0.1)
		else
			local obj169 = list1.getHeldMelee()

			if obj169 then
				local obj170 = obj169.Name:lower()
				local pos = obj170:find("musket") or obj170:find("flintlock") or obj170:find("bayonet")
				local remoteEvent = obj169:FindFirstChild("RemoteEvent")
				local character = localPlayer.Character
				character = character and character:FindFirstChild("Head")
				local list19 = list1.buildAttackTargets()

				if remoteEvent then
					for _, value287 in list19 do
						local zombie = value287.zombie

						if zombie and zombie.Parent then
							local head = zombie:FindFirstChild("Head")

							if head then
								local position = head.Position
								local unit = character and (position - character.Position).Unit or Vector3.new(0, 1, 0)

								pcall(function()
									list1.fireMeleeHit(remoteEvent, pos, zombie, position, unit)
								end)
							end
						end
					end
				end

				if #list19 > 0 then
					local currentAttackTargets = {}

					for _, value288 in list19 do
						table.insert(currentAttackTargets, value288.zombie)
					end

					list1.currentAttackTargets = currentAttackTargets
				else
					list1.currentAttackTargets = {}
				end
			else
				list1.currentAttackTargets = {}
			end

			task.wait(0.05)
		end
	end
end

list1.startAura = function()
	if list1.auraEnabled then
		return
	end
	list1.auraEnabled = true

	if list1.attackThread then
		task.cancel(list1.attackThread)
	end

	list1.attackThread = task.spawn(list1.attackLoop)
end

list1.stopAura = function()
	list1.auraEnabled = false

	if list1.attackThread then
		task.cancel(list1.attackThread)
		list1.attackThread = nil
	end

	list1.currentAttackTargets = {}
end

list1.rangeVisuals = {
	outerRingParts = {},
	outerRingBeams = {},
	innerRingParts = {},
	innerRingBeams = {},
	rayParts = {},
	rayEndParts = {},
	active = false,
	updateConn = nil,
	folder = nil,
	charAddedConn = nil,
	time = 0,
}

list1.clearRangeVisuals = function()
	if list1.rangeVisuals.folder then
		list1.rangeVisuals.folder:Destroy()
		list1.rangeVisuals.folder = nil
	end

	list1.rangeVisuals.outerRingParts = {}
	list1.rangeVisuals.outerRingBeams = {}
	list1.rangeVisuals.innerRingParts = {}
	list1.rangeVisuals.innerRingBeams = {}
	list1.rangeVisuals.rayParts = {}
	list1.rangeVisuals.rayEndParts = {}
	list1.rangeVisuals.lastOuterColor = nil
	list1.rangeVisuals.lastInnerColor = nil
	list1.rangeVisuals.lastRayColor = nil
	list1.rangeVisuals.lastShowRays = nil
	list1.rangeVisuals.innerBeamsEnabled = nil

	if list1.rangeVisuals.meleeCheckConn then
		list1.rangeVisuals.meleeCheckConn:Disconnect()
		list1.rangeVisuals.meleeCheckConn = nil
	end

	if list1.rangeVisuals.ancestryConn then
		list1.rangeVisuals.ancestryConn:Disconnect()
		list1.rangeVisuals.ancestryConn = nil
	end

	list1.rangeVisuals.cachedHoldingMelee = nil
end

list1.createRangeVisuals = function()
	list1.clearRangeVisuals()
	local folder = Instance.new("Folder")
	folder.Name = "KillAuraRangeVisuals"
	folder.Parent = workspace
	local outerRingParts = {}

	for i = 1, 24 do
		local part = Instance.new("Part")
		part.Size = Vector3.new(0.7, 0.7, 0.7)
		part.Shape = Enum.PartType.Ball
		part.Material = Enum.Material.Neon
		part.Anchored = true
		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = false
		part.Transparency = 0.1
		part.Color = color(0, 255, 100)
		part.Parent = folder
		table.insert(outerRingParts, part)
	end

	local outerRingBeams = {}

	for i = 1, 24 do
		local attachment = Instance.new("Attachment")
		attachment.Parent = outerRingParts[i]
		local attachment2 = Instance.new("Attachment")
		attachment2.Parent = outerRingParts[i % 24 + 1]
		local beam = Instance.new("Beam")
		beam.Attachment0 = attachment
		beam.Attachment1 = attachment2
		beam.Color = ColorSequence.new(color(0, 255, 100))
		beam.Width0 = 0.15
		beam.Width1 = 0.15
		beam.FaceCamera = true
		beam.Parent = folder
		table.insert(outerRingBeams, { beam = beam, att0 = attachment, att1 = attachment2 })
	end

	local innerRingParts = {}

	for i = 1, 12 do
		local part = Instance.new("Part")
		part.Size = Vector3.new(0.5, 0.5, 0.5)
		part.Shape = Enum.PartType.Ball
		part.Material = Enum.Material.Neon
		part.Anchored = true
		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = false
		part.Transparency = 0.2
		part.Color = color(0, 255, 100)
		part.Parent = folder
		table.insert(innerRingParts, part)
	end

	local innerRingBeams = {}

	for i = 1, 12 do
		local attachment = Instance.new("Attachment")
		attachment.Parent = innerRingParts[i]
		local attachment2 = Instance.new("Attachment")
		attachment2.Parent = innerRingParts[i % 12 + 1]
		local beam = Instance.new("Beam")
		beam.Attachment0 = attachment
		beam.Attachment1 = attachment2
		beam.Color = ColorSequence.new(color(0, 255, 100))
		beam.Width0 = 0.1
		beam.Width1 = 0.1
		beam.FaceCamera = true
		beam.Parent = folder
		table.insert(innerRingBeams, { beam = beam, att0 = attachment, att1 = attachment2 })
	end

	local rayParts = {}
	local rayEndParts = {}

	for i = 1, 2 do
		local attachment = Instance.new("Attachment")
		attachment.Parent = folder
		local attachment2 = Instance.new("Attachment")
		attachment2.Parent = folder
		local beam = Instance.new("Beam")
		beam.Attachment0 = attachment
		beam.Attachment1 = attachment2
		beam.Color = ColorSequence.new(color(0, 255, 100))
		beam.Width0 = 0.25
		beam.Width1 = 0.15
		beam.FaceCamera = true
		beam.Parent = folder
		table.insert(rayParts, { start = attachment, finish = attachment2, beam = beam })
		local part = Instance.new("Part")
		part.Size = Vector3.new(0.5, 0.5, 0.5)
		part.Shape = Enum.PartType.Ball
		part.Material = Enum.Material.Neon
		part.Anchored = true
		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = false
		part.Transparency = 0.15
		part.Color = color(0, 255, 100)
		part.Parent = folder
		table.insert(rayEndParts, part)
	end

	list1.rangeVisuals.folder = folder
	list1.rangeVisuals.outerRingParts = outerRingParts
	list1.rangeVisuals.outerRingBeams = outerRingBeams
	list1.rangeVisuals.innerRingParts = innerRingParts
	list1.rangeVisuals.innerRingBeams = innerRingBeams
	list1.rangeVisuals.rayParts = rayParts
	list1.rangeVisuals.rayEndParts = rayEndParts
end

local function func108(num54, obj171, param78, num55)
	local n2 = num55 / 2
	local zombies = workspace:FindFirstChild("Zombies")

	if zombies then
		for _, value289 in zombies:GetChildren() do
			if value289:IsA("Model") and value289:FindFirstChild("HumanoidRootPart") then
				local position = value289.HumanoidRootPart.Position
				if not ((position - num54).Magnitude <= param78) then
					continue
				end
				-- deobfuscated by 𝖲𝗈𝗎𝗋𝖼𝖾 𝖫𝖾𝖺𝗄 (𝖲𝖫) -> https://discord.gg/x7YbZeezpm

				if num55 >= 360 then
					return true
				end

				if math.deg(math.acos(clamp(obj171:Dot((position - num54).Unit), -1, 1))) <= n2 then
					return true
				end
			end
		end
	end

	if list1.attackDraculaEnabled then
		local transylvania = func4(workspace, "Transylvania", "Modes", "Boss", "Dracula")

		if transylvania and transylvania:FindFirstChild("HumanoidRootPart") then
			local position = transylvania.HumanoidRootPart.Position

			if (position - num54).Magnitude <= param78 then
				if num55 >= 360 then
					return true
				end

				if math.deg(math.acos(clamp(obj171:Dot((position - num54).Unit), -1, 1))) <= n2 then
					return true
				end
			end
		end
	end

	return false
end

list1.updateRangeVisuals = function()
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end
	local position = humanoidRootPart.Position
	local lookVector = humanoidRootPart.CFrame.LookVector
	local attackAngle = list1.attackAngle
	local n2 = attackAngle / 2
	local displayRange = list1.displayRange
	local innerRingFixedRadius = list1.INNER_RING_FIXED_RADIUS
	list1.rangeVisuals.time = (list1.rangeVisuals.time or 0) + 0.016
	local time_ = list1.rangeVisuals.time
	local cachedHoldingMelee = list1.rangeVisuals.cachedHoldingMelee

	if cachedHoldingMelee == nil then
		cachedHoldingMelee = list1.isHoldingMelee()
		list1.rangeVisuals.cachedHoldingMelee = cachedHoldingMelee
	end

	cachedHoldingMelee = displayRange > innerRingFixedRadius and cachedHoldingMelee
	local transparency = func108(position, lookVector, displayRange, attackAngle)
	local transparency2 = false

	if cachedHoldingMelee then
		transparency2 = func108(position, lookVector, innerRingFixedRadius, attackAngle)
	end

	local value290 = transparency and color(255, 50, 50) or color(0, 255, 100)
	local flag149 = transparency2 and color(255, 50, 50) or color(0, 255, 100)
	local n3 = math.sin(time_ * 1) * 0.3
	local n4 = time_ * 0.3
	local n5 = time_ * 0.6 + 0.8
	local outerRingParts = list1.rangeVisuals.outerRingParts
	local n6 = #outerRingParts
	transparency = transparency and 0.08 or 0.15

	for i = 1, n6 do
		local n7 = i / n6 * 2 * 3.1415926535897931 + n4
		local sin = math.sin
		local n8 = position + vector(math.cos(n7), 0, sin(n7)) * displayRange
		outerRingParts[i].Position = vector(n8.X, position.Y + n3, n8.Z)
		outerRingParts[i].Color = value290
		outerRingParts[i].Transparency = transparency
	end

	if list1.rangeVisuals.lastOuterColor ~= value290 then
		list1.rangeVisuals.lastOuterColor = value290
		local colorSequence = ColorSequence.new(value290)

		for _, outerRingBeam in list1.rangeVisuals.outerRingBeams do
			outerRingBeam.beam.Color = colorSequence
		end
	end

	local innerRingParts = list1.rangeVisuals.innerRingParts
	local n7 = #innerRingParts
	local n8 = math.sin(time_ * 1 + 1.2) * 0.3

	if cachedHoldingMelee then
		transparency2 = transparency2 and 0.12 or 0.25

		for i = 1, n7 do
			local n9 = i / n7 * 2 * 3.1415926535897931 + n5
			local sin = math.sin
			local n10 = position + vector(math.cos(n9), 0, sin(n9)) * innerRingFixedRadius
			innerRingParts[i].Position = vector(n10.X, position.Y + n8, n10.Z)
			innerRingParts[i].Color = flag149
			innerRingParts[i].Transparency = transparency2
		end

		if list1.rangeVisuals.lastInnerColor ~= flag149 or not list1.rangeVisuals.innerBeamsEnabled then
			list1.rangeVisuals.lastInnerColor = flag149
			list1.rangeVisuals.innerBeamsEnabled = true
			local colorSequence = ColorSequence.new(flag149)

			for _, innerRingBeam in list1.rangeVisuals.innerRingBeams do
				innerRingBeam.beam.Color = colorSequence
				innerRingBeam.beam.Enabled = true
			end
		end
	elseif list1.rangeVisuals.innerBeamsEnabled ~= false then
		list1.rangeVisuals.innerBeamsEnabled = false
		list1.rangeVisuals.lastInnerColor = nil

		for i = 1, n7 do
			innerRingParts[i].Color = color(0, 0, 0)
			innerRingParts[i].Transparency = 1
		end

		for _, innerRingBeam2 in list1.rangeVisuals.innerRingBeams do
			innerRingBeam2.beam.Enabled = false
		end
	end

	local lastShowRays = attackAngle < 360

	if lastShowRays ~= list1.rangeVisuals.lastShowRays then
		list1.rangeVisuals.lastShowRays = lastShowRays

		if not lastShowRays then
			for k, rayPart in list1.rangeVisuals.rayParts do
				rayPart.beam.Enabled = false

				if list1.rangeVisuals.rayEndParts[k] then
					list1.rangeVisuals.rayEndParts[k].Transparency = 1
				end
			end
		end
	end

	if lastShowRays then
		for k, rayPart2 in list1.rangeVisuals.rayParts do
			local n9 = k == 1 and -n2 or n2
			local cframe2 = CFrame.Angles
			local n10 = position + (cframe(Vector3.zero, lookVector) * cframe2(0, rad(n9), 0)).LookVector * displayRange
			local x4 = vector(n10.X, position.Y, n10.Z)
			rayPart2.start.Position = vector(position.X, position.Y, position.Z)
			rayPart2.finish.Position = x4
			rayPart2.beam.Enabled = true

			if list1.rangeVisuals.rayEndParts[k] then
				local value291 = list1.rangeVisuals.rayEndParts[k]
				value291.Position = x4
				value291.Transparency = 0.15
			end
		end

		if list1.rangeVisuals.lastOuterColor ~= list1.rangeVisuals.lastRayColor then
			list1.rangeVisuals.lastRayColor = value290
			local colorSequence = ColorSequence.new(value290)

			for k, rayPart3 in list1.rangeVisuals.rayParts do
				rayPart3.beam.Color = colorSequence

				if list1.rangeVisuals.rayEndParts[k] then
					list1.rangeVisuals.rayEndParts[k].Color = value290
				end
			end
		end
	end
end

list1.startRangeVisuals = function()
	if list1.rangeVisuals.active then
		return
	end
	list1.rangeVisuals.active = true
	list1.rangeVisuals.time = 0
	list1.createRangeVisuals()

	if list1.rangeVisuals.updateConn then
		list1.rangeVisuals.updateConn:Disconnect()
	end

	list1.rangeVisuals.updateConn = obj5.RenderStepped:Connect(function()
		local active = list1.rangeVisuals.active
		local showRangeVisuals

		if active then
			showRangeVisuals = list1.showRangeVisuals or false
		else
			showRangeVisuals = active
		end

		if showRangeVisuals then
			list1.updateRangeVisuals()
		end
	end)

	if list1.rangeVisuals.charAddedConn then
		list1.rangeVisuals.charAddedConn:Disconnect()
	end

	local value292 = localPlayer

	local function func109(param79)
		if list1.rangeVisuals.meleeCheckConn then
			list1.rangeVisuals.meleeCheckConn:Disconnect()
			list1.rangeVisuals.meleeCheckConn = nil
		end

		list1.rangeVisuals.cachedHoldingMelee = list1.isHoldingMelee()

		local connection2 = param79.ChildAdded:Connect(function()
			list1.rangeVisuals.cachedHoldingMelee = nil
		end)

		local connection3 = param79.ChildRemoved:Connect(function()
			list1.rangeVisuals.cachedHoldingMelee = nil
		end)

		list1.rangeVisuals.meleeCheckConn = { Disconnect = function()
			connection2:Disconnect()
			connection3:Disconnect()
		end }
	end

	if value292.Character then
		func109(value292.Character)
	end

	list1.rangeVisuals.charAddedConn = list1.onCharacterAdded(function(param80)
		task.wait(0.2)

		if list1.rangeVisuals.active then
			list1.createRangeVisuals()
			func109(param80)
		end
	end)

	if list1.rangeVisuals.ancestryConn then
		list1.rangeVisuals.ancestryConn:Disconnect()
		list1.rangeVisuals.ancestryConn = nil
	end

	local function func110()
		list1.clearRangeVisuals()
	end

	if value292.Character then
		list1.rangeVisuals.ancestryConn = value292.Character.AncestryChanged:Connect(function(child, parent)
			if not parent then
				func110()
			end
		end)
	end
end

list1.stopRangeVisuals = function()
	list1.rangeVisuals.active = false

	if list1.rangeVisuals.updateConn then
		list1.rangeVisuals.updateConn:Disconnect()
		list1.rangeVisuals.updateConn = nil
	end

	if list1.rangeVisuals.charAddedConn then
		list1.rangeVisuals.charAddedConn()
		list1.rangeVisuals.charAddedConn = nil
	end

	list1.clearRangeVisuals()
end

list1.createIndicator = function(parent)
	if not parent or not parent.Parent then
		return nil
	end
	local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChild("Torso")
	if not humanoidRootPart then
		return nil
	end
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "AttackTargetIndicator"
	billboardGui.Size = UDim2.new(0, 100, 0, 100)
	billboardGui.StudsOffset = Vector3.zero
	billboardGui.AlwaysOnTop = true
	billboardGui.Adornee = humanoidRootPart
	billboardGui.Parent = parent
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.Parent = billboardGui
	local frame2 = Instance.new("Frame")
	frame2.Size = UDim2.new(1, 0, 1, 0)
	frame2.BackgroundTransparency = 1
	frame2.Parent = frame
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Thickness = 2
	uiStroke.Color = color(255, 255, 255)
	uiStroke.Transparency = 0.6
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke.Parent = frame2
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(1, 0)
	uiCorner.Parent = frame2
	local frame3 = Instance.new("Frame")
	frame3.Size = UDim2.new(0, 1.5, 0, 45)
	frame3.BackgroundColor3 = color(255, 255, 255)
	frame3.BackgroundTransparency = 0.7
	frame3.Position = UDim2.new(0.5, -0.75, 0.5, -22.5)
	frame3.Parent = frame
	local uiGradient = Instance.new("UIGradient")
	local new = NumberSequenceKeypoint.new
	uiGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), new(1, 0.2) })
	uiGradient.Rotation = 90
	uiGradient.Parent = frame3
	local uiCorner2 = Instance.new("UICorner")
	uiCorner2.CornerRadius = UDim.new(0, 2)
	uiCorner2.Parent = frame3
	local frame4 = Instance.new("Frame")
	frame4.Size = UDim2.new(0.7, 0, 0.7, 0)
	frame4.BackgroundTransparency = 1
	frame4.Parent = frame
	frame4.Position = UDim2.new(0.15, 0, 0.15, 0)
	local uiStroke2 = Instance.new("UIStroke")
	uiStroke2.Thickness = 1.5
	uiStroke2.Color = color(255, 215, 0)
	uiStroke2.Transparency = 0.6
	uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke2.Parent = frame4
	local uiCorner3 = Instance.new("UICorner")
	uiCorner3.CornerRadius = UDim.new(1, 0)
	uiCorner3.Parent = frame4
	local n2 = 6
	local n3 = 0.45

	local function createFrame(parent2, num56, num57, rotation)
		local frame5 = Instance.new("Frame")
		frame5.Size = UDim2.new(0, 6, 0, 6)
		frame5.BackgroundTransparency = 1
		frame5.Position = UDim2.new(0.5 + num56 * n3, -n2 / 2, 0.5 + num57 * n3, -n2 / 2)
		frame5.Rotation = rotation
		frame5.Parent = parent2
		local frame6 = Instance.new("Frame")
		frame6.Size = UDim2.new(1, 0, 0, 1.5)
		frame6.BackgroundColor3 = color(255, 255, 255)
		frame6.BackgroundTransparency = 0.3
		frame6.Position = UDim2.new(0, 0, 0, 0)
		frame6.Parent = frame5
		local frame7 = Instance.new("Frame")
		frame7.Size = UDim2.new(0, 1.5, 1, 0)
		frame7.BackgroundColor3 = color(255, 255, 255)
		frame7.BackgroundTransparency = 0.3
		frame7.Position = UDim2.new(0, 0, 0, 0)
		frame7.Parent = frame5
		return frame5
	end

	local tbl56 = {}

	for _, value293 in { { -1, -1, 0 }, { 1, -1, 90 }, { -1, 1, -90 }, { 1, 1, 180 } }, nil, nil do
		local frame8 = createFrame(frame, value293[1], value293[2], value293[3])
		table.insert(tbl56, frame8)
	end

	local frame5 = Instance.new("Frame")
	frame5.Size = UDim2.new(0, 10, 0, 10)
	frame5.BackgroundTransparency = 1
	frame5.Position = UDim2.new(0.5, -5, 0.5, -5)
	frame5.Parent = frame
	local frame6 = Instance.new("Frame")
	frame6.Size = UDim2.new(1, 0, 0, 1.5)
	frame6.BackgroundColor3 = color(255, 255, 255)
	frame6.BackgroundTransparency = 0.4
	frame6.Position = UDim2.new(0, 0, 0.5, -0.75)
	frame6.Parent = frame5
	local frame7 = Instance.new("Frame")
	frame7.Size = UDim2.new(0, 1.5, 1, 0)
	frame7.BackgroundColor3 = color(255, 255, 255)
	frame7.BackgroundTransparency = 0.4
	frame7.Position = UDim2.new(0.5, -0.75, 0, 0)
	frame7.Parent = frame5

	return {
		gui = billboardGui,
		container = frame,
		outerFrame = frame2,
		outerStroke = uiStroke,
		innerFrame = frame4,
		innerStroke = uiStroke2,
		scanLine = frame3,
		corners = tbl56,
		crossGroup = frame5,
		currentAlpha = 0.8,
		targetAlpha = 0,
		currentSize = 100,
		targetSize = 50,
		normalSize = 50,
		state = "fadein",
	}
end

list1.startIndicatorUpdater = function()
	if list1.indicatorUpdateConn then
		return
	end

	list1.indicatorUpdateConn = obj5.RenderStepped:Connect(function(deltaTime)
		local currentAttackTargets = list1.currentAttackTargets or {}
		local indicatorData = list1.indicatorData
		local tbl57 = {}

		for _, currentAttackTarget in currentAttackTargets do
			if currentAttackTarget and currentAttackTarget.Parent then
				tbl57[currentAttackTarget] = true
			end
		end

		for k, value294 in indicatorData do
			if not k.Parent or not tbl57[k] then
				if value294.state ~= "fadeout" then
					value294.state = "fadeout"
					value294.targetAlpha = 0.8
					value294.targetSize = value294.normalSize * 2
				end
			elseif value294.state == "fadeout" then
				value294.state = "active"
				value294.targetAlpha = 0
				value294.targetSize = value294.normalSize
			elseif value294.state == "fadein" and value294.currentAlpha <= 0.02 and abs(value294.currentSize - value294.normalSize) < 0.5 then
				value294.state = "active"
			else
				value294.state = "active"
				value294.targetAlpha = 0
				value294.targetSize = value294.normalSize
			end

			if value294.state == "active" then
				value294.targetSize = value294.normalSize + math.sin(clock() * 2.5) * 1.5

				if value294.scanLine then
					value294.scanLine.Rotation = (value294.scanLine.Rotation or 0) + deltaTime * 120
				end

				value294.innerFrame.Rotation = (value294.innerFrame.Rotation or 0) + deltaTime * 80
				value294.innerStroke.Color = Color3.fromHSV(clock() % 3 / 3, 1, 1)
				value294.outerStroke.Transparency = math.sin(clock() * 2) * 0.3 + 0.6
				local backgroundTransparency = math.sin(clock() * 1.8 + 1) * 0.3 + 0.5

				for _, corner3 in value294.corners do
					for _, value295 in corner3:GetChildren() do
						if value295:IsA("Frame") then
							value295.BackgroundTransparency = backgroundTransparency
						end
					end
				end

				local backgroundTransparency2 = math.sin(clock() * 2.2 + 0.5) * 0.2 + 0.4

				if value294.crossGroup then
					for _, value296 in value294.crossGroup:GetChildren() do
						if value296:IsA("Frame") then
							value296.BackgroundTransparency = backgroundTransparency2
						end
					end
				end

				if value294.scanLine then
					value294.scanLine.BackgroundTransparency = math.sin(clock() * 4) * 0.2 + 0.6
				end
			elseif value294.state == "fadein" or value294.state == "fadeout" then
				value294.innerStroke.Color = color(255, 215, 0)
				value294.outerStroke.Transparency = 0.8

				if value294.scanLine then
					value294.scanLine.Rotation = 0
					value294.scanLine.BackgroundTransparency = 0.7
				end

				for _, corner4 in value294.corners do
					for _, value297 in corner4:GetChildren() do
						if value297:IsA("Frame") then
							value297.BackgroundTransparency = 0.3
						end
					end
				end

				if value294.crossGroup then
					for _, value298 in value294.crossGroup:GetChildren() do
						if value298:IsA("Frame") then
							value298.BackgroundTransparency = 0.4
						end
					end
				end
			end

			if value294.currentAlpha < value294.targetAlpha then
				value294.currentAlpha = min(value294.currentAlpha + 3 * deltaTime, value294.targetAlpha)
			elseif value294.targetAlpha < value294.currentAlpha then
				value294.currentAlpha = max(value294.currentAlpha - 3 * deltaTime, value294.targetAlpha)
			end

			if value294.currentSize < value294.targetSize then
				value294.currentSize = min(value294.currentSize + 180 * deltaTime, value294.targetSize)
			elseif value294.targetSize < value294.currentSize then
				value294.currentSize = max(value294.currentSize - 180 * deltaTime, value294.targetSize)
			end

			if value294.gui and value294.gui.Parent then
				local value299 = max(value294.currentSize, 1)
				value294.gui.Size = UDim2.new(0, value299, 0, value299)
			end

			if value294.state == "fadeout" and value294.currentAlpha >= 0.78 and value294.currentSize >= value294.normalSize * 1.9 then
				if value294.gui and value294.gui.Parent then
					value294.gui:Destroy()
				end

				indicatorData[k] = nil
			end
		end

		for _, currentAttackTarget2 in currentAttackTargets do
			if currentAttackTarget2 and currentAttackTarget2.Parent and not indicatorData[currentAttackTarget2] then
				local createIndicat = list1.createIndicator(currentAttackTarget2)

				if createIndicat then
					indicatorData[currentAttackTarget2] = createIndicat
				end
			end
		end
	end)
end

list1.stopIndicatorUpdater = function()
	if list1.indicatorUpdateConn then
		list1.indicatorUpdateConn:Disconnect()
		list1.indicatorUpdateConn = nil
	end

	for _, value300 in list1.indicatorData do
		if value300.gui and value300.gui.Parent then
			value300.gui:Destroy()
		end
	end

	list1.indicatorData = {}
	list1.currentAttackTargets = {}
end

do
	local function func111()
		return list1.displayRange
	end

	local function func112()
		local character = localPlayer.Character
		if not character then
			return false
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return false
		end
		local zombies = workspace:FindFirstChild("Zombies")
		if not zombies then
			return false
		end
		local position = humanoidRootPart.Position

		for _, value301 in zombies:GetChildren() do
			if value301:IsA("Model") and value301:FindFirstChild("HumanoidRootPart") then
				if (value301.HumanoidRootPart.Position - position).Magnitude <= 20 then
					return true
				end
			end
		end

		return false
	end

	list1.getHeldMelee = function()
		local character = localPlayer.Character
		if not character then
			return nil
		end

		for _, value302 in character:GetChildren() do
			if value302:IsA("Tool") then
				local obj172 = value302.Name:lower()
				if value302:GetAttribute("Melee") or obj172:find("musket") or obj172:find("flintlock") or obj172:find("bayonet") then
					return value302
				end
			end
		end

		if list1.autoEquipWeaponEnabled and func112() then
			local backpack = localPlayer:FindFirstChild("Backpack")

			if backpack then
				for _, value303 in backpack:GetChildren() do
					if value303:IsA("Tool") then
						local obj173 = value303.Name:lower()

						if value303:GetAttribute("Melee") or obj173:find("musket") or obj173:find("flintlock") or obj173:find("bayonet") then
							value303.Parent = character
							task.wait(0.05)
							return value303
						end
					end
				end
			end
		end

		return nil
	end

	local function func113(instance43)
		local flag150 = instance43:GetAttribute("Type") == "Barrel" or instance43:FindFirstChild("Barrel") ~= nil
		return list1.attackBarrelEnabled or not flag150
	end

	local function func114(part8, num58)
		if list1.attackAngle >= 360 then
			return true
		end
		local unit = (num58 - part8.Position).Unit
		local lookVector = part8.CFrame.LookVector
		local n2 = list1.attackAngle / 2
		return math.deg(math.acos(clamp(lookVector:Dot(unit), -1, 1))) <= n2
	end

	list1.buildAttackTargets = function()
		local character = localPlayer.Character
		if not character then
			return {}
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return {}
		end
		local result32 = func111()
		local tbl58 = {}
		local tbl59 = {}
		local zombies = workspace:FindFirstChild("Zombies")
		if not zombies then
			return {}
		end

		for _, value304 in zombies:GetChildren() do
			if value304:IsA("Model") and value304:FindFirstChild("HumanoidRootPart") then
				if list1.skipSpawningEnabled then
					local state = value304:FindFirstChild("State")
					if state and tostring(state.Value) == "Spawn" then
						continue
					end
				end

				local flag151 = value304:GetAttribute("Type") == "Barrel" or value304:FindFirstChild("Barrel") ~= nil

				if not (not list1.attackBarrelEnabled and flag151) then
					local position = value304.HumanoidRootPart.Position
					local magnitude = (position - humanoidRootPart.Position).Magnitude

					if magnitude <= result32 and func114(humanoidRootPart, position) then
						local tbl60 = { zombie = value304, dist = magnitude }

						if flag151 then
							table.insert(tbl58, tbl60)
						else
							table.insert(tbl59, tbl60)
						end
					end
				end
			end
		end

		table.sort(tbl58, function(param81, param82)
			return param81.dist < param82.dist
		end)

		table.sort(tbl59, function(param83, param84)
			return param83.dist < param84.dist
		end)

		local tbl61 = {}
		local attackCount = list1.attackCount or 2

		if attackCount >= 2 and #tbl58 > 0 and list1.attackBarrelEnabled then
			table.insert(tbl61, tbl58[1])

			for i = 1, min(#tbl59, attackCount - 1) do
				table.insert(tbl61, tbl59[i])
			end
		else
			local list20

			if list1.attackBarrelEnabled then
				list20 = {}

				for _, value305 in tbl58 do
					table.insert(list20, value305)
				end

				for _, value306 in tbl59 do
					table.insert(list20, value306)
				end

				table.sort(list20, function(param85, param86)
					return param85.dist < param86.dist
				end)
			else
				list20 = tbl59
			end

			for i = 1, min(#list20, attackCount) do
				table.insert(tbl61, list20[i])
			end
		end

		if list1.attackDraculaEnabled then
			local transylvania = func4(workspace, "Transylvania", "Modes", "Boss", "Dracula")

			if transylvania then
				local humanoidRootPart2 = transylvania:FindFirstChild("HumanoidRootPart")
				local head = transylvania:FindFirstChild("Head")

				if humanoidRootPart2 and head then
					local position = humanoidRootPart2.Position
					local magnitude = (position - humanoidRootPart.Position).Magnitude

					if magnitude <= result32 and func114(humanoidRootPart, position) then
						table.insert(tbl61, { zombie = transylvania, dist = magnitude })
					end
				end
			end
		end

		return tbl61
	end

	local obj174 = tbl2.Main:AddRightTabbox()
	local obj175 = obj174:AddTab("目标选择")
	local obj176 = obj174:AddTab("攻击设置")
	local obj177 = obj174:AddTab("命中特效")

	obj175:AddToggle("AttackBarrelToggle", {
		Text = "攻击自爆",
		Default = false,
		Tooltip = func6("开启后杀戮光环会攻击自爆僵尸"),
		Callback = function(attackBarrelEnabled)
			list1.attackBarrelEnabled = attackBarrelEnabled
		end,
	})

	obj175:AddToggle("AttackDraculaToggle", {
		Text = "攻击德古拉",
		Default = false,
		Tooltip = func6("开启后杀戮光环会同时攻击德古拉Boss"),
		Callback = function(attackDraculaEnabled)
			list1.attackDraculaEnabled = attackDraculaEnabled
		end,
	})

	obj175:AddToggle("SkipSpawningToggle", {
		Text = "跳过正在生成的僵尸",
		Default = true,
		Tooltip = func6("开启后不会攻击正在生成的僵尸（减少误判）"),
		Callback = function(skipSpawningEnabled)
			list1.skipSpawningEnabled = skipSpawningEnabled
		end,
	})

	obj175:AddToggle("ShowRangeToggle", {
		Text = "显示攻击范围",
		Default = false,
		Callback = function(showRangeVisuals)
			list1.showRangeVisuals = showRangeVisuals

			if showRangeVisuals then
				list1.startRangeVisuals()
			else
				list1.stopRangeVisuals()
			end
		end,
	})

	obj175:AddToggle("SmartAuraToggle", {
		Text = "智能光环（卡伤检测）",
		Default = false,
		Tooltip = func6("检测内环僵尸2秒未击杀则自动关闭光环，探测击杀后自动恢复（仅手持斧头/稿子/战壕铲生效）"),
		Callback = function(enabled)
			list1.smartAura.enabled = enabled

			if enabled then
				list1.startSmartAuraThread()
			else
				list1.stopSmartAuraThread()

				if list1.smartAura.auraClosed then
					list1.smartAura.auraClosed = false
					list1.smartAura.probeMode = false

					if not list1.auraEnabled then
						list1.startAura()
					end
				end
			end
		end,
	})

	obj175:AddToggle("AutoEquipToggle", {
		Text = "自动装备武器",
		Default = false,
		Tooltip = func6("靠近设定范围自动装备武器"),
		Callback = function(autoEquipWeaponEnabled)
			list1.autoEquipWeaponEnabled = autoEquipWeaponEnabled
		end,
	})

	obj176:AddSlider("AuraRange", {
		Text = "攻击距离",
		Default = 35,
		Min = 10,
		Max = 35,
		Rounding = 0,
		Suffix = " 格",
		Callback = function(value)
			local displayRange = floor(value * 0.5 + 0.5)

			if displayRange < 10 then
				displayRange = 10
			end

			if displayRange > 35 then
				displayRange = 35
			end

			list1.displayRange = displayRange
		end,
	})

	obj176:AddSlider("AuraAngle", {
		Text = "攻击角度",
		Default = 180,
		Min = 50,
		Max = 360,
		Rounding = 0,
		Suffix = "°",
		Callback = function(attackAngle)
			list1.attackAngle = attackAngle
		end,
	})

	obj176:AddSlider("AuraCount", {
		Text = "攻击数量",
		Default = 2,
		Min = 1,
		Max = 5,
		Rounding = 0,
		Suffix = " 个",
		Callback = function(attackCount)
			list1.attackCount = attackCount
		end,
	})

	list1.headshotEnabled = false
	list1.removeBloodEnabled = false
	list1.hookInstalled = false
	list1.originalBayonetHitCheck = nil
	list1.originalMeleeHitCheck = nil
	list1.lastZombieHitTime = {}
	list1.ZOMBIE_HIT_COOLDOWN = 0.1

	local function func115(instance44)
		if not instance44 then
			return nil
		end
		local parent = instance44.Parent

		for i = 1, 5 do
			if not parent then
				break
			end

			if parent:IsA("Model") and (parent.Name == "m_Zombie" or parent:FindFirstChild("Orig")) then
				return parent
			end
			parent = parent.Parent
		end

		return nil
	end

	local function func116(instance45)
		if not instance45 then
			return nil
		end

		for _, value307 in instance45:GetChildren() do
			if value307.Name == "Head" and (value307:IsA("Part") or value307:IsA("MeshPart")) then
				return value307
			end
		end

		return nil
	end

	list1.unifiedBayonetHitCheck = function(obj, param87, num59, param88, param89)
		local hit = workspace:Raycast(param87, num59, type(param88) == "table" and param88.ray or param88)

		if hit then
			local instance = hit.Instance
			local obj178 = func115(instance)

			if obj178 then
				local result33 = clock()
				if list1.lastZombieHitTime[obj178] and result33 - list1.lastZombieHitTime[obj178] < list1.ZOMBIE_HIT_COOLDOWN then
					return 0
				end
				local orig = obj178:FindFirstChild("Orig")

				if orig then
					local value308 = func116(obj178)

					if value308 then
						local value309 = orig.Value
						local position = value308.Position
						local str12

						if list1.headshotEnabled then
							str12 = "Head"
						elseif instance == value308 then
							str12 = "Head"
						else
							str12 = "Torso"
						end

						local n2

						if list1.removeBloodEnabled then
							local humanoidRootPart = obj178:FindFirstChild("HumanoidRootPart") or obj178:FindFirstChild("Torso")

							if humanoidRootPart then
								n2 = humanoidRootPart.Position + Vector3.new(0, -9999, 0)
							else
								n2 = position
							end
						else
							n2 = position
						end

						obj.remoteEvent:FireServer("Bayonet_HitZombie", value309, n2, true, str12, obj.swingType)
						value309:SetAttribute("WepHitID", clock())
						value309:SetAttribute("WepHitDirection", num59 * 10)
						value309:SetAttribute("WepHitPos", n2)
						list1.lastZombieHitTime[obj178] = result33
						return 1
					end
				end
			end
		end

		if list1.originalBayonetHitCheck then
			return list1.originalBayonetHitCheck(obj, param87, num59, param88, param89)
		end
		return 0
	end

	list1.unifiedMeleeHitCheck = function(obj, param90, param91, param92, param93, param94)
		local hit = workspace:Raycast(param90, param91, type(param92) == "table" and param92.ray or param92)

		if hit then
			local instance = hit.Instance
			local obj179 = func115(instance)

			if obj179 then
				local result34 = clock()
				if list1.lastZombieHitTime[obj179] and result34 - list1.lastZombieHitTime[obj179] < list1.ZOMBIE_HIT_COOLDOWN then
					return 0
				end
				local orig = obj179:FindFirstChild("Orig")

				if orig then
					local value310 = func116(obj179)

					if value310 then
						local value311 = orig.Value
						local position = value310.Position
						local str13

						if list1.headshotEnabled then
							str13 = "Head"
						elseif instance == value310 then
							str13 = "Head"
						else
							str13 = "Torso"
						end

						if list1.removeBloodEnabled then
							local humanoidRootPart = obj179:FindFirstChild("HumanoidRootPart") or obj179:FindFirstChild("Torso")

							if humanoidRootPart then
								position = humanoidRootPart.Position + Vector3.new(0, -9999, 0)
							end
						end

						local character = localPlayer.Character
						local head = character and character:FindFirstChild("Head")
						head = head and (position - head.Position).Unit or Vector3.new(0, 1, 0)

						if param94 then
							obj.remoteEvent:FireServer("ThrustCharge", value311, position, hit.Normal)
						else
							obj.remoteEvent:FireServer("HitZombieM", value311, position, true, position, str13, head)
						end

						list1.lastZombieHitTime[obj179] = result34
						return 1
					end
				end
			end
		end

		if list1.originalMeleeHitCheck then
			return list1.originalMeleeHitCheck(obj, param90, param91, param92, param93, param94)
		end
		return 0
	end

	list1.updateHitHooks = function()
		local headshotEnabled = list1.headshotEnabled or list1.removeBloodEnabled
		local value312 = obj7
		local weapons = obj7:FindFirstChild("Modules") and value312.Modules:FindFirstChild("Weapons")
		local flag152 = type(hookfunction) == "function"

		if headshotEnabled and not list1.hookInstalled then
			if weapons then
				local ok, result = pcall(require, weapons:FindFirstChild("Flintlock"))

				if ok and result and result.BayonetHitCheck then
					if flag152 then
						if not list1.originalBayonetHitCheck then
							list1.originalBayonetHitCheck = hookfunction(result.BayonetHitCheck, list1.unifiedBayonetHitCheck)
						else
							hookfunction(result.BayonetHitCheck, list1.unifiedBayonetHitCheck)
						end
					else
						if not list1.originalBayonetHitCheck then
							list1.originalBayonetHitCheck = result.BayonetHitCheck
						end

						result.BayonetHitCheck = list1.unifiedBayonetHitCheck
					end
				end

				local ok2, result2 = pcall(require, weapons:FindFirstChild("MeleeBase"))

				if ok2 and result2 and result2.MeleeHitCheck then
					if flag152 then
						if not list1.originalMeleeHitCheck then
							list1.originalMeleeHitCheck = hookfunction(result2.MeleeHitCheck, list1.unifiedMeleeHitCheck)
						else
							hookfunction(result2.MeleeHitCheck, list1.unifiedMeleeHitCheck)
						end
					else
						if not list1.originalMeleeHitCheck then
							list1.originalMeleeHitCheck = result2.MeleeHitCheck
						end

						result2.MeleeHitCheck = list1.unifiedMeleeHitCheck
					end
				end
			end

			list1.hookInstalled = true
		elseif not headshotEnabled and list1.hookInstalled then
			if weapons then
				if list1.originalBayonetHitCheck then
					local ok, result = pcall(require, weapons:FindFirstChild("Flintlock"))

					if ok and result and result.BayonetHitCheck then
						if flag152 then
							hookfunction(result.BayonetHitCheck, list1.originalBayonetHitCheck)
						else
							result.BayonetHitCheck = list1.originalBayonetHitCheck
						end
					end
				end

				if list1.originalMeleeHitCheck then
					local ok, result = pcall(require, weapons:FindFirstChild("MeleeBase"))

					if ok and result then
						if flag152 then
							hookfunction(result.MeleeHitCheck, list1.originalMeleeHitCheck)
						else
							result.MeleeHitCheck = list1.originalMeleeHitCheck
						end
					end
				end
			end

			list1.hookInstalled = false
		end
	end

	list1.onCharacterAdded(function()
		task.wait(1)
		list1.updateHitHooks()
	end)

	obj177:AddToggle("RemoveBloodToggle", {
		Text = "移除血液粒子",
		Default = false,
		Tooltip = func6("将血迹生成位置移到僵尸脚下不可见处，不影响伤害"),
		Callback = function(removeBloodEnabled)
			list1.removeBloodEnabled = removeBloodEnabled
			list1.updateHitHooks()
		end,
	})

	obj177:AddToggle("HeadshotToggle", {
		Text = "强制爆头",
		Default = false,
		Tooltip = func6("强制所有近战/刺刀攻击命中头部"),
		Callback = function(headshotEnabled)
			list1.headshotEnabled = headshotEnabled
			list1.updateHitHooks()
		end,
	})

	list1.zombieHitboxEnabled = false
	list1.zombieHitboxSize = 10
	list1.zombieHitboxAddedParts = {}

	local function func117(parent)
		if not list1.zombieHitboxEnabled then
			return
		end

		if list1.zombieHitboxAddedParts[parent] then
			return
		end
		local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")
		local head = parent:FindFirstChild("Head")
		if not humanoidRootPart or not head then
			return
		end
		local part = Instance.new("Part")
		part.Name = "ZombieHitbox_Outer"
		part.Size = vector(list1.zombieHitboxSize, list1.zombieHitboxSize, list1.zombieHitboxSize)
		part.Transparency = 1
		part.CanCollide = false
		part.CanTouch = true
		part.Massless = true
		part.Anchored = false
		part.CFrame = humanoidRootPart.CFrame
		part.Parent = parent
		local weldConstraint = Instance.new("WeldConstraint")
		weldConstraint.Part0 = humanoidRootPart
		weldConstraint.Part1 = part
		weldConstraint.Parent = part
		local part2 = Instance.new("Part")
		part2.Name = "ZombieHitbox_Head"
		part2.Size = vector(list1.zombieHitboxSize / 2, list1.zombieHitboxSize / 2, list1.zombieHitboxSize / 2)
		part2.Transparency = 1
		part2.CanCollide = false
		part2.CanTouch = true
		part2.Massless = true
		part2.Anchored = false
		part2.CFrame = head.CFrame
		part2.Parent = parent
		local weldConstraint2 = Instance.new("WeldConstraint")
		weldConstraint2.Part0 = head
		weldConstraint2.Part1 = part2
		weldConstraint2.Parent = part2
		list1.zombieHitboxAddedParts[parent] = { outer = part, head = part2 }
	end

	local function func118(instance46)
		local value313 = list1.zombieHitboxAddedParts[instance46]

		if value313 then
			if value313.outer then
				value313.outer:Destroy()
			end

			if value313.head then
				value313.head:Destroy()
			end

			list1.zombieHitboxAddedParts[instance46] = nil
		else
			for _, value314 in instance46:GetChildren() do
				if value314.Name == "ZombieHitbox_Outer" or value314.Name == "ZombieHitbox_Head" then
					value314:Destroy()
				end
			end
		end
	end

	local function func119()
		if not list1.zombieHitboxEnabled then
			local tbl62 = {}

			for k in list1.zombieHitboxAddedParts do
				table.insert(tbl62, k)
			end

			for _, value315 in tbl62 do
				func118(value315)
			end

			list1.zombieHitboxAddedParts = {}
			return
		end

		local tbl63 = {}

		for _, value316 in list1.ZombieWatch.getAll() do
			table.insert(tbl63, value316)
		end

		local tbl64 = {}

		for k in list1.zombieHitboxAddedParts do
			local flag153 = false

			for _, value317 in tbl63 do
				if value317 == k then
					flag153 = true
					break
				end
			end

			if not flag153 then
				table.insert(tbl64, k)
			end
		end

		for _, value318 in tbl64 do
			func118(value318)
		end

		for _, value319 in tbl63 do
			if not list1.zombieHitboxAddedParts[value319] then
				func117(value319)
			end
		end
	end

	local function func120()
		if not list1.zombieHitboxEnabled then
			return
		end

		for _, zombieHitboxAddedPart in list1.zombieHitboxAddedParts do
			if zombieHitboxAddedPart.outer and zombieHitboxAddedPart.outer.Parent then
				zombieHitboxAddedPart.outer.Size = vector(list1.zombieHitboxSize, list1.zombieHitboxSize, list1.zombieHitboxSize)
			end

			if zombieHitboxAddedPart.head and zombieHitboxAddedPart.head.Parent then
				zombieHitboxAddedPart.head.Size = vector(list1.zombieHitboxSize / 2, list1.zombieHitboxSize / 2, list1.zombieHitboxSize / 2)
			end
		end
	end

	local function func121(instance47)
		if list1.zombieHitboxEnabled and instance47:IsA("Model") then
			task.wait(0.1)
			func117(instance47)
		end
	end

	list1.ZombieWatch.start()
	list1.ZombieWatch.onAdded(func121)

	task.spawn(function()
		while true do
			task.wait(2)

			if list1.zombieHitboxEnabled then
				func119()
			end
		end
	end)

	obj177:AddToggle("ZombieHitboxToggle", {
		Text = "僵尸碰撞箱扩展",
		Default = false,
		Tooltip = func6("为僵尸添加更大的命中箱"),
		Callback = function(zombieHitboxEnabled)
			list1.zombieHitboxEnabled = zombieHitboxEnabled

			if zombieHitboxEnabled then
				func119()
			else
				local tbl65 = {}

				for k in list1.zombieHitboxAddedParts do
					table.insert(tbl65, k)
				end

				for _, value320 in tbl65 do
					func118(value320)
				end

				list1.zombieHitboxAddedParts = {}
			end
		end,
	})

	list1.attackSpeedEnabled = false
	list1.attackSpeedMultiplier = 1
	list1.attackSpeedConn = nil

	list1.MELEE_WEAPON_SET = {
		Sabre = true,
		["Le Revenant"] = true,
		Voivode = true,
		Axe = true,
		["Hand Axe"] = true,
		["Heavy Sabre"] = true,
		["Boarding Axe"] = true,
		Stake = true,
		Pickaxe = true,
		Spade = true,
		["Delicious Leg"] = true,
		Spontoon = true,
		Lance = true,
		Baguette = true,
		["Sword Bayonet"] = true,
	}

	list1.isMeleeOrBayonet = function(obj)
		if not obj or not obj:IsA("Tool") then
			return false
		end

		if list1.MELEE_WEAPON_SET[obj.Name] then
			return true
		end

		if obj:GetAttribute("Melee") == true then
			return true
		end
		local obj180 = obj.Name:lower()
		if obj180:find("sabre") or obj180:find("sword") or obj180:find("axe") or obj180:find("pickaxe") or obj180:find("spade") or obj180:find("shovel") or obj180:find("stake") or obj180:find("lance") or obj180:find("pike") or obj180:find("spontoon") or obj180:find("baguette") or obj180:find("bayonet") or obj180:find("revanant") or obj180:find("voivode") or obj180:find("leg") or obj180:find("稿") or obj180:find("铲") or obj180:find("镐") then
			return true
		end
		return false
	end

	local function func122(instance48)
		if not instance48 then
			return
		end

		for _, value321 in instance48:GetChildren() do
			if value321:IsA("Tool") then
				local swingSpeedBuff = value321:FindFirstChild("SwingSpeedBuff")

				if swingSpeedBuff then
					swingSpeedBuff:Destroy()
				end
			end
		end
	end

	list1.updateAttackSpeed = function()
		if not list1.attackSpeedEnabled then
			if list1.attackSpeedConn then
				list1.attackSpeedConn:Disconnect()
				list1.attackSpeedConn = nil
			end

			local character = localPlayer.Character
			local backpack = localPlayer:FindFirstChild("Backpack")
			func122(character)
			func122(backpack)
			return
		end

		if not list1.attackSpeedConn then
			list1.attackSpeedConn = obj5.Heartbeat:Connect(function()
				if not list1.attackSpeedEnabled then
					return
				end
				local character = localPlayer.Character
				local backpack = localPlayer:FindFirstChild("Backpack")

				for _, value322 in { character, backpack }, nil, nil do
					if value322 then
						for _, value323 in value322:GetChildren() do
							if value323:IsA("Tool") then
								if list1.isMeleeOrBayonet(value323) then
									local swingSpeedBuff = value323:FindFirstChild("SwingSpeedBuff")

									if not swingSpeedBuff then
										swingSpeedBuff = Instance.new("NumberValue")
										swingSpeedBuff.Name = "SwingSpeedBuff"
										swingSpeedBuff.Parent = value323
									end

									swingSpeedBuff.Value = list1.attackSpeedMultiplier
								else
									local swingSpeedBuff = value323:FindFirstChild("SwingSpeedBuff")

									if swingSpeedBuff then
										swingSpeedBuff:Destroy()
									end
								end
							end
						end
					end
				end
			end)
		end
	end

	list1.toggleAttackSpeed = function(attackSpeedEnabled)
		list1.attackSpeedEnabled = attackSpeedEnabled
		list1.updateAttackSpeed()
	end

	obj177:AddToggle("AttackSpeedToggle", {
		Text = "加快攻击速度",
		Default = false,
		Callback = function(value)
			list1.toggleAttackSpeed(value)
		end,
	})

	obj177:AddSlider("ZombieHitboxSize", {
		Text = "碰撞箱大小",
		Default = 10,
		Min = 1,
		Max = 30,
		Rounding = 0,
		Suffix = " 单位",
		Callback = function(value)
			list1.zombieHitboxSize = clamp(value, 1, 30)

			if list1.zombieHitboxEnabled then
				func120()
				func119()
			end
		end,
	})

	obj177:AddSlider("AttackSpeedMultiplier", {
		Text = "攻击速度倍数",
		Default = 0.5,
		Min = 0.5,
		Max = 10,
		Suffix = " 倍",
		Rounding = 1,
		Callback = function(attackSpeedMultiplier)
			list1.attackSpeedMultiplier = attackSpeedMultiplier

			if list1.attackSpeedEnabled then
				list1.updateAttackSpeed()
			end
		end,
	})

	if not list1.qingShuiAura then
		list1.qingShuiAura = {}
	end

	list1.qingShuiAura.enabled = false
	list1.qingShuiAura.thread = nil
	list1.qingShuiAura.lastAttackTime = {}

	list1.startQingShuiAura = function()
		if list1.qingShuiAura.thread then
			return
		end
		list1.qingShuiAura.enabled = true

		list1.qingShuiAura.thread = task.spawn(function()
			while list1.qingShuiAura.enabled do
				local obj181 = list1.getHeldMelee()

				if obj181 then
					local character = localPlayer.Character

					if character then
						local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

						if humanoidRootPart then
							local result35 = func111()
							local tbl66 = {}
							local zombies = workspace:FindFirstChild("Zombies")

							if zombies then
								for _, value324 in zombies:GetChildren() do
									if value324:IsA("Model") and value324:FindFirstChild("HumanoidRootPart") then
										if list1.skipSpawningEnabled then
											local state = value324:FindFirstChild("State")
											if state and tostring(state.Value) == "Spawn" then
												continue
											end
										end

										if func113(value324) then
											local position = value324.HumanoidRootPart.Position
											local magnitude = (position - humanoidRootPart.Position).Magnitude

											if magnitude <= result35 and func114(humanoidRootPart, position) then
												table.insert(tbl66, { zombie = value324, dist = magnitude })
											end
										end
									end
								end
							end

							if list1.attackDraculaEnabled then
								local transylvania = func4(workspace, "Transylvania", "Modes", "Boss", "Dracula")

								if transylvania then
									local humanoidRootPart2 = transylvania:FindFirstChild("HumanoidRootPart")
									local head = transylvania:FindFirstChild("Head")

									if humanoidRootPart2 and head then
										local position = humanoidRootPart2.Position
										local magnitude = (position - humanoidRootPart.Position).Magnitude

										if magnitude <= result35 and func114(humanoidRootPart, position) then
											table.insert(tbl66, { zombie = transylvania, dist = magnitude })
										end
									end
								end
							end

							table.sort(tbl66, function(param95, param96)
								return param95.dist < param96.dist
							end)

							local flag154 = min(list1.attackCount, #tbl66)
							local result36 = clock()

							for i = 1, flag154 do
								local zombie = tbl66[i].zombie

								if not list1.qingShuiAura.lastAttackTime[zombie] or result36 - list1.qingShuiAura.lastAttackTime[zombie] > 0.05 then
									local remoteEvent = obj181:FindFirstChild("RemoteEvent")

									if remoteEvent then
										local head = zombie:FindFirstChild("Head")

										if head then
											local character2 = localPlayer.Character
											character2 = character2 and character2:FindFirstChild("Head")
											local position = head.Position
											character2 = character2 and (position - character2.Position).Unit or Vector3.new(0, 1, 0)
											remoteEvent:FireServer("Swing", "Thrust")
											remoteEvent:FireServer("PrepareSwing")
											remoteEvent:FireServer("HitZombieM", zombie, position, true, position, "Head", character2)
											list1.qingShuiAura.lastAttackTime[zombie] = result36
										end
									end
								end
							end

							if flag154 > 0 then
								local currentAttackTargets = {}

								for i = 1, flag154 do
									if tbl66[i] then
										table.insert(currentAttackTargets, tbl66[i].zombie)
									end
								end

								list1.currentAttackTargets = currentAttackTargets
							else
								list1.currentAttackTargets = {}
							end
						end
					end
				else
					list1.currentAttackTargets = {}
				end

				task.wait(0.2)
			end
		end)
	end
end

list1.stopQingShuiAura = function()
	list1.qingShuiAura.enabled = false

	if list1.qingShuiAura.thread then
		task.cancel(list1.qingShuiAura.thread)
		list1.qingShuiAura.thread = nil
	end

	list1.qingShuiAura.lastAttackTime = {}
end

list1.onCharacterAdded(function()
	task.wait(0.5)

	if list1.showRangeVisuals then
		list1.startRangeVisuals()
	end
end)

lib:OnUnload(function()
	list1.stopRangeVisuals()
	list1.stopIndicatorUpdater()
	list1.stopSmartAuraThread()

	if list1.auraEnabled then
		list1.stopAura()
	end

	if list1.qingShuiAura and list1.qingShuiAura.enabled then
		list1.stopQingShuiAura()
	end
end)

local obj182 = tbl2.Settings:AddLeftGroupbox("菜单")

obj182:AddDropdown("InterfaceLanguage", {
	Text = "语言 / Language",
	Values = { "中文", "English" },
	Default = 1,
	Callback = function(value)
		func7(value)
	end,
})

options.InterfaceLanguage:OnChanged(function()
	func7(options.InterfaceLanguage.Value)
end)

lib:OnUnload(function()
	getgenv().SkinHubLoaded = nil

	local function func123(connection6)
		if connection6 and typeof(connection6) == "RBXScriptConnection" and connection6.Connected then
			connection6:Disconnect()
		end
	end

	func123(list1.autoCollectConnection)
	func123(list1.autoCannon and list1.autoCannon.connection)
	func123(list1.autoBell and list1.autoBell.conn)
	func123(list1.LondonBoardAuto and list1.LondonBoardAuto.heartbeat)
	func123(list8 and list8.meleeConn)
	func123(list1.SilentAim and list1.SilentAim.SilentAimUpdateConn)
	func123(list1.axeStunConnection)
	func123(list1.rollTiltConn)
	func123(list1.spin and list1.spin.connection)
	func123(list1.thirdPerson and list1.thirdPerson.connection)
	func123(list1.invert and list1.invert.conn)
	func123(list1.bigHead and list1.bigHead.connection)
	func123(list1.animLoop1205Connection)
	func123(list1.AutoEscape and list1.AutoEscape.suspendConn)
	func123(list1.AntiGrab and list1.AntiGrab.connection)
	func123(list1.infectionUpdateConn)
	func123(list1.jobUpdateConn)
	func123(list1.boomDraw and list1.boomDraw.connection)
	func123(list1.bulletDisplay and list1.bulletDisplay.connection)
	func123(list1.bulletDisplay and list1.bulletDisplay.cameraConn)
	func123(list1.pingDisplay and list1.pingDisplay.conn)
	func123(list1.infectionRemover and list1.infectionRemover.conn)
	func123(list1.bombRange and list1.bombRange.conn)
	func123(list1.handMortar and list1.handMortar.cameraConn)
	func123(list1.handMortar and list1.handMortar.conn)
	func123(list1.zombieESPHeartbeatConn)

	pcall(function()
		if lib4 then
			lib4:Clear()
		end
	end)

	func123(list1.CoordSpeed and list1.CoordSpeed.Connection)
	func123(connection)
	func123(list1.AutoJump and list1.AutoJump.Connection)
	func123(list1.JumpMod and list1.JumpMod.AntiFallConn)

	pcall(function()
		if list1.tpFreecam then
			list1.tpFreecam.cleanup()
		end
	end)

	pcall(function()
		if list1.oneClick and list1.oneClick.ui then
			list1.oneClick.ui:Destroy()
		end
	end)

	pcall(function()
		if list1.flyAway and list1.flyAway.screenGui then
			list1.flyAway.screenGui:Destroy()
		end
	end)

	pcall(function()
		if list1.invisTool and list1.invisTool.ui then
			list1.invisTool.ui:Destroy()
		end
	end)

	pcall(function()
		if _G.boxerUI then
			_G.boxerUI:Destroy()
		end
	end)

	pcall(function()
		if _G.cavalryUI then
			_G.cavalryUI:Destroy()
		end
	end)

	pcall(function()
		if _G.zapperUI then
			_G.zapperUI:Destroy()
		end
	end)

	pcall(function()
		if list1.toggleNewAnimUI then
			list1.toggleNewAnimUI(false)
		end
	end)

	pcall(function()
		if list1.toggleAnim17871770160UI then
			list1.toggleAnim17871770160UI(false)
		end
	end)
end)

obj182:AddButton("卸载脚本", function()
	pcall(function()
		if toggles then
			for _, toggle in pairs(toggles) do
				if toggle and toggle.Value == true and toggle.SetValue then
					pcall(function()
						toggle:SetValue(false)
					end)
				end
			end
		end
	end)

	lib:Unload()
end)

obj182:AddLabel("菜单快捷键"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
lib.ToggleKeybind = options.MenuKeybind
lib2:SetLibrary(lib)
lib3:SetLibrary(lib)
lib3:IgnoreThemeSettings()
lib2:SetFolder("MyScriptTheme")
lib3:SetFolder("MyScriptConfig")
lib3:BuildConfigSection(tbl2.Settings)
lib2:ApplyToTab(tbl2.Settings)
lib.Scheme.BackgroundColor = color(8, 14, 26)
lib.Scheme.MainColor = color(18, 32, 56)
lib.Scheme.AccentColor = color(80, 200, 255)
lib.Scheme.OutlineColor = color(45, 90, 140)
lib.Scheme.DarkColor = color(4, 8, 16)
lib.Scheme.RedColor = color(255, 90, 90)
lib.Scheme.DestructiveColor = color(230, 60, 60)
lib.Scheme.WhiteColor = Color3.new(1, 1, 1)
lib.Scheme.FontColor = Color3.new(1, 1, 1)
lib.CornerRadius = 10

if options.FontFace then
	options.FontFace:SetValue("RobotoMono")
end

if options.BackgroundColor then
	options.BackgroundColor:SetValue(lib.Scheme.BackgroundColor)
end

if options.MainColor then
	options.MainColor:SetValue(lib.Scheme.MainColor)
end

if options.AccentColor then
	options.AccentColor:SetValue(lib.Scheme.AccentColor)
end

if options.OutlineColor then
	options.OutlineColor:SetValue(lib.Scheme.OutlineColor)
end

lib:UpdateColorsUsingRegistry()

task.defer(function()
	if list1.bootLanguagePicked then
		options.InterfaceLanguage:SetValue(list1.bootLanguage)
	else
		func7(options.InterfaceLanguage.Value)
	end
end)

obj4 = func1(game:GetService("Players"))
localPlayer = obj4.LocalPlayer

playIdentityAnimation = function()
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")

	local ok, result = pcall(function()
		animation.AnimationId = "rbxassetid://507766666"
	end)

	if not ok then
		warn("playIdentityAnimation: failed to set AnimationId:", result)
		return
	end
	local obj183 = animator:LoadAnimation(animation)
	obj183.Looped = true
	obj183:Play()
	obj183:AdjustSpeed(1)
	_G._identityTrack = obj183
end

onCharacterAdded = function()
	task.wait(0.5)
	playIdentityAnimation()
end

localPlayer.CharacterAdded:Connect(onCharacterAdded)

if localPlayer.Character then
	onCharacterAdded()
end

list1.voteMonitor = { enabled = false, conns = {}, voter = nil, target = nil, votes = {}, inProgress = false }

list1.voteMonitor.start = function()
	if list1.voteMonitor.enabled then
		return
	end
	list1.voteMonitor.enabled = true
	local obj184 = func1(game:GetService("ReplicatedStorage"))
	local playerVote = obj184:FindFirstChild("GameStates") and obj184.GameStates:FindFirstChild("PlayerVote")
	if not playerVote then
		warn("[投票监听] 找不到 PlayerVote")
		return
	end
	local voted = playerVote:FindFirstChild("Voted")
	if not voted then
		warn("[投票监听] 找不到 Voted")
		return
	end

	for _, conn3 in list1.voteMonitor.conns do
		conn3:Disconnect()
	end

	table.clear(list1.voteMonitor.conns)

	local function func124()
		if playerVote:GetAttribute("InProgress") then
			list1.voteMonitor.inProgress = true
			list1.voteMonitor.voter = playerVote:GetAttribute("Voter")
			list1.voteMonitor.target = playerVote:GetAttribute("Target")
			list1.voteMonitor.votes = {}

			if list1.voteMonitor.voter and list1.voteMonitor.target then
				local voter = list1.voteMonitor.voter
				local target = list1.voteMonitor.target
				lib:Notify(format(func5("[投票] %s 发起对 %s 的投票"), voter, target), 3)
			end
		else
			list1.voteMonitor.inProgress = false
			list1.voteMonitor.voter = nil
			list1.voteMonitor.target = nil
			list1.voteMonitor.votes = {}
		end
	end

	local function func125(attribute)
		if not list1.voteMonitor.inProgress then
			return
		end
		local attribute2 = voted:GetAttribute(attribute)

		if attribute and attribute2 ~= nil then
			local value325 = attribute2 and func5("同意") or func5("反对")
			lib:Notify(format(func5("[投票] %s %s"), attribute, value325), 2)
		end
	end

	table.insert(list1.voteMonitor.conns, playerVote:GetAttributeChangedSignal("InProgress"):Connect(func124))
	table.insert(list1.voteMonitor.conns, voted.AttributeChanged:Connect(func125))

	if playerVote:GetAttribute("InProgress") then
		func124()
	end

	lib:Notify(func5("投票显示已开启"), 2)
end

list1.voteMonitor.stop = function()
	list1.voteMonitor.enabled = false

	for _, conn4 in list1.voteMonitor.conns do
		conn4:Disconnect()
	end

	table.clear(list1.voteMonitor.conns)
	list1.voteMonitor.voter = nil
	list1.voteMonitor.target = nil
	list1.voteMonitor.votes = {}
	list1.voteMonitor.inProgress = false
	lib:Notify(func5("投票显示已关闭"), 2)
end

obj147:AddToggle("VoteMonitorToggle", {
	Text = "投票显示",
	Default = false,
	Callback = function(value)
		if value then
			list1.voteMonitor.start()
		else
			list1.voteMonitor.stop()
		end
	end,
})

lib:OnUnload(function()
	list1.voteMonitor.stop()
end)

lib:UpdateColorsUsingRegistry()

do
	local accentColor = lib.Scheme.AccentColor
	local outlineColor = lib.Scheme.OutlineColor
	local mainColor = lib.Scheme.MainColor
	local backgroundColor = lib.Scheme.BackgroundColor
	Color3.fromRGB(math.floor(accentColor.R * 255 * 0.55), math.floor(accentColor.G * 255 * 0.55), math.floor(accentColor.B * 255 * 0.55))
	local min2 = math.min
	local n2 = outlineColor.B * 255 + 45
	local color2 = Color3.fromRGB(math.min(255, outlineColor.R * 255 + 30), math.min(255, outlineColor.G * 255 + 30), min2(255, n2))
	local min3 = math.min
	local n3 = mainColor.B * 255 + 18
	local color3 = Color3.fromRGB(math.min(255, mainColor.R * 255 + 12), math.min(255, mainColor.G * 255 + 12), min3(255, n3))

	local function func126(className, parent)
		local instance = parent:FindFirstChildOfClass(className)

		if not instance then
			instance = Instance.new(className)
			instance.Parent = parent
		end

		return instance
	end

	local function func127(param97, param98, param99, rotation)
		local UIGradient = func126("UIGradient", param97)
		UIGradient.Color = ColorSequence.new(param98, param99)
		UIGradient.Rotation = rotation or 90
	end

	local function func128(param100, color4, thickness, transparency)
		local UIStroke = func126("UIStroke", param100)
		UIStroke.Color = color4
		UIStroke.Thickness = thickness or 1
		UIStroke.Transparency = transparency or 0
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		return UIStroke
	end

	local function func129(param101, param102)
		local UICorner = func126("UICorner", param101)
		UICorner.CornerRadius = UDim.new(0, param102)
		return UICorner
	end

	local function func130(instance49)
		if not instance49.Parent then
			return
		end

		if instance49:IsA("TextButton") and instance49.Size.X.Scale == 1 and instance49.Size.Y.Offset >= 34 and instance49.Size.Y.Offset <= 44 then
			if not instance49:GetAttribute("SkinHub_Tab") then
				instance49:SetAttribute("SkinHub_Tab", true)
				func128(instance49, color2, 1, 0.55)
				func127(instance49, mainColor, Color3.fromRGB(math.min(255, mainColor.R * 255 + 8), math.min(255, mainColor.G * 255 + 8), math.min(255, mainColor.B * 255 + 14)), 90)
			end

			return
		end

		if (instance49:IsA("TextButton") or instance49:IsA("TextBox")) and instance49.Size.Y.Offset >= 18 and instance49.Size.Y.Offset <= 25 and instance49.BackgroundTransparency < 1 and instance49.BackgroundColor3 ~= Color3.new(1, 1, 1) then
			if not instance49:GetAttribute("SkinHub_Ctrl") then
				instance49:SetAttribute("SkinHub_Ctrl", true)
				func129(instance49, 6)
				func128(instance49, outlineColor, 1, 0.1)

				if instance49.BackgroundColor3 == mainColor or instance49.BackgroundColor3 == backgroundColor then
					local min4 = math.min
					local n4 = instance49.BackgroundColor3.B * 255 + 16
					func127(instance49, instance49.BackgroundColor3, Color3.fromRGB(math.min(255, instance49.BackgroundColor3.R * 255 + 10), math.min(255, instance49.BackgroundColor3.G * 255 + 10), min4(255, n4)), 90)
				end

				local backgroundColor3 = instance49.BackgroundColor3

				instance49.MouseEnter:Connect(function()
					if instance49:GetAttribute("SkinHub_Dis") then
						return
					end
					local tbl67 = { BackgroundColor3 = color3 }
					obj8:Create(instance49, TweenInfo.new(0.15), tbl67):Play()
				end)

				instance49.MouseLeave:Connect(function()
					if instance49:GetAttribute("SkinHub_Dis") then
						return
					end
					local tbl68 = { BackgroundColor3 = backgroundColor3 }
					obj8:Create(instance49, TweenInfo.new(0.15), tbl68):Play()
				end)
			end

			return
		end

		if instance49:IsA("Frame") and instance49.BackgroundTransparency == 0 then
			if instance49:FindFirstChildOfClass("UICorner") and instance49:FindFirstChildOfClass("UIStroke") then
				if not instance49:GetAttribute("SkinHub_Box") then
					instance49:SetAttribute("SkinHub_Box", true)
					local uiStroke = instance49:FindFirstChildOfClass("UIStroke")

					if uiStroke then
						uiStroke.Color = color2
						uiStroke.Transparency = 0.55
						uiStroke.Thickness = 1
					end
				end
			end
		end
	end

	task.defer(function()
		local screenGui = lib.ScreenGui
		if not screenGui then
			return
		end

		for _, getDescendant30 in screenGui:GetDescendants() do
			pcall(func130, getDescendant30)
		end

		screenGui.DescendantAdded:Connect(function(descendant)
			task.defer(function()
				pcall(func130, descendant)
			end)
		end)
	end)
end

local function func131(instance50)
	if instance50:IsA("TextLabel") or instance50:IsA("TextButton") or instance50:IsA("TextBox") then
		if instance50.TextTransparency ~= 0 then
			instance50.TextTransparency = 0
		end
	end
end

task.defer(function()
	local screenGui = lib.ScreenGui
	if not screenGui then
		return
	end

	for _, getDescendant31 in screenGui:GetDescendants() do
		func131(getDescendant31)
	end

	screenGui.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			task.defer(function()
				descendant.TextTransparency = 0
			end)
		end
	end)

	local n2 = 0

	obj5.Heartbeat:Connect(function()
		local now = os.clock()
		if now - n2 < 0.15 then
			return
		end
		n2 = now

		for _, getDescendant32 in screenGui:GetDescendants() do
			func131(getDescendant32)
		end
	end)
end)

local function func132()
	local mainFrame = lib.Window and lib.Window.MainFrame
	if not mainFrame then
		return nil
	end

	for _, getDescendant33 in mainFrame:GetDescendants() do
		if getDescendant33:IsA("TextLabel") and getDescendant33.Text and (getDescendant33.Text == "Nexus" or getDescendant33.Text:find("Nexus")) then
			return getDescendant33
		end
	end

	return nil
end

task.spawn(function()
	local obj185

	while true do
		obj185 = func132()

		if not obj185 then
			task.wait(0.2)
		end

		if not obj185 then
			continue
		end
		break
	end

	obj185.FontFace = Font.fromEnum(Enum.Font.SciFi)
	obj185.TextSize = 22
	local uiGradient = obj185:FindFirstChildOfClass("UIGradient")

	if not uiGradient then
		uiGradient = Instance.new("UIGradient")
		uiGradient.Parent = obj185
	end

	local colorSequence = ColorSequence.new
	local value326 = ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 220, 255))
	local value327 = ColorSequenceKeypoint.new(0.25, Color3.fromRGB(200, 245, 255))
	local value328 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255))
	local value329 = ColorSequenceKeypoint.new(0.75, Color3.fromRGB(140, 220, 255))
	local tbl69 = { value326, value327, value328, value329 }

	do
		local values = table.pack(ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 220, 255)))
		table.move(values, 1, values.n, 5, tbl69)
	end

	uiGradient.Color = colorSequence(tbl69)
	uiGradient.Rotation = 0
	obj185.TextStrokeColor3 = Color3.fromRGB(30, 120, 200)
	obj185.TextStrokeTransparency = 0.3
	local now = os.clock()

	while obj185.Parent do
		uiGradient.Rotation = (os.clock() - now) * 60 % 360
		obj5.RenderStepped:Wait()
	end
end)