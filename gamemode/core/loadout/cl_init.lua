local loadout = FBL.Config.Loadout
local primary, secondary = loadout.primary, loadout.secondary

net.Receive("FBL Loadout", function()
	local selected, buttons_primary, buttons_secondary = {}, {}, {}

    local fr = vgui.Create("XPFrame")
	fr:SetTitle("Loadout")
	fr:SetKeyboardInputEnabled(false)

	local done = fr:SetBottomButton("Done", FILL, function()
		net.Start("FBL Loadout Save")
			net.WriteTable(selected)
		net.SendToServer()
		fr:Remove()
	end)

	local left = vgui.Create("XPScrollPanel", fr)
	left:Dock(LEFT)
	left:SetWide(fr:GetWide() / 2)

	local _primary = vgui.Create("DLabel", left)
	_primary:Dock(TOP)
	_primary:SetTall(32)
	_primary:SetContentAlignment(5)
	_primary:SetColor(color_white)
	_primary:SetFont("xpgui_big")
	_primary:SetText("Select a primary weapon")

	for name, data in pairs(primary) do
		local info = ""
		local function getInfo(...) 
			return FBL.GetWeaponInfo(data.class, ...)
		end

		if getInfo("Melee") then
			info = info .. "Type: Melee\n"
			info = info .."Damage: " .. getInfo("Damage") .. "\n"
			info = info .. "Recoil: " .. getInfo("Recoil")
		else
			info = info .. "Type: Ranged\n"
			info = info .. "Damage: " .. getInfo("Damage") .. "\n"
			info = info .. "Recoil: " .. getInfo("Recoil") .. "\n"
			info = info .. "Shots: " .. getInfo("Shots") .. "\n"
			info = info .. "Clip Size: " .. getInfo("Primary", "ClipSize") .. "\n"
			info = info .. "Fire Delay: " .. getInfo("FireDelay")
		end

		local weapon = vgui.Create("XPButton", left)
		weapon:Dock(TOP)
		weapon:SetText(name)
		weapon:SetToolTip(info)

		weapon.DoClick = function(self)
			selected.primary = name
			if selected.secondary then
				done:SetToolTip("Primary: " .. name .. "\nSecondary: " .. selected.secondary)
			else
				done:SetToolTip("Primary: " .. name)
			end
			for _, btn in pairs(buttons_primary) do
				btn:SetColor(color_white)
			end
			self:SetColor(XPGUI.CheckBoxCheckColor)
		end

		table.insert(buttons_primary, weapon)
	end

	local right = vgui.Create("XPScrollPanel", fr)
	right:Dock(RIGHT)
	right:SetWide(fr:GetWide() / 2)

	local _secondary = vgui.Create("DLabel", right)
	_secondary:Dock(TOP)
	_secondary:SetTall(32)
	_secondary:SetContentAlignment(5)
	_secondary:SetColor(color_white)
	_secondary:SetFont("xpgui_big")
	_secondary:SetText("Select a secondary weapon")

	for name, data in pairs(secondary) do
		local info = ""
		local function getInfo(...) 
			return FBL.GetWeaponInfo(data.class, ...)
		end

		if getInfo("Melee") then
			info = info .. "Type: Melee\n"
			info = info .."Damage: " .. getInfo("Damage") .. "\n"
			info = info .. "Recoil: " .. getInfo("Recoil")
		else
			info = info .. "Type: Ranged\n"
			info = info .. "Damage: " .. getInfo("Damage") .. "\n"
			info = info .. "Recoil: " .. getInfo("Recoil") .. "\n"
			info = info .. "Shots: " .. getInfo("Shots") .. "\n"
			info = info .. "Clip Size: " .. getInfo("Primary", "ClipSize") .. "\n"
			info = info .. "Fire Delay: " .. getInfo("FireDelay")
		end

		local weapon = vgui.Create("XPButton", right)
		weapon:Dock(TOP)
		weapon:SetText(name)
		weapon:SetToolTip(info)

		weapon.DoClick = function(self)
			selected.secondary = name
			if selected.primary then
				done:SetToolTip("Primary: " .. selected.primary .. "\nSecondary: " .. name)
			else
				done:SetToolTip("Secondary: " .. name)
			end
			for _, btn in pairs(buttons_secondary) do
				btn:SetColor(color_white)
			end
			self:SetColor(XPGUI.CheckBoxCheckColor)
		end

		table.insert(buttons_secondary, weapon)
	end
end)