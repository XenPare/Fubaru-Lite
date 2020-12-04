function FBL.PutText(text, x, y, color, font, ang, shadow)
	local _x, _y = x, y
	if shadow then
		FBL.PutText(text, _x, _y, shadow, font .. "_s", ang)
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