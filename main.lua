local p = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local SG = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera

-- [[ CONFIG HỆ THỐNG TỔNG HỢP ]] --
local CONFIG1 = { EscapeHP = 25, SafeHP = 75, Speed = 100, TargetHP = 30 }
local CONFIG2 = { SelectedTarget = nil }

local activeInvis1, activeCombat1, activeEscape1, systemLock1 = false, false, true, false
local activeCombat2 = false

-- [[ THÔNG BÁO ]] --
SG:SetCore("SendNotification", {
    Title = "★ klưn.z DOUBLE SYSTEM ★",
    Text = "FIXED: MENU 2 LIST VISIBLE! 🗿",
    Duration = 5
})

-- ==========================================
-- ||      MENU 1 (BẢN V6 CHÍNH CHỦ)       ||
-- ==========================================
local gui1 = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui1.Name = "klunz_Master_V6"; gui1.ResetOnSpawn = false 

local frame1 = Instance.new("Frame", gui1)
frame1.Size, frame1.Position = UDim2.new(0,210,0,420), UDim2.new(0.1,0,0.3,0)
frame1.BackgroundColor3 = Color3.fromRGB(10,10,10); frame1.Active, frame1.Draggable = true, true
frame1.ClipsDescendants = true; Instance.new("UICorner", frame1)

local title1 = Instance.new("TextLabel", frame1)
title1.Size, title1.Text = UDim2.new(1, 0, 0, 35), "★ klưn.z MASTER ★"
title1.TextColor3, title1.BackgroundTransparency = Color3.fromRGB(0, 255, 150), 1
title1.Font, title1.TextSize, title1.ZIndex = Enum.Font.Code, 15, 10

local toggleBtn1 = Instance.new("TextButton", frame1)
toggleBtn1.Size, toggleBtn1.Position = UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5)
toggleBtn1.Text, toggleBtn1.BackgroundColor3 = "-", Color3.fromRGB(40,40,40)
toggleBtn1.TextColor3, toggleBtn1.ZIndex = Color3.new(1,1,1), 100; Instance.new("UICorner", toggleBtn1)

local content1 = Instance.new("Frame", frame1)
content1.Size, content1.Position, content1.BackgroundTransparency = UDim2.new(1,0,0.9,0), UDim2.new(0,0,0.1,0), 1
content1.ZIndex = 5

local function createBtn1(text, pos, color)
    local b = Instance.new("TextButton", content1)
    b.Size, b.Position = UDim2.new(0.9,0,0.08,0), pos
    b.Text, b.BackgroundColor3, b.TextColor3, b.Font = text, color, Color3.new(1,1,1), Enum.Font.Code
    b.TextSize, b.ZIndex = 12, 10; Instance.new("UICorner", b); return b
end

local invBtn1 = createBtn1("INVIS/HIDE NAME: OFF", UDim2.new(0.05,0,0.02,0), Color3.fromRGB(200,40,40))
local combatBtn1 = createBtn1("AUTO KILL + AIM: OFF", UDim2.new(0.05,0,0.11,0), Color3.fromRGB(80,80,80))
local escToggle1 = createBtn1("AUTO ESCAPE: ON", UDim2.new(0.05,0,0.20,0), Color3.fromRGB(0,150,255))
local getupBtn1 = createBtn1("AUTO GETUP: ON", UDim2.new(0.05,0,0.29,0), Color3.fromRGB(0, 180, 100))

local hpInput1 = Instance.new("TextBox", content1)
hpInput1.Size, hpInput1.Position = UDim2.new(0.9,0,0.08,0), UDim2.new(0.05,0,0.40,0)
hpInput1.Text = "Set Escape HP: 25"; hpInput1.BackgroundColor3 = Color3.fromRGB(30,30,30)
hpInput1.TextColor3, hpInput1.Font, hpInput1.TextSize = Color3.new(1,1,1), Enum.Font.Code, 12; Instance.new("UICorner", hpInput1)

