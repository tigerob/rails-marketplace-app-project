class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_listing, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :define_form_variables, only: [:new, :edit]
  
  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
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
    @listing.update(listing_params)
    if @listing.save
        redirect_to @listing, notice: "You have successfully updated the listing"
    else
      define_form_variables
      render "edit", alert: "Error creating listing. Ensure all fields are filled out correctly."
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path, notice: "You have successfully deleted the listing"
  end

  private

  def define_listing
    @listing = Listing.find(params[:id])
  end

  def authorize_user
    unless @listing.user_id == current_user.id
      redirect_to listings_path, alert: "You are not authorised to access that page"
    end
  end

  def define_form_variables
    @categories = Category.all
    @conditions = Listing.conditions.keys
  end
  
  def listing_params
    params.require(:listing).permit(:title, :description, :price, :condition, :postcode, :brand, :model, :finish, :capacity, :height, :width, :depth, :energy_efficiency, :category_id, :photo)
  end
end