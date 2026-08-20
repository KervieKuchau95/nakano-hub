--// NAKANO HUB V13 • MIKU + BANANA CAT + SAKURA
--// By Kervie_Kuchau95

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")

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

--// FUENTE PIXEL
local PIXEL_FONT = Enum.Font.Arcade

--// =========================================================
--// NOTIFICACIÓN ABAJO DERECHA
--// =========================================================

local notif = Instance.new("Frame")
notif.Parent = gui
notif.Size = UDim2.new(0, 310, 0, 82)
notif.Position = UDim2.new(1, -325, 1, -105)
notif.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
notif.BackgroundTransparency = 0.12
notif.Visible = true

Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)

local notifStroke = Instance.new("UIStroke", notif)
notifStroke.Color = Color3.fromRGB(255, 105, 180)
notifStroke.Thickness = 2

--// IMAGEN DE MIKU EN NOTIFICACIÓN
local notifImg = Instance.new("ImageLabel")
notifImg.Parent = notif
notifImg.Size = UDim2.new(0, 68, 0, 68)
notifImg.Position = UDim2.new(0, 7, 0.5, -34)
notifImg.BackgroundTransparency = 1
notifImg.Image = "rbxassetid://118017336964341"
notifImg.ScaleType = Enum.ScaleType.Crop

Instance.new("UICorner", notifImg).CornerRadius = UDim.new(1, 0)

--// TEXTO
local notifTitle = Instance.new("TextLabel")
notifTitle.Parent = notif
notifTitle.Size = UDim2.new(1, -85, 0, 24)
notifTitle.Position = UDim2.new(0, 82, 0, 12)
notifTitle.BackgroundTransparency = 1
notifTitle.Text = "NAKANO HUB ⚡"
notifTitle.Font = PIXEL_FONT
notifTitle.TextSize = 16
notifTitle.TextColor3 = Color3.fromRGB(255, 170, 220)
notifTitle.TextXAlignment = Enum.TextXAlignment.Left

local notifBy = Instance.new("TextLabel")
notifBy.Parent = notif
notifBy.Size = UDim2.new(1, -85, 0, 20)
notifBy.Position = UDim2.new(0, 82, 0, 37)
notifBy.BackgroundTransparency = 1
notifBy.Text = "by Kervie_Kuchau95"
notifBy.Font = PIXEL_FONT
notifBy.TextSize = 11
notifBy.TextColor3 = Color3.fromRGB(255, 255, 255)
notifBy.TextXAlignment = Enum.TextXAlignment.Left

local notifStatus = Instance.new("TextLabel")
notifStatus.Parent = notif
notifStatus.Size = UDim2.new(1, -85, 0, 18)
notifStatus.Position = UDim2.new(0, 82, 0, 57)
notifStatus.BackgroundTransparency = 1
notifStatus.Text = "CARGADO EXITOSAMENTE"
notifStatus.Font = PIXEL_FONT
notifStatus.TextSize = 9
notifStatus.TextColor3 = Color3.fromRGB(255, 150, 205)
notifStatus.TextXAlignment = Enum.TextXAlignment.Left

--// FADE DESPUÉS DE 3 SEGUNDOS
task.delay(3, function()

    local info = TweenInfo.new(
        0.65,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )

    TS:Create(notif, info, {
        BackgroundTransparency = 1
    }):Play()

    TS:Create(notifStroke, info, {
        Transparency = 1
    }):Play()

    TS:Create(notifImg, info, {
        ImageTransparency = 1
    }):Play()

    TS:Create(notifTitle, info, {
        TextTransparency = 1
    }):Play()

    TS:Create(notifBy, info, {
        TextTransparency = 1
    }):Play()

    TS:Create(notifStatus, info, {
        TextTransparency = 1
    }):Play()

    task.wait(0.7)

    notif.Visible = false
end)

--// =========================================================
--// BOTÓN MIKU
--// IZQUIERDA ABAJO
--// SIN MARCO ROSA
--// MOVIMIENTO MANUAL
--// =========================================================

local miku = Instance.new("ImageButton")
miku.Parent = gui
miku.Size = UDim2.new(0, 82, 0, 82)
miku.Position = UDim2.new(0, 22, 1, -105)
miku.BackgroundTransparency = 1
miku.Image = "rbxassetid://118017336964341"
miku.ScaleType = Enum.ScaleType.Crop
miku.AutoButtonColor = false

