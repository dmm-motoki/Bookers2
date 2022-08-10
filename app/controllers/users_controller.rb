class UsersController < ApplicationController
  before_action :is_current_user, only: [:edit, :update]
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_current_user
    @user = User.find(params[:id])
    @book = @user.books
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end
end
