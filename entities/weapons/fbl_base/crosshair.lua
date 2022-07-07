SWEP.CrossAmount = 0
SWEP.CrossAlpha = 255

SWEP.CurFOVMod = 0
SWEP.PassiveCone = 0.01

SWEP.AimCrossAlpha = 0
SWEP.CrossAlpha = 0

function SWEP:DoDrawCrosshair(x, y)
	local ft = FrameTime()

	if self:GetNextPrimaryFire() > CurTime() then
		self.CrossAlpha = 80
	end

	self.CrossAlpha = Lerp(ft * 15, self.CrossAlpha, 255)
	self.AimCrossAlpha = Lerp(ft * 15, self.AimCrossAlpha, 0)
	self.CrossAmount = Lerp(ft * 15, self.CrossAmount, (self.PassiveCone * 350) * (90 / (math.Clamp(GetConVarNumber("fov_desired"), 75, 90) - self.CurFOVMod)))

	surface.SetDrawColor(0, 0, 0, self.CrossAlpha * 0.75)
	surface.DrawRect(x - 13 - self.CrossAmount, y - 1, 12, 3)
	surface.DrawRect(x + 3 + self.CrossAmount, y - 1, 12, 3)
	surface.DrawRect(x - 1, y - 13 - self.CrossAmount, 3, 12)
	surface.DrawRect(x - 1, y + 3 + self.CrossAmount, 3, 12)

	surface.SetDrawColor(255, 255, 255, self.CrossAlpha)
	surface.DrawRect(x - 12 - self.CrossAmount, y, 10, 1)
	surface.DrawRect(x + 4 + self.CrossAmount, y, 10, 1)
	surface.DrawRect(x, y - 12 - self.CrossAmount, 1, 10)
	surface.DrawRect(x, y + 4 + self.CrossAmount, 1, 10)

	return true
end