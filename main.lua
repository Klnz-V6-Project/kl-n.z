-- [[ klưn.z MASTER SYSTEM - MENU 1 CLEANED ]] --
local p = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local SG = game:GetService("StarterGui")
local TP = game:GetService("TeleportService")
local Http = game:GetService("HttpService")
local Camera = workspace.CurrentCamera

-- [[ CONFIG TỔNG HỢP ]] --
local _S = (math.sqrt(10000)) 
local CONFIG1 = { EscapeHP = 100, SafeHP = 75, TargetHP = 30 } 
local CONFIG2 = { SelectedTarget = nil }

local activeCombat1, activeEscape1, systemLock1 = false, true, false
local activeCombat2 = false
local activeMelee = false -- Chỉ còn dùng biến này cho chế độ chiến đấu đặc biệt (Menu 3)

-- ==========================================
-- ||      THANH STATUS (GÓC TRÁI)         ||
-- ==========================================
local statusGui = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
statusGui.Name = "klunz_Status_Global"; statusGui.ResetOnSpawn = false
local sFrame = Instance.new("Frame", statusGui)
sFrame.Size, sFrame.Position = UDim2.new(0, 160, 0, 30), UDim2.new(0, 20, 0.25, 0)
sFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0); sFrame.BackgroundTransparency = 0.5
Instance.new("UICorner", sFrame)
local sInfo = Instance.new("TextLabel", sFrame)
sInfo.Size, sInfo.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
sInfo.Text, sInfo.TextColor3, sInfo.Font, sInfo.TextSize = "STATUS: IDLE", Color3.fromRGB(0, 255, 150), Enum.Font.Code, 11

-- ==========================================
-- ||      MENU 3 (MELEE RAGE - MINI)      ||
-- ==========================================
local gui3 = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui3.Name = "klunz_Melee_Mini"; gui3.ResetOnSpawn = false
local frame3 = Instance.new("Frame", gui3)
frame3.Size, frame3.Position = UDim2.new(0, 130, 0, 55), UDim2.new(1, -140, 0.15, 0)
frame3.BackgroundColor3 = Color3.fromRGB(20, 10, 10); frame3.Active, frame3.Draggable = true, true; Instance.new("UICorner", frame3)

local title3 = Instance.new("TextLabel", frame3)
title3.Size = UDim2.new(1, 0, 0, 18)
title3.Text = "🔥 MELEE RAGE"; title3.TextColor3 = Color3.fromRGB(255, 50, 50); title3.BackgroundTransparency, title3.Font, title3.TextSize = 1, Enum.Font.Code, 8

local meleeBtn = Instance.new("TextButton", frame3)
meleeBtn.Size, meleeBtn.Position = UDim2.new(0.9, 0, 0, 28), UDim2.new(0.05, 0, 0.4, 0)
meleeBtn.Text = "RAGE: OFF"; meleeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); meleeBtn.TextColor3, meleeBtn.Font, meleeBtn.TextSize = Color3.new(1, 1, 1), Enum.Font.Code, 9; Instance.new("UICorner", meleeBtn)

meleeBtn.MouseButton1Click:Connect(function()
    activeMelee = not activeMelee
    meleeBtn.Text = activeMelee and "RAGE: ON 🔥" or "RAGE: OFF"
    meleeBtn.BackgroundColor3 = activeMelee and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
    sInfo.TextColor3 = activeMelee and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 255, 150)
end)

-- ==========================================
-- ||      MENU 1 (ĐÃ XOÁ KHÔ MÁU)         ||
-- ==========================================
local gui1 = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui1.Name = "klunz_Master_V6"; gui1.ResetOnSpawn = false 
local frame1 = Instance.new("Frame", gui1)
frame1.Size, frame1.Position = UDim2.new(0,210,0,480), UDim2.new(0.1,0,0.3,0) -- Thu ngắn lại chút vì bớt nút
frame1.BackgroundColor3 = Color3.fromRGB(10,10,10); frame1.Active, frame1.Draggable = true, true
frame1.ClipsDescendants = true; Instance.new("UICorner", frame1)

