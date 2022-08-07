class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user[:id])
  end

  def update
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
