class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.auth(params[:session][:email], params[:session][:email])
    if user.nil?
      flash.now[:error] = "Invalid email/password combo."
      render 'new'
    else
      flash[:success] = "Welcome #{user.name}"
      redirect_to user
    end
  end
end
