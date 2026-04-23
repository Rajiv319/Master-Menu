-- --- MASTER MENU V4 (TOP TRACERS + CAM FLY) ---
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- --- CONFIG / STATE ---
local ESP_Settings = {
    Enabled = true,
    Boxes = true,
    Tracers = true,
    Names = true,
    RGB = true,
    MenuOpen = true,
    SpeedEnabled = false,
    FlyEnabled = false,
    NoclipEnabled = false,
    AimbotMaster = false,
    AimbotActive = false,
    SpeedValue = 300,
    FlySpeed = 5000,
    FOV_Radius = 200 
}

local Hue = 0

-- --- GUI ---
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "MasterMenu_Final_V4"
ScreenGui.ResetOnSpawn = false

local AimBtn = Instance.new("TextButton", ScreenGui)
AimBtn.Size = UDim2.new(0, 50, 0, 50)
AimBtn.Position = UDim2.new(0.8, 0, 0.4, 0)
AimBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
AimBtn.Text = "AIM"
AimBtn.TextColor3 = Color3.new(1, 1, 1)
AimBtn.Visible = false 
AimBtn.Draggable = true
AimBtn.Active = true
Instance.new("UICorner", AimBtn).CornerRadius = UDim.new(0, 10)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 180, 0, 395)
MainFrame.Position = UDim2.new(0, 50, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -35, 0, 35)
Title.Text = "  MASTER MENU"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", Title)

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -35, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

local Content = Instance.new("ScrollingFrame", MainFrame)
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 0, 450)
Content.ScrollBarThickness = 2

MinBtn.MouseButton1Click:Connect(function()
    ESP_Settings.MenuOpen = not ESP_Settings.MenuOpen
    Content.Visible = ESP_Settings.MenuOpen
    MainFrame.Size = ESP_Settings.MenuOpen and UDim2.new(0, 180, 0, 395) or UDim2.new(0, 180, 0, 35)
    MinBtn.Text = ESP_Settings.MenuOpen and "-" or "+"
end)

local function CreateToggle(name, pos, stateKey, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn)
    
    local function update()
        btn.Text = name .. ": " .. (ESP_Settings[stateKey] and "ON" or "OFF")
        btn.BackgroundColor3 = ESP_Settings[stateKey] and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    end
    
    btn.MouseButton1Click:Connect(function()
        ESP_Settings[stateKey] = not ESP_Settings[stateKey]
        update()
        if callback then callback(ESP_Settings[stateKey]) end
    end)
    update()
end

-- --- UI LAYOUT ---
local y = 0
CreateToggle("Master ESP", y, "Enabled"); y = y + 35
CreateToggle("Boxes", y, "Boxes"); y = y + 35
CreateToggle("Tracers", y, "Tracers"); y = y + 35
CreateToggle("Names", y, "Names"); y = y + 35
CreateToggle("Speed hack", y, "SpeedEnabled"); y = y + 35
CreateToggle("Fly (Cam Mode)", y, "FlyEnabled"); y = y + 35
CreateToggle("Noclip", y, "NoclipEnabled"); y = y + 35
CreateToggle("Aimbot Master", y, "AimbotMaster", function(s) 
    AimBtn.Visible = s 
    if not s then ESP_Settings.AimbotActive = false end
end); y = y + 35

AimBtn.MouseButton1Click:Connect(function()
    ESP_Settings.AimbotActive = not ESP_Settings.AimbotActive
    AimBtn.BackgroundColor3 = ESP_Settings.AimbotActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    AimBtn.Text = ESP_Settings.AimbotActive and "ON" or "OFF"
end)

-- --- AIMBOT & FLY LOOPS ---
RunService.RenderStepped:Connect(function(dt)
    Hue = (Hue + dt * 0.2) % 1
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if hrp and hum then
        hum.WalkSpeed = ESP_Settings.SpeedEnabled and ESP_Settings.SpeedValue or 16
        
        if ESP_Settings.FlyEnabled then
            hum.PlatformStand = true
            if hum.MoveDirection.Magnitude > 0 then
                hrp.Velocity = Camera.CFrame.LookVector * ESP_Settings.FlySpeed
            else
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        else
            if hum.PlatformStand then hum.PlatformStand = false end
        end

        if ESP_Settings.AimbotMaster and ESP_Settings.AimbotActive then
            local Target = nil
            local MaxDist = ESP_Settings.FOV_Radius
            local Center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local h = v.Character:FindFirstChild("Humanoid")
                    if h and h.Health > 0 then
                        local ScreenPos, OnScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                        if OnScreen then
                            local MouseDist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Center).Magnitude
                            if MouseDist < MaxDist then
                                MaxDist = MouseDist
                                Target = v
                            end
                        end
                    end
                end
            end
            
            if Target and Target.Character:FindFirstChild("HumanoidRootPart") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.HumanoidRootPart.Position)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if ESP_Settings.NoclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- --- ESP RENDERING (TOP SCREEN TRACERS) ---
local function CreateESP(player)
    if player == LocalPlayer then return end
    local line = Drawing.new("Line")
    line.Thickness = 1
    line.Visible = false

    local function setup(char)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        local hum = char:WaitForChild("Humanoid", 10)
        if not root or not hum then return end

        local box = Instance.new("BoxHandleAdornment", root)
        box.Size = Vector3.new(4, 6, 2)
        box.AlwaysOnTop = true
        box.Adornee = root
        box.Transparency = 0.5

        local gui = Instance.new("BillboardGui", root)
        gui.Size = UDim2.new(0, 150, 0, 60)
        gui.StudsOffset = Vector3.new(0, 4, 0)
        gui.AlwaysOnTop = true
        local lbl = Instance.new("TextLabel", gui)
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.TextStrokeTransparency = 0
        lbl.Font = Enum.Font.SourceSansBold

        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not char:IsDescendantOf(workspace) or hum.Health <= 0 then
                line.Visible = false
                conn:Disconnect()
                gui:Destroy()
                return
            end
            local vector, onScreen = Camera:WorldToViewportPoint(root.Position)
            local currentColor = Color3.fromHSV(Hue, 0.8, 1)
            
            if onScreen and ESP_Settings.Enabled and ESP_Settings.Tracers then
                line.Color = currentColor
                line.To = Vector2.new(vector.X, vector.Y)
                -- Yahan change kiya hai: 0 matlab Top of the screen
                line.From = Vector2.new(Camera.ViewportSize.X / 2, 0) 
                line.Visible = true
            else
                line.Visible = false
            end
            
            box.Visible = ESP_Settings.Enabled and ESP_Settings.Boxes
            box.Color3 = currentColor
            gui.Enabled = ESP_Settings.Enabled and ESP_Settings.Names
            if gui.Enabled then
                local dist = (root.Position - Camera.CFrame.Position).Magnitude
                lbl.Text = string.format("%s\n%d HP\n[%d studs]", player.Name, math.floor(hum.Health), math.floor(dist))
                lbl.TextColor3 = currentColor
            end
        end)
    end
    player.CharacterAdded:Connect(setup)
    if player.Character then setup(player.Character) end
end

Players.PlayerAdded:Connect(CreateESP)
for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
