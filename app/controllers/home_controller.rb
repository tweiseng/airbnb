class HomeController < ApplicationController

  def home
  	# byebug
    @listings = Listing.where(verification: "yes").paginate(:page => params[:page], :per_page => 5)
    @listingsAll = Listing.all.paginate(:page => params[:page], :per_page => 5)
  end


end
