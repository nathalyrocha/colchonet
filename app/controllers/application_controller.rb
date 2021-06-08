class ApplicationController < ActionController::Base
  delegate :current_user, :user_signed_in?, to: :user_session
  helper_method :current_user, :user_signed_in?

  def user_session
    UserSession.new(session)
  end

  def require_authentication
    return if user_signed_in?.nil? redirect_to new_user_sessions_path, alert: t('flash.alert.needs_login')
  end

  def require_no_authentication
    redirect_to root_path if user_signed_in?
  end
end
