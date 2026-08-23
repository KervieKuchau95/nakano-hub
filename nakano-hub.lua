--// NAKANO HUB
--// By Kervie_Kuchau95
--// Mobile-safe Miku drag: does not intentionally capture Roblox joystick input

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera

getgenv().Nakano = getgenv().Nakano or {
    AutoTP = false,
    AutoV4 = false,
    Aim = false,
    CamLock = false,
    FollowEnemy = false,
    ESP = false,
    FOV = 300,
    Boost = false
}

if game.CoreGui:FindFirstChild("NakanoV13") then
    game.CoreGui.NakanoV13:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NakanoV13"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local PIXEL = Enum.Font.Arcade

--========================================================--
-- PASTEL PINK THEME + CONFIG
--========================================================--

local PINK = Color3.fromRGB(255, 175, 215)
local PINK_BRIGHT = Color3.fromRGB(255, 145, 200)
local PINK_SOFT = Color3.fromRGB(255, 205, 230)
local PINK_DARK = Color3.fromRGB(105, 65, 90)

local CONFIG_FILE = "NakanoHub_V13_Config.json"

local function SaveConfig()
    if not writefile then
        return
    end

    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode({
            AutoTP = getgenv().Nakano.AutoTP,
            AutoV4 = getgenv().Nakano.AutoV4,
            Aim = getgenv().Nakano.Aim,
            CamLock = getgenv().Nakano.CamLock,
            FollowEnemy = getgenv().Nakano.FollowEnemy,
            ESP = getgenv().Nakano.ESP,
            Boost = getgenv().Nakano.Boost,
            AutoSave = getgenv().Nakano.AutoSave,
            ESPName = ESPName,
            ESPHealth = ESPHealth,
            ESPDistance = ESPDistance
        }))
    end)
end

local savedConfig = {}
if isfile and readfile then
    pcall(function()
        if isfile(CONFIG_FILE) then
            local decoded = HttpService:JSONDecode(readfile(CONFIG_FILE))
            if type(decoded) == "table" then
                savedConfig = decoded
            end
        end
    end)
end

for key,value in pairs(savedConfig) do
    if getgenv().Nakano[key] ~= nil then
        getgenv().Nakano[key] = value
    end
end

getgenv().Nakano.AutoSave = savedConfig.AutoSave == true
if savedConfig.CamLock == nil then
    getgenv().Nakano.CamLock = false
end
if savedConfig.FollowEnemy == nil then
    getgenv().Nakano.FollowEnemy = false
end
if getgenv().Nakano.FOV == nil then
    getgenv().Nakano.FOV = 300
end

-- Explicit defaults for older configuration files.
if getgenv().Nakano.AutoTP == nil then getgenv().Nakano.AutoTP = false end
if getgenv().Nakano.AutoV4 == nil then getgenv().Nakano.AutoV4 = false end
if getgenv().Nakano.Aim == nil then getgenv().Nakano.Aim = false end
if getgenv().Nakano.Boost == nil then getgenv().Nakano.Boost = false end

-- V13 migration: the old AutoTP feature is intentionally disabled.
getgenv().Nakano.AutoTP = false

--========================================================--
-- NOTIFICATION
--========================================================--

local notif = Instance.new("Frame", gui)
notif.Size = UDim2.new(0, 310, 0, 82)
notif.Position = UDim2.new(1, -325, 1, -105)
notif.BackgroundColor3 = Color3.fromRGB(18,18,26)
notif.BackgroundTransparency = 0.12

Instance.new("UICorner", notif).CornerRadius = UDim.new(0,12)

local notifStroke = Instance.new("UIStroke", notif)
notifStroke.Color = PINK_BRIGHT
notifStroke.Thickness = 2

local notifImg = Instance.new("ImageLabel", notif)
notifImg.Size = UDim2.new(0,68,0,68)
notifImg.Position = UDim2.new(0,7,0.5,-34)
notifImg.BackgroundTransparency = 1
notifImg.Image = "rbxassetid://118017336964341"
notifImg.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", notifImg).CornerRadius = UDim.new(1,0)

