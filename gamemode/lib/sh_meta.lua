local pl = FindMetaTable("Player")

function pl:GetPrimaryWeapon()
	return self:GetNWString("Primary", FBL.Config.PrimaryDefault)
end

function pl:GetSecondaryWeapon()
	return self:GetNWString("Secondary", FBL.Config.SecondaryDefault)
end