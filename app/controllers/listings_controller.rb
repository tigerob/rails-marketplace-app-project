class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :define_listing, only: [:show, :edit, :update, :destroy]
  
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
end