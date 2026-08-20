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

--// LIMPIAR GUI ANTERIOR
if game.CoreGui:FindFirstChild("NakanoV13") then
    game.CoreGui.NakanoV13:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NakanoV13"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

--// NOTIFICACIÓN
local notif = Instance.new("Frame")
notif.Parent = gui
notif.Size = UDim2.new(0, 320, 0, 48)
notif.Position = UDim2.new(0.5, -160, 0, -60)
notif.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
notif.BackgroundTransparency = 0.2

Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)

local nStroke = Instance.new("UIStroke", notif)
nStroke.Color = Color3.fromRGB(255, 105, 180)
nStroke.Thickness = 2

local nText = Instance.new("TextLabel", notif)
nText.Size = UDim2.new(1, 0, 1, 0)
nText.BackgroundTransparency = 1
nText.Text = "NAKANO HUB by Kervie_Kuchau95⚡"
nText.Font = Enum.Font.GothamBold
nText.TextSize = 13
nText.TextColor3 = Color3.fromRGB(255, 255, 255)

TS:Create(
    notif,
    TweenInfo.new(0.5, Enum.EasingStyle.Back),
    {Position = UDim2.new(0.5, -160, 0, 20)}
):Play()

task.delay(3, function()
    TS:Create(
        notif,
        TweenInfo.new(0.4),
        {Position = UDim2.new(0.5, -160, 0, -60)}
    ):Play()
end)

--// BOTÓN FLOTANTE CIRCULAR
local side = Instance.new("Frame")
side.Parent = gui
side.Size = UDim2.new(0, 70, 0, 70)
side.Position = UDim2.new(0, 15, 0.4, 0)
side.BackgroundTransparency = 1
side.Active = true
side.Draggable = true

local btn = Instance.new("ImageButton")
btn.Parent = side
btn.Size = UDim2.new(0, 65, 0, 65)
btn.Position = UDim2.new(0.5, -32, 0.5, -32)
btn.Image = "rbxassetid://118017336964341"
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
btn.BackgroundTransparency = 0

--// CÍRCULO REAL, SIN MARCO CUADRADO
Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

local s1 = Instance.new("UIStroke", btn)
s1.Color = Color3.fromRGB(255, 105, 180)
s1.Thickness = 2.5

--// MAIN
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 395, 0, 470)
main.Position = UDim2.new(0.5, -197, 0.5, -235)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
main.BackgroundTransparency = 0.25
main.Visible = false
main.Active = true
main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local s2 = Instance.new("UIStroke", main)
s2.Color = Color3.fromRGB(255, 105, 180)
s2.Thickness = 2

--// SAKURA
local sakuraContainer = Instance.new("Frame")
sakuraContainer.Parent = main
sakuraContainer.Size = UDim2.new(1, 0, 1, 0)
sakuraContainer.BackgroundTransparency = 1
sakuraContainer.ClipsDescendants = true
sakuraContainer.ZIndex = 10

