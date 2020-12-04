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

local function putText(text, x, y, color, font, ang, shadow)
	local _x, _y = x, y
	if shadow then
		putText(text, _x, _y, shadow, font .. "_s", ang)
	end

	render.PushFilterMag(TEXFILTER.ANISOTROPIC)
	render.PushFilterMin(TEXFILTER.ANISOTROPIC)
		surface.SetFont(font)
		surface.SetTextColor(color)
		surface.SetTextPos(0, 0)

		local textWidth, textHeight = surface.GetTextSize(text)
		local rad = -math.rad(ang)
		x = x - math.cos(rad) * textWidth / 2 + math.sin(rad) * textHeight / 2
		y = y + math.sin(rad) * textWidth / 2 + math.cos(rad) * textHeight / 2

		local m = Matrix()
		m:SetAngles(Angle(0, ang, 0))
		m:SetTranslation(Vector(x, y, 0))

		cam.PushModelMatrix(m)
			surface.DrawText(text)
		cam.PopModelMatrix()
	render.PopFilterMag()
	render.PopFilterMin()
end

local pl, health, armor, wep, clip1, count
local color_hp, color_ar = Color(251, 63, 44, 195), Color(0, 161, 255)
local color_ammo = Color(45, 45, 45, 195)
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