local targetInput1 = Instance.new("TextBox", content1)
targetInput1.Size, targetInput1.Position = UDim2.new(0.9,0,0.08,0), UDim2.new(0.05,0,0.50,0)
targetInput1.Text = "Set Target HP: 30"; targetInput1.BackgroundColor3 = Color3.fromRGB(30,30,30)
targetInput1.TextColor3, targetInput1.Font, targetInput1.TextSize = Color3.fromRGB(255, 255, 0), Enum.Font.Code, 12; Instance.new("UICorner", targetInput1)

local statusLabel1 = Instance.new("TextLabel", content1)
statusLabel1.Size, statusLabel1.Position = UDim2.new(1,0,0.07,0), UDim2.new(0,0,0.88,0)
statusLabel1.Text, statusLabel1.TextColor3 = "STATUS: IDLE", Color3.new(0.7,0.7,0.7)
statusLabel1.Font, statusLabel1.TextSize, statusLabel1.BackgroundTransparency = Enum.Font.Code, 11, 1

-- ==========================================
-- ||      MENU 2 (FIXED: HIỆN DANH SÁCH)   ||
-- ==========================================
local gui2 = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui2.Name = "klunz_Aimbot_Killer"; gui2.ResetOnSpawn = false

local main2 = Instance.new("Frame", gui2)
main2.Size, main2.Position = UDim2.new(0, 180, 0, 110), UDim2.new(1, -190, 0.3, 0)
main2.BackgroundColor3 = Color3.fromRGB(15, 15, 15); main2.Active, main2.Draggable = true, true
-- Tắt ClipsDescendants để thấy bảng danh sách bên ngoài
main2.ClipsDescendants = false; Instance.new("UICorner", main2)

local topBar2 = Instance.new("Frame", main2)
topBar2.Size, topBar2.BackgroundColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(25, 25, 25); Instance.new("UICorner", topBar2)

local title2 = Instance.new("TextLabel", topBar2)
title2.Size, title2.Position = UDim2.new(1, -60, 1, 0), UDim2.new(0, 10, 0, 0)
title2.Text = "★ TARGET LOCK ★"; title2.TextColor3 = Color3.fromRGB(255, 60, 60)
title2.Font, title2.TextSize, title2.BackgroundTransparency = Enum.Font.Code, 11, 1; title2.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn2 = Instance.new("TextButton", topBar2)
toggleBtn2.Size, toggleBtn2.Position = UDim2.new(0, 22, 0, 22), UDim2.new(1, -52, 0, 4)
toggleBtn2.Text, toggleBtn2.BackgroundColor3 = "-", Color3.fromRGB(45, 45, 45); toggleBtn2.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", toggleBtn2)

local listToggle2 = Instance.new("TextButton", topBar2)
listToggle2.Size, listToggle2.Position = UDim2.new(0, 22, 0, 22), UDim2.new(1, -26, 0, 4)
listToggle2.Text, listToggle2.BackgroundColor3 = ">", Color3.fromRGB(45, 45, 45); listToggle2.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", listToggle2)

local content2 = Instance.new("Frame", main2)
content2.Size, content2.Position, content2.BackgroundTransparency = UDim2.new(1, 0, 1, -30), UDim2.new(0, 0, 0, 30), 1

local combatBtn2 = Instance.new("TextButton", content2)
combatBtn2.Size, combatBtn2.Position = UDim2.new(0.9, 0, 0, 35), UDim2.new(0.05, 0, 0.05, 0)
combatBtn2.Text = "AIM & KILL: OFF"; combatBtn2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
combatBtn2.TextColor3, combatBtn2.Font, combatBtn2.TextSize = Color3.new(1, 1, 1), Enum.Font.Code, 10; Instance.new("UICorner", combatBtn2)

