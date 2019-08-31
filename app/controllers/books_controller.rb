class BooksController < ApplicationController
   before_action :authenticate_user!
  before_action :ensure_correct_user,only: [:edit, :destroy,:update]
  def show
     @book = Book.find(params[:id])
     @new_book=Book.new
     @user=current_user
     @user=User.all
  end
  def edit
      @book = Book.find(params[:id])
  end
  def index
     @new_book=Book.new
     @user=current_user
     @books=Book.all
  end
  def create
        flash[:notice] = "You have creatad book successfully"
        @new_book = Book.new(book_params)
        @new_book.user_id = current_user.id
        if @new_book.save
        redirect_to book_path(@new_book.id)
        else
          flash[:notice] = "error"
          @user=current_user
          @books=Book.all
          render :index
        end

  end
  def new
    @book= Book.new

  end
  def update
  
       @book = Book.find(params[:id])
    if @book.update(book_params)
         flash[:notice] = "You have updated book successfully."

    redirect_to book_path(@book.id)
    else 
       flash[:notice] = "error"
      render :edit
  end
  end



  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  private

   def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end

    def book_params
      params.require(:book).permit(:title, :body,:profile_image)
    end
end
