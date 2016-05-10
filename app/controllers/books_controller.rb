class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  
  def import
    Book.delete_all
    Book.import(params[:file])
    redirect_to books_path, notice: "#{Book.count} Books imported."
  end
  
  def order_count
    @books = Array.new
    @total_quantity = 0
    
    Book.order("LOWER(title)").all.each do |book|
      @books << book unless book.subscribers.count == 0 || book.active == false
    end
    
    @books.each do |book|
      @total_quantity += book.order_quantity
    end
  end

  # GET /books
  # GET /books.json
  def index
    case params[:active] 
      when "true"
        @books = Book.all.where(active: :true).order("LOWER(title)")
      when "false"
        @books = Book.all.where(:active => false).order("LOWER(title)")
      else
        @books = Book.all.order("LOWER(title)")
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    
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
    @book.update(active: :false)
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book has been marked inactive.' }
      format.json { head :no_content }
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
