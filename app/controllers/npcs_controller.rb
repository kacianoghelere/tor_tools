class NpcsController < ApplicationController
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :correct_user,	 only: [:edit, :update, :destroy]

	def index
		if params[:term]
			respond_to do |format|
				format.html
				format.json { @npcs = Npc.search(params[:term]) }
			end
		else
			@npcs = Npc.all
		end
	end

	def show
		@npc = Npc.find(params[:id])
	end

	def new
		@npc = Npc.new
	end

	def create
		@npc = Npc.new(npc_params)
		@npc.user = current_user
		if @npc.save
			@npc.create_weapons(params[:npc][:weapons])
			@npc.create_skills(params[:npc][:skills])
			flash[:success] = "Operação concluída com sucesso!"
			redirect_to @npc
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@npc = Npc.find(params[:id])
		if @npc.update_attributes(npc_params)
			@npc.create_weapons(params[:npc][:weapons])
			@npc.create_skills(params[:npc][:skills])
			flash[:success] = "Informações atualizadas"
			redirect_to @npc
		else
			render 'edit'
		end
	end

	def destroy
		Npc.find(params[:id]).destroy
		flash[:success] = "Operação concluída com sucesso!"
		redirect_to npcs_url
	end

	private

		def npc_params
			params.require(:npc).permit(:name, :description, :img_url, :ally, 
				:attr_index, :resistance, :resource, :parry, :armour, :personality,
				:movement, :perception, :survival, :custom, :vocation)
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
			@npc = Npc.find(params[:id])
			redirect_to(root_url) unless current_user?(@npc.user)
		end
end