local notifTitle = Instance.new("TextLabel", notif)
notifTitle.Size = UDim2.new(1,-85,0,24)
notifTitle.Position = UDim2.new(0,82,0,15)
notifTitle.BackgroundTransparency = 1
notifTitle.Text = "NAKANO HUB 鈿�"
notifTitle.Font = PIXEL
notifTitle.TextSize = 16
notifTitle.TextColor3 = PINK_SOFT
notifTitle.TextXAlignment = Enum.TextXAlignment.Left

local notifBy = Instance.new("TextLabel", notif)
notifBy.Size = UDim2.new(1,-85,0,20)
notifBy.Position = UDim2.new(0,82,0,42)
notifBy.BackgroundTransparency = 1
notifBy.Text = "by Kervie_Kuchau"
notifBy.Font = PIXEL
notifBy.TextSize = 11
notifBy.TextColor3 = Color3.new(1,1,1)
notifBy.TextXAlignment = Enum.TextXAlignment.Left

task.delay(5,function()
    local info = TweenInfo.new(0.65,Enum.EasingStyle.Quad)

    TS:Create(notif,info,{BackgroundTransparency = 1}):Play()
    TS:Create(notifStroke,info,{Transparency = 1}):Play()
    TS:Create(notifImg,info,{ImageTransparency = 1}):Play()
    TS:Create(notifTitle,info,{TextTransparency = 1}):Play()
    TS:Create(notifBy,info,{TextTransparency = 1}):Play()

    task.wait(0.7)
    if notif then
        notif:Destroy()
    end
end)

--========================================================--
-- MAIN
--========================================================--

local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,395,0,470)
main.Position = UDim2.new(0.5,-197,0.5,-235)
main.BackgroundColor3 = Color3.fromRGB(22,18,28)
main.BackgroundTransparency = 0.38
main.Visible = false
main.Active = true

Instance.new("UICorner",main).CornerRadius = UDim.new(0,16)

local mainStroke = Instance.new("UIStroke",main)
mainStroke.Color = PINK
mainStroke.Thickness = 3
mainStroke.Transparency = 0.08

local mainGlow = Instance.new("UIStroke",main)
mainGlow.Color = PINK_BRIGHT
mainGlow.Thickness = 8
mainGlow.Transparency = 0.62

local gloss = Instance.new("Frame", main)
gloss.Name = "Gloss"
gloss.Size = UDim2.new(1,-6,0,92)
gloss.Position = UDim2.new(0,3,0,3)
gloss.BackgroundColor3 = PINK_SOFT
gloss.BackgroundTransparency = 0.88
gloss.BorderSizePixel = 0
gloss.ZIndex = 2
Instance.new("UICorner", gloss).CornerRadius = UDim.new(0,14)

local glossGradient = Instance.new("UIGradient", gloss)
glossGradient.Rotation = 90
glossGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0,0.15),
    NumberSequenceKeypoint.new(1,1)
})

--========================================================--
-- MIKU BUTTON 鈥� MOBILE SAFE
--========================================================--

local miku = Instance.new("ImageButton",gui)
miku.Size = UDim2.new(0,62,0,62)
miku.Position = UDim2.new(0,20,1,-82)
miku.BackgroundTransparency = 1
miku.Image = "rbxassetid://118017336964341"
miku.ScaleType = Enum.ScaleType.Crop
miku.AutoButtonColor = false
miku.Active = true
miku.Selectable = false

Instance.new("UICorner",miku).CornerRadius = UDim.new(1,0)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPosition = nil
local wasDragged = false

local function updateDrag(input)
    if not dragging or not dragStart or not startPosition then
        return
    end

    local delta = input.Position - dragStart

    if math.abs(delta.X) > 8 or math.abs(delta.Y) > 8 then
        wasDragged = true
    end

    miku.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end

miku.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        wasDragged = false
        dragStart = input.Position
        startPosition = miku.Position

        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                dragInput = nil
            end
        end)
    end
end)

miku.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            dragInput = input
        end
    end
end)

-- Only the input that originated on Miku is followed.
UIS.InputChanged:Connect(function(input)
    if dragging and dragInput and input == dragInput then
        updateDrag(input)
    end
end)

miku.Activated:Connect(function()
    if wasDragged then
        wasDragged = false
        return
    end

    main.Visible = not main.Visible

    if main.Visible then
        main.Size = UDim2.new(0,0,0,0)

        TS:Create(
            main,
            TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
            {Size = UDim2.new(0,395,0,470)}
        ):Play()
    end
end)

