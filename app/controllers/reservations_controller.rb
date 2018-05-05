class ReservationsController < ApplicationController
	def new
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new
	end

	def index
		@reservations = Reservation.all
	end

	def create
		# @listing = Listing.find(params[:id])
		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:listing_id]
		reservation = Reservation.where(listing_id: params[:listing_id])
		if reservation == []
			# byebug
			@reservation.save
			redirect_to braintree_new_path(reservation: @reservation)
		else
			count =0
			roll = -1
			while count<reservation.length && roll ==-1 do
				if @reservation.checkin < reservation[count].checkout && @reservation.checkout >reservation[count].checkin 
					flash[:notice] = "Sorry. You stupid person these dates have been booked."
					roll =1
					redirect_to :back
					
				elsif roll ==-1 && count == reservation.length-1
					# byebug
					@reservation.save
					redirect_to braintree_new_path(reservation: @reservation)
				end
				 count+=1
			end
		end
		if @reservation.save
			x = Listing.find(params[:listing_id])
			ReservationJob.perform_later(current_user, User.find(x.user_id),x, @reservation.id)

		end
	end

private
	def reservation_params
      params.require(:reservation).permit(:checkin, :checkout, :number_guests)
    end

	
end