--// SOLO RECORTE CIRCULAR
--// NO UIStroke = NO ARO ROSA
local mikuCorner = Instance.new("UICorner")
mikuCorner.Parent = miku
mikuCorner.CornerRadius = UDim.new(1, 0)

--// =========================================================
--// DRAG MANUAL DEL BOTÓN
--// EVITA EL BUG DE DRAGGABLE
--// =========================================================

local dragging = false
local dragStart
local startPos
local moved = false

local function updateDrag(input)

    local delta = input.Position - dragStart

    miku.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

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

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        if dragging then
            updateDrag(input)

            local delta = input.Position - dragStart

            if math.abs(delta.X) > 8 or math.abs(delta.Y) > 8 then
                moved = true
            end
        end
    end
end)

--// =========================================================
--// MAIN
--// =========================================================

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 395, 0, 470)
main.Position = UDim2.new(0.5, -197, 0.5, -235)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
main.BackgroundTransparency = 0.25
main.Visible = false
main.Active = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local mainStroke = Instance.new("UIStroke")
mainStroke.Parent = main
mainStroke.Color = Color3.fromRGB(255, 105, 180)
mainStroke.Thickness = 2

--// =========================================================
--// SAKURA
--// =========================================================

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

            petal.Position =
                UDim2.new(math.random(), 0, -0.1, 0)

            TS:Create(
                petal,
                TweenInfo.new(
                    math.random(5, 9),
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

--// =========================================================
--// TOP
--// =========================================================

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
tl.Font = PIXEL_FONT
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
close.Font = PIXEL_FONT
close.TextSize = 14

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

--// =========================================================
--// SCROLL
--// =========================================================

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

--// =========================================================
--// TOGGLE
--// =========================================================

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
    t1.Font = PIXEL_FONT
    t1.TextSize = 12
    t1.TextXAlignment = Enum.TextXAlignment.Left

    local t2 = Instance.new("TextLabel")
    t2.Parent = f
    t2.Text = desc
    t2.Size = UDim2.new(0.6, 0, 0, 14)
    t2.Position = UDim2.new(0, 10, 0, 30)
    t2.BackgroundTransparency = 1
    t2.TextColor3 = Color3.fromRGB(130, 180, 255)
    t2.Font = PIXEL_FONT
    t2.TextSize = 9
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

--// =========================================================
--// LOGICA ORIGINAL
--// =========================================================

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

--// FPS BOOST
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

--// AUTO TP
MakeToggle(
    "AUTO TP JUGADOR",
    "SOLO players - Fix NPC",
    false,
    function(v)
        getgenv().Nakano.AutoTP = v
    end
)

--// AIMBOT
MakeToggle(
    "AIMBOT PVP",
    "Lock al mas cercano a mira",
    false,
    function(v)
        getgenv().Nakano.Aim = v
    end
)

--// AUTO V4
MakeToggle(
    "AUTO V4 DRACO",
    "Presiona Y automatico",
    false,
    function(v)
        getgenv().Nakano.AutoV4 = v
    end
)

--// ESP
MakeToggle(
    "ESP VIDA + DIST",
    "Ver vida real",
    false,
    function(v)
        getgenv().Nakano.ESP = v
    end
)

--// =========================================================
--// PREMIUM
--// =========================================================

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
pt.Font = PIXEL_FONT
pt.TextSize = 11

--// =========================================================
--// ABRIR / CERRAR CON MIKU
--// =========================================================

local clickStart

miku.MouseButton1Down:Connect(function()
    clickStart = tick()
end)

miku.MouseButton1Up:Connect(function()

    if not moved then

        main.Visible = not main.Visible

        if main.Visible then

            main.Size = UDim2.new(0, 0, 0, 0)

            TS:Create(
                main,
                TweenInfo.new(
                    0.3,
                    Enum.EasingStyle.Back,
                    Enum.EasingDirection.Out
                ),
                {
                    Size = UDim2.new(0, 395, 0, 470)
                }
            ):Play()

        end
    end

    moved = false
end)

--// =========================================================
--// AIMBOT
--// =========================================================

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

--// =========================================================
--// AUTO TP
--// =========================================================

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

--// =========================================================
--// AUTO V4
--// =========================================================

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

print("NAKANO V13 • MIKU + BANANA CAT + SAKURA • CARGADO")
