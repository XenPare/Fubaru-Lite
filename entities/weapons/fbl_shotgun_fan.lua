AddCSLuaFile()

SWEP.PrintName = "Fan Shotgun"
SWEP.Category = "Fubaru Lite"

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.HoldType = "shotgun"
SWEP.Base = "fbl_base"

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.ViewModel = "models/weapons/v_models/v_soda_popper.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_soda_popper.mdl"

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

SWEP.FireSound = Sound("Weapon_Soda_Popper.Single")

SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 84
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Buckshot"

SWEP.Shots = 2
SWEP.Damage = 24

SWEP.OverrideShotgunReload = true

SWEP.FireDelay = 0.28
SWEP.Recoil = 9