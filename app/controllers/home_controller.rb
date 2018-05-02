class HomeController < ApplicationController

  def home
    @listings = Listing.all#.paginate(:page => params[:page], :per_page => 5)
  end


end
