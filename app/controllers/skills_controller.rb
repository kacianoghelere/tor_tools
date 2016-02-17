class SkillsController < ApplicationController
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :correct_user,	 only: [:edit, :update, :destroy]

	def index
		@skills = Skill.all
	end

	def show
		@skill = Skill.find(params[:id])
	end

	def new
		@skill = Skill.new
	end

	def create
		@skill = Skill.new(skill_params)
		@skill.user = current_user
		if @skill.save
			flash[:success] = "Operação concluída com sucesso!"
			redirect_to @skill
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@skill = Skill.find(params[:id])
		if @skill.update_attributes(skill_params)
			flash[:success] = "Informações atualizadas"
			redirect_to @skill
		else
			render 'edit'
		end
	end

	def destroy
		Skill.find(params[:id]).destroy
		flash[:success] = "Operação concluída com sucesso!"
		redirect_to skills_url
	end

	private
		def skill_params
			params.require(:skill).permit(:name, :description)
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
			@skill = Skill.find(params[:id])
			redirect_to(root_url) unless current_user?(@skill.user)
		end
end
