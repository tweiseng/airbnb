class AddColumnToReservations < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :checkin, :date
  	add_column :reservations, :checkout, :date
  	add_column :reservations, :number_guests, :integer
  end
end