local title1 = Instance.new("TextLabel", frame1)
title1.Size, title1.Text = UDim2.new(1, 0, 0, 35), "★ klưn.z MASTER ★"
title1.TextColor3, title1.BackgroundTransparency, title1.Font, title1.TextSize = Color3.fromRGB(0, 255, 150), 1, Enum.Font.Code, 15

local toggleBtn1 = Instance.new("TextButton", frame1)
toggleBtn1.Size, toggleBtn1.Position = UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5)
toggleBtn1.Text, toggleBtn1.BackgroundColor3, toggleBtn1.TextColor3 = "-", Color3.fromRGB(40,40,40), Color3.new(1,1,1)
Instance.new("UICorner", toggleBtn1)

local content1 = Instance.new("Frame", frame1)
content1.Size, content1.Position, content1.BackgroundTransparency = UDim2.new(1,0,0.9,0), UDim2.new(0,0,0.1,0), 1
local layout1 = Instance.new("UIListLayout", content1)
layout1.HorizontalAlignment, layout1.Padding = Enum.HorizontalAlignment.Center, UDim.new(0,6)

local function createBtn1(text, color, func)
    local b = Instance.new("TextButton", content1)
    b.Size = UDim2.new(0.9,0,0,32)
    b.Text, b.BackgroundColor3, b.TextColor3, b.Font, b.TextSize = text, color, Color3.new(1,1,1), Enum.Font.Code, 10
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() func(b) end)
    return b
end

local function createInput1(placeholder, defaultVal, callback)
    local t = Instance.new("TextBox", content1)
    t.Size = UDim2.new(0.9,0,0,32)
    t.PlaceholderText = placeholder; t.Text = placeholder .. ": " .. defaultVal
    t.BackgroundColor3 = Color3.fromRGB(30,30,30); t.TextColor3, t.Font, t.TextSize = Color3.new(1,1,1), Enum.Font.Code, 10
    Instance.new("UICorner", t)
    t.FocusLost:Connect(function()
        local val = tonumber(t.Text)
        if val then callback(val); t.Text = placeholder .. ": " .. val else t.Text = placeholder .. ": " .. defaultVal end
    end)
end

-- RENDER BUTTONS MENU 1 (KHÔNG CÒN KHÔ MÁU)
createBtn1("⭐ SUPER HOP (100%)", Color3.fromRGB(0, 120, 50), function()
    sInfo.Text = "STATUS: SCANNING SV..."
    task.spawn(function()
        local success, res = pcall(function()
            return game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        end)
        if success then
            local data = Http:JSONDecode(res)
            local targetServer = nil
            for _, s in pairs(data.data) do
                if s.id ~= game.JobId and s.playing <= (s.maxPlayers - 2) then
                    targetServer = s; break
                end
            end
            if targetServer then
                sInfo.Text = "STATUS: JOINING ["..targetServer.playing.."]"
                TP:TeleportToPlaceInstance(game.PlaceId, targetServer.id, p)
            else sInfo.Text = "STATUS: NO SAFE SV!" end
        else sInfo.Text = "STATUS: HTTP ERROR!" end
    end)
end)

local combatBtn1 = createBtn1("AUTO KILL (M1): OFF", Color3.fromRGB(80,80,80), function(b)
    activeCombat1 = not activeCombat1
    b.Text = activeCombat1 and "AUTO KILL (M1): ON" or "AUTO KILL (M1): OFF"
    b.BackgroundColor3 = activeCombat1 and Color3.fromRGB(138,43,226) or Color3.fromRGB(80,80,80)
end)

local escBtn1 = createBtn1("AUTO ESCAPE: ON", Color3.fromRGB(0,150,255), function(b)
    activeEscape1 = not activeEscape1
    if not activeEscape1 then systemLock1 = false end
    b.Text = activeEscape1 and "AUTO ESCAPE: ON" or "AUTO ESCAPE: OFF"
    b.BackgroundColor3 = activeEscape1 and Color3.fromRGB(0,150,255) or Color3.fromRGB(80,80,80)
end)

createInput1("SET TARGET HP", 30, function(v) CONFIG1.TargetHP = v end)
createInput1("SET ESCAPE HP", 25, function(v) CONFIG1.EscapeHP = v end)

