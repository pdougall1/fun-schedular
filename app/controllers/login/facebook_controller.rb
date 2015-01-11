class Login::FacebookController < ApplicationController

	def create
		current_user.update_attributes(
			facebook_id: response_params[:userID], 
			facebook_access_token: response_params[:accessToken] )
		
		render json: current_user
	end

	private

	def response_params
		params.require(:response).permit(:accessToken, :userID)
	end

end
