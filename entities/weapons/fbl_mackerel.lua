AddCSLuaFile()

SWEP.PrintName = "Mackerel"
SWEP.Category = "Fubaru Lite"

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.HoldType = "melee"
SWEP.Base = "fbl_base"

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.ViewModel = "models/weapons/v_models/v_holymackerel.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_holymackerel.mdl"

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

SWEP.FireSound = Sound("Weapon_Bat.Miss")
SWEP.HitSound = Sound("Weapon_HolyMackerel.HitFlesh")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Melee = true
SWEP.Damage = 62

SWEP.FireDelay = 0.55
SWEP.Recoil = 4