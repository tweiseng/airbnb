class UpdateListings3 < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :verification, :string
  end
end
