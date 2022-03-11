class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_listing, only: [:show, :edit, :update, :destroy]
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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def define_listing
    @listing = Listing.find(params[:id])
  end

  def define_form_variables
    @categories = Category.all
    @conditions = Listing.conditions.keys
  end
end