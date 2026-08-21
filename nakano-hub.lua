--// NAKANO HUB V13 • MIKU + BANANA CAT + SAKURA
--// By Kervie_Kuchau95
--// Mobile-safe Miku drag
--// AUTO TP: nearest player by REAL 3D distance
--// AIMBOT: keeps FOV-based selection
--// ESP: NAME + HEALTH + DISTANCE + LEVEL
--// AUTO SAVE: CONFIGURATION PERSISTENCE
--// AUTO V4: RESPAWN SAFE

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera

--========================================================--
-- CONFIG
--========================================================--

local CONFIG_FILE = "NakanoHub_V13_Config.json"

local DEFAULT_CONFIG = {
    AutoTP = false,
    AutoV4 = false,
    Aim = false,
    ESP = false,
    Boost = false,

    ESPName = true,
    ESPHealth = false,
    ESPDistance = false,
    ESPLevel = true,

    FOV = 300
}

local function cloneTable(tbl)
    local new = {}

    for k,v in pairs(tbl) do
        new[k] = v
    end

    return new
end

local function LoadConfig()

    local config = cloneTable(DEFAULT_CONFIG)

    if not isfile or not readfile then
        return config
    end

    pcall(function()

        if isfile(CONFIG_FILE) then

            local data = readfile(CONFIG_FILE)
            local decoded = HttpService:JSONDecode(data)

            if type(decoded) == "table" then

                for key,value in pairs(decoded) do

                    if config[key] ~= nil then
                        config[key] = value
                    end

                end

            end

        end

    end)

    return config
end

local function SaveConfig()

    if not writefile then
        return
    end

    pcall(function()

        writefile(
            CONFIG_FILE,
            HttpService:JSONEncode(getgenv().Nakano)
        )

    end)
end

local savedConfig = LoadConfig()

getgenv().Nakano = getgenv().Nakano or {}

for key,value in pairs(DEFAULT_CONFIG) do
    getgenv().Nakano[key] = savedConfig[key]
end

--========================================================--
-- GUI
--========================================================--

if game.CoreGui:FindFirstChild("NakanoV13") then
    game.CoreGui.NakanoV13:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NakanoV13"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local PIXEL = Enum.Font.Arcade

--========================================================--
-- NOTIFICATION • 10 SECONDS
--========================================================--

local notif = Instance.new("Frame",gui)
notif.Size = UDim2.new(0,310,0,82)
notif.Position = UDim2.new(1,-325,1,-105)
notif.BackgroundColor3 = Color3.fromRGB(18,18,26)
notif.BackgroundTransparency = 0.12

Instance.new("UICorner",notif).CornerRadius = UDim.new(0,12)

local notifStroke = Instance.new("UIStroke",notif)
notifStroke.Color = Color3.fromRGB(255,105,180)
notifStroke.Thickness = 2

local notifImg = Instance.new("ImageLabel",notif)
notifImg.Size = UDim2.new(0,68,0,68)
notifImg.Position = UDim2.new(0,7,0.5,-34)
notifImg.BackgroundTransparency = 1
notifImg.Image = "rbxassetid://118017336964341"
notifImg.ScaleType = Enum.ScaleType.Crop

Instance.new("UICorner",notifImg).CornerRadius = UDim.new(1,0)

local notifTitle = Instance.new("TextLabel",notif)
notifTitle.Size = UDim2.new(1,-85,0,24)
notifTitle.Position = UDim2.new(0,82,0,15)
notifTitle.BackgroundTransparency = 1
notifTitle.Text = "NAKANO HUB ⚡"
notifTitle.Font = PIXEL
notifTitle.TextSize = 16
notifTitle.TextColor3 = Color3.fromRGB(255,170,220)
notifTitle.TextXAlignment = Enum.TextXAlignment.Left

local notifBy = Instance.new("TextLabel",notif)
notifBy.Size = UDim2.new(1,-85,0,20)
notifBy.Position = UDim2.new(0,82,0,42)
notifBy.BackgroundTransparency = 1
notifBy.Text = "by Kervie_Kuchau95"
notifBy.Font = PIXEL
notifBy.TextSize = 11
notifBy.TextColor3 = Color3.new(1,1,1)
notifBy.TextXAlignment = Enum.TextXAlignment.Left

