class WeaponCategoriesController < ApplicationController
	before_action :set_weapon_category, only: [:show, :edit, :update, :destroy]
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :admin_user,	   only: [:new, :create, :update, :edit, :destroy]

	def index
		@weapon_categories = WeaponCategory.all
	end

	def show
	end

	def new
		@weapon_category = WeaponCategory.new
	end

	def create
		@weapon_category = WeaponCategory.new(weapon_category_params)
		@weapon_category.user = current_user
		if @weapon_category.save
			flash.now[:success] = "Operação concluída com sucesso!"
			redirect_to @weapon_category
		else
			flash.now[:danger] = COOL_ERROR_MESSAGE
			render 'new'
		end
	end

	def edit
	end

	def update
		if @weapon_category.update_attributes(weapon_category_params)
			flash.now[:success] = "Informações atualizadas"
			redirect_to @weapon_category
		else
			flash.now[:danger] = "Ooops! Algo deu errado..."
			render 'edit'
		end
	end

	def destroy
		@weapon_category.destroy
		flash.now[:success] = "Operação concluída com sucesso!"
		redirect_to weapon_categories_url
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_weapon_category
			@weapon_category = WeaponCategory.find(params[:id])
		end

		def weapon_category_params
			params.require(:weapon_category).permit(:name, :effect)
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
		def admin_user
			redirect_to(root_url) unless admin?
		end
end
