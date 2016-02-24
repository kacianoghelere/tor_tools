class NpcWeaponsController < ApplicationController
	before_action :set_npc_weapon, only: [:destroy]
	before_action :logged_in_user, only: [:destroy]

	def destroy
		@npc_weapon.destroy
		flash.now[:success] = "Operação concluída com sucesso!"
		render :nothing => true
	end

	private

		# Use callbacks to share common setup or constraints between actions.
		def set_npc_weapon
			@npc_weapon = NpcWeapon.find(params[:id])
		end

		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash.now[:danger] = "Acesse o sistema para efetuar esta operação"
				redirect_to login_url
			end
		end
end