task.delay(10,function()

    if not notif or not notif.Parent then
        return
    end

    local info = TweenInfo.new(
        0.65,
        Enum.EasingStyle.Quad
    )

    TS:Create(notif,info,{
        BackgroundTransparency = 1
    }):Play()

    TS:Create(notifStroke,info,{
        Transparency = 1
    }):Play()

    TS:Create(notifImg,info,{
        ImageTransparency = 1
    }):Play()

    TS:Create(notifTitle,info,{
        TextTransparency = 1
    }):Play()

    TS:Create(notifBy,info,{
        TextTransparency = 1
    }):Play()

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
main.BackgroundColor3 = Color3.fromRGB(18,18,26)
main.BackgroundTransparency = 0.25
main.Visible = false
main.Active = true

Instance.new("UICorner",main).CornerRadius = UDim.new(0,16)

local mainStroke = Instance.new("UIStroke",main)
mainStroke.Color = Color3.fromRGB(255,105,180)
mainStroke.Thickness = 2

--========================================================--
-- MIKU BUTTON
--========================================================--

local miku = Instance.new("ImageButton",gui)
miku.Size = UDim2.new(0,68,0,68)
miku.Position = UDim2.new(0,20,1,-88)
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
            TweenInfo.new(
                0.3,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Size = UDim2.new(0,395,0,470)
            }
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

    petal.Text = "🌸"
    petal.Size = UDim2.new(0,20,0,20)
    petal.Position = UDim2.new(math.random(),0,-0.1,0)
    petal.BackgroundTransparency = 1
    petal.TextSize = math.random(12,18)
    petal.ZIndex = 10

    task.spawn(function()

        while task.wait(math.random(4,8)) do

            if not petal.Parent then
                break
            end

            petal.Position =
                UDim2.new(math.random(),0,-0.1,0)

            TS:Create(
                petal,
                TweenInfo.new(
                    math.random(5,9),
                    Enum.EasingStyle.Linear
                ),
                {
                    Position =
                        UDim2.new(
                            petal.Position.X.Scale,
                            0,
                            1.1,
                            0
                        )
                }
            ):Play()

        end

    end)

end

--========================================================--
-- HEADER
--========================================================--

local top = Instance.new("Frame",main)
top.Size = UDim2.new(1,0,0,42)
top.BackgroundColor3 = Color3.fromRGB(255,105,180)
top.BackgroundTransparency = 0.2

Instance.new("UICorner",top).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel",top)
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,15,0,0)
title.BackgroundTransparency = 1
title.Text = "NAKANO HUB • MIKU 🍌🌸"
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
scroll.CanvasSize = UDim2.new(0,0,0,1100)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

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
    nameLabel.TextColor3 = Color3.fromRGB(255,170,215)
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
        default
        and Color3.fromRGB(255,130,190)
        or Color3.fromRGB(80,55,70)

    Instance.new("UICorner",switch).CornerRadius = UDim.new(1,0)

    local dot = Instance.new("Frame",switch)
    dot.Size = UDim2.new(0,20,0,20)

    dot.Position =
        default
        and UDim2.new(1,-23,0.5,-10)
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
                state
                and Color3.fromRGB(255,130,190)
                or Color3.fromRGB(80,55,70)
        }):Play()

        TS:Create(dot,TweenInfo.new(0.2),{
            Position =
                state
                and UDim2.new(1,-23,0.5,-10)
                or UDim2.new(0,3,0.5,-10)
        }):Play()

        callback(state)

    end)

    return frame
end

--========================================================--
-- ESP
--========================================================--

local ESPEnabled = getgenv().Nakano.ESP
local ESPName = getgenv().Nakano.ESPName
local ESPHealth = getgenv().Nakano.ESPHealth
local ESPDistance = getgenv().Nakano.ESPDistance
local ESPLevel = getgenv().Nakano.ESPLevel

local ESP_MAX_DISTANCE = 5000
local MAX_LEVEL = 2800

local ESPObjects = {}

local function RemoveESP(player)

    if ESPObjects[player] then

        ESPObjects[player]:Destroy()
        ESPObjects[player] = nil

    end

end

--========================================================--
-- LEVEL DETECTOR
--========================================================--

