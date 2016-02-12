class WeaponsController < ApplicationController
	def index
		@weapons = Weapon.all
	end

	def show
		@weapon = Weapon.find(params[:id])
	end

	def new
		@weapon = Weapon.new
	end

	def edit
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password,
																	 :password_confirmation)
		end
end
