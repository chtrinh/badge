class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.auth(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combo."
      render 'new'
    else
      session[:user_id] = user.id
      redirect_to user
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
