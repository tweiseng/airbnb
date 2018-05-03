class UpdateListings2 < ActiveRecord::Migration[5.0]
  def change
  	change_table :listings do |t|
  		t.timestamps
  	end
  end
end
