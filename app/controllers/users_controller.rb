class UsersController < ActionController::Base

	def show
		user = params[:id] ? User.find(params[:id]) : current_user
		user = user.to_ember_json with: :friends
		render json: user
	end


end