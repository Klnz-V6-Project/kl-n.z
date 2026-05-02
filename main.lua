-- [[ klưn.z MASTER SYSTEM - FULL VERSION + HITBOX + HP LIST ]] --
local p = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local SG = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera

-- [[ CONFIG HỆ THỐNG ]] --
local CONFIG1 = { EscapeHP = 25, SafeHP = 75, Speed = 100, TargetHP = 30, HitboxSize = 8 }
local CONFIG2 = { SelectedTarget = nil }

local activeInvis1, activeCombat1, activeEscape1, systemLock1 = false, false, true, false
local activeCombat2, activeHitbox = false, false

-- [[ THÔNG BÁO KHỞI TẠO ]] --
SG:SetCore("SendNotification", {
    Title = "★ klưn.z FULL SYSTEM ★",
    Text = "BY klunz.mFLie! 🗿",
    Duration = 10
})

-- ==========================================
-- ||      MENU 1 (V6 + HITBOX BUTTON)     ||
-- ==========================================
local gui1 = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui1.Name = "klunz_Master_V6"; gui1.ResetOnSpawn = false 

local frame1 = Instance.new("Frame", gui1)
frame1.Size, frame1.Position = UDim2.new(0,210,0,450), UDim2.new(0.1,0,0.3,0)
frame1.BackgroundColor3 = Color3.fromRGB(10,10,10); frame1.Active, frame1.Draggable = true, true
frame1.ClipsDescendants = true; Instance.new("UICorner", frame1)

local title1 = Instance.new("TextLabel", frame1)
title1.Size, title1.Text = UDim2.new(1, 0, 0, 35), "★ klưn.z MASTER ★"
title1.TextColor3, title1.BackgroundTransparency = Color3.fromRGB(0, 255, 150), 1
title1.Font, title1.TextSize = Enum.Font.Code, 15

local toggleBtn1 = Instance.new("TextButton", frame1)
toggleBtn1.Size, toggleBtn1.Position = UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5)
toggleBtn1.Text, toggleBtn1.BackgroundColor3 = "-", Color3.fromRGB(40,40,40)
toggleBtn1.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", toggleBtn1)

local content1 = Instance.new("Frame", frame1)
content1.Size, content1.Position, content1.BackgroundTransparency = UDim2.new(1,0,0.9,0), UDim2.new(0,0,0.1,0), 1

local function createBtn1(text, pos, color)
    local b = Instance.new("TextButton", content1)
    b.Size, b.Position = UDim2.new(0.9,0,0.07,0), pos
    b.Text, b.BackgroundColor3, b.TextColor3, b.Font = text, color, Color3.new(1,1,1), Enum.Font.Code
    b.TextSize = 11; Instance.new("UICorner", b); return b
end

local invBtn1 = createBtn1("INVIS/HIDE NAME: OFF", UDim2.new(0.05,0,0.02,0), Color3.fromRGB(200,40,40))
local combatBtn1 = createBtn1("AUTO KILL + AIM: OFF", UDim2.new(0.05,0,0.10,0), Color3.fromRGB(80,80,80))
local hitboxBtn = createBtn1("HITBOX EXPANDER: OFF", UDim2.new(0.05,0,0.18,0), Color3.fromRGB(100,20,150))
local escToggle1 = createBtn1("AUTO ESCAPE: ON", UDim2.new(0.05,0,0.26,0), Color3.fromRGB(0,150,255))
local getupBtn1 = createBtn1("AUTO GETUP: ON", UDim2.new(0.05,0,0.34,0), Color3.fromRGB(0, 180, 100))

-- ==========================================
-- ||      MENU 2 (TARGET + HP LIST)       ||
-- ==========================================
local gui2 = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui2.Name = "klunz_Aimbot_Killer"; gui2.ResetOnSpawn = false

local main2 = Instance.new("Frame", gui2)
main2.Size, main2.Position = UDim2.new(0, 180, 0, 110), UDim2.new(1, -190, 0.3, 0)
main2.BackgroundColor3 = Color3.fromRGB(15, 15, 15); main2.Active, main2.Draggable = true, true
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
            b.Size = UDim2.new(1, 0, 0, 22)
            
            local hpInfo = "[??%]"
            local hpCol = Color3.fromRGB(200, 200, 200)
            if pl.Character and pl.Character:FindFirstChild("Humanoid") then
                local h = pl.Character.Humanoid
                local pct = math.floor((h.Health / h.MaxHealth) * 100)
                hpInfo = "[" .. pct .. "%]"
                if pct <= 30 then hpCol = Color3.fromRGB(255, 0, 0)
                elseif pct <= 70 then hpCol = Color3.fromRGB(255, 255, 0)
                else hpCol = Color3.fromRGB(0, 255, 100) end
            end

            b.Text = " " .. hpInfo .. " " .. pl.Name
            b.BackgroundColor3 = (CONFIG2.SelectedTarget == pl) and Color3.fromRGB(120, 0, 0) or Color3.fromRGB(25, 25, 25)
            b.TextColor3, b.Font, b.TextSize = hpCol, Enum.Font.Code, 8
            b.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", b)
            
            b.MouseButton1Click:Connect(function() 
                CONFIG2.SelectedTarget = (CONFIG2.SelectedTarget == pl) and nil or pl 
                updateList2() 
            end)
        end
    end
