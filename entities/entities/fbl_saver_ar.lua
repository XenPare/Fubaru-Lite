AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "fbl_saver_base"
ENT.PrintName = "Armor Saver"
ENT.Category = "Fubaru Lite"
ENT.Author = "crester"
ENT.Spawnable = true

ENT.Model = "models/sohald_spike/props/potion_3.mdl"
ENT.Scale = 3
ENT.Color = Color(0, 0, 200)

if SERVER then
	ENT.CustomCheck = function(pl)
		return pl:Armor() < pl:GetMaxArmor()
	end

	ENT.SaveFunc = function(pl)
		pl:SetArmor(pl:GetMaxArmor())
		pl:EmitSound("npc/barnacle/barnacle_gulp" .. math.random(1, 2) .. ".wav")
		pl:EmitSound("npc/vort/attack_shoot.wav", 75, 100, 0.1)
	end
end