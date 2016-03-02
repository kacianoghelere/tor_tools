class ApplicationController < ActionController::Base
	before_filter :set_cache_headers

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include SessionsHelper
	COOL_SUCCESS_MESSAGE = "Operação concluída com sucesso!"
	COOL_INFO_MESSAGE = "Informações atualizadas"
	COOL_ERROR_MESSAGE = "Ooops! Algo deu errado..."

  
	private
		def set_cache_headers
			response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
			response.headers["Pragma"] = "no-cache"
			response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
		end
end
