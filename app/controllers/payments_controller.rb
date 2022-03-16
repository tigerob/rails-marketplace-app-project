class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
        # Capture the specific listing determined by parameter id
        @purchase = Purchase.find_by(listing_id: params[:id])
    end

    def webhook
        # Verify transaction with Stripe 'signing secret', construct Stripe payment event, and raise exceptions for errors
        begin
            payload = request.raw_post
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

        # Retrieve key purchase information for payment event
        payment_intent_id = event.data.object.payment_intent
        payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
        listing_id = payment.metadata.listing_id
        @listing = Listing.find(listing_id)
        buyer_id = payment.metadata.user_id
        seller_id = @listing.user_id
        receipt_url = payment.charges.data[0].receipt_url

        # Update listing to sold
        @listing.update(sold: true)

        # Create a record through Purchase model in order to track key purchase information
        Purchase.create(listing_id: listing_id, buyer_id: buyer_id, seller_id: seller_id, payment_id: payment_intent_id, receipt_url: receipt_url)
    end
end