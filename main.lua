local p = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local SG = game:GetService("StarterGui")

-- [[ THÔNG BÁO ]] --
SG:SetCore("SendNotification", {
    Title = "★ klưn.z MASTER V6 ★",
    Text = "FULL FIX: Invis, Name, ESP, Escape! 🗿",
    Duration = 5
})

local CONFIG = {
    EscapeHP = 25,  
    SafeHP = 75,    
    Speed = 100,    
    TargetHP = 20   
}

local activeInvis, activeCombat, activeEscape, systemLock = false, false, true, false

-- [[ GUI DESIGN - GIỮ NGUYÊN ]] --
local gui = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui.Name = "klunz_Master_V6"; gui.ResetOnSpawn = false 

local frame = Instance.new("Frame", gui)
frame.Size, frame.Position = UDim2.new(0,210,0,380), UDim2.new(0.1,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(10,10,10); frame.Active, frame.Draggable = true, true
frame.ClipsDescendants = true; Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size, title.Text = UDim2.new(1, 0, 0, 35), "★ klưn.z MASTER ★"
title.TextColor3, title.BackgroundTransparency = Color3.fromRGB(0, 255, 150), 1
title.Font, title.TextSize, title.ZIndex = Enum.Font.Code, 15, 10

local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size, toggleBtn.Position = UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5)
toggleBtn.Text, toggleBtn.BackgroundColor3 = "-", Color3.fromRGB(40,40,40)
toggleBtn.TextColor3, toggleBtn.ZIndex = Color3.new(1,1,1), 100
Instance.new("UICorner", toggleBtn)

local content = Instance.new("Frame", frame)
content.Size, content.Position, content.BackgroundTransparency = UDim2.new(1,0,0.9,0), UDim2.new(0,0,0.1,0), 1
content.ZIndex = 5

local function createBtn(text, pos, color)
    local b = Instance.new("TextButton", content)
    b.Size, b.Position = UDim2.new(0.9,0,0.09,0), pos
    b.Text, b.BackgroundColor3, b.TextColor3, b.Font = text, color, Color3.new(1,1,1), Enum.Font.Code
    b.TextSize, b.ZIndex = 12, 10; Instance.new("UICorner", b); return b
end

local invBtn = createBtn("INVIS/HIDE NAME: OFF", UDim2.new(0.05,0,0.02,0), Color3.fromRGB(200,40,40))
local combatBtn = createBtn("AUTO KILL: OFF", UDim2.new(0.05,0,0.13,0), Color3.fromRGB(80,80,80))
local escToggle = createBtn("AUTO ESCAPE: ON", UDim2.new(0.05,0,0.24,0), Color3.fromRGB(0,150,255))
local getupBtn = createBtn("AUTO GETUP: ON", UDim2.new(0.05,0,0.35,0), Color3.fromRGB(0, 180, 100))

local hpInput = Instance.new("TextBox", content)
hpInput.Size, hpInput.Position = UDim2.new(0.9,0,0.08,0), UDim2.new(0.05,0,0.48,0)
hpInput.Text = "Set Escape HP: 25"; hpInput.BackgroundColor3 = Color3.fromRGB(30,30,30)
hpInput.TextColor3, hpInput.Font, hpInput.TextSize = Color3.new(1,1,1), Enum.Font.Code, 12
Instance.new("UICorner", hpInput)

local statusLabel = Instance.new("TextLabel", content)
statusLabel.Size, statusLabel.Position = UDim2.new(1,0,0.07,0), UDim2.new(0,0,0.85,0)
statusLabel.Text, statusLabel.TextColor3 = "STATUS: IDLE", Color3.new(0.7,0.7,0.7)
statusLabel.Font, statusLabel.TextSize, statusLabel.BackgroundTransparency = Enum.Font.Code, 11, 1

-- [[ HÀM XỬ LÝ ESP X-RAY & HP % ]] --
local function updateESP(vChar, healthPercent)
    local hl = vChar:FindFirstChild("Hunter_HL") or Instance.new("Highlight", vChar)
    hl.Name = "Hunter_HL"
    hl.FillColor = Color3.fromRGB(255, 0, 0)
    hl.FillTransparency = 0.5
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    local tag = vChar:FindFirstChild("HealthTag") or Instance.new("BillboardGui", vChar)
    if tag.ClassName ~= "BillboardGui" then tag:Destroy() tag = Instance.new("BillboardGui", vChar) end
    tag.Name = "HealthTag"
    tag.Size, tag.AlwaysOnTop, tag.Adornee = UDim2.new(0,100,0,50), true, vChar:FindFirstChild("Head")
    tag.ExtentsOffset = Vector3.new(0, 3, 0)

    local txt = tag:FindFirstChild("Val") or Instance.new("TextLabel", tag)
    txt.Name = "Val"
    txt.Size, txt.BackgroundTransparency = UDim2.new(1,0,1,0), 1
    txt.TextColor3 = (healthPercent <= 15) and Color3.new(1,0,0) or Color3.new(1,1,0)
    txt.Text, txt.Font, txt.TextSize, txt.TextStrokeTransparency = "HP: "..healthPercent.."%", Enum.Font.Code, 14, 0
