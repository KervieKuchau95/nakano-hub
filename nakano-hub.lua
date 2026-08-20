--// NAKANO HUB V13 • MIKU + BANANA CAT + SAKURA
--// By Kervie_Kuchau95

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")

local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera

getgenv().Nakano = getgenv().Nakano or {
    AutoTP = false,
    AutoV4 = false,
    Aim = false,
    ESP = false,
    Boost = false,
    FOV = 300
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
-- NOTIFICATION
--========================================================--

local notif = Instance.new("Frame", gui)
notif.Size = UDim2.new(0, 310, 0, 82)
notif.Position = UDim2.new(1, -325, 1, -105)
notif.BackgroundColor3 = Color3.fromRGB(18,18,26)
notif.BackgroundTransparency = 0.12

Instance.new("UICorner", notif).CornerRadius = UDim.new(0,12)

local notifStroke = Instance.new("UIStroke", notif)
notifStroke.Color = Color3.fromRGB(255,105,180)
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
notifTitle.Text = "NAKANO HUB ⚡"
notifTitle.Font = PIXEL
notifTitle.TextSize = 16
notifTitle.TextColor3 = Color3.fromRGB(255,170,220)
notifTitle.TextXAlignment = Enum.TextXAlignment.Left

local notifBy = Instance.new("TextLabel", notif)
notifBy.Size = UDim2.new(1,-85,0,20)
notifBy.Position = UDim2.new(0,82,0,42)
notifBy.BackgroundTransparency = 1
notifBy.Text = "by Kervie_Kuchau95"
notifBy.Font = PIXEL
notifBy.TextSize = 11
notifBy.TextColor3 = Color3.new(1,1,1)
notifBy.TextXAlignment = Enum.TextXAlignment.Left

task.delay(5,function()

    local info = TweenInfo.new(0.65,Enum.EasingStyle.Quad)

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
    notif:Destroy()
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

        if math.abs(delta.X) > 8 or math.abs(delta.Y) > 8 then
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
scroll.CanvasSize = UDim2.new(0,0,0,900)

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

local ESPEnabled = false
local ESPName = true
local ESPHealth = false
local ESPDistance = false

local ESPObjects = {}

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

            if ESPName then
                table.insert(lines,player.Name)
            end

            if ESPHealth and humanoid then

                table.insert(
                    lines,
                    "HP: "
                    .. math.floor(humanoid.Health)
                    .. "/"
                    .. math.floor(humanoid.MaxHealth)
                )
            end

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
    false,
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
            espOptions.Size = UDim2.new(1,0,0,0)
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
-- OTHER FEATURES
--========================================================--

MakeToggle(
    "FPS BOOST ULTRA",
    "Reduce lag and improve performance",
    false,
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

MakeToggle(
    "AUTO TP PLAYER",
    "Players only - NPC protection",
    false,
    function(v)
        getgenv().Nakano.AutoTP = v
    end
)

MakeToggle(
    "AIMBOT PVP",
    "Lock onto the closest player",
    false,
    function(v)
        getgenv().Nakano.Aim = v
    end
)

MakeToggle(
    "AUTO ACTIVE V4",
    "Automatically press Y",
    false,
    function(v)
        getgenv().Nakano.AutoV4 = v
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
-- CLOSE MENU WHEN PLAYER DIES / RESPAWNS
--========================================================--

plr.CharacterAdded:Connect(function()

    task.wait(0.5)

    if ESPEnabled then
        RefreshESP()
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
-- AIM LOOP
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

    if getgenv().Nakano.Aim then

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

            local target = GetClosestPlayer()

            if target
            and target.Character
            and plr.Character
            and plr.Character:FindFirstChild("HumanoidRootPart") then

                plr.Character.HumanoidRootPart.CFrame =
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

    while task.wait(2) do

        if getgenv().Nakano.AutoV4 then

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
        end
    end
end)

print("NAKANO HUB V13 • LOADED")
