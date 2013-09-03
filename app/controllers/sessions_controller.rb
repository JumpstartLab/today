require './lib/github'

class SessionsController < ApplicationController

  def new
    redirect_to Github.login_url
  end

  def show
  end

  def destroy
    logout
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end

  def callback
    unless params[:code]
      flash[:error] = "We didn't receive any authentication code from GitHub."
    end

    begin
      user = Authentication.perform(params[:code])
      login(user)
    rescue => e
      logger.warn e
      flash[:error] = "We're having trouble with logins right now. Please come back later."
    end

    if current_user.guest?
      flash[:error] = "We're having trouble with logins right now. Please come back later."
    end

    if current_user.admin?
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
