class AccessController < ApplicationController

  def index

  end
  def login
    # login form
    if session[:user_id]
      redirect_to(products_path)
    end
  end

  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = Customer.where(:email => params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      # mark user as logged in
      session[:is_admin]=authorized_user.is_admin
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.firstname+" "+authorized_user.lastname
      flash[:notice] = "You are now logged in."
      redirect_to(products_path)
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    # mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    session[:is_admin]=nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
end
