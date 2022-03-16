class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_listing, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :define_form_variables, only: [:new, :edit]
  
  def index
    # Capture all records in the listings table by querying the listings table through the Listing model
    @listings = Listing.all
  end

  def show
    # Create Stripe session, capture certain payment data, and set up redirect URLs
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user && current_user.email,
      line_items: [
        {
          name: @listing.title,
          description: @listing.description,
          amount: @listing.price,
          currency: 'aud',
          quantity: 1
        }
      ],
      payment_intent_data: {
        metadata: {
          user_id: current_user && current_user.id, 
          listing_id: @listing.id
        }
      },
      success_url: "#{root_url}payments/success/#{@listing.id}",
      cancel_url: root_url
    )

    # Capture Stripe session id
    @session_id = session.id

  end

  def new
    # Create new record in listings table by querying the listings table through the Listing model
    @listing = Listing.new
  end

  def create
    # Create new record in listings table under the current_user (as defined by the Devise gem) and alert user of any error creating the listing
    @listing = current_user.listings.new(listing_params)
    if @listing.save
        redirect_to @listing, notice: "You have successfully created a listing"
    else
      define_form_variables
      render "new", alert: "Error creating listing. Ensure all fields are filled out correctly."
    end
  end

  def edit
  end

  def update
    # Update record in listings table and alert user of any error updating the listing
    @listing.update(listing_params)
    if @listing.save
        redirect_to @listing, notice: "You have successfully updated the listing"
    else
      define_form_variables
      render "edit", alert: "Error creating listing. Ensure all fields are filled out correctly."
    end
  end

  def destroy
    # Delete listing
    @listing.destroy
    redirect_to listings_path, notice: "You have successfully deleted the listing"
  end

  private

  def define_listing
    # Capture the specific listing determined by parameter id
    @listing = Listing.find(params[:id])
  end

  def authorize_user
    # Prevent unauthorized users from accessing edit, update and destroy actions (utilising a before_action)
    unless @listing.user_id == current_user.id
      redirect_to listings_path, alert: "You are not authorised to access that page"
    end
  end

  def define_form_variables
    # Capture (for use in the form): (1) all records in the categories table by querying the categories table through the Category model; (2) the keys of the 'condition' enum that is set in the Listing model by querying the Listing model; and (3) all records in the features table by querying the features table through the Feature model
    @categories = Category.all
    @conditions = Listing.conditions.keys
    @features = Feature.all
  end
  
  def listing_params
    # Whitelist acceptable parameters for a listing
    params.require(:listing).permit(:title, :description, :price, :condition, :postcode, :brand, :model, :finish, :capacity, :height, :width, :depth, :energy_efficiency, :category_id, :photo, feature_ids: [])
  end
end