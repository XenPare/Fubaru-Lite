util.AddNetworkString("FBL KF")

hook.Add("PlayerDeath", "FBL KF", function(victim, _, attacker)
	if not victim:IsPlayer() or not attacker:IsPlayer() then
		return
	end

	net.Start("FBL KF")
		net.WriteEntity(victim)
		net.WriteEntity(attacker)
	net.Broadcast()
end)