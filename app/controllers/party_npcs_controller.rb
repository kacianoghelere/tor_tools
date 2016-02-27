class PartyNpcsController < ApplicationController
	before_action :set_party_npc, only: [:destroy]
	before_action :logged_in_user, only: [:index, :destroy]

	def index
		if params[:party_id]
			@party_npcs = PartyNpc.where('"party_id" = ?', params[:party_id])
			respond_to do |format|
				format.html
				format.json { 
					render :json => @party_npcs.to_json(
						:only    => [:amount],
						:include => { 
							:npc => { 
								:include => {
									:equipments => { 
										:only    => [:weapon, :bonus],
										:include => { 
											:weapon  => { 
												:only    => [:name, :damage, :damage, :edge, :injury],
												:include => {
													:weapon_category => {
														:only    => [:name, :effect]
													}
												}
											}
										}
									}
								} 
							}
						}
				)}
			end
		else
			@party_npcs = PartyNpc.all
		end
	end

	def destroy
		@party_npc.destroy
		flash.now[:success] = "Operação concluída com sucesso!"
		render :nothing => true
	end

	private

		# Use callbacks to share common setup or constraints between actions.
		def set_party_npc
			@party_npc = PartyNpc.find(params[:id])
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
