class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_to root_path, flash: { success: "Authenticated ^_^" }
    else
      flash[:warning] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { danger: "Logged out"}
  end

end
