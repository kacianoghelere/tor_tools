json.array!(@parties) do |party|
	json.id    party.id
	json.title party.title
	json.npcs  party.members.map { |m| "#{m.npc.id} - #{m.npc.name} x #{m.amount}" }
end