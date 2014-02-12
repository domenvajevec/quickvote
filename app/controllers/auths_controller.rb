class AuthsController < ApplicationController

	# Show a login form
	def new
			# Make a login form from an object that has username and password
		if current_user
			redirect_to up_down_votes_path
		else
			@user = User.new
		end
	end

	# Log them in!
	def create
		user = User.find_by(email: params[:user][:email]) 

		if user && user.authenticated?(params[:user][:password]) 
			
			session[:user_id] = user.id
			flash[:notice] = "Welcome, #{current_user.email}!"
			redirect_to up_down_votes_path
		else
			flash[:error] = "Sorry, wrong password/email"
			redirect_to new_auth_path
		end
	end

	# Log out
	def destroy
		logger.debug "In destroy method"
		session[:user_id] = nil
		redirect_to new_auth_path
	end

end