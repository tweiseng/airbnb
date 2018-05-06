class ConfirmationJob < ApplicationJob
  queue_as :default
	def perform(host, reservation_id)
	  	ReservationMailer.payment_confirm(host,reservation_id).deliver_now
	end

end