for i = 1, 8 do
    local petal = Instance.new("TextLabel")
    petal.Parent = sakuraContainer
    petal.Text = "🌸"
    petal.Size = UDim2.new(0, 20, 0, 20)
    petal.Position = UDim2.new(math.random(), 0, -0.1, 0)
    petal.BackgroundTransparency = 1
    petal.TextSize = math.random(12, 18)
    petal.ZIndex = 10

    task.spawn(function()
        while task.wait(math.random(4, 8)) do
            petal.Position = UDim2.new(math.random(), 0, -0.1, 0)

            TS:Create(
                petal,
                TweenInfo.new(math.random(5, 9), Enum.EasingStyle.Linear),
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

--// TOP
local top = Instance.new("Frame")
top.Parent = main
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
top.BackgroundTransparency = 0.2

Instance.new("UICorner", top).CornerRadius = UDim.new(0, 16)

local tl = Instance.new("TextLabel")
tl.Parent = top
tl.Size = UDim2.new(1, -60, 1, 0)
tl.Position = UDim2.new(0, 15, 0, 0)
tl.Text = "NAKANO HUB • VISUAL 🍌🐱🌸"
tl.BackgroundTransparency = 1
tl.Font = Enum.Font.GothamBold
tl.TextSize = 14
tl.TextColor3 = Color3.fromRGB(255, 255, 255)
tl.TextXAlignment = Enum.TextXAlignment.Left

--// CERRAR
local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -35, 0, 7)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

--// SCROLL
local scroll = Instance.new("ScrollingFrame")
scroll.Parent = main
scroll.Size = UDim2.new(1, 0, 1, -92)
scroll.Position = UDim2.new(0, 0, 0, 48)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 2
scroll.CanvasSize = UDim2.new(0, 0, 0, 700)

local lay = Instance.new("UIListLayout")
lay.Parent = scroll
lay.Padding = UDim.new(0, 10)

local pad = Instance.new("UIPadding")
pad.Parent = scroll
pad.PaddingLeft = UDim.new(0, 12)
pad.PaddingRight = UDim.new(0, 12)
pad.PaddingTop = UDim.new(0, 10)

--// TOGGLE
local function MakeToggle(name, desc, default, callback)

    local f = Instance.new("Frame")
    f.Parent = scroll
    f.Size = UDim2.new(1, 0, 0, 62)
    f.BackgroundColor3 = Color3.fromRGB(22, 22, 32)

    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)

    local st = Instance.new("UIStroke", f)
    st.Color = Color3.fromRGB(255, 105, 180)
    st.Transparency = 0.6

    local t1 = Instance.new("TextLabel")
    t1.Parent = f
    t1.Text = name
    t1.Size = UDim2.new(0.6, 0, 0, 18)
    t1.Position = UDim2.new(0, 10, 0, 8)
    t1.BackgroundTransparency = 1
    t1.TextColor3 = Color3.new(1, 1, 1)
    t1.Font = Enum.Font.GothamBold
    t1.TextSize = 13
    t1.TextXAlignment = Enum.TextXAlignment.Left

    local t2 = Instance.new("TextLabel")
    t2.Parent = f
    t2.Text = desc
    t2.Size = UDim2.new(0.6, 0, 0, 14)
    t2.Position = UDim2.new(0, 10, 0, 30)
    t2.BackgroundTransparency = 1
    t2.TextColor3 = Color3.fromRGB(130, 180, 255)
    t2.TextSize = 10
    t2.TextXAlignment = Enum.TextXAlignment.Left

    local tog = Instance.new("Frame")
    tog.Parent = f
    tog.Size = UDim2.new(0, 52, 0, 26)
    tog.Position = UDim2.new(1, -62, 0.5, -13)
    tog.BackgroundColor3 =
        default
        and Color3.fromRGB(255, 105, 180)
        or Color3.fromRGB(55, 55, 65)

    Instance.new("UICorner", tog).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame")
    dot.Parent = tog
    dot.Size = UDim2.new(0, 20, 0, 20)
    dot.Position =
        default
        and UDim2.new(1, -23, 0.5, -10)
        or UDim2.new(0, 3, 0.5, -10)

    dot.BackgroundColor3 = Color3.new(1, 1, 1)

    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local btn2 = Instance.new("TextButton")
    btn2.Parent = f
    btn2.Size = UDim2.new(1, 0, 1, 0)
    btn2.Text = ""
    btn2.BackgroundTransparency = 1

    local on = default

    btn2.MouseButton1Click:Connect(function()

        on = not on

        TS:Create(
            tog,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 =
                    on
                    and Color3.fromRGB(255, 105, 180)
                    or Color3.fromRGB(55, 55, 65)
            }
        ):Play()

        TS:Create(
            dot,
            TweenInfo.new(0.2),
            {
                Position =
                    on
                    and UDim2.new(1, -23, 0.5, -10)
                    or UDim2.new(0, 3, 0.5, -10)
            }
        ):Play()

        callback(on)
    end)
end

--// LÓGICA DEL CÓDIGO 1

