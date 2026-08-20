--// NAKANO HUB V13 - MIKU FINAL - ID: 118017336964341
local Players=game:GetService("Players")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local VIM=game:GetService("VirtualInputManager")
local plr=Players.LocalPlayer
local cam=workspace.CurrentCamera

getgenv().Nakano = getgenv().Nakano or {AutoTP=false, AutoV4=false, Aim=false, ESP=false, Boost=false, FOV=300}
if game.CoreGui:FindFirstChild("NakanoV13") then game.CoreGui.NakanoV13:Destroy() end
local gui=Instance.new("ScreenGui",game.CoreGui) gui.Name="NakanoV13" gui.ResetOnSpawn=false

-- BOTON AI CON TU MIKU
local side=Instance.new("Frame",gui) side.Size=UDim2.new(0,75,0,115) side.Position=UDim2.new(0,15,0.4,0) side.BackgroundColor3=Color3.fromRGB(15,15,25) side.Active=true side.Draggable=true
Instance.new("UICorner",side).CornerRadius=UDim.new(0,14) local s1=Instance.new("UIStroke",side) s1.Color=Color3.fromRGB(255,105,180) s1.Thickness=2.5
local ai=Instance.new("TextLabel",side) ai.Size=UDim2.new(1,0,0,22) ai.Text="AI" ai.Font=Enum.Font.GothamBold ai.TextSize=16 ai.TextColor3=Color3.fromRGB(255,150,220) ai.BackgroundTransparency=1
local btn=Instance.new("ImageButton",side) 
btn.Size=UDim2.new(0,55,0,55) 
btn.Position=UDim2.new(0.5,-27,0,30) 
btn.Image="rbxassetid://118017336964341" -- TU MIKU NAKANO
btn.BackgroundColor3=Color3.fromRGB(30,30,40) 
Instance.new("UICorner",btn).CornerRadius=UDim.new(1,0)
local ml=Instance.new("TextLabel",side) ml.Size=UDim2.new(1,0,0,20) ml.Position=UDim2.new(0,0,0,90) ml.Text="Menu" ml.BackgroundTransparency=1 ml.TextColor3=Color3.fromRGB(255,215,0) ml.Font=Enum.Font.GothamBold ml.TextSize=11

-- MAIN
local main=Instance.new("Frame",gui) main.Size=UDim2.new(0,395,0,470) main.Position=UDim2.new(0.5,-197,0.5,-235) main.BackgroundColor3=Color3.fromRGB(12,12,18) main.Visible=false main.Active=true main.Draggable=true
Instance.new("UICorner",main).CornerRadius=UDim.new(0,16) local s2=Instance.new("UIStroke",main) s2.Color=Color3.fromRGB(255,105,180) s2.Thickness=2

local top=Instance.new("Frame",main) top.Size=UDim2.new(1,0,0,42) top.BackgroundColor3=Color3.fromRGB(255,105,180) Instance.new("UICorner",top).CornerRadius=UDim.new(0,16)
local tl=Instance.new("TextLabel",top) tl.Size=UDim2.new(1,-60,1,0) tl.Position=UDim2.new(0,15,0,0) tl.Text="NAKANO HUB V13 • MIKU" tl.BackgroundTransparency=1 tl.Font=Enum.Font.GothamBold tl.TextSize=16 tl.TextColor3=Color3.fromRGB(15,15,15) tl.TextXAlignment=Enum.TextXAlignment.Left
local close=Instance.new("TextButton",top) close.Size=UDim2.new(0,30,0,30) close.Position=UDim2.new(1,-35,0,6) close.Text="X" close.TextColor3=Color3.new(1,1,1) close.BackgroundColor3=Color3.fromRGB(20,20,20) Instance.new("UICorner",close).CornerRadius=UDim.new(0,8)
close.MouseButton1Click:Connect(function() main.Visible=false end)

local scroll=Instance.new("ScrollingFrame",main) scroll.Size=UDim2.new(1,0,1,-92) scroll.Position=UDim2.new(0,0,0,48) scroll.BackgroundTransparency=1 scroll.ScrollBarThickness=2 scroll.CanvasSize=UDim2.new(0,0,0,700)
local lay=Instance.new("UIListLayout",scroll) lay.Padding=UDim.new(0,10) local pad=Instance.new("UIPadding",scroll) pad.PaddingLeft=UDim.new(0,12) pad.PaddingRight=UDim.new(0,12) pad.PaddingTop=UDim.new(0,10)

