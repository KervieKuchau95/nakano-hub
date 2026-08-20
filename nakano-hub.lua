-- NAKANO HUB - SOLO VISUAL LEGAL - Banana Cat + Sakura
-- By Kervie_Kuchau95
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local plr = Players.LocalPlayer

if game.CoreGui:FindFirstChild("NakanoVisual") then
    game.CoreGui.NakanoVisual:Destroy()
end

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NakanoVisual"
gui.ResetOnSpawn = false

-- NOTIFICACION 3 SEG
local notif = Instance.new("Frame", gui)
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

TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -160, 0, 20)}):Play()
task.delay(3, function()
    TweenService:Create(notif, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -160, 0, -60)}):Play()
end)

-- BOTON FLOTANTE BANANA CAT STYLE
local side = Instance.new("Frame", gui)
side.Size = UDim2.new(0, 80, 0, 120)
side.Position = UDim2.new(0, 15, 0.4, 0)
side.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
side.BackgroundTransparency = 0.3 -- transparente como pediste
side.Active = true
side.Draggable = true
Instance.new("UICorner", side).CornerRadius = UDim.new(0, 16)
local s1 = Instance.new("UIStroke", side)
s1.Color = Color3.fromRGB(255, 240, 150) -- banana cat
s1.Thickness = 2.5

local ai = Instance.new("TextLabel", side)
ai.Size = UDim2.new(1, 0, 0, 22)
ai.Text = "AI • BANANA CAT"
ai.Font = Enum.Font.GothamBold
ai.TextSize = 10
ai.TextColor3 = Color3.fromRGB(255, 240, 150)
ai.BackgroundTransparency = 1

local btn = Instance.new("ImageButton", side)
btn.Size = UDim2.new(0, 58, 0, 58)
btn.Position = UDim2.new(0.5, -29, 0, 30)
btn.Image = "rbxassetid://118017336964341" -- TU MIKU
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
btn.BackgroundTransparency = 0.2
Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

local ml = Instance.new("TextLabel", side)
ml.Size = UDim2.new(1, 0, 0, 20)
ml.Position = UDim2.new(0, 0, 0, 92)
ml.Text = "Menu"
ml.BackgroundTransparency = 1
ml.TextColor3 = Color3.fromRGB(255, 215, 0)
ml.Font = Enum.Font.GothamBold
ml.TextSize = 11

-- MAIN TRANSPARENTE
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 380, 0, 420)
main.Position = UDim2.new(0.5, -190, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
main.BackgroundTransparency = 0.25 -- transparente
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)
local s2 = Instance.new("UIStroke", main)
s2.Color = Color3.fromRGB(255, 105, 180)
s2.Thickness = 2

-- SAKURAS CAYENDO (EFECTO VISUAL)
local sakuraContainer = Instance.new("Frame", main)
sakuraContainer.Size = UDim2.new(1, 0, 1, 0)
sakuraContainer.BackgroundTransparency = 1
sakuraContainer.ClipsDescendants = true
sakuraContainer.ZIndex = 10

for i = 1, 8 do
    local petal = Instance.new("TextLabel", sakuraContainer)
    petal.Text = "🌸"
    petal.Size = UDim2.new(0, 20, 0, 20)
    petal.Position = UDim2.new(math.random(), 0, -0.1, 0)
    petal.BackgroundTransparency = 1
    petal.TextSize = math.random(12, 18)
    petal.ZIndex = 10
    spawn(function()
        while task.wait(math.random(4, 8)) do
            petal.Position = UDim2.new(math.random(), 0, -0.1, 0)
            TweenService:Create(petal, TweenInfo.new(math.random(5, 9), Enum.EasingStyle.Linear), {
                Position = UDim2.new(petal.Position.X.Scale, 0, 1.1, 0)
            }):Play()
        end
    end)
end

local top = Instance.new("Frame", main)
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
top.BackgroundTransparency = 0.2
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 16)

local tl = Instance.new("TextLabel", top)
tl.Size = UDim2.new(1, -60, 1, 0)
tl.Position = UDim2.new(0, 15, 0, 0)
tl.Text = "NAKANO HUB • VISUAL 🍌🐱🌸"
tl.BackgroundTransparency = 1
tl.Font = Enum.Font.GothamBold
tl.TextSize = 14
tl.TextColor3 = Color3.fromRGB(255, 255, 255)
tl.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -35, 0, 7)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
close.MouseButton1Click:Connect(function() main.Visible = false end)

btn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    if main.Visible then
        main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 380, 0, 420)}):Play()
    end
end)

print("NAKANO VISUAL CARGADO - Banana Cat + Sakura")
