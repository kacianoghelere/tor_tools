class NpcWeaponsController < ApplicationController
	before_action :set_npc_weapon, only: [:destroy]

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
end
