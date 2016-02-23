if logged_in?
	json.array!(@npcs) do |npc|
		json.id    npc.id
		json.label npc.name
	end
else
	store_location
	flash[:danger] = "Acesse o sistema para efetuar esta operação"
	redirect_to login_url
end