local cfg = FBL.Config
local savers = cfg.Savers

local map = savers[game.GetMap()]
if not map then
	return
end

local types = {}
for type, _ in pairs(map) do
	table.insert(types, type)
end

local c_saver
timer.Create("FBL Savers", cfg.SaverRespawnDelay, 0, function()
	if IsValid(c_saver) then
		c_saver:Remove()
	end
	local type = table.Random(types)
	c_saver = ents.Create(type)
	c_saver:SetPos(table.Random(map[type]))
end)