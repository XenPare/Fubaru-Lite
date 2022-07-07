AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Saver Base"
ENT.Category = "Fubaru Lite"
ENT.Author = "crester"
ENT.Spawnable = false

if CLIENT then
	function ENT:Initialize()
		self.csModel = ClientsideModel(self.Model)
		self.csModel:SetModelScale(self.Scale)
		self.csModel:SetColor(self.Color)
	end

	function ENT:Draw()
		self.csModel:SetPos(self:GetPos() + Vector(0, 0, (math.sin(CurTime() * 3) * 5) - 1))
		self.csModel:SetAngles(Angle(0, (CurTime() * 90) % 360, 0))
	end

	function ENT:OnRemove()
		self.csModel:Remove()
	end
end

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:SetModelScale(self.Scale)
		self:PhysicsInit(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetPos(self:GetPos() + Vector(0, 0, 40))
	end

	local pos
	local radius = FBL.Config.SaverRadius
	function ENT:Think()
		pos = self:GetPos()
		for _, pl in pairs(ents.FindInSphere(pos, radius)) do
			if not pl:IsPlayer() then
				continue
			end
			if self.SaveFunc then
				if self.CustomCheck then
					if self.CustomCheck(pl) then
						self.SaveFunc(pl)
						self:Remove()
					end
				else
					self.SaveFunc(pl)
					self:Remove()
				end
			end
		end
	end
end