--========================================================--
-- SAKURA
--========================================================--

local sakuraContainer = Instance.new("Frame",main)
sakuraContainer.Size = UDim2.new(1,0,1,0)
sakuraContainer.BackgroundTransparency = 1
sakuraContainer.ClipsDescendants = true
sakuraContainer.ZIndex = 10

for i = 1,8 do
    local petal = Instance.new("TextLabel",sakuraContainer)
    petal.Text = "馃尭"
    petal.Size = UDim2.new(0,20,0,20)
    petal.Position = UDim2.new(math.random(),0,-0.1,0)
    petal.BackgroundTransparency = 1
    petal.TextSize = math.random(12,18)
    petal.ZIndex = 10

    task.spawn(function()
        while task.wait(math.random(4,8)) do
            petal.Position = UDim2.new(math.random(),0,-0.1,0)

            TS:Create(
                petal,
                TweenInfo.new(math.random(5,9),Enum.EasingStyle.Linear),
                {Position = UDim2.new(petal.Position.X.Scale,0,1.1,0)}
            ):Play()
        end
    end)
end

--========================================================--
-- HEADER
--========================================================--

local top = Instance.new("Frame",main)
top.Size = UDim2.new(1,0,0,42)
top.BackgroundColor3 = PINK_BRIGHT
top.BackgroundTransparency = 0.35
Instance.new("UICorner",top).CornerRadius = UDim.new(0,16)
local topStroke = Instance.new("UIStroke",top)
topStroke.Color = PINK_SOFT
topStroke.Thickness = 2
topStroke.Transparency = 0.2

local title = Instance.new("TextLabel",top)
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,15,0,0)
title.BackgroundTransparency = 1
title.Text = "NAKANO HUB"
title.Font = PIXEL
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton",top)
close.Size = UDim2.new(0,28,0,28)
close.Position = UDim2.new(1,-35,0,7)
close.Text = "X"
close.Font = PIXEL
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner",close).CornerRadius = UDim.new(0,8)

close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

--========================================================--
-- SCROLL
--========================================================--

local scroll = Instance.new("ScrollingFrame",main)
scroll.Size = UDim2.new(1,0,1,-92)
scroll.Position = UDim2.new(0,0,0,48)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 2
scroll.CanvasSize = UDim2.new(0,0,0,900)

local layout = Instance.new("UIListLayout",scroll)
layout.Padding = UDim.new(0,8)

local padding = Instance.new("UIPadding",scroll)
padding.PaddingLeft = UDim.new(0,12)
padding.PaddingRight = UDim.new(0,12)
padding.PaddingTop = UDim.new(0,10)

--========================================================--
-- TOGGLE
--========================================================--

local function MakeToggle(name,desc,default,callback)
    local frame = Instance.new("Frame",scroll)
    frame.Size = UDim2.new(1,0,0,58)
    frame.BackgroundTransparency = 1

    local nameLabel = Instance.new("TextLabel",frame)
    nameLabel.Size = UDim2.new(0.68,0,0,20)
    nameLabel.Position = UDim2.new(0,10,0,6)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.Font = PIXEL
    nameLabel.TextSize = 12
    nameLabel.TextColor3 = PINK_SOFT
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local descLabel = Instance.new("TextLabel",frame)
    descLabel.Size = UDim2.new(0.68,0,0,16)
    descLabel.Position = UDim2.new(0,10,0,29)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.Font = PIXEL
    descLabel.TextSize = 8
    descLabel.TextColor3 = Color3.fromRGB(170,195,255)
    descLabel.TextXAlignment = Enum.TextXAlignment.Left

    local switch = Instance.new("Frame",frame)
    switch.Size = UDim2.new(0,52,0,26)
    switch.Position = UDim2.new(1,-62,0.5,-13)
    switch.BackgroundColor3 =
        default and PINK_BRIGHT
        or PINK_DARK
    Instance.new("UICorner",switch).CornerRadius = UDim.new(1,0)

    local dot = Instance.new("Frame",switch)
    dot.Size = UDim2.new(0,20,0,20)
    dot.Position =
        default and UDim2.new(1,-23,0.5,-10)
        or UDim2.new(0,3,0.5,-10)
    dot.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)

    local click = Instance.new("TextButton",frame)
    click.Size = UDim2.new(1,0,1,0)
    click.BackgroundTransparency = 1
    click.Text = ""

    local state = default

    click.MouseButton1Click:Connect(function()
        state = not state

        TS:Create(switch,TweenInfo.new(0.2),{
            BackgroundColor3 =
                state and PINK_BRIGHT
                or PINK_DARK
        }):Play()

        TS:Create(dot,TweenInfo.new(0.2),{
            Position =
                state and UDim2.new(1,-23,0.5,-10)
                or UDim2.new(0,3,0.5,-10)
        }):Play()

        callback(state)
    end)

    return frame
