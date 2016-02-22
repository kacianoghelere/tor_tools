class NpcsController < ApplicationController
	before_action :set_npc,        only: [:show, :edit, :update, :destroy]
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
	end

	def new
		@npc = Npc.new
		@npc.build_equipments
	end

	def create
		@npc = Npc.new(npc_params)
		if params[:add_weapon]
			# add empty npc_weapon associated with @npc
			flash.now[:info] = "Equipamento adicionado."
			@npc.equipments.build #.bonus = 1
		elsif params[:remove_weapon]
			# nested model that have _destroy attribute = 1
			# automatically deleted by rails
		else
			@npc.user = current_user
			if @npc.save
				@npc.create_skills(params[:npc][:skills])
				flash.now[:success] = "Operação concluída com sucesso!"
				redirect_to @npc and return
			else
				flash.now[:danger] = COOL_ERROR_MESSAGE
			end
		end
		render :action => 'new'
	end

	def edit
	end

	def update
		if params[:add_weapon]
			# rebuild the npc_npc attributes that doesn't have an id
			unless params[:npc][:equipments_attributes].blank?
				for attribute in params[:npc][:equipments_attributes]
					if !attribute.last.has_key?(:id) || attribute.last[:id].empty?
						@npc.equipments.build(attribute.last.permit(:id, :bonus))
					end
				end
			end
			# add one more empty npc_npc attribute
		  @npc.equipments.build
			flash.now[:info] = "Equipamento adicionado."
		elsif params[:remove_weapon]
			# collect all marked for delete npc_weapon ids
			attrs = params[:npc][:equipments_attributes]
			rmvd = attrs.collect {|i, a| a[:id] if (a[:id] && a[:_destroy].to_i == 1)}
			# physically delete the equipments from database
			NpcWeapon.delete(rmvd)
			flash.now[:info] = "Equipamento removido."
			for attribute in params[:npc][:equipments_attributes]
				# rebuild equipments attributes that doesn't have an id 
				# and its _destroy attribute is not 1
				last = attribute.last
				if (!last.has_key?(:id) && last[:_destroy].to_i == 0)
					@npc.equipments.build(last.except(:id, :_destroy))
				end
			end
    else
			# save goes like usual
			if @npc.update_attributes(npc_params)
				@npc.create_skills(params[:npc][:skills])
				flash[:success] = "Informações atualizadas"
				redirect_to @npc and return
			else
				flash.now[:danger] = COOL_ERROR_MESSAGE
			end
		end
		render :action => 'edit'
	end

	def destroy
		@npc.destroy
		flash.now[:success] = "Operação concluída com sucesso!"
		redirect_to npcs_url
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_npc
			@npc = Npc.find(params[:id])
		end

		def npc_params
			params.require(:npc).permit(:name, :description, :img_url, :ally, 
				:attr_index, :resistance, :resource, :parry, :armour, 
				:personality, :movement, :perception, :survival, :custom, :vocation, 
				equipments_attributes: [:id, :weapon_id, :bonus, :_destroy])
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
			@npc = Npc.find(params[:id])
			redirect_to(root_url) unless current_user?(@npc.user)
		end
end