end

-- ==========================================
-- ||      HỆ THỐNG LOGIC & HITBOX         ||
-- ==========================================
hitboxBtn.MouseButton1Click:Connect(function()
    activeHitbox = not activeHitbox
    hitboxBtn.Text = activeHitbox and "HITBOX: ON" or "HITBOX: OFF"
    hitboxBtn.BackgroundColor3 = activeHitbox and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(100,20,150)
end)

task.spawn(function()
    while task.wait(0.5) do
        if activeHitbox then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(CONFIG1.HitboxSize, CONFIG1.HitboxSize, CONFIG1.HitboxSize)
                    hrp.Transparency = 0.8; hrp.CanCollide = false
                end
            end
        end
    end
end)

-- (Các hàm Toggle, ESP và Heartbeat giữ nguyên như cũ của bạn)
toggleBtn1.MouseButton1Click:Connect(function()
    local isCol = (toggleBtn1.Text == "-")
    frame1:TweenSize(isCol and UDim2.new(0,210,0,35) or UDim2.new(0,210,0,450), "Out", "Quart", 0.3, true)
    content1.Visible = not isCol; toggleBtn1.Text = isCol and "+" or "-"
end)

toggleBtn2.MouseButton1Click:Connect(function()
    local isCol = (toggleBtn2.Text == "-")
    if isCol then listFrame2.Visible = false; listToggle2.Text = ">" end
    main2:TweenSize(isCol and UDim2.new(0, 180, 0, 30) or UDim2.new(0, 180, 0, 110), "Out", "Quart", 0.3, true)
    content2.Visible = not isCol; toggleBtn2.Text = isCol and "+" or "-"
end)

listToggle2.MouseButton1Click:Connect(function()
    listFrame2.Visible = not listFrame2.Visible
    listToggle2.Text = listFrame2.Visible and "<" or ">"
    if listFrame2.Visible then updateList2() end
end)

combatBtn2.MouseButton1Click:Connect(function()
    activeCombat2 = not activeCombat2
    combatBtn2.Text = activeCombat2 and "AIM & KILL: ON" or "AIM & KILL: OFF"
    combatBtn2.BackgroundColor3 = activeCombat2 and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(35, 35, 35)
end)

resetBtn2.MouseButton1Click:Connect(function() CONFIG2.SelectedTarget = nil updateList2() end)

RS.Heartbeat:Connect(function()
    local char = p.Character; local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not (root and hum) then return end

    if listFrame2.Visible then updateList2() end -- Cập nhật máu real-time trong list
    hum.WalkSpeed = CONFIG1.Speed

    local myHP = math.floor((hum.Health / hum.MaxHealth) * 100)
    if activeEscape1 and myHP <= CONFIG1.EscapeHP then systemLock1 = true 
    elseif myHP >= CONFIG1.SafeHP then systemLock1 = false end

    if systemLock1 then
        root.CFrame = CFrame.new(root.Position.X, 1000, root.Position.Z); root.Velocity = Vector3.zero
        return
    end

    local target = nil
    if activeCombat2 and CONFIG2.SelectedTarget and CONFIG2.SelectedTarget.Character then
        local tHum = CONFIG2.SelectedTarget.Character:FindFirstChild("Humanoid")
        if tHum and tHum.Health > 0 then target = CONFIG2.SelectedTarget.Character:FindFirstChild("HumanoidRootPart") end
    end
    
    if target then
        root.CFrame = target.CFrame * CFrame.new(0, 0, 2.8)
        root.CFrame = CFrame.lookAt(root.Position, target.Position)
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position + Vector3.new(0, 1, 0))
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if activeCombat2 and not systemLock1 then
            local ev = p.Character and p.Character:FindFirstChild("Communicate")
            if ev then for i = 1, 4 do ev:FireServer({[1] = i}) end end
        end
    end
end)
