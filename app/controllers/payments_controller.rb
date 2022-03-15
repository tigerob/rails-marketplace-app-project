class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
        @listing = Listing.find(params[:id])
    end
    def webhook
        # create Stripe event and verify transactions with Stripe 'signing secret'
        begin
            payload = request.raw_body
            header = request.headers['HTTP_STRIPE_SIGNATURE']
            endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
            event = Stripe::Webhook.construct_event(payload, header, endpoint_secret)
        rescue Stripe::SignatureVerificationError => e
            render json: {error: "Forbidden"}, status: 403
            return
        rescue JSON::ParserError => e
            render json: [error: "Bad request"], status: 400
            return
        end

        # Implement webhook
        payment_intent_id = event.data.object.payment_intent
        payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
        listing_id = payment.metadata.listing_id 
        pp payment.charges.data[0].receipt_url
        @listing = Listing.find(listing_id)
        @listing.update(sold: true)
    end
end