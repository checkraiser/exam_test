class UsersController < ApplicationController
	
	def index
		@users = User.finder(params[:q]).page(params[:page]).per(params[:per])
		respond_to do |format|
	      format.html
	      format.json { render json: @users }
	    end
	end

	def show
		@user = User.find(params[:id])
		@enrollments = @user.enrollments
	end

	def update
		authorize! :update, current_user
		current_user.update(user_params)
		redirect_to "/profile"
	end
	private
	def user_params
		params.require(:user).permit(:username, :birthday)
	end
end