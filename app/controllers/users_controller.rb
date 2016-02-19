class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy, :update_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, flash: { success:  "User created" }
    else
      flash[:danger] = "User not created"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, flash: { info:  "User Updated" }
    else
      flash[:danger] = "nope"
      render :edit
    end
  end

  def edit_password
    @user = User.find(params[:id])
  end

  def update_password
    if (@user.authenticate(user_params[:current_password])) && (user_params[:password] == user_params[:password_confirmation]) && @user.update(password: user_params[:password])
      redirect_to root_path, flash: { success: "Project Updated!" }
    else
      flash[:warning] = "Invalid Combination"
      render :edit_password
    end
  end

    private

      def user_params
        params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation, :current_password])
      end

      def find_user
        @user = User.find(params[:id])
      end
end
