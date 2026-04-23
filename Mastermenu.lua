-- Master Menu: RGB ESP + Speed, Fly, Noclip
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
    SpeedValue = 300,
    FlySpeed = 50
}

local Hue = 0

-- --- GUI CREATION ---
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "ESPMaster_V3"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 180, 0, 360)
MainFrame.Position = UDim2.new(0, 50, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
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
Content.CanvasSize = UDim2.new(0, 0, 0, 400)
Content.ScrollBarThickness = 2

MinBtn.MouseButton1Click:Connect(function()
    ESP_Settings.MenuOpen = not ESP_Settings.MenuOpen
    Content.Visible = ESP_Settings.MenuOpen
    MainFrame.Size = ESP_Settings.MenuOpen and UDim2.new(0, 180, 0, 360) or UDim2.new(0, 180, 0, 35)
    MinBtn.Text = ESP_Settings.MenuOpen and "-" or "+"
end)

local function CreateToggle(name, pos, stateKey)
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
    end)
    update()
end

-- UI Layout
local y_pos = 0
CreateToggle("Master ESP", y_pos, "Enabled"); y_pos = y_pos + 35
CreateToggle("Boxes", y_pos, "Boxes"); y_pos = y_pos + 35
CreateToggle("Tracers", y_pos, "Tracers"); y_pos = y_pos + 35
CreateToggle("Names", y_pos, "Names"); y_pos = y_pos + 35
CreateToggle("Speed", y_pos, "SpeedEnabled"); y_pos = y_pos + 35
CreateToggle("Fly", y_pos, "FlyEnabled"); y_pos = y_pos + 35
CreateToggle("Noclip", y_pos, "NoclipEnabled"); y_pos = y_pos + 35

-- --- CORE LOGIC (Movement & ESP) ---
local function CreateESP(player)
    if player == LocalPlayer then return end
    local line = Drawing.new("Line")
    line.Visible = false
    line.Thickness = 1

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

            -- TRACER LOGIC: Set to Top Middle
            if onScreen and ESP_Settings.Enabled and ESP_Settings.Tracers then
                line.Color = currentColor
                line.To = Vector2.new(vector.X, vector.Y)
                line.From = Vector2.new(Camera.ViewportSize.X / 2, 0) -- This moves tracers to the top
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

-- Universal Loops
RunService.Heartbeat:Connect(function(dt)
    Hue = (Hue + dt * 0.2) % 1
    
    -- Noclip Heartbeat
    if ESP_Settings.NoclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    -- Speed
    hum.WalkSpeed = ESP_Settings.SpeedEnabled and ESP_Settings.SpeedValue or 16

    -- Fly
    if ESP_Settings.FlyEnabled then
        hum.PlatformStand = true
        local flyVec = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then flyVec = flyVec - Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then flyVec = flyVec + Vector3.new(0, 1, 0) end
        hrp.Velocity = (hum.MoveDirection * ESP_Settings.FlySpeed) + (flyVec * ESP_Settings.FlySpeed)
    else
        if hum.PlatformStand then hum.PlatformStand = false end
    end
end)

Players.PlayerAdded:Connect(CreateESP)
for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
