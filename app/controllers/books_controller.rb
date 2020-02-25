class BooksController < ApplicationController

  def top
	
  end
  
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "Book was successfully created."
       redirect_to book_path(@book.id)
    else
      @books = Book.all
      render action: :index
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @users = User.all
    @user = current_user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        flash[:notice] = "Book was successfully updated."
         redirect_to book_path(@book.id)
      else
        render action: :edit
      end
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
end
