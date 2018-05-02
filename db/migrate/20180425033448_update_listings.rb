class UpdateListings < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :listings, :title, false
  	change_column_null :listings, :property_type, false
  	change_column_null :listings, :description, false
  	change_column_null :listings, :location, false
  	change_column_null :listings, :city, false
  	change_column_null :listings, :state, false
  	change_column_null :listings, :country, false
  	change_column_null :listings, :address, false
  	change_column_null :listings, :postcode, false
  	change_column_null :listings, :price, false
  end

end
