local optf = ScreenScale(24)

surface.CreateFont("fbl_hud", {
	font = "Tahoma",
	size = optf,
	weight = 600,
	extended = true,
	antialias = true
})

surface.CreateFont("fbl_hud_s", {
	font = "Tahoma",
	size = optf + 4,
	weight = 600,
	extended = true,
	antialias = true
})

local pl, health, armor, wep, clip1, count
local color_hp, color_ar = Color(251, 63, 44, 195), Color(0, 161, 255)
local color_ammo = Color(45, 45, 45, 195)
local putText = FBL.PutText
hook.Add("HUDPaint", "FBL", function()
	pl = LocalPlayer()
	if not pl:Alive() then
		return
	end

	health, armor = pl:Health(), pl:Armor()
	putText(health .. "%", optf * 2, ScrH() - 125, color_white, "fbl_hud", math.sin(CurTime() % 3) * 3, color_hp)
	if armor > 0 then
		putText(armor .. "%", optf * 2 * 2.5, ScrH() - 125, color_white, "fbl_hud", math.sin(CurTime() % 3) * 3, color_ar)
	end

	wep = pl:GetActiveWeapon()
	if not IsValid(wep) or wep.Melee then
		return
	end

	clip1, count = wep:Clip1(), pl:GetAmmoCount(wep:GetPrimaryAmmoType())
	putText(count, ScrW() - optf * 2, ScrH() - 125, color_white, "fbl_hud", math.sin(CurTime() % 3) * 3, color_ammo)
	putText(clip1, ScrW() - optf * 2 * 2, ScrH() - 125, color_white, "fbl_hud", math.sin(CurTime() % 3) * 3, color_ammo)
end)