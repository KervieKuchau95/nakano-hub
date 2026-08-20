--// NAKANO HUB V10 MIKU - FIX CELULAR
local P=game:GetService("Players")
local R=game:GetService("RunService")
local T=game:GetService("TweenService")
local plr=P.LocalPlayer
local cam=workspace.CurrentCamera
getgenv().Nakano={FOV=250,Target=nil,Boost=false,AutoTP=true,AutoV4=true}

if game.CoreGui:FindFirstChild("NakanoV10") then
 game.CoreGui.NakanoV10:Destroy()
end

local gui=Instance.new("ScreenGui",game.CoreGui)
gui.Name="NakanoV10"
gui.ResetOnSpawn=false

local side=Instance.new("Frame",gui)
side.Size=UDim2.new(0,75,0,120)
side.Position=UDim2.new(0,15,0.3,0)
side.BackgroundColor3=Color3.fromRGB(18,18,28)
side.Active=true
side.Draggable=true
Instance.new("UICorner",side).CornerRadius=UDim.new(0,18)
Instance.new("UIStroke",side).Color=Color3.fromRGB(255,105,180)

local ai=Instance.new("TextLabel",side)
ai.Size=UDim2.new(1,0,0,28)
ai.Text="AI"
ai.TextColor3=Color3.fromRGB(255,150,220)
ai.BackgroundTransparency=1
ai.Font=Enum.Font.GothamBold
ai.TextSize=20

local btn=Instance.new("ImageButton",side)
btn.Size=UDim2.new(0,56,0,56)
btn.Position=UDim2.new(0.5,-28,0,35)
btn.Image="rbxassetid://11296273386"
btn.BackgroundColor3=Color3.fromRGB(30,30,40)
Instance.new("UICorner",btn).CornerRadius=UDim.new(1,0)

local main=Instance.new("Frame",gui)
main.Size=UDim2.new(0,340,0,380)
main.Position=UDim2.new(0.5,-170,0.5,-190)
main.BackgroundColor3=Color3.fromRGB(12,12,18)
main.Visible=false
main.Active=true
main.Draggable=true
Instance.new("UICorner",main).CornerRadius=UDim.new(0,16)
Instance.new("UIStroke",main).Color=Color3.fromRGB(255,105,180)

local title=Instance.new("TextLabel",main)
title.Size=UDim2.new(1,0,0,40)
title.Position=UDim2.new(0,10,0,5)
title.Text="NAKANO HUB V10"
title.TextColor3=Color3.fromRGB(255,180,255)
title.BackgroundTransparency=1
title.Font=Enum.Font.GothamBold
title.TextSize=22

local status=Instance.new("TextLabel",main)
status.Size=UDim2.new(1,0,0,60)
status.Position=UDim2.new(0,10,0,45)
status.Text="FPS BOOST ULTRA: ON\nAuto TP: ON\nAuto V4 Draco: ON\nUser: NAKANO_USER"
status.TextColor3=Color3.new(1,1,1)
status.BackgroundTransparency=1
status.TextXAlignment=Enum.TextXAlignment.Left
status.TextSize=12

local prem=Instance.new("Frame",main)
prem.Size=UDim2.new(1,-20,0,30)
prem.Position=UDim2.new(0,10,1,-40)
prem.BackgroundColor3=Color3.fromRGB(255,105,180)
Instance.new("UICorner",prem).CornerRadius=UDim.new(0,10)

local pt=Instance.new("TextLabel",prem)
pt.Size=UDim2.new(1,0,1,0)
pt.Text="PREMIUM • NAKANO HUB ACTIVE"
pt.TextColor3=Color3.new(1,1,1)
pt.BackgroundTransparency=1
pt.Font=Enum.Font.GothamBold

btn.MouseButton1Click:Connect(function()
 main.Visible=not main.Visible
end)

-- LOGIC
local function GetClosest()
 local c,d=nil,250
 for _,v in pairs(P:GetPlayers()) do
  if v~=plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
   if v.Character.Humanoid.Health>0 then
    local pos,on=cam:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
    if on then
     local m=(Vector2.new(pos.X,pos.Y)-Vector2.new(plr:GetMouse().X,plr:GetMouse().Y)).Magnitude
     if m<d then d=m c=v end
    end
   end
  end
 end
 return c
end

R.RenderStepped:Connect(function()
 if getgenv().Nakano.Target==nil then
  getgenv().Nakano.Target=GetClosest()
 end
end)

spawn(function()
 while wait(0.3) do
  if getgenv().Nakano.AutoTP and getgenv().Nakano.Target and getgenv().Nakano.Target.Character then
   if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
    T:Create(plr.Character.HumanoidRootPart,TweenInfo.new(0.2),{CFrame=CFrame.new(getgenv().Nakano.Target.Character.HumanoidRootPart.Position+Vector3.new(0,0,4))}):Play()
   end
  end
 end
end)

print("Nakano V10 cargado we")
