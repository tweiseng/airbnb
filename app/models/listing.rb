class Listing < ApplicationRecord
	attr_accessor :pictures
	belongs_to :user
	has_many :reservations
	mount_uploaders :pictures, PictureUploader
end
