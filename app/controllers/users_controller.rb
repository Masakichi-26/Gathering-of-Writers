class UsersController < ApplicationController
	before_action :params_search_blank?, only: [:search]
	before_action :set_user, only: [:edit, :update, :show, :destroy, 
		:change_password, :change_password_confirm]
	before_action :authorize_user, only: [:new, :create, :search]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.registration_confirmation(@user).deliver
			redirect_to root_path, flash: {success: "An email has been sent to you. 
				Please access the URL to confirm your email address."}
		else
			flash[:error] = "Something went wrong. Please try again."
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to @user, flash: {success: "Profile was updated."}
		else
			render 'edit'
		end
	end

	def destroy
	end

	def show
		if logged_in?
			@friend = @user.friends.include?(current_user)
			@pending = current_user.friend_requests.exists? friend_id: @user.id
			@received = @user.friend_requests.exists? friend_id: current_user.id
		end

		if @pending 
			@friend_request = current_user.friend_requests.find_by_friend_id(@user.id)
		elsif @received
			@friend_request = @user.friend_requests.find_by_friend_id(current_user.id)
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

	def confirm_email
		user = User.find_by_confirm_token(params[:id])
		if user
			user.email_activate
			UserMailer.with(user: user).welcome_email.deliver_later
			flash[:success] = "Welcome to Gathering of Writers! Your email has been confirmed.
			Please sign in to continue."
			redirect_to login_path
		else
			flash[:error] = "We are sorry to say this, but that user does not exist."
			redirect_to root_path
		end
	end

	def change_password

	end

	def change_password_confirm
		if !params[:user][:current_password].blank?
			@user = User.find_by_id(params[:id])
			if (@user.authenticate(params[:user][:current_password]) == false)
				@user.errors.add(:current_password, " is incorrect.")
				render 'change_password'
			else
				if params[:user][:password].blank?
					@user.errors.add(:password, " cannot be blank.")
					render 'change_password'
				else
					if params[:user][:current_password] != params[:user][:password]
						if @user.update(user_params)
							flash[:success] = "Your password has been successfully changed."
							redirect_to edit_user_path(@user)
						else
							render 'change_password'
						end
					else
						@user.errors.add(:current_password, " and Password cannot be the same.")
						render 'change_password'
					end
				end
			end
		else
			@user.errors.add(:current_password, " cannot be blank.")
			render 'change_password'
		end
	end

private

	def user_params
		params.require(:user).permit(:email, :username, :password, :password_confirmation, :bio)
	end

	def params_search_blank?
		params[:search] == nil || params[:search].strip == ''
	end

	def set_user
		@user = User.find_by_id(params[:id])
		authorize @user
	end

	def authorize_user
        authorize User
    end

end
