class AccessController < ApplicationController

  layout 'admin'
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
    # display links and text
  end

  def login
    # login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(:username => params[:username]).first

      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      ## mark users logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username

      flash[:notice] = 'You are now logged in.'
      redirect_to(:action => 'index')
    else
      flash[:notice] = 'Invalid Username/Password combination.'
      redirect_to(:action => 'login')
    end
  end

  def logout
    ##TODO : mark users logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'You are now logged out.'
    redirect_to(:action => 'login')
  end

  ## KP : This is one way but we are protecting only access_controllers.
  ## KP : But we need to protect other controllers too.
  ## KP : So the right place is to put this code in application_controller
  # private
  # def confirm_logged_in
  #   unless session[:user_id] 
  #     flash[:notice] = 'Please Log In'
  #     redirect_to(:action => 'login')
  #     return false
  #   else
  #     return true
  #   end
  # end

end
