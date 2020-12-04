include("shared.lua")

local HideHUD = {
	["CHudBattery"] = true,
	["CHudHealth"] = true,	
	--["CHudAmmo"] = true,
	--["CHudSecondaryAmmo"] = true,
	--["CHudDamageIndicator"] = true,
	["CHudSuitPower"] = true,
	["CHudZoom"] = true,
	["CHudWeaponSelection"] = true
}

hook.Add("HUDShouldDraw", "FBL", function(name)
	if HideHUD[name] then 
		return false 
	end
end)

function GM:HUDDrawTargetID()
	return
end

local newinv
local function SelectWeapon(class)
	newinv = class
end

function GM:CreateMove(cmd)
	if newinv then
		local wep = LocalPlayer():GetWeapon(newinv)
		if IsValid(wep) and LocalPlayer():GetActiveWeapon() ~= wep then
			cmd:SelectWeapon(wep)
		else
			newinv = nil
		end
	end
end

local delay = FBL.Config.WeaponSelectorDelay
local last = -delay
local wep, primary, secondary
function GM:PlayerBindPress(pl, bind, pressed)
	local elapsed = CurTime() - last
	if elapsed > delay then
		wep, primary, secondary = pl:GetActiveWeapon(), pl:GetPrimaryWeapon(), pl:GetSecondaryWeapon()
		if bind == "slot1" then
			SelectWeapon(primary)
		elseif bind == "slot2" then
			SelectWeapon(secondary)
		end
		if table.HasValue({"invnext", "invprev"}, bind) then
			if IsValid(wep) and (wep:GetClass() == primary) then
				SelectWeapon(secondary)
			else
				SelectWeapon(primary)
			end
		end
		last = CurTime()
	end
end