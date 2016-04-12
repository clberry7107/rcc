class NewreleasesController < ApplicationController
  before_action :set_newrelease, only: [:show, :edit, :update, :destroy]

  def import
    Newrelease.import(params[:file])
    redirect_to newreleases_path, notice: "Products imported."
  end
  
  # GET /newreleases
  # GET /newreleases.json
  def index
    @newreleases = Newrelease.all
  end

  # GET /newreleases/1
  # GET /newreleases/1.json
  def show
  end

  # GET /newreleases/new
  def new
    @newrelease = Newrelease.new
  end

  # GET /newreleases/1/edit
  def edit
  end

  # POST /newreleases
  # POST /newreleases.json
  def create
    @newrelease = Newrelease.new(newrelease_params)

    respond_to do |format|
      if @newrelease.save
        format.html { redirect_to @newrelease, notice: 'Newrelease was successfully created.' }
        format.json { render :show, status: :created, location: @newrelease }
      else
        format.html { render :new }
        format.json { render json: @newrelease.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newreleases/1
  # PATCH/PUT /newreleases/1.json
  def update
    respond_to do |format|
      if @newrelease.update(newrelease_params)
        format.html { redirect_to @newrelease, notice: 'Newrelease was successfully updated.' }
        format.json { render :show, status: :ok, location: @newrelease }
      else
        format.html { render :edit }
        format.json { render json: @newrelease.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newreleases/1
  # DELETE /newreleases/1.json
  def destroy
    @newrelease.destroy
    respond_to do |format|
      format.html { redirect_to newreleases_url, notice: 'Newrelease was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newrelease
      @newrelease = Newrelease.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newrelease_params
      params.fetch(:newrelease, {})
    end
end
