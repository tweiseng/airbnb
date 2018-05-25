class ListingsController < ApplicationController


  def listings
    # byebug
    if params[:query]
      @listings = Listing.where(verification: "yes")
      @listings = @listings.where('location LIKE?', "%#{params[:query]}%")
      # @listings = @listings.where('title LIKE?', "%#{params[:search]}%") 
      # @listings = @listings.where('city LIKE?', "%#{params[:search]}%")
      @listings = @listings.where('country LIKE?',"%#{params[:query]}%")
      if params[:price] && params[:price1] 
        @listings = @listings.where(price: params[:price]..params[:price1])
      end
    elsif params[:query] =""
      if params[:price] && params[:price1]
        @listings = Listing.where(verification: "yes")
        @listings = @listings.where(price: params[:price]..params[:price1])
      end
    else
      
      @listings = Listing.where(verification: "yes").paginate(:page => params[:page], :per_page => 5)
      @listingsAll = Listing.all.paginate(:page => params[:page], :per_page => 5)

    end
  end

  # def search
  #   p params
  #   @location = Listing.where('location LIKE?', "%#{params[:query]}%")
  #   @title = Listing.where('title LIKE?', "%#{params[:query]}%") 
  #   @city = Listing.where('city LIKE?', "%#{params[:query]}%")
  #   @country = Listing.where('country LIKE?', "%#{params[:query]}%")
  #   @min_max = Listing.where(price: params[:price]..params[:price1])
     
  #     render json: @location 

  
  # end 

   def destroy
    # if allowed?(action: "listing_destroy", user: @listing.user)
      @listing.destroy
      respond_to do |format|
        format.js 
        format.html { redirect_to listings_url, :flash => { :success => 'Listing was successfully destroyed.' } }
        # format.json { head :no_content }
      end
    # end
  end

  def carousel
    @listing = Listing.find(params[:id])
  end

  # GET /listings/1
  # GET /listings/1.json
  def list
    @listing = Listing.find(params[:id])
  end

  def verify
    @listing = Listing.find(params[:id])
    # byebug
      if @listing.verification == "no" || @listing.verification ==nil
          @listing.verification = "yes"
          @listing.save
          redirect_to:"listings"
      else
        @listing.verification = "no"
        @listing.save
        redirect_to:"listings"
      end
  end


  # GET /listings/new
  def new
    if !signed_in?
      flash[:notice] = "You need to be signed in to create a listing"
      redirect_to :back
    end
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
    if current_user.id != @listing.user_id
       flash[:notice] = "Sorry. You are not allowed to perform this action."
        return redirect_to :back, notice: "Sorry. You do not have the permission to edit this property."
      end

  end

  def picdel
    # byebug
    @listing = Listing.find(params[:id])
    @listing['pictures'].delete_at(params[:i].to_i)
    @listing.save
    render :edit
  end
  # POST /listings
  # POST /listings.json
  def create
    # byebug
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    # byebug
    @listing = Listing.find(params[:id])
    if params[:listing][:pictures]!= nil
      @listing.pictures += params[:listing][:pictures]
    end
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title, :location, :property_type, :number_rooms, :number_beds, 
        :number_guests, :country, :state, :city, :postcode, :address, :price, :description, :user_id)
    end
end

 




