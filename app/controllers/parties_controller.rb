class PartiesController < ApplicationController
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :correct_user,	 only: [:edit, :update, :destroy]

	def index
		@parties = current_user.parties
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

		def party_params
			params.require(:party).permit(:title)
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
