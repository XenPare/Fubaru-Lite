AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "fbl_saver_base"
ENT.PrintName = "Health Saver"
ENT.Category = "Fubaru Lite"
ENT.Author = "crester"
ENT.Spawnable = true

ENT.Model = "models/sohald_spike/props/potion_4.mdl"
ENT.Scale = 3
ENT.Color = Color(255, 0, 0)

if SERVER then
	ENT.CustomCheck = function(pl)
		return pl:Health() < pl:GetMaxHealth()
	end

	ENT.SaveFunc = function(pl)
		pl:SetHealth(pl:GetMaxHealth())
		pl:EmitSound("npc/barnacle/barnacle_gulp" .. math.random(1, 2) .. ".wav")
		pl:EmitSound("npc/vort/attack_shoot.wav", 75, 100, 0.1)
	end
end