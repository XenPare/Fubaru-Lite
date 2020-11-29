local sway, ea, _ea, _pos, _ang, vec = Vector(), Angle(), Angle(), Vector(), Vector(), Vector()

local function GetVMAffectedPosAng(self)
	local pos, ang = vec, vec

	local vel = self.Owner:GetVelocity()
	local len = self.Owner:IsOnGround() and vel:Length() or 0
	local move = len / self.Owner:GetWalkSpeed()

	local t = RealTime() * (len > 0.2 and 8 or 2)
	local amp = 0

	amp = 0.2 + move * 0.6
	pos = pos + Vector(math.cos(t) * 0.5, 0, math.sin(2 * t) / 2) * amp

	_ea.p = math.AngleDifference(EyeAngles().p, ea.p)
	_ea.y = math.AngleDifference(EyeAngles().y, ea.y)

	local max = 5
	sway.x = math.Clamp(sway.x + _ea.p * 0.25, -max, max)
	sway.y = math.Clamp(sway.y + _ea.y * 0.25, -max, max)
	
	local velRoll = math.Clamp((vel:DotProduct(EyeAngles():Right()) * 0.04) * move, -5, 5)
	ang = ang + Vector(sway.x, sway.y * 2, velRoll - sway.y)
	pos = pos + Vector(sway.y * 0.5, 0, sway.x * 0.5)

	sway = LerpVector(math.min(1, FrameTime() * 20), sway, vec)
	ea = EyeAngles()

	return pos, ang
end

local function GetWeaponShake(pos, ang)
	ang:RotateAroundAxis(ang:Right(), _ang.x)
	ang:RotateAroundAxis(ang:Up(), _ang.y)
	ang:RotateAroundAxis(ang:Forward(), _ang.z)

	pos:Add(ang:Right() * _pos.x)
	pos:Add(ang:Forward() * _pos.y)
	pos:Add(ang:Up() * _pos.z)

	return pos, ang
end

function SWEP:CalcViewModelView(_, pos, ang)
	return GetWeaponShake(pos, ang)
end

local pos, ang
function SWEP:PreDrawViewModel(_, wep)
	pos, ang = GetVMAffectedPosAng(wep)
	_pos = LerpVector(math.min(1, FrameTime() * 10), _pos, pos)
	_ang = LerpVector(math.min(1, FrameTime() * 10), _ang, ang)
end