class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include SessionsHelper
	COOL_SUCCESS_MESSAGE = "Operação concluída com sucesso!"
	COOL_INFO_MESSAGE = "Informações atualizadas"
	COOL_ERROR_MESSAGE = "Ooops! Algo deu errado..."
end
