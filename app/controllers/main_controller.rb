class MainController < ApplicationController
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

	private
		def message_params
			params.require(:message).permit(:email, :name, :message)
		end
end
