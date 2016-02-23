json.array!(@skills) do |skill|
	json.id          skill.id
	json.name        skill.name
	json.description skill.description
end