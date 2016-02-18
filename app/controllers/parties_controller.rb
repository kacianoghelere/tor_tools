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
		@party.build_party_npcs
	end

	def create
		@party = Party.new(party_params)
		if params[:add_npc]
			# add empty party_npc associated with @party
			@party.party_npcs.build.amount = 1
		elsif params[:remove_npc]
			# nested model that have _destroy attribute = 1
			# automatically deleted by rails
		else
			@party.user = current_user
			if @party.save
				flash[:success] = "Informações Salvas"
				redirect_to @party and return
			else
				flash[:danger] = "Ooops! Algo deu errado..."
			end
		end
		render :action => 'new'
	end

	def edit
		@party = Party.find(params[:id])
	end

	def update
		@party = Party.find(params[:id])
		if params[:add_npc]
			# rebuild the party_npc attributes that doesn't have an id
			attrs = params[:party][:party_npcs_attributes]
			unless attrs.blank?
				for pt_attr in attrs
					unless pt_attr.last.has_key?(:id)
						@party.party_npcs.build(pt_attr.last.except(:_destroy))
					end
				end
			end
			# add one more empty party_npc attribute
		  @party.party_npcs.build.amount = 1
		elsif params[:remove_npc]
			# collect all marked for delete party_npc ids
			attrs = params[:party][:party_npcs_attributes]
			rmv = attrs.collect {|i, a| a[:id] if (a[:id] && a[:_destroy].to_i == 1)}
			# physically delete the party_npcs from database
			PartyNpc.delete(rmv)
			flash[:info] = "NPC removido."
			for pt_attr in params[:party][:party_npcs_attributes]
				# rebuild party_npcs attributes that doesn't have an id 
				# and its _destroy attribute is not 1
				if (!pt_attr.last.has_key?(:id) && pt_attr.last[:_destroy].to_i == 0)
					@party.party_npcs.build(pt_attr.last.except(:_destroy)).amount = 1
				end
			end
    else
      # save goes like usual
			if @party.update_attributes(party_params)
				flash[:success] = "Informações atualizadas"
				redirect_to @party and return
			else
				flash[:danger] = "Ooops! Algo deu errado..."
			end
    end
    render :action => 'edit'
	end

	def destroy
		Party.find(params[:id]).destroy
		flash[:success] = "Operação concluída com sucesso!"
		redirect_to parties_url
	end

	private

		def party_params
			params.require(:party).permit(:title, 
									party_npcs_attributes: [:npc_id, :amount, :_destroy, :id])
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
