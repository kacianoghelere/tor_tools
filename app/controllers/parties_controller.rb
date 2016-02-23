class PartiesController < ApplicationController
	before_action :set_party, only: [:show, :edit, :update, :destroy]
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :correct_user,	 only: [:edit, :update, :destroy]

	def index
		@parties = Party.all
	end

	def show
	end

	def new
		@party = Party.new
		@party.build_members
	end

	def create
		@party = Party.new(party_params)
		@party.user = current_user
		if @party.save
			flash.now[:success] = "Informações Salvas"
			redirect_to @party and return
		else
			flash.now[:danger] = "Ooops! Algo deu errado..."
		end
		render :action => 'new'
	end

	def edit
	end

	def update
		# save goes like usual
		if @party.update_attributes(party_params)
			flash.now[:success] = "Informações atualizadas"
			redirect_to @party and return
		else
			flash.now[:danger] = "Ooops! Algo deu errado..."
		end
		render :action => 'edit'
	end

	def destroy
		Party.find(params[:id]).destroy
		flash.now[:success] = "Operação concluída com sucesso!"
		redirect_to parties_url
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_party
			@party = Party.find(params[:id])
		end

		def party_params
			params.require(:party).permit(:title, 
									members_attributes: [:npc_id, :amount, :_destroy, :id])
		end

		# Before filters

		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash.now[:danger] = "Acesse o sistema para efetuar esta operação"
				redirect_to login_url
			end
		end

		# Confirms the correct user.
		def correct_user
			@party = Party.find(params[:id])
			redirect_to(root_url) unless current_user?(@party.user)
		end
end
