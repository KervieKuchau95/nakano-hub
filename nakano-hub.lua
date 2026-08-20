--// NAKANO HUB V5 FIXED - MIKU CIRCULAR
local plr = game.Players.LocalPlayer
local Run = game:GetService("RunService")
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NakanoHubV5"
gui.ResetOnSpawn = false
local openBtn = Instance.new("ImageButton", gui)
openBtn.Size = UDim2.new(0,65,0,65)
openBtn.Position = UDim2.new(0.05,0,0.15,0)
openBtn.Image = "rbxthumb://type=Asset&id=121791820577874&w=420&h=420"
openBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1,0)
local stroke = Instance.new("UIStroke", openBtn)
stroke.Color = Color3.fromRGB(255,105,180)
stroke.Thickness = 3
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,200,0,220)
main.Position = UDim2.new(0.05,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)
openBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.Text = "Nakano Hub V5"
title.TextColor3 = Color3.fromRGB(255,105,180)
title.BackgroundColor3 = Color3.fromRGB(45,45,45)
title.TextScaled = true
Instance.new("UICorner", title)
local function createBtn(text, y, callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.9,0,0,35)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text.." [OFF]"
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    Instance.new("UICorner", b)
    local on = false
    b.MouseButton1Click:Connect(function()
        on = not on
        b.Text = text.." ["..(on and "ON" or "OFF").."]"
        b.BackgroundColor3 = on and Color3.fromRGB(255,105,180) or Color3.fromRGB(60,60,60)
        callback(on)
    end)
end
getgenv().ESPOn = false
createBtn("ESP PLAYERS", 35, function(s) getgenv().ESPOn = s end)
Run.Stepped:Connect(function()
    if getgenv().ESPOn then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if not v.Character:FindFirstChild("NakanoESP") then
                    local h = Instance.new("Highlight", v.Character)
                    h.Name = "NakanoESP"
                    h.FillColor = Color3.fromRGB(255,0,100)
                    h.OutlineColor = Color3.fromRGB(255,255,255)
                    h.FillTransparency = 0.3
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            end
        end
    else
        for _,v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("NakanoESP") then
                v.Character.NakanoESP:Destroy()
            end
        end
    end
end)
getgenv().Aimbot = false
local function GetClosest()
    local closest, dist = nil, 9999
    for _,v in pairs(game.Players:GetPlayers()) do
        if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(plr:GetMouse().X, plr:GetMouse().Y)).Magnitude
                if mag < dist then dist = mag closest = v.Character.HumanoidRootPart end
            end
        end
    end
    return closest
end
createBtn("AIMBOT", 75, function(s) getgenv().Aimbot = s end)
Run.RenderStepped:Connect(function()
    if getgenv().Aimbot then
        local target = GetClosest()
        if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position) end
    end
end)
createBtn("NOCLIP", 115, function(s)
    getgenv().Noclip = s
    Run.Stepped:Connect(function()
        if getgenv().Noclip and plr.Character then
            for _,v in pairs(plr.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
        end
    end)
end)
createBtn("BOOST FPS", 155, function(state)
    if state then
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
        end
        game.Lighting.GlobalShadows = false
    end
end)
