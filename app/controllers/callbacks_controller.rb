class CallbacksController < ApplicationController

  def twitter
    omniauth_data = request.env["omniauth.auth"]
    user = User.find_twitter_user(omniauth_data)
    user ||= User.create_from_twitter(omniauth_data)
    sign_in(user)
    redirect_to root_path, flash: { success: "Signed In."}
  end

  def github
    # render json: request.env["omniauth.auth"]
    omniauth_data = request.env["omniauth.auth"]
    user = User.find_github_user(omniauth_data)
    user ||= User.create_from_github(omniauth_data)
    sign_in(user)
    redirect_to root_path, flash: { success: "Signed In."}
  end

end
