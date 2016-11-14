class SubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_subscriber, only: [:show, :edit, :edit_subscriptions, :update, :destroy]


  def import
    @errors = Array.new
    Relationship.delete_all
    SubscribersBook.delete_all
    Subscriber.delete_all
    Subscriber.import(params[:file]).each do |subscriber|
      subscriber.save validate: false
    end
    
    @subscribers = Subscriber.all.order('last_name ASC')
    render :index
  end
  
  # GET /subscribers
  # GET /subscribers.json
  def index
    
    session[:request_page] = subscribers_path
    authorize! :view, @user
    @search = Subscriber.search(params[:q])
    @search.sorts = "last_name asc"
    @subscribers = @search.result
    @total_subscribers = Subscriber.count
    @per_page = params[:per_page] || 5
    @subscribers = @subscribers.paginate(:page => params[:page], :per_page => @per_page)
  end

  # GET /subscribers/1
  # GET /subscribers/1.json
  def show
    respond_to :html, :json
    session[:request_page] = subscriber_path(@subscriber)
  end

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
    @subscriber.index = (Subscriber.maximum(:index)) + 1
  end

  # GET /subscribers/1/edit
  def edit
  end
  
  def edit_subscriptions
    
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.new(subscriber_params)
    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to @subscriber, notice: 'Subscriber was successfully created.' }
        format.json { render :show, status: :created, location: @subscriber }
      else
        @subscriber.index = (Subscriber.maximum(:index)) + 1
        format.html { render :new }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscribers/1
  # PATCH/PUT /subscribers/1.json
  def update
    
    if params[:reactivate] == "true"
      @subscriber.active = "true"
      @subscriber.save
      
      @subscriber.subscribers_books.each do |sb|
        sb.quantity = 1
        sb.save
      end
      

      redirect_to session[:request_page], notice: 'Subscriber has been reactivated.'
      return
    end
    
    if params[:commit]
      respond_to do |format|
        if @subscriber.update(subscriber_params)
          format.html { redirect_to @subscriber, notice: 'Subscriber was successfully updated.' }
          format.json { render :show, status: :ok, location: @subscriber }
        else
          format.html { render :edit }
          format.json { render json: @subscriber.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to subscriber_path(@subscriber), notice: 'Edit canceled.'
    end
  end

  # DELETE /subscribers/1
  # DELETE /subscribers/1.json
  def destroy
    @subscriber.update(active: :false)
    respond_to do |format|
      format.html { redirect_to session[:request_page], notice: 'Subscriber is now inactive.' }
      format.json { head :no_content }
    end
    @subscriber.subscribers_books.each do |subscription|
      subscription.quantity = 0
      subscription.save
    end
    relations = Relationship.where("name_index = ?", @subscriber.index)
    relations.each do |relation|
      relation.quantity = 0
      relation.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end
    
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:first_name,:last_name, :email, :address,:city,:state,:zip,:home_phone,:work_phone,:mobile_phone,:mail_list,:subscriber_type, :notes, :active, :q)
    end
end
