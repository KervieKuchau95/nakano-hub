--// NAKANO HUB V13 • MIKU + BANANA CAT + SAKURA
--// By Kervie_Kuchau95

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera

getgenv().Nakano = getgenv().Nakano or {
    AutoTP = false,
    AutoV4 = false,
    Aim = false,
    ESP = false,
    Boost = false,
    AutoSave = false,
    FOV = 300
}

--========================================================--
-- CONFIG
--========================================================--

local CONFIG_FILE = "NakanoHub_V13_Config.json"
local MAX_LEVEL = 2800
local ESP_MAX_DISTANCE = 2000

--========================================================--
-- LOAD CONFIG
--========================================================--

local function LoadConfig()

    if not isfile or not isfile(CONFIG_FILE) then
        return
    end

    local success, data = pcall(function()

        return HttpService:JSONDecode(
            readfile(CONFIG_FILE)
        )

    end)

    if success and type(data) == "table" then

        for key,value in pairs(data) do

            if getgenv().Nakano[key] ~= nil then
                getgenv().Nakano[key] = value
            end

        end

    end

end

LoadConfig()

--========================================================--
-- SAVE CONFIG
--========================================================--

local function SaveConfig()

    if not writefile then
        return
    end

    pcall(function()

        writefile(
            CONFIG_FILE,
            HttpService:JSONEncode({
                AutoTP = getgenv().Nakano.AutoTP,
                AutoV4 = getgenv().Nakano.AutoV4,
                Aim = getgenv().Nakano.Aim,
                ESP = getgenv().Nakano.ESP,
                Boost = getgenv().Nakano.Boost,
                AutoSave = getgenv().Nakano.AutoSave,
                FOV = getgenv().Nakano.FOV
            })
        )

    end)

end

--========================================================--
-- REMOVE OLD GUI
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
-- NOTIFICATION
--========================================================--

local notif = Instance.new("Frame", gui)
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

-- 10 SEGUNDOS
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
-- MIKU BUTTON
--========================================================--

local miku = Instance.new("ImageButton",gui)
miku.Size = UDim2.new(0,72,0,72)
miku.Position = UDim2.new(0,22,1,-92)
miku.BackgroundTransparency = 1
miku.Image = "rbxassetid://118017336964341"
miku.ScaleType = Enum.ScaleType.Crop
miku.AutoButtonColor = false

Instance.new("UICorner",miku).CornerRadius = UDim.new(1,0)

local dragging = false
local dragStart
local startPos
local moved = false

miku.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        moved = false
        dragStart = input.Position
        startPos = miku.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end

        end)

    end

end)