local resetBtn2 = Instance.new("TextButton", content2)
resetBtn2.Size, resetBtn2.Position = UDim2.new(0.9, 0, 0, 25), UDim2.new(0.05, 0, 0.55, 0)
resetBtn2.Text = "[ RESET SCAN ]"; resetBtn2.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
resetBtn2.TextColor3, resetBtn2.Font, resetBtn2.TextSize = Color3.new(1, 1, 1), Enum.Font.Code, 9; Instance.new("UICorner", resetBtn2)

-- Bảng danh sách đặt bên Trái (-160)
local listFrame2 = Instance.new("Frame", main2)
listFrame2.Size, listFrame2.Position = UDim2.new(0, 150, 0, 200), UDim2.new(0, -160, 0, 0)
listFrame2.BackgroundColor3 = Color3.fromRGB(10, 10, 10); listFrame2.Visible = false; Instance.new("UICorner", listFrame2)

local scroll2 = Instance.new("ScrollingFrame", listFrame2)
scroll2.Size, scroll2.Position = UDim2.new(0.9, 0, 0.9, 0), UDim2.new(0.05, 0, 0.05, 0)
scroll2.BackgroundColor3, scroll2.ScrollBarThickness = Color3.fromRGB(15, 15, 15), 1; Instance.new("UIListLayout", scroll2)

function updateList2()
    for _, v in pairs(scroll2:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, pl in pairs(game.Players:GetPlayers()) do
        if pl ~= p then
            local b = Instance.new("TextButton", scroll2)
            b.Size, b.Text = UDim2.new(1, 0, 0, 22), " " .. pl.Name
            b.BackgroundColor3 = (CONFIG2.SelectedTarget == pl) and Color3.fromRGB(120, 0, 0) or Color3.fromRGB(25, 25, 25)
            b.TextColor3, b.Font, b.TextSize = Color3.new(1, 1, 1), Enum.Font.Code, 8
            b.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() CONFIG2.SelectedTarget = (CONFIG2.SelectedTarget == pl) and nil or pl updateList2() end)
        end
    end
end

-- [[ LOGIC NÚT BẤM CHUNG ]] --
toggleBtn1.MouseButton1Click:Connect(function()
    local isCol = (toggleBtn1.Text == "-")
    frame1:TweenSize(isCol and UDim2.new(0,210,0,35) or UDim2.new(0,210,0,420), "Out", "Quart", 0.3, true)
    content1.Visible = not isCol; toggleBtn1.Text = isCol and "+" or "-"
end)

toggleBtn2.MouseButton1Click:Connect(function()
    local isCol = (toggleBtn2.Text == "-")
    -- Khi thu gọn thì ẩn luôn list để tránh bị treo lơ lửng
    if isCol then listFrame2.Visible = false; listToggle2.Text = ">" end
    main2:TweenSize(isCol and UDim2.new(0, 180, 0, 30) or UDim2.new(0, 180, 0, 110), "Out", "Quart", 0.3, true)
    content2.Visible = not isCol; toggleBtn2.Text = isCol and "+" or "-"
end)

listToggle2.MouseButton1Click:Connect(function()
    listFrame2.Visible = not listFrame2.Visible
    listToggle2.Text = listFrame2.Visible and "<" or ">"
    if listFrame2.Visible then updateList2() end
end)

combatBtn1.MouseButton1Click:Connect(function() 
    activeCombat1 = not activeCombat1
    combatBtn1.Text = activeCombat1 and "AUTO KILL + AIM: ON" or "AUTO KILL + AIM: OFF"
    combatBtn1.BackgroundColor3 = activeCombat1 and Color3.fromRGB(138,43,226) or Color3.fromRGB(80,80,80)
end)

combatBtn2.MouseButton1Click:Connect(function()
    activeCombat2 = not activeCombat2
    combatBtn2.Text = activeCombat2 and "AIM & KILL: ON" or "AIM & KILL: OFF"
    combatBtn2.BackgroundColor3 = activeCombat2 and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(35, 35, 35)
end)

