if logged_in?
	json.array!(@users) do |user|
		json.extract! user, :id, :name, :email
		json.url user_url(user, format: :json)
	end
else
	store_location
	flash[:danger] = "Acesse o sistema para efetuar esta operação"
	redirect_to login_url
end