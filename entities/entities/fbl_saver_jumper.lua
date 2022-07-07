AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "fbl_saver_base"
ENT.PrintName = "Jump Saver"
ENT.Category = "Fubaru Lite"
ENT.Author = "crester"
ENT.Spawnable = true

ENT.Model = "models/sohald_spike/props/potion_5.mdl"
ENT.Scale = 3
ENT.Color = Color(0, 255, 157)

if SERVER then
	ENT.CustomCheck = function(pl)
		return not pl:GetNWBool("FBL Jumper Potion")
	end

	ENT.SaveFunc = function(pl)
		pl:SetJumpPower(pl:GetJumpPower() + FBL.Config.JumperPotionAdder)
		pl:SetNWBool("FBL Jumper Potion", true)
		pl:SetTimer("FBL Jumper Potion", FBL.Config.JumperPotionAction, 1, function()
			if not pl:GetNWBool("FBL Jumper Potion") then
				return
			end
			pl:SetJumpPower(pl:GetJumpPower() - FBL.Config.JumperPotionAdder)
			pl:SetNWBool("FBL Jumper Potion", false)
		end)
	end

	hook.Add("PlayerDeath", "FBL Jumper Potion", function(pl)
		if not pl:GetNWBool("FBL Jumper Potion") then
			return
		end
		pl:SetJumpPower(pl:GetJumpPower() - FBL.Config.JumperPotionAdder)
		pl:SetNWBool("FBL Jumper Potion", false)
		pl:RemoveTimer("FBL Jumper Potion")
	end)
end