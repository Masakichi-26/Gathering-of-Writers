class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  # protect_from_forgery with: :exception
  include SessionsHelper
  include GroupsHelper
  include FriendRequestsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_back fallback_location: root_path
  end

end
