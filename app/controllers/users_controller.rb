class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,only: [:edit, :destroy,:update]

 def show
    @users = User.all
    @user = User.find(params[:id])
    @books= @user.books
    @book = Book.new
  end
  def edit
        @user = User.find(params[:id])
    end

  def update
    flash[:notice] = "You have updated user successfully."
    @user = User.find(params[:id])
    if @user.update(user_params)

    redirect_to user_path(@user.id)
    else 
      render :edit
  end
  end


     def index
    @users=User.all
     @user=current_user
     @new_book=Book.new
  end
  private
   def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user)
    end
  end
 



  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
  end
end