end

--========================================================--
-- ESP
--========================================================--

local ESPEnabled = false
local ESPName = true
local ESPHealth = false
local ESPDistance = false
local ESPObjects = {}

ESPEnabled = savedConfig.ESP == true
ESPName = savedConfig.ESPName ~= false
ESPHealth = savedConfig.ESPHealth == true
ESPDistance = savedConfig.ESPDistance == true
getgenv().Nakano.ESP = ESPEnabled


local function RemoveESP(player)
    if ESPObjects[player] then
        ESPObjects[player]:Destroy()
        ESPObjects[player] = nil
    end
end

local function CreateESP(player)
    if player == plr or not ESPEnabled then return end

    local character = player.Character
    if not character then return end

    local head = character:FindFirstChild("Head")
    if not head then return end

    RemoveESP(player)

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NakanoESP"
    billboard.Parent = head
    billboard.Size = UDim2.new(0,190,0,75)
    billboard.StudsOffset = Vector3.new(0,3,0)
    billboard.AlwaysOnTop = true

    local text = Instance.new("TextLabel",billboard)
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Font = PIXEL
    text.TextSize = 12
    text.TextColor3 = PINK
    text.TextStrokeTransparency = 0.2
    text.TextWrapped = true

    ESPObjects[player] = billboard

    task.spawn(function()
        while billboard.Parent
        and ESPEnabled
        and player.Character == character do

            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local root = character:FindFirstChild("HumanoidRootPart")
            local lines = {}

            if ESPName then
                table.insert(lines,player.Name)
            end

            if ESPHealth and humanoid then
                table.insert(
                    lines,
                    "HP: "..math.floor(humanoid.Health)
                    .."/"..math.floor(humanoid.MaxHealth)
                )
            end

            if ESPDistance and root
            and plr.Character
            and plr.Character:FindFirstChild("HumanoidRootPart") then

                local distance =
                    (root.Position - plr.Character.HumanoidRootPart.Position).Magnitude

                table.insert(lines,"Distance: "..math.floor(distance).."m")
            end

            text.Text = table.concat(lines,"\n")
            task.wait(0.1)
        end

        if billboard then
            billboard:Destroy()
        end
    end)
end

local function RefreshESP()
    for _,player in ipairs(Players:GetPlayers()) do
        if player ~= plr then
            if ESPEnabled then
                CreateESP(player)
            else
                RemoveESP(player)
            end
        end
    end
end

local espOptions = Instance.new("Frame",scroll)
espOptions.Size = UDim2.new(1,0,0,0)
espOptions.BackgroundTransparency = 1
espOptions.Visible = false
espOptions.ClipsDescendants = true

local espLayout = Instance.new("UIListLayout",espOptions)
espLayout.Padding = UDim.new(0,2)