local function GetClosestPlayer()

    local closest
    local dist = getgenv().Nakano.FOV

    for _, v in pairs(Players:GetPlayers()) do

        if v ~= plr
        and v.Character
        and v.Character:FindFirstChild("HumanoidRootPart")
        and v.Character:FindFirstChild("Humanoid") then

            if v.Character.Humanoid.Health > 0 then

                local pos, onScreen =
                    cam:WorldToViewportPoint(
                        v.Character.HumanoidRootPart.Position
                    )

                if onScreen then

                    local mag =
                        (
                            Vector2.new(pos.X, pos.Y)
                            -
                            Vector2.new(
                                cam.ViewportSize.X / 2,
                                cam.ViewportSize.Y / 2
                            )
                        ).Magnitude

                    if mag < dist then
                        dist = mag
                        closest = v
                    end
                end
            end
        end
    end

    return closest
end

--// TOGGLES

MakeToggle(
    "FPS BOOST ULTRA",
    "Activa - Quita lag Draco V4",
    false,
    function(v)

        getgenv().Nakano.Boost = v

        if v then

            game.Lighting.GlobalShadows = false
            settings().Rendering.QualityLevel = 1

            for _, obj in pairs(workspace:GetDescendants()) do

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
    "Auto TP Jugador",
    "SOLO players - Fix NPC",
    false,
    function(v)
        getgenv().Nakano.AutoTP = v
    end
)

MakeToggle(
    "Aimbot PVP",
    "Lock al mas cercano a mira",
    false,
    function(v)
        getgenv().Nakano.Aim = v
    end
)

MakeToggle(
    "Auto V4 Draco",
    "Presiona Y automatico",
    false,
    function(v)
        getgenv().Nakano.AutoV4 = v
    end
)

MakeToggle(
    "ESP Vida + Dist",
    "Ver vida real",
    false,
    function(v)
        getgenv().Nakano.ESP = v
    end
)

--// PREMIUM
local prem = Instance.new("Frame")
prem.Parent = main
prem.Size = UDim2.new(1, -20, 0, 34)
prem.Position = UDim2.new(0, 10, 1, -42)
prem.BackgroundColor3 = Color3.fromRGB(255, 105, 180)

Instance.new("UICorner", prem).CornerRadius = UDim.new(0, 10)

local pt = Instance.new("TextLabel")
pt.Parent = prem
pt.Size = UDim2.new(1, 0, 1, 0)
pt.Text = "PREMIUM • MIKU NAKANO • V13"
pt.BackgroundTransparency = 1
pt.TextColor3 = Color3.new(1, 1, 1)
pt.Font = Enum.Font.GothamBold
pt.TextSize = 11

--// BOTÓN MIKU
btn.MouseButton1Click:Connect(function()

    main.Visible = not main.Visible

    if main.Visible then

        main.Size = UDim2.new(0, 0, 0, 0)

        TS:Create(
            main,
            TweenInfo.new(0.3, Enum.EasingStyle.Back),
            {
                Size = UDim2.new(0, 395, 0, 470)
            }
        ):Play()
    end
end)

--// AIMBOT
RS.RenderStepped:Connect(function()

    if getgenv().Nakano.Aim then

        local t = GetClosestPlayer()

        if t
        and t.Character
        and t.Character:FindFirstChild("HumanoidRootPart") then

            cam.CFrame =
                CFrame.new(
                    cam.CFrame.Position,
                    t.Character.HumanoidRootPart.Position
                )
        end
    end
end)

--// AUTO TP
task.spawn(function()

    while task.wait(0.35) do

        if getgenv().Nakano.AutoTP then

            local t = GetClosestPlayer()

            if t
            and t.Character
            and plr.Character
            and plr.Character:FindFirstChild("HumanoidRootPart") then

                plr.Character.HumanoidRootPart.CFrame =
                    CFrame.new(
                        t.Character.HumanoidRootPart.Position
                        + Vector3.new(2, 1, 2)
                    )
            end
        end
    end
end)

--// AUTO V4
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

print("NAKANO V13 MIKU + BANANA CAT + SAKURA CARGADO")
