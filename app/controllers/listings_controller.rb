class ListingsController < ApplicationController


  def listings
    if params[:search]
      @listings = Listing.where('location LIKE?', "%#{params[:search]}%")
      @listings = Listing.where('title LIKE?', "%#{params[:search]}%") 
      @listings = Listing.where('city LIKE?', "%#{params[:search]}%")
      @listings = Listing.where('country LIKE?', "%#{params[:search]}%")
      if params[:price] && params[:price1] 
      @listings = Listing.where(price: params[:price]..params[:price1])
      end
    else
      @listings = Listing.all#.paginate(:page => params[:page], :per_page => 5)
    end
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

  # POST /listings
  # POST /listings.json
  def create
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
    @listing = Listing.find(params[:id])
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
        :number_guests, :country, :state, :city, :postcode, :address, :price, :description, :user_id, pictures:[])
    end
end

 




