class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_relationship, only: [:show, :edit, :update, :destroy]
  
  def import
    Relationship.delete_all
    SubscribersBook.delete_all
    Relationship.import(params[:file])
    redirect_to relationships_path, notice: "#{Relationship.count} relationships imported."
  end

  # GET /relationships
  # GET /relationships.json
  def index
    if params[:sort]
      case params[:sort]
        when 'book'
          @relationships = Relationship.all.order('book_index')
        when 'subscriber'
          @relationships = Relationship.all.order('name_index')
        else
          @relationships = Relationship.all.order("created_at DESC")
      end
    else
      @relationships = Relationship.all.order("created_at DESC")
    end
  end

  # GET /relationships/1
  # GET /relationships/1.json
  def show
  end

  # GET /relationships/new
  def new
    @relationship = Relationship.new
  end

  # GET /relationships/1/edit
  def edit
  end

  # POST /relationships
  # POST /relationships.json
  def create
    @relationship = Relationship.new(relationship_params)

    respond_to do |format|
      if @relationship.save
        format.html { redirect_to @relationship, notice: 'Relationship was successfully created.' }
        format.json { render :show, status: :created, location: @relationship }
      else
        format.html { render :new }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    respond_to do |format|
      if @relationship.update(relationship_params)
        format.html { redirect_to @relationship, notice: 'Relationship was successfully updated.' }
        format.json { render :show, status: :ok, location: @relationship }
      else
        format.html { render :edit }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    SubscribersBook.where("subscriber_id = ? AND book_id = ?", Subscriber.find_by(index: @relationship.name_index).id, Book.find_by(index: @relationship.book_index)).delete_all
    @relationship.destroy
    respond_to do |format|
      format.html { redirect_to relationships_url, notice: 'Relationship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params.fetch(:relationship, {})
    end
end
