class PartyNpcsController < ApplicationController
	before_action :set_party_npc, only: [:destroy]

	def destroy
		@set_party_npc.destroy
		flash.now[:success] = "Operação concluída com sucesso!"
		render :nothing => true
	end

	private

		# Use callbacks to share common setup or constraints between actions.
		def set_party_npc
			@party_npc = PartyNpc.find(params[:id])
		end
end
