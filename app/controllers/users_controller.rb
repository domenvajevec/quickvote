class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		# @user.update_attributes(admin: "No")
		if @user.save
			redirect_to root_path
		else
			redirect_to new_user_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
