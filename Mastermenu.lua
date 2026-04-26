local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- --- CONFIG / KEY SYSTEM ---
local CorrectKey = "TILLU_MODS26"
local KeyInput = ""

-- --- KEY SYSTEM UI ---
local KeyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
KeyGui.Name = "TILLU_MODS_SYSTEM"

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke", KeyFrame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 150, 255)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "TILLU MODS - VERIFY"
KeyTitle.TextColor3 = Color3.new(1, 1, 1)
KeyTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0, 8)

local TextBox = Instance.new("TextBox", KeyFrame)
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.Position = UDim2.new(0.1, 0, 0.35, 0)
TextBox.PlaceholderText = "Enter Key Here..."
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.Font = Enum.Font.SourceSans
TextBox.TextSize = 16
Instance.new("UICorner", TextBox)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0.35, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
SubmitBtn.Text = "Submit"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 16
Instance.new("UICorner", SubmitBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.35, 0, 0, 40)
GetKeyBtn.Position = UDim2.new(0.55, 0, 0.65, 0)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 0)
GetKeyBtn.TextColor3 = Color3.new(1, 1, 1)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 16
Instance.new("UICorner", GetKeyBtn)

-- --- MAIN SCRIPT EXECUTION ---
local function StartMainScript()
    KeyGui:Destroy()
    
    local ESP_Settings = {
        Enabled = true,
        Boxes = true,
        Tracers = true,
        Names = true,
        MenuOpen = true, 
        SpeedEnabled = false,
        FlyEnabled = false,
        NoclipEnabled = false,
        AimbotMaster = false,
        AimbotActive = false,
        SpinbotEnabled = false,
        SpeedValue = 100,
        FlySpeed = 200,
        FOV_Radius = 200,
        SpinSpeed = 50
    }

    local MainColor = Color3.fromRGB(0, 150, 255) 

    local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.Name = "MasterMenu_Improved_V2"
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
    MainFrame.Size = UDim2.new(0, 220, 0, 450)
    MainFrame.Position = UDim2.new(0, 20, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) 
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.BorderSizePixel = 0
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

    local TitleLabel = Instance.new("TextLabel", TitleBar)
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0.05, 0, 0, 0)
    TitleLabel.Text = "TILLU MODS"
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextSize = 16

    local MinBtn = Instance.new("TextButton", TitleBar)
    MinBtn.Size = UDim2.new(0, 30, 0, 30)
    MinBtn.Position = UDim2.new(0.9, -15, 0.5, -15)
    MinBtn.Text = "-"
    MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MinBtn.TextColor3 = Color3.new(1, 1, 1)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 20
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

    local Line = Instance.new("Frame", MainFrame)
    Line.Size = UDim2.new(0.9, 0, 0, 2)
    Line.Position = UDim2.new(0.05, 0, 0, 40)
    Line.BackgroundColor3 = MainColor
    Line.BorderSizePixel = 0

    local Content = Instance.new("ScrollingFrame", MainFrame)
    Content.Size = UDim2.new(1, -20, 1, -55)
    Content.Position = UDim2.new(0, 10, 0, 50)
    Content.BackgroundTransparency = 1
    Content.CanvasSize = UDim2.new(0, 0, 0, 750) 
    Content.ScrollBarThickness = 3
    Content.ScrollBarImageColor3 = MainColor

    MinBtn.MouseButton1Click:Connect(function()
        ESP_Settings.MenuOpen = not ESP_Settings.MenuOpen
        Content.Visible = ESP_Settings.MenuOpen
        Line.Visible = ESP_Settings.MenuOpen
        MainFrame:TweenSize(ESP_Settings.MenuOpen and UDim2.new(0, 220, 0, 450) or UDim2.new(0, 220, 0, 35), "Out", "Quad", 0.3, true)
        MinBtn.Text = ESP_Settings.MenuOpen and "-" or "+"
    end)

    local function CreateControl(name, pos, stateKey, valueKey, callback)
        local controlFrame = Instance.new("Frame", Content)
        controlFrame.Size = UDim2.new(1, 0, 0, 35)
        controlFrame.Position = UDim2.new(0, 0, 0, pos)
        controlFrame.BackgroundTransparency = 1

        local btn = Instance.new("TextButton", controlFrame)
        btn.Size = valueKey and UDim2.new(0.65, 0, 1, 0) or UDim2.new(1, 0, 1, 0)
        btn.Text = name
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 15
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        if valueKey then
            local valInput = Instance.new("TextBox", controlFrame)
            valInput.Size = UDim2.new(0.3, 0, 1, 0)
            valInput.Position = UDim2.new(0.7, 0, 0, 0)
            valInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            valInput.TextColor3 = Color3.new(1, 1, 1)
            valInput.Text = tostring(ESP_Settings[valueKey])
            valInput.Font = Enum.Font.Code
            valInput.TextSize = 14
            Instance.new("UICorner", valInput).CornerRadius = UDim.new(0, 6)
            valInput.FocusLost:Connect(function()
                local num = tonumber(valInput.Text)
                if num then ESP_Settings[valueKey] = num else valInput.Text = tostring(ESP_Settings[valueKey]) end
            end)
        end

        local function update()
            local isOn = ESP_Settings[stateKey]
            btn.BackgroundColor3 = isOn and MainColor or Color3.fromRGB(50, 50, 50)
        end
        
        btn.MouseButton1Click:Connect(function()
            ESP_Settings[stateKey] = not ESP_Settings[stateKey]
            update()
            if callback then callback(ESP_Settings[stateKey]) end
        end)
        update()
    end

    local y = 0
    CreateControl("Master ESP", y, "Enabled"); y = y + 40
    CreateControl("Boxes", y, "Boxes"); y = y + 40
    CreateControl("Tracers", y, "Tracers"); y = y + 40
    CreateControl("Names", y, "Names"); y = y + 40
    y = y + 20
    CreateControl("Speed Hack", y, "SpeedEnabled", "SpeedValue"); y = y + 40
    CreateControl("Fly (Cam Mode)", y, "FlyEnabled", "FlySpeed"); y = y + 40
    CreateControl("Spinbot", y, "SpinbotEnabled", "SpinSpeed"); y = y + 40
    CreateControl("Noclip", y, "NoclipEnabled"); y = y + 40
    CreateControl("Aimbot Master", y, "AimbotMaster", nil, function(s) 
        AimBtn.Visible = s 
        if not s then ESP_Settings.AimbotActive = false end
    end); y = y + 40

    AimBtn.MouseButton1Click:Connect(function()
        ESP_Settings.AimbotActive = not ESP_Settings.AimbotActive
        AimBtn.BackgroundColor3 = ESP_Settings.AimbotActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        AimBtn.Text = ESP_Settings.AimbotActive and "ON" or "OFF"
    end)

    RunService.RenderStepped:Connect(function(dt)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        
        if hrp and hum then
            hum.WalkSpeed = ESP_Settings.SpeedEnabled and ESP_Settings.SpeedValue or 16

            if ESP_Settings.FlyEnabled then
                hum.PlatformStand = true
                hrp.Velocity = (hum.MoveDirection.Magnitude > 0) and (Camera.CFrame.LookVector * ESP_Settings.FlySpeed) or Vector3.new(0, 0.1, 0)
            else
                if hum.PlatformStand then hum.PlatformStand = false end
            end

            if ESP_Settings.AimbotMaster and ESP_Settings.AimbotActive then
                local Target = nil
                local MaxDist = ESP_Settings.FOV_Radius
                local Center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHum = v.Character:FindFirstChild("Humanoid")
                        if targetHum and targetHum.Health > 0 then
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
                if Target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.HumanoidRootPart.Position) end
            end

            local bodyAngular = hrp:FindFirstChild("SpinbotVelocity")
            if ESP_Settings.SpinbotEnabled then
                if not bodyAngular then
                    bodyAngular = Instance.new("AngularVelocity")
                    bodyAngular.Name = "SpinbotVelocity"
                    bodyAngular.MaxTorque = math.huge
                    bodyAngular.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
                    local att = Instance.new("Attachment", hrp)
                    att.Name = "SpinAttachment"
                    bodyAngular.Attachment0 = att
                    bodyAngular.Parent = hrp
                end
                bodyAngular.AngularVelocity = Vector3.new(0, ESP_Settings.SpinSpeed, 0)
            else
                if bodyAngular then bodyAngular:Destroy() end
                if hrp:FindFirstChild("SpinAttachment") then hrp.SpinAttachment:Destroy() end
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

    local function CreateESP(player)
        if player == LocalPlayer then return end
        local line = Drawing.new("Line")
        line.Thickness = 1.5 
        line.Visible = false
        local box = Drawing.new("Square")
        box.Thickness = 1.5
        box.Filled = false
        box.Visible = false

        local function setup(char)
            local root = char:WaitForChild("HumanoidRootPart", 10)
            local hum = char:WaitForChild("Humanoid", 10)
            if not root or not hum then return end
            local gui = Instance.new("BillboardGui", root)
            gui.Size = UDim2.new(0, 150, 0, 60)
            gui.StudsOffset = Vector3.new(0, 4.5, 0)
            gui.AlwaysOnTop = true
            local lbl = Instance.new("TextLabel", gui)
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.TextStrokeTransparency = 0.5
            lbl.Font = Enum.Font.SourceSansBold
            lbl.TextSize = 14

            local conn
            conn = RunService.RenderStepped:Connect(function()
                if not char:IsDescendantOf(workspace) or hum.Health <= 0 then
                    line.Visible = false
                    box.Visible = false
                    conn:Disconnect()
                    if gui then gui:Destroy() end
                    return
                end
                
                local vector, onScreen = Camera:WorldToViewportPoint(root.Position)
                
                -- --- RGB LOGIC ---
                local hue = tick() % 5 / 5
                local espColor = Color3.fromHSV(hue, 1, 1)

                if onScreen and ESP_Settings.Enabled then
                    if ESP_Settings.Boxes then
                        local top = Camera:WorldToViewportPoint(root.Position + Vector3.new(0, 3.5, 0))
                        local bottom = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 4, 0))
                        local height = math.abs(top.Y - bottom.Y)
                        local width = height / 1.5
                        box.Size = Vector2.new(width, height)
                        box.Position = Vector2.new(vector.X - width/2, vector.Y - height/2)
                        box.Color = espColor
                        box.Visible = true
                    else box.Visible = false end

                    if ESP_Settings.Tracers then
                        line.Color = espColor
                        line.To = Vector2.new(vector.X, vector.Y)
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, 0) 
                        line.Visible = true
                    else line.Visible = false end
                else
                    line.Visible = false
                    box.Visible = false
                end
                
                gui.Enabled = ESP_Settings.Enabled and ESP_Settings.Names
                if gui.Enabled then
                    local dist = (root.Position - Camera.CFrame.Position).Magnitude
                    lbl.Text = string.format("%s\n%d HP\n[%d studs]", player.DisplayName, math.floor(hum.Health), math.floor(dist))
                    lbl.TextColor3 = espColor
                end
            end)
        end
        player.CharacterAdded:Connect(setup)
        if player.Character then setup(player.Character) end
    end

    for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
    Players.PlayerAdded:Connect(CreateESP)
end

SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CorrectKey then
        StartMainScript()
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "WRONG KEY!"
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard("https://discord.gg/yourlink") end
    GetKeyBtn.Text = "Copied!"
    task.wait(2)
    GetKeyBtn.Text = "Get Key"
end)
