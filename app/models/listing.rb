class Listing < ApplicationRecord
	attr_accessor :pictures
	belongs_to :user
	has_many :reservations
	mount_uploaders :pictures, PictureUploader
	# scope :country, -> (country) {where country: country}
	# scope :title, -> (title) {where "title like ?", "#{title}"}
	# scope :verification, -> (verification) {where verification: verification}
	# scope :city, -> (city) {where city: city}	
end
