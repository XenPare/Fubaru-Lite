AddCSLuaFile("shake.lua")
AddCSLuaFile("crosshair.lua")

if CLIENT then
	include("shake.lua")
	include("crosshair.lua")
end

SWEP.PrintName = "FBL Weapon"
SWEP.Slot = 1
SWEP.SlotPos = 9
SWEP.DrawAmmo = true
SWEP.Category = "Fubaru Lite"

SWEP.Author	= "crester"
SWEP.Contact = "76561198159772522"

SWEP.ViewModelFOV = 64
SWEP.ViewModelFlip = false
SWEP.ViewModel = ""
SWEP.WorldModel = ""

SWEP.Spawnable = false
SWEP.AdminSpawnable	= false

SWEP.Cone = 0
SWEP.Recoil = 1
SWEP.Damage = 25
SWEP.Shots = 1

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo	= "none"

SWEP.DeployTime = 0.3
SWEP.FireDelay = 0.1

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self.DeployTime)
end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:MakeRecoil()
	local mod = 1
	if self.Owner:Crouching() then
		mod = mod * 0.75
	end
	self.Owner:ViewPunch(Angle(-self.Recoil * 1.25 * mod, 0, 0))
end

function SWEP:ShootBullet(damage, num_bullets, aimcone)
	local bullet = {}
	if self.Shots > 1 then
		for i = 1, self.Shots do
			bullet.Num = self.Primary.Shots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector(aimcone, aimcone, 0) + VectorRand(0, 0.1)
			bullet.Tracer = 5
			bullet.Force = 1
			bullet.Damage = self.Damage
			bullet.AmmoType = self.Primary.Ammo
			self.Owner:FireBullets(bullet)
		end
	else
		bullet.Num = self.Primary.Shots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector(aimcone, aimcone, 0)
		bullet.Tracer = 5
		bullet.Force = 1
		bullet.Damage = self.Damage
		bullet.AmmoType = self.Primary.Ammo
		self.Owner:FireBullets(bullet)
	end
	self:ShootEffects()
end

function SWEP:PrimaryAttack()
	if self.Melee then
		self:SendWeaponAnim(ACT_VM_HITCENTER)
		self.Owner:SetAnimation(PLAYER_ATTACK1)

		self:EmitSound(self.FireSound)
		self:MakeRecoil()

		local tr = util.TraceLine({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		})

		if not IsValid(tr.Entity) then
			tr = util.TraceHull({
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
				filter = self.Owner,
				mins = Vector(-32, -32, 0),
				maxs = Vector(32, 32, 0),
				mask = MASK_SHOT_HULL
			})
		end

		if IsValid(tr.Entity) then
			if SERVER then
				local dmg = DamageInfo()
				dmg:SetAttacker(self.Owner)
				dmg:SetInflictor(self)
				dmg:SetDamage(self.Damage)
				dmg:SetDamageForce(self.Owner:GetForward() * 1000)
				dmg:SetAttacker(self.Owner or self)

				tr.Entity:TakeDamageInfo(dmg)
			end
			self:EmitSound(self.HitSound or self.FireSound)
		end
	else
		if self:Clip1() == 0 then
			self:EmitSound("fbl/weapons/empty.wav", 105, 100)
			self:SetNextPrimaryFire(CurTime() + 0.25)
			return
		end

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		self:EmitSound(self.FireSound, 105, 100)
		self:ShootBullet(self.Damage, 1, self.Cone)
		self:TakePrimaryAmmo(1)
		self:MakeRecoil()
	end

	if CLIENT then
		self.CrossAmount = self.CrossAmount + self.Recoil
	end

	self:SetNextPrimaryFire(CurTime() + self.FireDelay)
end

function SWEP:SecondaryAttack()
	return
end

function SWEP:Reload()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 or self:Clip1() == self:GetMaxClip1() then
		return
	end

	if self.Shots > 1 and not self.OverrideShotgunReload then
		self:DefaultReload(ACT_VM_RELOAD)

		local seq_reload = self:SelectWeightedSequence(ACT_VM_RELOAD)
		local seq_reload_d = self:SequenceDuration(seq_reload)
		if seq_reload_d == nil then
			return
		end

		timer.Simple(seq_reload_d, function()
			if not IsValid(self) then
				return
			end

			self:SendWeaponAnim(ACT_RELOAD_FINISH)

			local seq_finish = self:SelectWeightedSequence(ACT_VM_RELOAD)
			local seq_finish_d = self:SequenceDuration(seq_finish) or 0.1
			self:SetNextPrimaryFire(CurTime() + seq_finish_d)
		end)
	else
		self:DefaultReload(ACT_VM_RELOAD)

		local seq_reload = self:SelectWeightedSequence(ACT_VM_RELOAD)
		local seq_reload_d = self:SequenceDuration(seq_reload)
		self:SetNextPrimaryFire(CurTime() + seq_reload_d)
	end

	self:SetHoldType(self.HoldType)
end