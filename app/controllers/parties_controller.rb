require 'facets'
class PartiesController < ApplicationController
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :correct_user,	 only: [:edit, :update, :destroy]

	def index
		@parties = Party.all
	end

	def show
		@party = Party.find(params[:id])
	end

	def new
		@party = Party.new
	end

	def edit
	end

	def update
		@party = Party.find(params[:id])
		if @party.update_attributes(party_params)
			create_npcs(@party)
			flash[:success] = "Informações atualizadas"
			redirect_to @party
		else
			render 'edit'
		end
	end


	def destroy
		Party.find(params[:id]).destroy
		flash[:success] = "Operação concluída com sucesso!"
		redirect_to parties_url
	end

	private

		# Cria o vinculo entre o npc e as armas, deleta anteriores
		def create_npcs(party)
			members = params[:party][:members]
			party.party_npcs.destroy_all
			members.each do |member|
				if !member.empty?
					party_npc = party.party_npcs.create!({npc_id: member[:npc_id], 
							amount: member[:amount]})
					debugger
				end
			end
		end

		def party_params
			params.require(:party).permit(:title, members: [:npc_id, :name, :amount])
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
			@party = Party.find(params[:id])
			redirect_to(root_url) unless current_user?(@party.user)
		end
end