miku.InputChanged:Connect(function(input)

    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - dragStart

        if math.abs(delta.X) > 8
        or math.abs(delta.Y) > 8 then
            moved = true
        end

        miku.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )

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

            petal.Position =
                UDim2.new(math.random(),0,-0.1,0)

            TS:Create(
                petal,
                TweenInfo.new(
                    math.random(5,9),
                    Enum.EasingStyle.Linear
                ),
                {
                    Position = UDim2.new(
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
scroll.CanvasSize = UDim2.new(0,0,0,1000)

local layout = Instance.new("UIListLayout",scroll)
layout.Padding = UDim.new(0,8)

local padding = Instance.new("UIPadding",scroll)
padding.PaddingLeft = UDim.new(0,12)
padding.PaddingRight = UDim.new(0,12)
padding.PaddingTop = UDim.new(0,10)

--========================================================--
-- GENERIC TOGGLE
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
-- ESP SYSTEM
--========================================================--

local ESPEnabled = getgenv().Nakano.ESP
local ESPName = true
local ESPHealth = false
local ESPDistance = false
local ESPLevel = true

local ESPObjects = {}

local function GetPlayerLevel(player)

    -- Leaderstats
    local leaderstats = player:FindFirstChild("leaderstats")

    if leaderstats then

        local level =
            leaderstats:FindFirstChild("Level")
            or leaderstats:FindFirstChild("Lvl")
            or leaderstats:FindFirstChild("level")

        if level then
            local value = tonumber(level.Value)

            if value then
                return math.clamp(value,0,MAX_LEVEL)
            end
        end

    end

    -- Data
    local data = player:FindFirstChild("Data")

    if data then

        local level =
            data:FindFirstChild("Level")
            or data:FindFirstChild("Lvl")
            or data:FindFirstChild("level")

        if level then
            local value = tonumber(level.Value)

            if value then
                return math.clamp(value,0,MAX_LEVEL)
            end
        end

    end

    -- Direct Level
    local direct =
        player:FindFirstChild("Level")
        or player:FindFirstChild("Lvl")

    if direct then

        local value = tonumber(direct.Value)

        if value then
            return math.clamp(value,0,MAX_LEVEL)
        end

    end

    return nil

end

local function RemoveESP(player)

    if ESPObjects[player] then

        ESPObjects[player]:Destroy()
        ESPObjects[player] = nil

    end

end

local function CreateESP(player)

    if player == plr or not ESPEnabled then
        return
    end

    local character = player.Character

    if not character then
        return
    end

    local head = character:FindFirstChild("Head")

    if not head then
        return
    end

    RemoveESP(player)

    local billboard = Instance.new("BillboardGui")

    billboard.Name = "NakanoESP"
    billboard.Parent = head
    billboard.Size = UDim2.new(0,210,0,95)
    billboard.StudsOffset = Vector3.new(0,3,0)
    billboard.AlwaysOnTop = true

    -- MÁS ALCANCE
    billboard.MaxDistance = ESP_MAX_DISTANCE

    local text = Instance.new("TextLabel",billboard)

    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Font = PIXEL
    text.TextSize = 12
    text.TextColor3 = Color3.fromRGB(255,150,210)
    text.TextStrokeTransparency = 0.2
    text.TextWrapped = true

    ESPObjects[player] = billboard

    task.spawn(function()

        while billboard.Parent
        and ESPEnabled
        and player.Character == character do

            local humanoid =
                character:FindFirstChildOfClass("Humanoid")

            local root =
                character:FindFirstChild("HumanoidRootPart")

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

                local level = GetPlayerLevel(player)

                if level then

                    table.insert(
                        lines,
                        "LVL: "
                        .. tostring(level)
                        .. "/"
                        .. tostring(MAX_LEVEL)
                    )

                else

                    table.insert(
                        lines,
                        "LVL: ?/"
                        .. tostring(MAX_LEVEL)
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
            and plr.Character:FindFirstChild("HumanoidRootPart") then

                local distance =
                    (
                        root.Position
                        - plr.Character.HumanoidRootPart.Position
                    ).Magnitude

                table.insert(
                    lines,
                    "Distance: "
                    .. math.floor(distance)
                    .. "m"
                )

            end

            text.Text = table.concat(
                lines,
                "\n"
            )

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

--========================================================--
-- ESP DROPDOWN
--========================================================--

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
    label.Text = "• "..name
    label.Font = PIXEL
    label.TextSize = 9
    label.TextColor3 = Color3.fromRGB(230,190,215)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sw = Instance.new("Frame",row)
    sw.Size = UDim2.new(0,42,0,20)
    sw.Position = UDim2.new(1,-48,0.5,-10)

    sw.BackgroundColor3 =
        default
        and Color3.fromRGB(255,130,190)
        or Color3.fromRGB(80,55,70)

    Instance.new("UICorner",sw).CornerRadius = UDim.new(1,0)

    local dot = Instance.new("Frame",sw)
    dot.Size = UDim2.new(0,16,0,16)

    dot.Position =
        default
        and UDim2.new(1,-19,0.5,-8)
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
    getgenv().Nakano.ESP,
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

    end
)

MakeESPOption(
    "SHOW NAME",
    true,
    function(v)

        ESPName = v
        RefreshESP()

    end
)

MakeESPOption(
    "SHOW LEVEL",
    true,
    function(v)

        ESPLevel = v
        RefreshESP()

    end
)

MakeESPOption(
    "SHOW HEALTH",
    false,
    function(v)

        ESPHealth = v
        RefreshESP()

    end
)

MakeESPOption(
    "SHOW DISTANCE",
    false,
    function(v)

        ESPDistance = v
        RefreshESP()

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

            for _,obj in pairs(workspace:GetDescendants()) do

                if obj:IsA("BasePart") then

                    obj.Material = Enum.Material.SmoothPlastic
                    obj.CastShadow = false

                elseif obj:IsA("ParticleEmitter") then

                    obj.Enabled = false

                end

            end

        end

    end
)

--========================================================--
-- AUTO TP
--========================================================--

MakeToggle(
    "AUTO TP PLAYER",
    "Players only - NPC protection",
    getgenv().Nakano.AutoTP,
    function(v)

        getgenv().Nakano.AutoTP = v

    end
)

--========================================================--
-- AIMBOT
--========================================================--

MakeToggle(
    "AIMBOT PVP",
    "Lock onto the closest player",
    getgenv().Nakano.Aim,
    function(v)

        getgenv().Nakano.Aim = v

    end
)

--========================================================--
-- AUTO V4
--========================================================--

local V4Ready = true

MakeToggle(
    "AUTO ACTIVE V4",
    "Automatically press Y",
    getgenv().Nakano.AutoV4,
    function(v)

        getgenv().Nakano.AutoV4 = v

        if not v then
            V4Ready = true
        end

    end
)

--========================================================--
-- AUTO SAVE
--========================================================--

MakeToggle(
    "AUTO SAVE",
    "Automatically save hub settings",
    getgenv().Nakano.AutoSave,
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
premium.BackgroundColor3 = Color3.fromRGB(255,105,180)
premium.BackgroundTransparency = 0.15

Instance.new("UICorner",premium).CornerRadius = UDim.new(0,10)

local premiumText = Instance.new("TextLabel",premium)
premiumText.Size = UDim2.new(1,0,1,0)
premiumText.BackgroundTransparency = 1
premiumText.Text = "PREMIUM • MIKU NAKANO • V13"
premiumText.Font = PIXEL
premiumText.TextSize = 11
premiumText.TextColor3 = Color3.new(1,1,1)

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
-- MIKU OPEN/CLOSE
--========================================================--

miku.MouseButton1Click:Connect(function()

    if moved then

        moved = false
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
-- CHARACTER RESPAWN
--========================================================--

plr.CharacterAdded:Connect(function(character)

    -- IMPORTANTE:
    -- Esperamos a que el personaje realmente exista

    task.wait(1)

    -- Reset del sistema V4 después de morir
    V4Ready = true

    -- Si el Auto V4 estaba activo,
    -- dejamos que vuelva a funcionar normalmente
    if getgenv().Nakano.AutoV4 then
        V4Ready = true
    end

    -- ESP del jugador local ya volvió
    if ESPEnabled then
        RefreshESP()
    end

    -- Guardar configuración después del respawn
    if getgenv().Nakano.AutoSave then
        SaveConfig()
    end

end)

--========================================================--
-- PLAYER ESP EVENTS
--========================================================--

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
-- CLOSE ESP WHEN CHARACTER CHANGES
--========================================================--

plr.CharacterRemoving:Connect(function()

    -- Limpiar ESP mientras el personaje está muerto
    for player,billboard in pairs(ESPObjects) do

        if billboard then
            billboard:Destroy()
        end

        ESPObjects[player] = nil

    end

end)

--========================================================--
-- GET CLOSEST PLAYER
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

--========================================================--
-- AIM LOOP
--========================================================--

RS.RenderStepped:Connect(function()

    if getgenv().Nakano.Aim then

        local character = plr.Character

        if not character then
            return
        end

        local humanoid =
            character:FindFirstChildOfClass("Humanoid")

        if not humanoid or humanoid.Health <= 0 then
            return
        end

        local target = GetClosestPlayer()

        if target
        and target.Character
        and target.Character:FindFirstChild("HumanoidRootPart") then

            cam.CFrame =
                CFrame.new(
                    cam.CFrame.Position,
                    target.Character.HumanoidRootPart.Position
                )

        end

    end

end)

--========================================================--
-- AUTO TP
--========================================================--

task.spawn(function()

    while task.wait(0.35) do

        if getgenv().Nakano.AutoTP then

            local character = plr.Character

            if not character then
                continue
            end

            local humanoid =
                character:FindFirstChildOfClass("Humanoid")

            local root =
                character:FindFirstChild("HumanoidRootPart")

            if not humanoid
            or humanoid.Health <= 0
            or not root then
                continue
            end

            local target = GetClosestPlayer()

            if target
            and target.Character
            and target.Character:FindFirstChild("HumanoidRootPart") then

                root.CFrame =
                    CFrame.new(
                        target.Character.HumanoidRootPart.Position
                        + Vector3.new(2,1,2)
                    )

            end

        end

    end

end)

--========================================================--
-- AUTO V4
--========================================================--

task.spawn(function()

    while task.wait(1) do

        if getgenv().Nakano.AutoV4
        and V4Ready then

            local character = plr.Character

            if not character then
                continue
            end

            local humanoid =
                character:FindFirstChildOfClass("Humanoid")

            if not humanoid then
                continue
            end

            -- NO ACTIVAR V4 SI ESTÁ MUERTO
            if humanoid.Health <= 0 then
                V4Ready = true
                continue
            end

            -- Evita quedarse spameando Y continuamente
            V4Ready = false

            pcall(function()

                VIM:SendKeyEvent(
                    true,
                    "Y",
                    false,
                    game
                )

                task.wait(0.1)

                VIM:SendKeyEvent(
                    false,
                    "Y",
                    false,
                    game
                )

            end)

            -- Permitir otro intento después
            task.wait(2)

            if plr.Character
            and plr.Character:FindFirstChildOfClass("Humanoid")
            and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then

                V4Ready = true

            end

        end

    end

end)

--========================================================--
-- FINAL AUTO SAVE
--========================================================--

if getgenv().Nakano.AutoSave then
    task.delay(1,SaveConfig)
end

print("NAKANO HUB V13 • LOADED")
print("MAX LEVEL:",MAX_LEVEL)
print("ESP RANGE:",ESP_MAX_DISTANCE)
print("AUTO SAVE:",getgenv().Nakano.AutoSave)z
z
