class WeaponsController < ApplicationController
	before_action :set_weapon,     only: [:show,:edit,:update,:destroy]
	before_action :logged_in_user, only: [:index,:show,:edit,:update,:destroy]
	before_action :correct_user,   only: [:edit,:update,:destroy]

	def index
		@weapons = Weapon.all
	end

	def show
	end

	def new
		@weapon = Weapon.new
	end

	def create
		@weapon = Weapon.new(weapon_params)
		@weapon.user = current_user
		if @weapon.save
			flash[:success] = "Operação concluída com sucesso!"
			redirect_to @weapon
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @weapon.update_attributes(weapon_params)
			flash[:success] = "Informações atualizadas"
			redirect_to @weapon
		else
			render 'edit'
		end
	end

	def destroy
		@weapon.destroy
		flash[:success] = "Operação concluída com sucesso!"
		redirect_to weapons_url
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_weapon
			@weapon = Weapon.find(params[:id])
		end

		def weapon_params
			params.require(:weapon).permit(:name, :damage, :edge, :injury, 
																			:weapon_category_id)
		end

		# Before filters

		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Acesse o sistema para efetuar esta operação"
				redirect_to login_url
			end
		end

		# Confirms the correct user.
		def correct_user
			@weapon = Weapon.find(params[:id])
			redirect_to(root_url) unless current_user?(@weapon.user)
		end
end
