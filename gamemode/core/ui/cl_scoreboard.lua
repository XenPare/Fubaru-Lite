local optf, logotall = ScreenScale(12), ScreenScale(34)

surface.CreateFont("fbl_scoreboard", {
	font = "Tahoma",
	size = optf,
	weight = 600,
	extended = true,
	antialias = true
})

local colors, fr = {}
local putText = FBL.PutText
local gradient_up = Material("gui/gradient_up")
colors.base, colors.hovered, colors.down = Color(186, 65, 83), Color(163, 54, 70), Color(138, 41, 56)
colors.header = Color(41, 91, 207)
local function openScoreboard()
	fr = vgui.Create("DPanel")
	fr:SetSize(ScrW() / 3, ScrH() / 1.2)
	fr:Center()
	fr:SetAlpha(1)
	fr:AlphaTo(255, 0.2, 0)
	fr:SetKeyboardInputEnabled(false) 
	fr:MakePopup()

	fr.Paint = function(self, w, h)
		surface.SetDrawColor(ColorAlpha(colors.header, 125))
		surface.SetMaterial(gradient_up)
		surface.DrawTexturedRect(0, 0, w, h)
		draw.RoundedBox(3, 0, 0, w, h, ColorAlpha(color_black, 140))
	end

	local logo = vgui.Create("EditablePanel", fr)
	logo:Dock(TOP)
	logo:DockMargin(0, 0, 0, 2)
	logo:SetTall(logotall)

	logo.Paint = function(self, w, h)
		draw.RoundedBox(3, 1, 1, w - 2, h - 2, colors.header)
		putText("Fubaru Lite", fr:GetWide() / 2, -logotall / 2, color_white, "fbl_hud", 3)
	end

	local pnl = vgui.Create("DScrollPanel", fr)
	pnl:Dock(FILL)

	fr.Update = function()
		pnl:Clear()
		for _, pl in pairs(player.GetAll()) do
			local btn = vgui.Create("DButton", pnl)
			btn:Dock(TOP)
			btn:DockMargin(2, 1, 2, 1)
			btn:SetTall(64)
			btn:SetText("")

			local clr
			btn.Paint = function(self, w, h)
				if not IsValid(pl) then
					fr:Update()
				end

				clr = colors.base
				if self:IsHovered() then
					clr = colors.hovered
				end

				if self:IsDown() then
					clr = colors.down
				end

				draw.RoundedBox(3, 1, 1, w - 2, h - 2, clr)

				draw.SimpleText(pl:Name(), "fbl_scoreboard", 72, 12, color_white, TEXT_ALIGN_LEFT)
				putText(pl:Deaths(), btn:GetWide() - 24, -32, color_white, "fbl_scoreboard", 3)
				putText(pl:Frags(), btn:GetWide() - 24 - 64, -32, color_white, "fbl_scoreboard", 3)
			end

			btn.DoClick = function()
				local menu = DermaMenu()

				menu:AddOption("Show Profile", function()
					pl:ShowProfile()
				end):SetIcon("icon16/link.png")

				if pl ~= LocalPlayer() then
					menu:AddSpacer()
					menu:AddOption("VoteKick", function()
						RunConsoleCommand("xpa", "votekick", pl:SteamID())
					end):SetIcon("icon16/door_open.png")
				end

				menu:Open()
			end

			local aww = vgui.Create("AvatarImage", btn)
	        aww:SetSize(60, 60)
	        aww:SetPos(2, 2)
			aww:SetPlayer(pl, 60)
		end
	end

	fr:Update()
end

hook.Add("Initialize", "FBL", function()
    GAMEMODE.ScoreboardShow = nil 
    GAMEMODE.ScoreboardHide = nil
end)

hook.Add("ScoreboardShow", "FBL", function()
    if fr ~= nil then
        openScoreboard()
        fr:Update()
    else 
        openScoreboard()
	end     
	return true
end)

hook.Add("ScoreboardHide", "FBL", function() 
    if fr then
    	fr:Remove()   	
    end  
end)