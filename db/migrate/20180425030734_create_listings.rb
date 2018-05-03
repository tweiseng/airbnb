class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.string :title
    	t.string :property_type
    	t.string :description
    	t.string :location
    	t.string :city
    	t.string :state
    	t.string :country
    	t.string :address
    	t.string :postcode
    	t.integer :price
    	t.integer :number_beds
    	t.integer :number_rooms
    	t.integer :number_guests
    	t.belongs_to :user, index: true

    end
  end
end
