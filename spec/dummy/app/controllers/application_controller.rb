class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user

  def current_user
    @current_user
  end
  helper_method :current_user

  def set_user
    if params[:user]
      @current_user = ::User.first
    end
  end
end
