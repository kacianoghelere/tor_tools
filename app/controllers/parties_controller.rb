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
		if params[:add_npc]
			# add empty party_npc associated with @party
			flash.now[:info] = "NPC adicionado."
			@party.members.build.amount = 1
		elsif params[:remove_npc]
			# nested model that have _destroy attribute = 1
			# automatically deleted by rails
		else
			@party.user = current_user
			if @party.save
				flash.now[:success] = "Informações Salvas"
				redirect_to @party and return
			else
				flash.now[:danger] = "Ooops! Algo deu errado..."
			end
		end
		render :action => 'new'
	end

	def edit
	end

	def update
		if params[:add_npc]
			# rebuild the party_npc attributes that doesn't have an id
			unless params[:party][:members_attributes].blank?
				for attribute in params[:party][:members_attributes]
					if !attribute.last.has_key?(:id) || attribute.last[:id].empty?
						@party.members.build(attribute.last.permit(:id, :bonus))
					end
				end
			end
			# add one more empty party_npc attribute
			flash.now[:info] = "NPC adicionado."
		  @party.members.build.amount = 1
		elsif params[:remove_npc]
			# collect all marked for delete party_npc ids
			attrs = params[:party][:members_attributes]
			rmv = attrs.collect {|i, a| a[:id] if (a[:id] && a[:_destroy].to_i == 1)}
			# physically delete the members from database
			PartyNpc.delete(rmv)
			flash.now[:info] = "NPC removido."
			for pt_attr in params[:party][:members_attributes]
				# rebuild members attributes that doesn't have an id 
				# and its _destroy attribute is not 1
				if (!pt_attr.last.has_key?(:id) && pt_attr.last[:_destroy].to_i == 0)
					@party.members.build(pt_attr.last.except(:_destroy)).amount = 1
				end
			end
		else
			# save goes like usual
			if @party.update_attributes(party_params)
				flash.now[:success] = "Informações atualizadas"
				redirect_to @party and return
			else
				flash.now[:danger] = "Ooops! Algo deu errado..."
			end
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
