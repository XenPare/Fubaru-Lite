local workshop = {
	["Mercenary"] = "2092560687",
	["Mad Weapons"] = "947897747",
	["Fan Weapons"] = "947417471",
	["Elegant Weapons"] = "947307512"
}

for _, id in pairs(workshop) do
	resource.AddWorkshop(id)
end