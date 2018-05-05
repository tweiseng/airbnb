class BraintreeController < ApplicationController
  def new
  @client_token = Braintree::ClientToken.generate
  @reservation = Reservation.find(params[:reservation])
  
  
end

def checkout
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  reservation = Reservation.find(params[:reservation_id])
  listing = reservation.listing
  total = listing.price * (reservation.checkout - reservation.checkin)
  byebug
  result = Braintree::Transaction.sale(
   :amount => (total.numerator).to_s, #this is currently hardcoded
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

  if result.success?
    # redirect_to :back, :flash => { :success => "Transaction successful!" }
    flash[:notice] = "Transaction successful"
    redirect_to :root

    ReservationMailer.payment_confirm(listing.user, reservation.id).deliver_now
  else
    # redirect_to :back, :flash => { :error => "Transaction failed. Please try again." }
    flash[:notice] = "Transaction failed. Please try again"
    redirect_to :root
  end
end

end
