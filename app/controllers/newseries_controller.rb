class NewseriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_newseries, only: [:show, :edit, :update, :destroy]


  def import
    Newseries.import(params[:file])
    redirect_to newseries_index_path, notice: "Products imported."
  end
  
  # GET /newseries
  # GET /newseries.json
  def index
    @newseries = Newseries.all
  end

  # GET /newseries/1
  # GET /newseries/1.json
  def show
  end

  # GET /newseries/new
  def new
    @newseries = Newseries.new
  end

  # GET /newseries/1/edit
  def edit
  end

  # POST /newseries
  # POST /newseries.json
  def create
    @newseries = Newseries.new(newseries_params)

    respond_to do |format|
      if @newseries.save
        format.html { redirect_to @newseries, notice: 'Newseries was successfully created.' }
        format.json { render :show, status: :created, location: @newseries }
      else
        format.html { render :new }
        format.json { render json: @newseries.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newseries/1
  # PATCH/PUT /newseries/1.json
  def update
    respond_to do |format|
      if @newseries.update(newseries_params)
        format.html { redirect_to @newseries, notice: 'Newseries was successfully updated.' }
        format.json { render :show, status: :ok, location: @newseries }
      else
        format.html { render :edit }
        format.json { render json: @newseries.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newseries/1
  # DELETE /newseries/1.json
  def destroy
    @newseries.destroy
    respond_to do |format|
      format.html { redirect_to newseries_index_url, notice: 'Newseries was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newseries
      @newseries = Newseries.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newseries_params
      params.fetch(:newseries, {})
    end
end