local function MakeESPOption(name,default,callback)
    local row = Instance.new("Frame",espOptions)
    row.Size = UDim2.new(1,-25,0,38)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel",row)
    label.Size = UDim2.new(0.7,0,1,0)
    label.Position = UDim2.new(0,30,0,0)
    label.BackgroundTransparency = 1
    label.Text = "鈥� "..name
    label.Font = PIXEL
    label.TextSize = 9
    label.TextColor3 = Color3.fromRGB(230,190,215)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sw = Instance.new("Frame",row)
    sw.Size = UDim2.new(0,42,0,20)
    sw.Position = UDim2.new(1,-48,0.5,-10)
    sw.BackgroundColor3 =
        default and PINK_BRIGHT
        or PINK_DARK
    Instance.new("UICorner",sw).CornerRadius = UDim.new(1,0)

    local dot = Instance.new("Frame",sw)
    dot.Size = UDim2.new(0,16,0,16)
    dot.Position =
        default and UDim2.new(1,-19,0.5,-8)
        or UDim2.new(0,3,0.5,-8)
    dot.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)

    local button = Instance.new("TextButton",row)
    button.Size = UDim2.new(1,0,1,0)
    button.BackgroundTransparency = 1
    button.Text = ""

    local state = default

    button.MouseButton1Click:Connect(function()
        state = not state

        TS:Create(sw,TweenInfo.new(0.18),{
            BackgroundColor3 =
                state and PINK_BRIGHT
                or PINK_DARK
        }):Play()

        TS:Create(dot,TweenInfo.new(0.18),{
            Position =
                state and UDim2.new(1,-19,0.5,-8)
                or UDim2.new(0,3,0.5,-8)
        }):Play()

        callback(state)
    end)
end

MakeToggle("ESP","Player information overlay",ESPEnabled,function(v)
    ESPEnabled = v
    getgenv().Nakano.ESP = v
    if getgenv().Nakano.AutoSave then SaveConfig() end
    espOptions.Visible = v

    if v then
        task.wait()
        espOptions.Size =
            UDim2.new(1,0,0,espLayout.AbsoluteContentSize.Y + 4)
    else
        espOptions.Size = UDim2.new(1,0,0,0)
    end

    RefreshESP()
end)

MakeESPOption("SHOW NAME",ESPName,function(v)
    ESPName = v
    if getgenv().Nakano.AutoSave then SaveConfig() end
    RefreshESP()
end)

MakeESPOption("SHOW HEALTH",ESPHealth,function(v)
    ESPHealth = v
    if getgenv().Nakano.AutoSave then SaveConfig() end
    RefreshESP()
end)

MakeESPOption("SHOW DISTANCE",ESPDistance,function(v)
    ESPDistance = v
    if getgenv().Nakano.AutoSave then SaveConfig() end
    RefreshESP()
end)

--========================================================--
-- OTHER FEATURES
--========================================================--

MakeToggle(
    "FPS BOOST ULTRA",
    "Reduce lag and improve performance",
    getgenv().Nakano.Boost == true,
    function(v)
        getgenv().Nakano.Boost = v

        if getgenv().Nakano.AutoSave then SaveConfig() end

        if v then
            pcall(function()
                game.Lighting.GlobalShadows = false
                settings().Rendering.QualityLevel = 1
            end)

            -- Aggressive visual cleanup for lower-end devices.
            pcall(function()
                local lighting = game:GetService("Lighting")

                for _,obj in ipairs(lighting:GetChildren()) do
                    if obj:IsA("PostEffect") then
                        obj.Enabled = false
                    elseif obj:IsA("Atmosphere") then
                        obj.Density = 0
                        obj.Haze = 0
                        obj.Glare = 0
                    end
                end

                local terrain = workspace:FindFirstChildOfClass("Terrain")
                if terrain then
                    pcall(function() terrain.Decoration = false end)
                    pcall(function() terrain.WaterWaveSize = 0 end)
                    pcall(function() terrain.WaterWaveSpeed = 0 end)
                    pcall(function() terrain.WaterReflectance = 0 end)
                    pcall(function() terrain.WaterTransparency = 1 end)
                end
            end)

            for _,obj in ipairs(workspace:GetDescendants()) do
                pcall(function()
                    if obj:IsA("BasePart") then
                        obj.Material = Enum.Material.SmoothPlastic
                        obj.CastShadow = false
                        if obj:IsA("MeshPart") then
                            obj.RenderFidelity = Enum.RenderFidelity.Performance
                        end
                    elseif obj:IsA("ParticleEmitter")
                        or obj:IsA("Trail")
                        or obj:IsA("Beam")
                        or obj:IsA("Smoke")
                        or obj:IsA("Fire")
                        or obj:IsA("Sparkles") then
                        obj.Enabled = false
                    elseif obj:IsA("PointLight")
                        or obj:IsA("SpotLight")
                        or obj:IsA("SurfaceLight") then
                        obj.Enabled = false
                    elseif obj:IsA("Clouds") then
                        obj.Enabled = false
                    elseif obj:IsA("Highlight") then
                        obj.Enabled = false
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                        -- Keep textures/images intact; do not destroy them.
                        -- Only reduce costly transparency effects.
                        if obj.Transparency < 1 then
                            obj.Transparency = math.min(1, obj.Transparency + 0.15)
                        end
                    end
                end)
            end
        end
    end
)

