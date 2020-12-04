local tag, loadout = "FBL Loadout", FBL.Config.Loadout

util.AddNetworkString(tag)
util.AddNetworkString(tag .. " Save")

net.Receive(tag .. " Save", function(_, pl)
	local selected = net.ReadTable()
	local primary, secondary = selected.primary, selected.secondary
	local primary_tbl, secondary_tbl = loadout.primary[primary], loadout.secondary[secondary]
	if pl:Alive() then
		hook.Add("PlayerDeath", tag .. " #" .. pl:SteamID(), function(victim)
			if victim == pl then
				hook.Remove("PlayerDeath", tag .. " #" .. pl:SteamID())
				if primary and primary_tbl then
					pl:SetNWString("Primary", primary_tbl.class)
					pl:ConCommand("fbl_primary " .. primary_tbl.class)
				end
				if secondary and secondary_tbl then
					pl:SetNWString("Secondary", secondary_tbl.class)
					pl:ConCommand("fbl_secondary " .. secondary_tbl.class)
				end
			end
		end)
	else
		if primary and primary_tbl then
			pl:SetNWString("Primary", primary_tbl.class)
			pl:ConCommand("fbl_primary " .. primary_tbl.class)
		end
		if secondary and secondary_tbl then
			pl:SetNWString("Secondary", secondary_tbl.class)
			pl:ConCommand("fbl_secondary " .. secondary_tbl.class)
		end
	end
end)

hook.Add("PlayerInitialSpawn", tag, function(pl)
	if pl:GetInfo("fbl_primary", "") == "" or pl:GetInfo("fbl_secondary", "") == "" then
		net.Start(tag)
		net.Send(pl)
	end
end)

hook.Add("ShowHelp", tag, function(pl)
	net.Start(tag)
	net.Send(pl)
end)