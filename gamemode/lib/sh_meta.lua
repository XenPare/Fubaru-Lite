local pl = FindMetaTable("Player")
local cfg = FBL.Config
local loadout = cfg.Loadout

function pl:GetPrimaryWeapon()
	local def = cfg.PrimaryDefault
	local var = self:GetInfo("fbl_primary", "")
	if var ~= "" then
		def = var
	end
	return self:GetNWString("Primary", def)
end

function pl:GetSecondaryWeapon()
	local def = cfg.SecondaryDefault
	local var = self:GetInfo("fbl_secondary", "")
	if var ~= "" then
		def = var
	end
	return self:GetNWString("Secondary", def)
end