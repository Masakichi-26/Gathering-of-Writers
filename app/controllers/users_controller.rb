class UsersController < ApplicationController
	before_action :params_search_blank?, only: [:search]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to login_path
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user, flash: {success: "Profile was updated."}
		else
			render 'edit'
		end
	end

	def destroy
	end

	def show
		@user = User.find(params[:id])
		if logged_in?
			@friend = @user.friends.include?(current_user)
			@pending = current_user.friend_requests.exists? friend_id: @user.id
			@received = @user.friend_requests.exists? friend_id: current_user.id
		end

		if @pending 
			@friend_request = current_user.friend_requests.find_by(friend_id: @user.id)
		elsif @received
			@friend_request = @user.friend_requests.find_by(friend_id: current_user.id)
		end
	end

	def search
		@search_blank = params_search_blank?
		if params[:search].blank?
			@users = User.all.order(username: "ASC")
		else
			@users = User.order(username: "ASC").search(params[:search])
		end

		@users = current_user.except_current_user(@users)
		flash.now[:error] = "No users match this search criteria" if @users.blank?
	end

private

	def user_params
		params.require(:user).permit(:email, :username, :password, :password_confirmation, :bio)
	end

	def params_search_blank?
		params[:search] == nil || params[:search].strip == ''
	end

end
