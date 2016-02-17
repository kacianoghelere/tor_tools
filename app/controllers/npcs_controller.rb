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
			weapons = params[:npc][:weapons]
			skills  = params[:npc][:skills]
			create_weapons(@npc, weapons)
			create_skills(@npc,  skills)
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
			weapons = params[:npc][:weapons]
			skills  = params[:npc][:skills]
			create_weapons(@npc, weapons)
			create_skills(@npc,  skills)
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

		# Cria o vinculo entre o npc e as armas, deleta anteriores
		def create_weapons(npc, weapons)
			npc.npc_weapons.destroy_all
			weapons.each do |w|
				if !w.empty?
					npc.npc_weapons.create({npc_id: npc, weapon_id: w.to_i})
				end
			end
		end

		# Cria o vinculo entre o npc e as habilidades, deleta anteriores
		def create_skills(npc, skills)
			npc.npc_skills.destroy_all
			skills.each do |s|
			if !s.empty?
			 	npc.npc_skills.create({npc_id: npc, skill_id: s.to_i})
			end
			end
		end

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
