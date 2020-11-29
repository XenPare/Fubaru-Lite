AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

hook.Add("PlayerInitialSpawn", "FBL", function(pl)
    pl:SetModel(FBL.Config.Playermodel)
end)