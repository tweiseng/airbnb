class HomeController < ApplicationController

  def home
  	byebug
    @listings = Listing.all.paginate(:page => params[:page], :per_page => 5)
  end


end
