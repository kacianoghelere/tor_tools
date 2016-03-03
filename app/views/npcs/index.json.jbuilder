json.array!(@npcs) do |npc|
	json.id    npc.id
	json.label npc.name
end