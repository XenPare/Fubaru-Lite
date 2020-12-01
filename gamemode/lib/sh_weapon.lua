function FBL.GetWeaponInfo(class, info, _info)
	if _info then
		return weapons.GetStored(class)[info][_info]
	end
	return weapons.GetStored(class)[info]
end