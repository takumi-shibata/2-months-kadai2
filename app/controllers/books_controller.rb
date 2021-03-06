class BooksController < ApplicationController
      before_action :authenticate_user!
      before_action :correct_user, only: [:edit, :update]
  def show
  	@book_id = Book.find(params[:id])
    @book = Book.new
    @user = @book_id.user
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
    @book_id = Book.find(params[:id])
    @user = @book_id.user
  	if @book.update(book_params)
  		redirect_to book_path(@book.id), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title,:body)
  end
  
  def correct_user
    book = Book.find(params[:id])
    userid = book.user
    if current_user != userid
      redirect_to books_path
    end
  end
end
