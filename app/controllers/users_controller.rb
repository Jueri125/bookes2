class UsersController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])

  end

 def update
   @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end

 end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id

    if @user.save
    flash[:notic] = "User successfully created."
    redirect_to user_path
    else
    render :new
    end

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @users = User.all

  end


  def index
    @users = User.all
    @books = Book.all
    @user = current_user
    @book = Book.new
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def authorize_user_edit
    unless current_user == @user
      flash[:error] = "You are not authorized to edit this user."
      redirect_to root_path
    end
  end

end