resetBtn2.MouseButton1Click:Connect(function() CONFIG2.SelectedTarget = nil updateList2() end)
game.Players.PlayerAdded:Connect(updateList2); game.Players.PlayerRemoving:Connect(updateList2)

-- Các chức năng Menu 1 giữ nguyên
invBtn1.MouseButton1Click:Connect(function() 
    activeInvis1 = not activeInvis1
    invBtn1.Text = activeInvis1 and "INVIS: ON" or "INVIS: OFF"
    invBtn1.BackgroundColor3 = activeInvis1 and Color3.fromRGB(0,255,150) or Color3.fromRGB(200,40,40)
end)

escToggle1.MouseButton1Click:Connect(function() 
    activeEscape1 = not activeEscape1
    escToggle1.Text = activeEscape1 and "AUTO ESCAPE: ON" or "AUTO ESCAPE: OFF"
    escToggle1.BackgroundColor3 = activeEscape1 and Color3.fromRGB(0,150,255) or Color3.fromRGB(200,40,40)
    if not activeEscape1 then systemLock1 = false end
end)

hpInput1.FocusLost:Connect(function()
    local val = tonumber(hpInput1.Text:match("%d+"))
    if val then CONFIG1.EscapeHP = val hpInput1.Text = "Set Escape HP: "..val end
end)

targetInput1.FocusLost:Connect(function()
    local val = tonumber(targetInput1.Text:match("%d+"))
    if val then CONFIG1.TargetHP = val targetInput1.Text = "Set Target HP: "..val end
end)

-- [[ HỆ THỐNG CORE ]] --
RS.Heartbeat:Connect(function()
    local char = p.Character; local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not (root and hum) then return end

    -- Tự động tăng tốc nếu cần
    hum.WalkSpeed = CONFIG1.Speed

    -- ESCAPE
    local myHP = math.floor((hum.Health / hum.MaxHealth) * 100)
    if activeEscape1 and myHP <= CONFIG1.EscapeHP then systemLock1 = true 
    elseif myHP >= CONFIG1.SafeHP then systemLock1 = false end

    if systemLock1 then
        root.CFrame = CFrame.new(root.Position.X, 1000, root.Position.Z); root.Velocity = Vector3.zero
        statusLabel1.Text = "STATUS: SKY ESCAPE"; return
    end

    -- Tìm mục tiêu
    local target = nil
    if activeCombat2 and CONFIG2.SelectedTarget and CONFIG2.SelectedTarget.Character then
        local tHum = CONFIG2.SelectedTarget.Character:FindFirstChild("Humanoid")
        if tHum and tHum.Health > 0 then target = CONFIG2.SelectedTarget.Character:FindFirstChild("HumanoidRootPart") end
    end
    
    if not target and (activeCombat1 or activeCombat2) then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= p and v.Character and v.Character:FindFirstChild("Humanoid") then
                local eHP = math.floor((v.Character.Humanoid.Health / v.Character.Humanoid.MaxHealth) * 100)
                if eHP > 0 and eHP <= CONFIG1.TargetHP then target = v.Character.HumanoidRootPart; break end
            end
        end
    end

    if target and (activeCombat1 or activeCombat2) then
        root.CFrame = target.CFrame * CFrame.new(0, 0, 2.8)
        root.CFrame = CFrame.lookAt(root.Position, target.Position)
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position + Vector3.new(0, 1, 0))
        statusLabel1.Text = "AIMING: " .. target.Parent.Name
    else
        statusLabel1.Text = (activeCombat1 or activeCombat2) and "STATUS: SEARCHING..." or "STATUS: IDLE"
    end
end)

-- Loop đánh server
task.spawn(function()
    while task.wait(0.1) do
        if (activeCombat1 or activeCombat2) and not systemLock1 then
            local ev = p.Character and p.Character:FindFirstChild("Communicate")
            if ev then for i = 1, 4 do ev:FireServer({[1] = i}) end end
        end
    end
end)