local function GetPlayerLevel(player)

    local level = nil

    pcall(function()

        local leaderstats =
            player:FindFirstChild("leaderstats")

        if leaderstats then

            local levelValue =
                leaderstats:FindFirstChild("Level")

            if levelValue and tonumber(levelValue.Value) then
                level = tonumber(levelValue.Value)
            end

        end

        if not level then

            local data =
                player:FindFirstChild("Data")

            if data then

                local levelValue =
                    data:FindFirstChild("Level")

                if levelValue and tonumber(levelValue.Value) then
                    level = tonumber(levelValue.Value)
                end

            end

        end

        if not level then

            local character =
                player.Character

            if character then

                local levelValue =
                    character:FindFirstChild("Level")

                if levelValue and tonumber(levelValue.Value) then
                    level = tonumber(levelValue.Value)
                end

            end

        end

    end)

    if level then

        -- Mantiene el nivel dentro del rango del juego
        level = math.clamp(
            math.floor(level),
            0,
            MAX_LEVEL
        )

    end

    return level
end

--========================================================--
-- CREATE ESP
--========================================================--

local function CreateESP(player)

    if player == plr or not ESPEnabled then
        return
    end

    local character = player.Character

    if not character then
        return
    end

    local head =
        character:FindFirstChild("Head")

    if not head then
        return
    end

    RemoveESP(player)

    local billboard =
        Instance.new("BillboardGui")

    billboard.Name = "NakanoESP"
    billboard.Parent = head
    billboard.Size = UDim2.new(0,210,0,95)
    billboard.StudsOffset = Vector3.new(0,3.2,0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = ESP_MAX_DISTANCE

    local text =
        Instance.new("TextLabel",billboard)

    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Font = PIXEL
    text.TextSize = 12
    text.TextColor3 =
        Color3.fromRGB(255,150,210)

    text.TextStrokeTransparency = 0.2
    text.TextWrapped = true

    ESPObjects[player] = billboard

    task.spawn(function()

        while billboard.Parent
        and ESPEnabled
        and player.Character == character do

            local humanoid =
                character:FindFirstChildOfClass(
                    "Humanoid"
                )

            local root =
                character:FindFirstChild(
                    "HumanoidRootPart"
                )

            local lines = {}

            -- NAME
            if ESPName then
                table.insert(
                    lines,
                    player.Name
                )
            end

            -- LEVEL
            if ESPLevel then

                local level =
                    GetPlayerLevel(player)

                if level then

                    table.insert(
                        lines,
                        "Level: "
                        .. level
                        .. "/"
                        .. MAX_LEVEL
                    )

                else

                    table.insert(
                        lines,
                        "Level: ?/"
                        .. MAX_LEVEL
                    )

                end

            end

            -- HEALTH
            if ESPHealth and humanoid then

                table.insert(
                    lines,
                    "HP: "
                    .. math.floor(humanoid.Health)
                    .. "/"
                    .. math.floor(humanoid.MaxHealth)
                )

            end

            -- DISTANCE
            if ESPDistance
            and root
            and plr.Character
            and plr.Character:FindFirstChild(
                "HumanoidRootPart"
            ) then

                local myRoot =
                    plr.Character.HumanoidRootPart

                local distance =
                    (
                        root.Position
                        - myRoot.Position
                    ).Magnitude

                if distance <= ESP_MAX_DISTANCE then

                    table.insert(
                        lines,
                        "Distance: "
                        .. math.floor(distance)
                        .. "m"
                    )

                end

            end

            text.Text =
                table.concat(lines,"\n")

            task.wait(0.15)

        end

        if billboard then
            billboard:Destroy()
        end

    end)

end

local function RefreshESP()

    for _,player in ipairs(
        Players:GetPlayers()
    ) do

        if player ~= plr then

            if ESPEnabled then
                CreateESP(player)
            else
                RemoveESP(player)
            end

        end

    end

end

--========================================================--
-- ESP OPTIONS
--========================================================--

local espOptions =
    Instance.new("Frame",scroll)

espOptions.Size =
    UDim2.new(1,0,0,0)

espOptions.BackgroundTransparency = 1
espOptions.Visible = ESPEnabled
espOptions.ClipsDescendants = true

local espLayout =
    Instance.new("UIListLayout",espOptions)

espLayout.Padding = UDim.new(0,2)

local function MakeESPOption(
    name,
    default,
    callback
)

    local row =
        Instance.new("Frame",espOptions)

    row.Size =
        UDim2.new(1,-25,0,38)

    row.BackgroundTransparency = 1

    local label =
        Instance.new("TextLabel",row)

    label.Size =
        UDim2.new(0.7,0,1,0)

    label.Position =
        UDim2.new(0,30,0,0)

    label.BackgroundTransparency = 1
    label.Text = "• "..name
    label.Font = PIXEL
    label.TextSize = 9
    label.TextColor3 =
        Color3.fromRGB(230,190,215)

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    local sw =
        Instance.new("Frame",row)

    sw.Size =
        UDim2.new(0,42,0,20)

    sw.Position =
        UDim2.new(1,-48,0.5,-10)

    sw.BackgroundColor3 =
        default
        and Color3.fromRGB(255,130,190)
        or Color3.fromRGB(80,55,70)

    Instance.new("UICorner",sw).CornerRadius =
        UDim.new(1,0)

    local dot =
        Instance.new("Frame",sw)

    dot.Size =
        UDim2.new(0,16,0,16)

    dot.Position =
        default
        and UDim2.new(1,-19,0.5,-8)
        or UDim2.new(0,3,0.5,-8)

    dot.BackgroundColor3 =
        Color3.new(1,1,1)

    Instance.new("UICorner",dot).CornerRadius =
        UDim.new(1,0)

    local button =
        Instance.new("TextButton",row)

    button.Size =
        UDim2.new(1,0,1,0)

    button.BackgroundTransparency = 1
    button.Text = ""

    local state = default

    button.MouseButton1Click:Connect(function()

        state = not state

        TS:Create(sw,TweenInfo.new(0.18),{
            BackgroundColor3 =
                state
                and Color3.fromRGB(255,130,190)
                or Color3.fromRGB(80,55,70)
        }):Play()

        TS:Create(dot,TweenInfo.new(0.18),{
            Position =
                state
                and UDim2.new(1,-19,0.5,-8)
                or UDim2.new(0,3,0.5,-8)
        }):Play()

        callback(state)

    end)

end

MakeToggle(
    "ESP",
    "Player information overlay",
    ESPEnabled,
    function(v)

        ESPEnabled = v
        getgenv().Nakano.ESP = v

        espOptions.Visible = v

        if v then

            task.wait()

            espOptions.Size =
                UDim2.new(
                    1,
                    0,
                    0,
                    espLayout.AbsoluteContentSize.Y + 4
                )

        else

            espOptions.Size =
                UDim2.new(1,0,0,0)

        end

        RefreshESP()

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

MakeESPOption(
    "SHOW NAME",
    ESPName,
    function(v)

        ESPName = v
        getgenv().Nakano.ESPName = v

        RefreshESP()

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

MakeESPOption(
    "SHOW HEALTH",
    ESPHealth,
    function(v)

        ESPHealth = v
        getgenv().Nakano.ESPHealth = v

        RefreshESP()

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

MakeESPOption(
    "SHOW DISTANCE",
    ESPDistance,
    function(v)

        ESPDistance = v
        getgenv().Nakano.ESPDistance = v

        RefreshESP()

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

MakeESPOption(
    "SHOW LEVEL",
    ESPLevel,
    function(v)

        ESPLevel = v
        getgenv().Nakano.ESPLevel = v

        RefreshESP()

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

--========================================================--
-- FPS BOOST
--========================================================--

MakeToggle(
    "FPS BOOST ULTRA",
    "Reduce lag and improve performance",
    getgenv().Nakano.Boost,
    function(v)

        getgenv().Nakano.Boost = v

        if v then

            game.Lighting.GlobalShadows = false
            settings().Rendering.QualityLevel = 1

            for _,obj in pairs(
                workspace:GetDescendants()
            ) do

                if obj:IsA("BasePart") then

                    obj.Material =
                        Enum.Material.SmoothPlastic

                    obj.CastShadow = false

                elseif obj:IsA("ParticleEmitter") then

                    obj.Enabled = false

                end

            end

        end

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

--========================================================--
-- AUTO TP
--========================================================--

MakeToggle(
    "AUTO TP PLAYER",
    "Always teleport to the nearest living player",
    getgenv().Nakano.AutoTP,
    function(v)

        getgenv().Nakano.AutoTP = v

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

--========================================================--
-- AIMBOT
--========================================================--

MakeToggle(
    "AIMBOT PVP",
    "Lock onto the closest player inside FOV",
    getgenv().Nakano.Aim,
    function(v)

        getgenv().Nakano.Aim = v

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

--========================================================--
-- AUTO V4
--========================================================--

MakeToggle(
    "AUTO ACTIVE V4",
    "Automatically press Y",
    getgenv().Nakano.AutoV4,
    function(v)

        getgenv().Nakano.AutoV4 = v

        -- Al apagarlo, queda completamente detenido
        if not v then
            getgenv().Nakano.V4Busy = false
        end

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end
)

--========================================================--
-- AUTO SAVE
--========================================================--

MakeToggle(
    "AUTO SAVE",
    "Automatically save hub configuration",
    false,
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

local premium =
    Instance.new("Frame",main)

premium.Size =
    UDim2.new(1,-20,0,34)

premium.Position =
    UDim2.new(0,10,1,-42)

premium.BackgroundColor3 =
    Color3.fromRGB(255,105,180)

premium.BackgroundTransparency = 0.15

Instance.new("UICorner",premium).CornerRadius =
    UDim.new(0,10)

local premiumText =
    Instance.new("TextLabel",premium)

premiumText.Size =
    UDim2.new(1,0,1,0)

premiumText.BackgroundTransparency = 1
premiumText.Text =
    "PREMIUM • MIKU NAKANO • V13"

premiumText.Font = PIXEL
premiumText.TextSize = 11
premiumText.TextColor3 =
    Color3.new(1,1,1)

--========================================================--
-- PLAYER EVENTS
--========================================================--

local function HandleRespawn()

    -- IMPORTANTE:
    -- Después de morir no dejamos Auto V4
    -- intentando trabajar con el personaje viejo.

    getgenv().Nakano.V4Busy = false

    task.wait(1)

    local character =
        plr.Character

    if not character then
        return
    end

    local humanoid =
        character:FindFirstChildOfClass(
            "Humanoid"
        )

    local root =
        character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not humanoid or not root then
        return
    end

    -- Esperamos a que el nuevo personaje
    -- realmente esté vivo antes de continuar.

    if humanoid.Health <= 0 then
        return
    end

    if ESPEnabled then
        RefreshESP()
    end

end

plr.CharacterAdded:Connect(function(character)

    -- Desactivar temporalmente V4 durante respawn
    getgenv().Nakano.V4Busy = false

    task.spawn(function()

        local humanoid =
            character:WaitForChild(
                "Humanoid",
                10
            )

        if humanoid then

            humanoid.Died:Connect(function()

                -- Evita que el loop de V4
                -- siga enviando Y al morir.

                getgenv().Nakano.V4Busy = false

            end)

        end

        HandleRespawn()

    end)

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
-- AIMBOT • FOV SELECTION
--========================================================--

local function GetClosestPlayer()

    local closest
    local distance =
        getgenv().Nakano.FOV

    for _,v in pairs(
        Players:GetPlayers()
    ) do

        if v ~= plr
        and v.Character
        and v.Character:FindFirstChild(
            "HumanoidRootPart"
        )
        and v.Character:FindFirstChild(
            "Humanoid"
        ) then

            local humanoid =
                v.Character:FindFirstChild(
                    "Humanoid"
                )

            if humanoid.Health > 0 then

                local pos,onScreen =
                    cam:WorldToViewportPoint(
                        v.Character.HumanoidRootPart.Position
                    )

                if onScreen then

                    local mag =
                        (
                            Vector2.new(
                                pos.X,
                                pos.Y
                            )
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

--========================================================--
-- AIMBOT LOOP
--========================================================--

RS.RenderStepped:Connect(function()

    if getgenv().Nakano.Aim then

        local character =
            plr.Character

        local humanoid =
            character
            and character:FindFirstChildOfClass(
                "Humanoid"
            )

        if not humanoid
        or humanoid.Health <= 0 then
            return
        end

        local target =
            GetClosestPlayer()

        if target
        and target.Character
        and target.Character:FindFirstChild(
            "HumanoidRootPart"
        ) then

            cam.CFrame =
                CFrame.new(
                    cam.CFrame.Position,
                    target.Character.HumanoidRootPart.Position
                )

        end

    end

end)

--========================================================--
-- AUTO TP • REAL 3D DISTANCE
--========================================================--

local function GetNearestPlayerForTP()

    local character =
        plr.Character

    if not character then
        return nil
    end

    local myRoot =
        character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not myRoot then
        return nil
    end

    local nearest = nil
    local nearestDistance =
        math.huge

    for _,player in ipairs(
        Players:GetPlayers()
    ) do

        if player ~= plr
        and player.Character then

            local targetRoot =
                player.Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            local humanoid =
                player.Character:FindFirstChildOfClass(
                    "Humanoid"
                )

            if targetRoot
            and humanoid
            and humanoid.Health > 0 then

                local distance =
                    (
                        targetRoot.Position
                        - myRoot.Position
                    ).Magnitude

                if distance < nearestDistance then

                    nearestDistance =
                        distance

                    nearest = player

                end

            end

        end

    end

    return nearest

end

task.spawn(function()

    while task.wait(0.35) do

        if getgenv().Nakano.AutoTP then

            pcall(function()

                local character =
                    plr.Character

                if not character then
                    return
                end

                local myHumanoid =
                    character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if not myHumanoid
                or myHumanoid.Health <= 0 then
                    return
                end

                local myRoot =
                    character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if not myRoot then
                    return
                end

                local target =
                    GetNearestPlayerForTP()

                if target
                and target.Character then

                    local targetRoot =
                        target.Character:FindFirstChild(
                            "HumanoidRootPart"
                        )

                    local targetHumanoid =
                        target.Character:FindFirstChildOfClass(
                            "Humanoid"
                        )

                    if targetRoot
                    and targetHumanoid
                    and targetHumanoid.Health > 0 then

                        myRoot.CFrame =
                            CFrame.new(
                                targetRoot.Position
                                + Vector3.new(2,1,2)
                            )

                    end

                end

            end)

        end

    end

end)

--========================================================--
-- AUTO V4 • RESPAWN SAFE
--========================================================--

task.spawn(function()

    while task.wait(2) do

        if getgenv().Nakano.AutoV4 then

            pcall(function()

                local character =
                    plr.Character

                if not character then
                    return
                end

                local humanoid =
                    character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                local root =
                    character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                -- NO mandar Y si estamos muertos
                if not humanoid
                or humanoid.Health <= 0
                or not root then

                    getgenv().Nakano.V4Busy = false
                    return

                end

                -- Evita ejecuciones simultáneas
                if getgenv().Nakano.V4Busy then
                    return
                end

                getgenv().Nakano.V4Busy = true

                VIM:SendKeyEvent(
                    true,
                    "Y",
                    false,
                    game
                )

                task.wait(0.1)

                -- Comprobar otra vez por si murió
                -- durante el pequeño intervalo.

                if humanoid
                and humanoid.Parent
                and humanoid.Health > 0 then

                    VIM:SendKeyEvent(
                        false,
                        "Y",
                        false,
                        game
                    )

                else

                    -- Asegurar que no quede
                    -- una tecla virtual presionada.

                    VIM:SendKeyEvent(
                        false,
                        "Y",
                        false,
                        game
                    )

                end

                getgenv().Nakano.V4Busy = false

            end)

        else

            getgenv().Nakano.V4Busy = false

        end

    end

end)

--========================================================--
-- AUTO SAVE LOOP
--========================================================--

task.spawn(function()

    while task.wait(5) do

        if getgenv().Nakano.AutoSave then
            SaveConfig()
        end

    end

end)

--========================================================--
-- UPDATE CAMERA
--========================================================--

workspace:GetPropertyChangedSignal(
    "CurrentCamera"
):Connect(function()

    cam = workspace.CurrentCamera

end)

--========================================================--
-- INITIAL ESP
--========================================================--

if ESPEnabled then

    task.defer(function()

        task.wait(1)
        RefreshESP()

    end)

end

print("NAKANO HUB V13 • LOADED")
print("AUTO TP • REAL 3D NEAREST PLAYER")
print("AIMBOT • FOV SELECTION")
print("ESP • NAME / HEALTH / DISTANCE / LEVEL")
print("ESP MAX DISTANCE • 5000")
print("MAX LEVEL • 2800")
print("AUTO V4 • RESPAWN SAFE")
print("AUTO SAVE • READY")