end

-- [[ LOGIC NÚT BẤM ]] --
toggleBtn.MouseButton1Click:Connect(function()
    local isCol = (toggleBtn.Text == "-")
    frame:TweenSize(isCol and UDim2.new(0,210,0,35) or UDim2.new(0,210,0,380), "Out", "Quart", 0.3, true)
    content.Visible = not isCol; toggleBtn.Text = isCol and "+" or "-"
end)

invBtn.MouseButton1Click:Connect(function() 
    activeInvis = not activeInvis
    invBtn.Text = activeInvis and "INVIS/HIDE NAME: ON" or "INVIS/HIDE NAME: OFF"
    invBtn.BackgroundColor3 = activeInvis and Color3.fromRGB(0,255,150) or Color3.fromRGB(200,40,40)
    if not activeInvis and p.Character:FindFirstChild("Humanoid") then
        p.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
    end
end)

combatBtn.MouseButton1Click:Connect(function() 
    activeCombat = not activeCombat
    combatBtn.Text = activeCombat and "AUTO KILL: ON" or "AUTO KILL: OFF"
    combatBtn.BackgroundColor3 = activeCombat and Color3.fromRGB(138,43,226) or Color3.fromRGB(80,80,80)
end)

escToggle.MouseButton1Click:Connect(function() 
    activeEscape = not activeEscape
    escToggle.Text = activeEscape and "AUTO ESCAPE: ON" or "AUTO ESCAPE: OFF"
    escToggle.BackgroundColor3 = activeEscape and Color3.fromRGB(0,150,255) or Color3.fromRGB(200,40,40)
    if not activeEscape then systemLock = false end
end)

hpInput.FocusLost:Connect(function()
    local val = tonumber(hpInput.Text:match("%d+"))
    if val then CONFIG.EscapeHP = val; hpInput.Text = "Set Escape HP: "..val end
end)

-- [[ VÒNG LẶP CHÍNH ]] --
RS.Heartbeat:Connect(function()
    local char = p.Character; local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not (root and hum) then return end

    -- FIX INVIS & HIDE NAME (XỬ LÝ TRIỆT ĐỂ)
    if activeInvis then
        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None -- Ẩn tên
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then 
                v.Transparency = 1 
            elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then 
                v.Handle.Transparency = 1 
            end
        end
    else
        -- Hiện lại khi tắt
        for _, v in pairs(char:GetDescendants()) do
            if (v:IsA("BasePart") and v.Name ~= "HumanoidRootPart") or v:IsA("Decal") then 
                v.Transparency = 0 
            elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then 
                v.Handle.Transparency = 0 
            end
        end
    end

    -- AUTO ESCAPE
    local myHP = math.floor((hum.Health / hum.MaxHealth) * 100)
    if activeEscape then
        if myHP <= CONFIG.EscapeHP then systemLock = true 
        elseif myHP >= CONFIG.SafeHP then systemLock = false end
    else systemLock = false end

    if systemLock then
        root.CFrame = CFrame.new(root.Position.X, 1000, root.Position.Z); root.Velocity = Vector3.zero
        statusLabel.Text = "STATUS: SKY ESCAPE"; return
    end

    hum.WalkSpeed = CONFIG.Speed
    
    -- QUÉT ĐỊCH & ESP
    local target = nil
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= p and v.Character and v.Character:FindFirstChild("Humanoid") then
            local eHum = v.Character.Humanoid
            local eHP = math.floor((eHum.Health / eHum.MaxHealth) * 100)
            
            if eHP > 0 and eHP <= CONFIG.TargetHP then
                updateESP(v.Character, eHP)
                if activeCombat and not target then target = v.Character.HumanoidRootPart end
            else
                if v.Character:FindFirstChild("Hunter_HL") then v.Character.Hunter_HL:Destroy() end
                if v.Character:FindFirstChild("HealthTag") then v.Character.HealthTag:Destroy() end
            end
        end
    end

    if target and activeCombat then
        root.CFrame = target.CFrame * CFrame.new(0, 0, 2.5)
        root.CFrame = CFrame.lookAt(root.Position, target.Position)
        statusLabel.Text = "TARGET: " .. target.Parent.Name .. " [" .. math.floor((target.Parent.Humanoid.Health / target.Parent.Humanoid.MaxHealth) * 100) .. "%]"
    else
        statusLabel.Text = activeCombat and "STATUS: SEARCHING" or "STATUS: IDLE"
    end
end)

-- ATTACK LOOP
task.spawn(function()
    while task.wait(0.1) do
        if activeCombat and not systemLock then
            local char = p.Character
            if char and char:FindFirstChild("Communicate") then 
                for i = 1, 4 do char.Communicate:FireServer({[1] = i}) end
            end
        end
    end
end)