MakeToggle(
    "FOLLOW ENEMY",
    "Follow the selected player without teleporting",
    getgenv().Nakano.FollowEnemy == true,
    function(v)
        getgenv().Nakano.FollowEnemy = v
        -- Keep the legacy AutoTP state off: this feature never teleports.
        getgenv().Nakano.AutoTP = false
        if getgenv().Nakano.AutoSave then SaveConfig() end
    end
)

MakeToggle(
    "AIMBOT PVP",
    "Turn your character toward the closest player",
    getgenv().Nakano.Aim == true,
    function(v)
        getgenv().Nakano.Aim = v
        if getgenv().Nakano.AutoSave then SaveConfig() end
    end
)

MakeToggle(
    "CAM LOCK",
    "Lock the camera onto the closest player",
    getgenv().Nakano.CamLock == true,
    function(v)
        getgenv().Nakano.CamLock = v
        if getgenv().Nakano.AutoSave then SaveConfig() end
    end
)

MakeToggle(
    "AUTO ACTIVE V4",
    "Automatically press Y",
    getgenv().Nakano.AutoV4 == true,
    function(v)
        getgenv().Nakano.AutoV4 = v
        if getgenv().Nakano.AutoSave then SaveConfig() end
    end
)

--========================================================--
-- AUTO SAVE
--========================================================--

MakeToggle(
    "AUTO SAVE",
    "Automatically save hub configuration",
    getgenv().Nakano.AutoSave == true,
    function(v)
        getgenv().Nakano.AutoSave = v
        if v then
            SaveConfig()
        end
    end
)

--========================================================--
-- PREMIUM
--========================================================--

local premium = Instance.new("Frame",main)
premium.Size = UDim2.new(1,-20,0,34)
premium.Position = UDim2.new(0,10,1,-42)
premium.BackgroundColor3 = PINK_BRIGHT
premium.BackgroundTransparency = 0.40
Instance.new("UICorner",premium).CornerRadius = UDim.new(0,10)
local premiumStroke = Instance.new("UIStroke",premium)
premiumStroke.Color = PINK_SOFT
premiumStroke.Thickness = 2
premiumStroke.Transparency = 0.15

local premiumText = Instance.new("TextLabel",premium)
premiumText.Size = UDim2.new(1,0,1,0)
premiumText.BackgroundTransparency = 1
premiumText.Text = "Nino Nakano 馃挄馃尭"
premiumText.Font = PIXEL
premiumText.TextSize = 11
premiumText.TextColor3 = Color3.new(1,1,1)

--========================================================--
-- PLAYER EVENTS
--========================================================--

plr.CharacterAdded:Connect(function()
    task.wait(0.5)
    if ESPEnabled then
        RefreshESP()
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if ESPEnabled then
            CreateESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

--========================================================--
-- AIM
--========================================================--

local function GetClosestPlayer()
    local closest
    local distance = getgenv().Nakano.FOV

    for _,v in pairs(Players:GetPlayers()) do
        if v ~= plr
        and v.Character
        and v.Character:FindFirstChild("HumanoidRootPart")
        and v.Character:FindFirstChild("Humanoid") then

            if v.Character.Humanoid.Health > 0 then
                local pos,onScreen =
                    cam:WorldToViewportPoint(
                        v.Character.HumanoidRootPart.Position
                    )

                if onScreen then
                    local mag =
                        (
                            Vector2.new(pos.X,pos.Y)
                            -
                            Vector2.new(
                                cam.ViewportSize.X/2,
                                cam.ViewportSize.Y/2
                            )
                        ).Magnitude

                    if mag < distance then
                        distance = mag
                        closest = v
                    end
                end
            end
        end
    end

    return closest
end

RS.RenderStepped:Connect(function()
    local aimEnabled = getgenv().Nakano.Aim == true
    local camLockEnabled = getgenv().Nakano.CamLock == true

    if not aimEnabled and not camLockEnabled then
        return
    end

    local target = GetClosestPlayer()
    if not target or not target.Character then
        return
    end

    local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end

    -- Smooth camera lock instead of snapping every frame.
    if camLockEnabled then
        local desired = CFrame.lookAt(cam.CFrame.Position, targetRoot.Position)
        cam.CFrame = cam.CFrame:Lerp(desired, 0.35)
    end

    -- Aim stays independent from CamLock.
    if aimEnabled then
        local myCharacter = plr.Character
        local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")

        if myRoot then
            local myPos = myRoot.Position
            local targetPos = targetRoot.Position
            local flatTarget = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)

            if (flatTarget - myPos).Magnitude > 0.05 then
                local desiredRoot = CFrame.lookAt(myPos, flatTarget)
                myRoot.CFrame = myRoot.CFrame:Lerp(desiredRoot, 0.25)
            end
        end
    end
end)

