class NpcsController < ApplicationController
	before_action :set_npc,        only: [:show, :edit, :update, :destroy]
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :correct_user,	 only: [:correct_user, :edit, :update, :destroy]

	def index
		if params[:party_id]
			@npcs = Party.find(params[:party_id]).npcs
			respond_to do |format|
				format.html
				format.json { 
					render :json => @npcs.to_json(:include => { 
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
				)}
			end
		elsif params[:term]
			respond_to do |format|
				format.html
				format.json { @npcs = Npc.search(params[:term]) }
			end
		else
			@npcs = Npc.all
			@newest = Npc.newest
		end
	end

	def show
		respond_to do |format|
			format.html
			format.json { 
				render :json => @npc.to_json(:include => { 
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
			)}
		end
	end

	def new
		@npc = Npc.new
		@npc.build_equipments
	end

	def create
		@npc = Npc.new(npc_params)
		@npc.user = current_user
		if @npc.save
			@npc.create_skills(params[:npc][:skills])
			flash.now[:success] = COOL_SUCCESS_MESSAGE
			redirect_to @npc and return
		else
			flash.now[:danger] = COOL_ERROR_MESSAGE
		end
		render :action => 'new'
	end

	def edit
	end

	def update
		# save goes like usual
		if @npc.update_attributes(npc_params)
			@npc.create_skills(params[:npc][:skills])
			flash[:success] = COOL_SUCCESS_MESSAGE
			redirect_to @npc and return
		else
			flash.now[:danger] = COOL_ERROR_MESSAGE
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
			redirect_to(root_url) unless current_user?(@npc.user) || admin?
		end
end