-- ==========================================
-- ||      MENU 2 (GIỮ NGUYÊN)             ||
-- ==========================================
local gui2 = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui2.Name = "klunz_Aimbot_Killer"; gui2.ResetOnSpawn = false
local main2 = Instance.new("Frame", gui2); main2.Size, main2.Position = UDim2.new(0, 180, 0, 110), UDim2.new(1, -190, 0.3, 0)
main2.BackgroundColor3 = Color3.fromRGB(15, 15, 15); main2.Active, main2.Draggable = true, true; main2.ClipsDescendants = false; Instance.new("UICorner", main2)
local topBar2 = Instance.new("Frame", main2); topBar2.Size, topBar2.BackgroundColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(25, 25, 25); Instance.new("UICorner", topBar2)
local title2 = Instance.new("TextLabel", topBar2); title2.Size, title2.Position = UDim2.new(1, -70, 1, 0), UDim2.new(0, 5, 0, 0)
title2.Text = "★ TARGET LOCK ★"; title2.TextColor3 = Color3.fromRGB(255, 60, 60); title2.Font, title2.TextSize, title2.BackgroundTransparency = Enum.Font.Code, 9, 1
local toggleBtn2 = Instance.new("TextButton", topBar2); toggleBtn2.Size, toggleBtn2.Position = UDim2.new(0, 22, 0, 22), UDim2.new(1, -52, 0, 4)
toggleBtn2.Text, toggleBtn2.BackgroundColor3, toggleBtn2.TextColor3 = "-", Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1); Instance.new("UICorner", toggleBtn2)
local listToggle2 = Instance.new("TextButton", topBar2); listToggle2.Size, listToggle2.Position = UDim2.new(0, 22, 0, 22), UDim2.new(1, -26, 0, 4)
listToggle2.Text, listToggle2.BackgroundColor3 = ">", Color3.fromRGB(45, 45, 45); listToggle2.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", listToggle2)
local content2 = Instance.new("Frame", main2); content2.Size, content2.Position, content2.BackgroundTransparency = UDim2.new(1, 0, 1, -30), UDim2.new(0, 0, 0, 30), 1
local combatBtn2 = Instance.new("TextButton", content2); combatBtn2.Size, combatBtn2.Position = UDim2.new(0.9, 0, 0, 35), UDim2.new(0.05, 0, 0.15, 0)
combatBtn2.Text = "AIM & KILL: OFF"; combatBtn2.BackgroundColor3 = Color3.fromRGB(35, 35, 35); combatBtn2.TextColor3, combatBtn2.Font, combatBtn2.TextSize = Color3.new(1, 1, 1), Enum.Font.Code, 10; Instance.new("UICorner", combatBtn2)
local listFrame2 = Instance.new("Frame", main2); listFrame2.Size, listFrame2.Position = UDim2.new(0, 150, 0, 200), UDim2.new(0, -155, 0, 0); listFrame2.BackgroundColor3 = Color3.fromRGB(10, 10, 10); listFrame2.Visible = false; Instance.new("UICorner", listFrame2)
local scroll2 = Instance.new("ScrollingFrame", listFrame2); scroll2.Size, scroll2.Position = UDim2.new(0.9, 0, 0.9, 0), UDim2.new(0.05, 0, 0.05, 0); scroll2.BackgroundColor3, scroll2.ScrollBarThickness = Color3.fromRGB(15, 15, 15), 1; Instance.new("UIListLayout", scroll2).Padding = UDim.new(0, 2)

function updateList2()
    for _, v in pairs(scroll2:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, pl in pairs(game.Players:GetPlayers()) do
        if pl ~= p then
            local b = Instance.new("TextButton", scroll2); b.Size = UDim2.new(1, -5, 0, 22)
            b.Text = " " .. pl.Name; b.BackgroundColor3 = (CONFIG2.SelectedTarget == pl) and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(30, 30, 30); b.TextColor3, b.Font, b.TextSize = Color3.new(1,1,1), Enum.Font.Code, 8; b.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() CONFIG2.SelectedTarget = (CONFIG2.SelectedTarget == pl) and nil or pl; updateList2() end)
        end
    end
end

