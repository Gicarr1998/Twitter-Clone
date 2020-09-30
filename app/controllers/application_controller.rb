class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper

  def logged_in_user
    unless logged_in?
      flash[:info] = "Please Login"
      redirect_to login_url
    end
  end
end
