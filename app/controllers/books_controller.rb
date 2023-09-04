class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = User.find(@book.user_id)
  end

  def index
    @newbook = Book.new
    @books = Book.all
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title ,:body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id ==current_user.id
      redirect_to books_path
    end
  end
end
