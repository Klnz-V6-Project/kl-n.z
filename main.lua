-- [[ HỆ THỐNG BẢO TRÌ VÀ NGẮT KẾT NỐI ]] --

local thongBao = "Script hiện đang bảo trì để thay đổi code. Vui lòng quay lại sau!"
local userGhiChu = "Gửi bạn: Đang đổi code nhé, đừng vào nữa."

-- Hiển thị thông báo ở console/output
print("------------------------------------------")
print(thongBao)
print(userGhiChu)
print("------------------------------------------")

-- Thực hiện lệnh Kick (Dành cho Roblox)
-- Nếu bạn dùng nền tảng khác, hãy thay lệnh game.Players.LocalPlayer:Kick bằng lệnh tương ứng
if game:GetService("RunService"):IsClient() then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("\n\n[BẢO TRÌ SYSTEM]\n" .. thongBao .. "\n\n" .. userGhiChu)
    end
end

return -- Dừng script ngay lập tức
