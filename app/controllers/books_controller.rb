class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only:[:show, :edit, :update, :destroy]
  
  def import
    Book.delete_all
    SubscribersBook.delete_all
    Book.import(params[:file])
    redirect_to books_path, notice: "#{Book.count} Books imported."
  end
  
  def order_count
    
    session[:request_page] = '/books/order_count'
    @total_quantity = 0
    
    @books = Book.includes("subscribers_books").where(active: [true,:true], subscribers_books: { quantity: 1}).order("LOWER(title)")
    
    @books.each do |book|
      @total_quantity += book.order_quantity
    end
    
    @book_count = @books.count
    @search = @books.search(params[:q])
    @books = @search.result
    if params[:first_letter]
      @books = @books.where("title LIKE ? OR title LIKE ?", params[:first_letter].downcase + '%', params[:first_letter].upcase + '%')
      @first_letter = params[:first_letter]
    end
    @per_page = params[:per_page] || 25
    @books = @books.paginate(:page => params[:page], :per_page => @per_page)
  end

  # GET /books
  # GET /books.json
  def index
    @search = Book.search(params[:q])
    @search.sorts = 'title asc'
    
    @books = @search.result
    if !params[:first_letter].blank?
      @books = Book.where("title LIKE ? OR title LIKE ?", params[:first_letter].downcase + '%', params[:first_letter].upcase + '%')
      @first_letter = params[:first_letter]
    end
    @total_books = Book.count
    @per_page = params[:per_page] || 5
    @books = @books.paginate(:page => params[:page], :per_page => @per_page)
    session[:request_page] = books_path(:first_letter => params[:first_letter], :page => params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
    session[:request_page] = book_path(@book)
  end

  # GET /books/new
  def new
    @book = Book.new
    @book.index = (Book.maximum(:index)) + 1
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if params[:reactivate] == "true"
      @book.active = true
      @book.save

      redirect_to session[:request_page], notice: "#{@book.title} has been reactivated."
      return
    end
    if params[:commit]
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to book_path(@book), notice: 'Edit canceled.'
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.update(active: :false)
      respond_to do |format|
        format.html { redirect_to session[:request_page], notice: "#{@book.title} has been marked inactive." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to session[:request_page], notice: 'An error occured while updating.  Check book details.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :index, :notes, :active, :stock_quantity)
    end
end
