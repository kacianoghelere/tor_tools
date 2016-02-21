class MainController < ApplicationController
	before_action :logged_in_user, only: [:battle]

	def index
		unless logged_in?
			render "visitor"
		end
	end

	def about
	end

	def help
	end

	def contact
	end

	def send_contact
	end

	def battle
	end

	private
		def message_params
			params.require(:message).permit(:email, :name, :message)
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
end
