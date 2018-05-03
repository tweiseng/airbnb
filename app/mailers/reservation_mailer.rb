class ReservationMailer < ApplicationMailer
	default from: 't.weiseng@gmail.com'
	def booking_email(customer, host, reservation_id)
		@customer = customer
		# @url = "localhost:3000/reservations"
		mail(to: host.email, subject: 'Welcome to My Awesome Site')
		

	end

	def welcome_email(customer, listing, reservation_id)
		@customer = customer
		@listing = listing
		# @url = "localhost:3000/reservations"
		mail(to: @customer.email, subject: 'Welcome to My Awesome Site')

	end
end
