class BooksController < ApplicationController
   before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to @book
    else
    @user = current_user
    render :index
    end

  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end



  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def authorize_post_edit
    unless current_user == @post.user
      flash[:error] = "You are not authorized to edit this post."
      redirect_to root_path
    end
  end



  def book_params
    params.require(:book).permit(:title, :body, :image)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to '/books'
    end
  end
end