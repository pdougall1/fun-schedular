class FriendsController < ApplicationController

	def show
		friend = params[:id] ? User.find(params[:id]) : current_user
		friend = friend.as_friend_json
		render json: friend
	end

end
