class PaymentsController < ApplicationController
    def success
        @listing = Listing.find(params[:id])
    end
end