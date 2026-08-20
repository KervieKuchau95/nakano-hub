--// NAKANO HUB - FINAL CLEAN BY KERVIE
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

pcall(function() game.StarterGui:SetCore("SendNotification",{Title="Nakano Hub",Text="Cargado!",Duration=3}) end)

local ESP_ENABLED = false
local AIMBOT_ENABLED = false
local NOCLIP_ENABLED = false

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "NakanoHub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,280)
frame.Position = UDim2.new(0,50,0,80)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.Text = "Nakano Hub"
title.BackgroundColor3 = Color3.fromRGB(255,105,180)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)

local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,50,0,50)
openBtn.Position = UDim2.new(0,10,0.5,0)
openBtn.Text = "N"
openBtn.BackgroundColor3 = Color3.fromRGB(255,105,180)
openBtn.TextScaled = true
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Draggable = true
openBtn.Active = true
openBtn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)

UserInputService.InputBegan:Connect(function(input,gpe) if not gpe and input.KeyCode == Enum.KeyCode.RightShift then frame.Visible = not frame.Visible end end)

local function createButton(text, y, callback)
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,200,0,35)
btn.Position = UDim2.new(0,30,0,y)
btn.Text = text
btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
btn.TextColor3 = Color3.new(0,0,0)
btn.Font = Enum.Font.GothamBold
btn.MouseButton1Click:Connect(callback)
return btn
end

createButton("ESP VIDA/DIST",50,function() ESP_ENABLED = not ESP_ENABLED end)
createButton("AIMBOT PRO",90,function() AIMBOT_ENABLED = not AIMBOT_ENABLED end)
createButton("NOCLIP",130,function() NOCLIP_ENABLED = not NOCLIP_ENABLED end)
createButton("BOOST FPS",170,function() for _,v in pairs(Workspace:GetDescendants()) do if v:IsA("Texture") or v:IsA("Decal") then v.Transparency = 1 end if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end end Workspace.GlobalShadows = false end)

RunService.Stepped:Connect(function() if NOCLIP_ENABLED and LocalPlayer.Character then for _,part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end end end end)

local FOV = Drawing.new("Circle")
FOV.Visible = true
FOV.Radius = 120
FOV.Color = Color3.fromRGB(255,105,180)
FOV.Thickness = 2

local espCache = {}
function createESP(player)
if player == LocalPlayer then return end
local box = Drawing.new("Square")
box.Color = Color3.fromRGB(255,105,180)
box.Thickness = 2
box.Filled = false
local text = Drawing.new("Text")
text.Color = Color3.fromRGB(255,255,255)
text.Size = 16
text.Center = true
text.Outline = true
espCache[player] = {box,text}
end
for _,p in pairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(function(p) if espCache[p] then espCache[p][1]:Remove() espCache[p][2]:Remove() espCache[p]=nil end end)

function getClosest()
local closest, shortest = nil, 120
local mousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
for _,player in pairs(Players:GetPlayers()) do
if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
if onScreen then
local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
if dist < shortest then shortest = dist closest = player end
end
end
end
return closest
end

RunService.RenderStepped:Connect(function()
FOV.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
if AIMBOT_ENABLED then
local target = getClosest()
if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
end
end
for player,data in pairs(espCache) do
local box,text = data[1],data[2]
if ESP_ENABLED and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
local root,hum = player.Character.HumanoidRootPart, player.Character.Humanoid
local pos,visible = Camera:WorldToViewportPoint(root.Position)
if visible then
local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude)
box.Size = Vector2.new(40,60)
box.Position = Vector2.new(pos.X-20,pos.Y-30)
box.Visible = true
text.Position = Vector2.new(pos.X,pos.Y-40)
text.Text = player.Name.."\nVida: "..math.floor(hum.Health).."\nDist: "..dist
text.Visible = true
else box.Visible=false text.Visible=false end
else box.Visible=false text.Visible=false end
end
end)
