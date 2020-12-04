local workshop = {
	["Scout"] = "284337366",
	["Mad Weapons"] = "947897747",
	["Fan Weapons"] = "947417471",
	["Elegant Weapons"] = "947307512",
	["Maps"] = "2308290678"
}

for _, id in pairs(workshop) do
	resource.AddWorkshop(id)
end