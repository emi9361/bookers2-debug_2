class RelationshipsController < ApplicationController

	def create
	  follow_id = params[:follow_id].to_i
	  if current_user.id == follow_id
		flash[:notice] = '自分をフォローすることはできません'
	  else
		@user = current_user
		relationship = @user.relationships.new(relationship_params)
		relationship.save
	  end
	    redirect_to user_path(User.find(follow_id))
	end

	def destroy
		Relationship.where(user_id: current_user.id, follow_id: params[:follow_id]).destroy_all
		redirect_to user_path(User.find(params[:follow_id]))
	end

	private
	def relationship_params
		params.permit(:user_id, :follow_id)
	end
end
