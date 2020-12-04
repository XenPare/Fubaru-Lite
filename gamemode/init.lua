AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local CFG = FBL.Config

function GM:Initialize()
	local map = CFG.Maps[game.GetMap()]
	if not map then
		return
	end
	for _, pos in pairs(map) do
		local spawn = ents.Create("fbl_spawn")
		spawn:SetPos(pos)
		spawn:Spawn()
	end
end

hook.Add("PlayerSelectSpawn", "FBL", function()
	local spawns = ents.FindByClass("fbl_spawn")
	local random = math.random(#spawns)
	return spawns[random]
end)

hook.Add("PlayerInitialSpawn", "FBL", function(pl)
	local color = ColorRand()

	pl:SetWalkSpeed(CFG.WalkSpeed)
	pl:SetRunSpeed(CFG.RunSpeed)
	pl:SetJumpPower(CFG.JumpPower)
	pl:SetModel(CFG.Playermodel)
	pl:SetPlayerColor(Vector(color.r / 255, color.g / 255, color.b / 255))

	pl:Give(pl:GetPrimaryWeapon())
	pl:Give(pl:GetSecondaryWeapon())
	pl:SelectWeapon(pl:GetPrimaryWeapon())

	pl:SetSimpleTimer(0.1, function()
		pl:SetTeam(TEAM_MERCENARY)
	end)
end)

hook.Add("PlayerSpawn", "FBL", function(pl)
	pl:SetWalkSpeed(CFG.WalkSpeed)
	pl:SetRunSpeed(CFG.RunSpeed)
	pl:SetJumpPower(CFG.JumpPower)

	pl:Give(pl:GetPrimaryWeapon())
	pl:Give(pl:GetSecondaryWeapon())
	pl:SelectWeapon(pl:GetPrimaryWeapon())
end)

hook.Add("PlayerDeath", "FBL", function(victim, inflictor, killer)
	local _killer
	if IsValid(killer) and killer:IsPlayer() then
		_killer = killer
	else
		if not inflictor.Owner then
			_killer = inflictor.Owner
		end
		if not IsValid(_killer) or _killer == nil then
			return
		end
	end
	local ammo_primary = FBL.GetWeaponInfo(_killer:GetPrimaryWeapon(), "Primary", "Ammo")
	local ammo_secondary = FBL.GetWeaponInfo(_killer:GetSecondaryWeapon(), "Primary", "Ammo")
	if ammo_primary ~= "none" then
		_killer:GiveAmmo(math.random(6, 18), ammo_primary)
	end
	if ammo_secondary ~= "none" then
		_killer:GiveAmmo(math.random(6, 18), ammo_secondary)
	end
end)

hook.Add("GetFallDamage", "FBL", function()
    return 0
end)