--========================================================--
-- FOLLOW ENEMY 鈥� NO TELEPORT
-- Keeps a visible camera-to-target guide and follows the
-- selected enemy using normal movement instead of CFrame TP.
--========================================================--

local followLine = nil

local function UpdateFollowLine(target)
    if not getgenv().Nakano.FollowEnemy or not target
    or not target.Character then
        if followLine then
            followLine:Destroy()
            followLine = nil
        end
        return
    end

    local root = target.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if not followLine then
        followLine = Instance.new("Beam")
        followLine.Name = "NakanoFollowLine"
        followLine.FaceCamera = true
        followLine.Width0 = 0.035
        followLine.Width1 = 0.035
        followLine.LightEmission = 1
        followLine.Color = ColorSequence.new(PINK_BRIGHT)

        local a0 = Instance.new("Attachment")
        a0.Name = "NakanoCameraGuide"
        a0.Parent = workspace.Terrain

        local a1 = Instance.new("Attachment")
        a1.Name = "NakanoTargetGuide"
        a1.Parent = root

        followLine.Attachment0 = a0
        followLine.Attachment1 = a1
        followLine.Parent = workspace.Terrain
    end

    local cameraAttachment = followLine.Attachment0
    if cameraAttachment then
        cameraAttachment.WorldPosition = cam.CFrame.Position
    end

    if followLine.Attachment1.Parent ~= root then
        followLine.Attachment1.Parent = root
    end
end

local function StopFollowLine()
    if followLine then
        followLine:Destroy()
        followLine = nil
    end
end

RS.RenderStepped:Connect(function()
    if not getgenv().Nakano.FollowEnemy then
        StopFollowLine()
        return
    end

    local target = GetClosestPlayer()

    if not target
    or not target.Character
    or not target.Character:FindFirstChild("HumanoidRootPart") then
        StopFollowLine()
        return
    end

    UpdateFollowLine(target)

    local myCharacter = plr.Character
    local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
    local humanoid = myCharacter and myCharacter:FindFirstChildOfClass("Humanoid")

    if myRoot and humanoid and humanoid.Health > 0 then
        local targetRoot = target.Character.HumanoidRootPart
        local offset = targetRoot.Position - targetRoot.CFrame.LookVector * 5
        local delta = offset - myRoot.Position

        if delta.Magnitude > 7 then
            humanoid:MoveTo(offset)
        else
            humanoid:Move(Vector3.zero, false)
        end
    end
end)

--========================================================--
-- AUTO V4
--========================================================--

task.spawn(function()
    while task.wait(0.35) do
        if not getgenv().Nakano.AutoV4 then
            continue
        end

        local character = plr.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if not humanoid or humanoid.Health <= 0 then
            continue
        end

        -- Do not spam Y while Roblox is still transitioning the character
        -- between movement/death/respawn states.
        local state = humanoid:GetState()

        if state == Enum.HumanoidStateType.Dead
        or state == Enum.HumanoidStateType.Physics
        or state == Enum.HumanoidStateType.PlatformStanding then
            continue
        end

        pcall(function()
            VIM:SendKeyEvent(true, "Y", false, game)
            task.wait(0.06)
            VIM:SendKeyEvent(false, "Y", false, game)
        end)

        -- Give Roblox movement/input a short window before the next attempt.
        task.wait(0.45)
    end
end)

task.spawn(function()
    while task.wait(5) do
        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end
    end
end)

print("NAKANO HUB V13 鈥� LOADED")
