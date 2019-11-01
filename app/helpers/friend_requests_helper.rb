module FriendRequestsHelper

    def friend_request_count
        @incoming = FriendRequest.where(friend: current_user).includes(:user)
        @incoming.length
    end

end
