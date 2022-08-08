class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to "/books/#{@book.id}"
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
  end

  def edit
  end

  def update
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
