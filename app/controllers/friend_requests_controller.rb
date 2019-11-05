class FriendRequestsController < ApplicationController
    before_action :set_friend_request, only: [:update, :destroy]
    before_action :authorize_friend_request, only: [:index, :create]

    def index
        @incoming = FriendRequest.where(friend: current_user).includes(:user)
        # @outcoming = current_user.friend_requests
        @outgoing = FriendRequest.where(user: current_user).includes(:friend)
    end


    def create
        friend = User.find(params[:friend_id])
        @friend_request = current_user.friend_requests.new(friend: friend)

        if @friend_request.save
            # render :index, status: :created#, location: @friend_request
            redirect_to friend_requests_path
        else
            render json: @friend_request.errors, status: :unprocessable_entity
        end
    end

    def update
        @friend_request.accept
        # head :no_content
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @friend_request.destroy
        # head :no_content
        redirect_back(fallback_location: root_path)
    end

private

    def set_friend_request
        @friend_request = FriendRequest.find(params[:id])
        authorize @friend_request
    end

    def authorize_friend_request
        authorize FriendRequest
    end

end
