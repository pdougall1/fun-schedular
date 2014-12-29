class RelationshipsController < ActionController::Base

	def show
		re = Relationship.find(params[:id])
		render json: { relationship: re }
	end

end