-- Logic Toggle UI
toggleBtn1.MouseButton1Click:Connect(function()
    local isCol = (toggleBtn1.Text == "-")
    frame1:TweenSize(isCol and UDim2.new(0,210,0,35) or UDim2.new(0,210,0,480), "Out", "Quart", 0.3, true)
    content1.Visible = not isCol; toggleBtn1.Text = isCol and "+" or "-"
end)

toggleBtn2.MouseButton1Click:Connect(function()
    local isCol = (toggleBtn2.Text == "-")
    main2:TweenSize(isCol and UDim2.new(0,180,0,30) or UDim2.new(0,180,0,110), "Out", "Quart", 0.3, true)
    content2.Visible = not isCol; if isCol then listFrame2.Visible = false end; toggleBtn2.Text = isCol and "+" or "-"
end)

listToggle2.MouseButton1Click:Connect(function()
    if toggleBtn2.Text == "+" then return end
    listFrame2.Visible = not listFrame2.Visible; if listFrame2.Visible then updateList2() end
end)

combatBtn2.MouseButton1Click:Connect(function()
    activeCombat2 = not activeCombat2
    combatBtn2.Text = activeCombat2 and "AIM & KILL: ON" or "AIM & KILL: OFF"
    combatBtn2.BackgroundColor3 = activeCombat2 and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(35, 35, 35)
end)

-- ==========================================
-- ||      HỆ THỐNG VẬN HÀNH (CORE)        ||
-- ==========================================
RS.Heartbeat:Connect(function(dt)
    local char = p.Character; local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not (root and hum) then return end
    
    local myHP = (hum.Health / hum.MaxHealth) * 100
    
    -- Escape logic (Bị chặn nếu bật Melee Rage ở Menu 3)
    if activeEscape1 and not activeMelee then
        if myHP <= CONFIG1.EscapeHP then systemLock1 = true 
        elseif myHP >= CONFIG1.SafeHP then systemLock1 = false end
    else
        systemLock1 = false 
    end
    
    if systemLock1 then 
        root.CFrame = CFrame.new(root.Position.X, 1200, root.Position.Z)
        root.Velocity = Vector3.new(0,0,0)
        sInfo.Text = "STATUS: ESCAPING! (LOW HP)"
        return 
    end

    -- Tìm mục tiêu
    local target = nil
    if activeCombat2 and CONFIG2.SelectedTarget and CONFIG2.SelectedTarget.Character then
        local tHum = CONFIG2.SelectedTarget.Character:FindFirstChild("Humanoid")
        if tHum and tHum.Health > 0 then target = CONFIG2.SelectedTarget.Character:FindFirstChild("HumanoidRootPart") end
    end
    
    if not target and (activeCombat1 or activeMelee) then
        local lowestHP = 101
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= p and v.Character and v.Character:FindFirstChild("Humanoid") then
                local eHum = v.Character.Humanoid; local eHP = (eHum.Health / eHum.MaxHealth) * 100
                if eHP > 0 and eHP <= CONFIG1.TargetHP and eHP < lowestHP then 
                    lowestHP = eHP; target = v.Character:FindFirstChild("HumanoidRootPart") 
                end
            end
        end
    end

    if target then
        -- KHOẢNG CÁCH: Melee Rage áp sát cực gần (1.5), thường (2.4)
        local range = activeMelee and 1.5 or 2.4
        root.CFrame = target.CFrame * CFrame.new(0, 0, range) 
        root.CFrame = CFrame.lookAt(root.Position, target.Position)
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        sInfo.Text = (activeMelee and "🔥 RAGE: " or "TARGET: ") .. target.Parent.Name
    else
        if hum.MoveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + (hum.MoveDirection * (_S * dt))
        end
        sInfo.Text = activeMelee and "STATUS: KHÔ MÁU MODE 🔥" or ((activeCombat1 or activeCombat2) and "STATUS: SCANNING..." or "STATUS: IDLE")
    end
end)

-- Attack Loop
task.spawn(function()
    while true do
        local speed = activeMelee and 0.08 or 0.12
        if (activeCombat1 or activeCombat2 or activeMelee) and not systemLock1 then
            local ev = p.Character and p.Character:FindFirstChild("Communicate")
            if ev then for i = 1, 3 do ev:FireServer({[1] = i}) end end
        end
        task.wait(speed)
    end
end)
