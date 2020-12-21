local optf, kf = ScreenScale(16), {}

surface.CreateFont("fbl_kf", {
	font = "Tahoma",
	size = optf,
	weight = 400,
	extended = true,
	antialias = true
})

net.Receive("FBL KF", function()
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()

	table.insert(kf, {
		victim = victim,
		attacker = attacker
	})
end)

local offset = 48
local color_attacker, color_victim = Color(251, 63, 44), Color(0, 161, 255)
hook.Add("HUDPaint", "FBL KF", function()
	surface.SetFont("fbl_kf")
	local done, count = {}, 0
	for key, data in SortedPairs(kf, true) do
		if table.HasValue(done, key) or count >= 3 then
			continue
		end

		table.insert(done, key)
		count = count + 1
		local _offset = offset * count

		local victim = IsValid(data.victim) and data.victim:Name() or "World "
		local victim_w = surface.GetTextSize(victim)

		local attacker = IsValid(data.attacker) and data.attacker:Name() or "World "
		local attacker_w = surface.GetTextSize(attacker)

		draw.SimpleText(victim, "fbl_kf", ScrW() - offset, _offset + 2, ColorAlpha(color_black, 190), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		draw.SimpleText(victim, "fbl_kf", ScrW() - offset, _offset, color_victim, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

		draw.SimpleText(" killed ", "fbl_kf", ScrW() - offset - victim_w - 4, _offset + 2, ColorAlpha(color_black, 190), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		draw.SimpleText(" killed ", "fbl_kf", ScrW() - offset - victim_w - 4, _offset, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

		draw.SimpleText(attacker, "fbl_kf", ScrW() - offset - victim_w - 4 - attacker_w, _offset + 2, ColorAlpha(color_black, 190), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		draw.SimpleText(attacker, "fbl_kf", ScrW() - offset - victim_w - 4 - attacker_w, _offset, color_attacker, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
	end
end)

hook.Add("DrawDeathNotice", "FBL KF", function()
	return 0, 0
end)