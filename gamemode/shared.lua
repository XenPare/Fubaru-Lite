local GM = GM or GAMEMODE

GM.Name	= "Fubaru Lite"
GM.Author = "crester"

FBL = FBL or {}
FBL.Config = FBL.Config or {}

XPA.IncludeCompounded("fbl/gamemode/config")
XPA.IncludeCompounded("fbl/gamemode/lib")
XPA.IncludeCompounded("fbl/gamemode/core/*")

TEAM_MERCENARY = 1
function GM:PreGamemodeLoaded()
    team.SetUp(TEAM_MERCENARY, "Mercenary", Color(46, 46, 46), false)
end

function GM:Move(pl)
    return not pl:Alive()
end