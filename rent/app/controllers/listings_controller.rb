class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new(:status => Status.listing_status.first)
#    @listing.status = Status.
  end

  def create
    @listing = Listing.new(params[:listing])
    @listing.current_step = session[:listing_step]
    
    if @listing.current_step == 'building'
      @coordinates = Geocoder.coordinates @listing.address_geo
      @building = Building.where(:latitude => @coordinates[0], :longitude => @coordinates[1]).first
      if @building
        @listing.building = @building
        @listing.next_step 
      end
    elsif @listing.last_step?
      create_finalize
    else
      @listing.next_step
    end
    
    session[:listing_step] = @listing.current_step 
    flash.now[:notice]  = @listing.current_step
    render :action => 'new'
  end

  def create_finalize
    if @listing.save
      redirect_to @listing, :notice => "Successfully created listing."
    else
      render :action => 'new'
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(params[:listing])
      redirect_to @listing, :notice  => "Successfully updated listing."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_url, :notice => "Successfully destroyed listing."
  end
end