local function MakeToggle(name, desc, default, callback)
 local f=Instance.new("Frame",scroll) f.Size=UDim2.new(1,0,0,62) f.BackgroundColor3=Color3.fromRGB(22,22,32) Instance.new("UICorner",f).CornerRadius=UDim.new(0,12) local st=Instance.new("UIStroke",f) st.Color=Color3.fromRGB(255,105,180) st.Transparency=0.6
 local t1=Instance.new("TextLabel",f) t1.Text=name t1.Size=UDim2.new(0.6,0,0,18) t1.Position=UDim2.new(0,10,0,8) t1.BackgroundTransparency=1 t1.TextColor3=Color3.new(1,1,1) t1.Font=Enum.Font.GothamBold t1.TextSize=13 t1.TextXAlignment=Enum.TextXAlignment.Left
 local t2=Instance.new("TextLabel",f) t2.Text=desc t2.Size=UDim2.new(0.6,0,0,14) t2.Position=UDim2.new(0,10,0,30) t2.BackgroundTransparency=1 t2.TextColor3=Color3.fromRGB(130,180,255) t2.TextSize=10 t2.TextXAlignment=Enum.TextXAlignment.Left
 local tog=Instance.new("Frame",f) tog.Size=UDim2.new(0,52,0,26) tog.Position=UDim2.new(1,-62,0.5,-13) tog.BackgroundColor3=default and Color3.fromRGB(255,105,180) or Color3.fromRGB(55,55,65) Instance.new("UICorner",tog).CornerRadius=UDim.new(1,0)
 local dot=Instance.new("Frame",tog) dot.Size=UDim2.new(0,20,0,20) dot.Position=default and UDim2.new(1,-23,0.5,-10) or UDim2.new(0,3,0.5,-10) dot.BackgroundColor3=Color3.new(1,1,1) Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
 local btn2=Instance.new("TextButton",f) btn2.Size=UDim2.new(1,0,1,0) btn2.Text="" btn2.BackgroundTransparency=1
 local on=default
 btn2.MouseButton1Click:Connect(function() on=not on TS:Create(tog,TweenInfo.new(0.2),{BackgroundColor3=on and Color3.fromRGB(255,105,180) or Color3.fromRGB(55,55,65)}):Play() TS:Create(dot,TweenInfo.new(0.2),{Position=on and UDim2.new(1,-23,0.5,-10) or UDim2.new(0,3,0.5,-10)}):Play() callback(on) end)
end

-- LOGICA FIX: SOLO JUGADORES ENEMIGOS
local function GetClosestPlayer()
 local closest, dist = nil, getgenv().Nakano.FOV
 for _,v in pairs(Players:GetPlayers()) do
  if v~=plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
   if v.Character.Humanoid.Health>0 then
    local pos,onScreen=cam:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
    if onScreen then
     local mag=(Vector2.new(pos.X,pos.Y)-Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)).Magnitude
     if mag < dist then dist=mag closest=v end
    end
   end
  end
 end
 return closest
end

MakeToggle("FPS BOOST ULTRA","Activa - Quita lag Draco V4",false,function(v)
 getgenv().Nakano.Boost=v
 if v then
  game.Lighting.GlobalShadows=false settings().Rendering.QualityLevel=1
  for _,obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") then obj.Material=Enum.Material.SmoothPlastic obj.CastShadow=false elseif obj:IsA("ParticleEmitter") then obj.Enabled=false end end
 end
end)

MakeToggle("Auto TP Jugador","SOLO players - Fix NPC",false,function(v) getgenv().Nakano.AutoTP=v end)
MakeToggle("Aimbot PVP","Lock al mas cercano a mira",false,function(v) getgenv().Nakano.Aim=v end)
MakeToggle("Auto V4 Draco","Presiona Y automatico",false,function(v) getgenv().Nakano.AutoV4=v end)
MakeToggle("ESP Vida + Dist","Ver vida real",false,function(v) getgenv().Nakano.ESP=v end)

local prem=Instance.new("Frame",main) prem.Size=UDim2.new(1,-20,0,34) prem.Position=UDim2.new(0,10,1,-42) prem.BackgroundColor3=Color3.fromRGB(255,105,180) Instance.new("UICorner",prem).CornerRadius=UDim.new(0,10)
local pt=Instance.new("TextLabel",prem) pt.Size=UDim2.new(1,0,1,0) pt.Text="PREMIUM • MIKU NAKANO • V13" pt.BackgroundTransparency=1 pt.TextColor3=Color3.new(1,1,1) pt.Font=Enum.Font.GothamBold pt.TextSize=11

btn.MouseButton1Click:Connect(function() main.Visible=not main.Visible if main.Visible then main.Size=UDim2.new(0,0,0,0) TS:Create(main,TweenInfo.new(0.3,Enum.EasingStyle.Back),{Size=UDim2.new(0,395,0,470)}):Play() end end)

-- LOOPS REALES
RS.RenderStepped:Connect(function() if getgenv().Nakano.Aim then local t=GetClosestPlayer() if t and t.Character then cam.CFrame=CFrame.new(cam.CFrame.Position, t.Character.HumanoidRootPart.Position) end end end)
spawn(function() while task.wait(0.35) do if getgenv().Nakano.AutoTP then local t=GetClosestPlayer() if t and t.Character and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then plr.Character.HumanoidRootPart.CFrame=CFrame.new(t.Character.HumanoidRootPart.Position + Vector3.new(2,1,2)) end end end end)
spawn(function() while task.wait(2) do if getgenv().Nakano.AutoV4 then pcall(function() VIM:SendKeyEvent(true,"Y",false,game) task.wait(0.1) VIM:SendKeyEvent(false,"Y",false,game) end) end end end)

print("NAKANO V13 MIKU CARGADO")
