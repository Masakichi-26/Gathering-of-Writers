class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy
  before_action :authorize_friend

  def index
    @friends = current_user.friends
    # authorize @friends, policy_class: FriendshipPolicy
  end

  def destroy
    current_user.friends.destroy(@friend)
    redirect_back(fallback_location: root_path)
  end

private

  def set_friend
    @friend = current_user.friends.find(params[:user_id])
    # authorize @friend, policy_class: FriendshipPolicy
  end

  def authorize_friend
    authorize Friendship, policy_class: FriendshipPolicy
  end
  
end
