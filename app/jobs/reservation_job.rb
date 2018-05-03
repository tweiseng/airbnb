class ReservationJob < ApplicationJob
  queue_as :default

  def perform(customer, host, listing, reservation_id)
  	ReservationMailer.booking_email(customer, host, reservation_id).deliver_now
  	ReservationMailer.welcome_email(customer,listing, reservation_id).deliver_now
    # Do something later
  end
end
