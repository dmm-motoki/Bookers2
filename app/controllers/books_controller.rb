class BooksController < ApplicationController
  before_action :is_current_user, only: [:edit, :update]
  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
      redirect_to "/books/#{@book.id}"
      flash[:notice] = "You have created book successfully."
    else
      render 'index'
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_current_user
    @book = Book.find(params[:id])
    @user = @book.user
    if @user != current_user
      redirect_to books_path
    end
  end
end
