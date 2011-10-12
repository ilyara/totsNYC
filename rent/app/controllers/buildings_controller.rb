class BuildingsController < ApplicationController
  def index
    @buildings = Building.all
    gmap_base = 'http://maps.googleapis.com/maps/api/staticmap?&size=512x512&maptype=roadmap&sensor=false'
    marker_base = "&markers="
    markers = Building.all.collect {|b| [b.latitude, b.longitude].join(',')} .join('|')
    @map_url = gmap_base + marker_base + markers
  end

  def show
    @building = Building.find(params[:id])
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(params[:building])
    if @building.save
      redirect_to @building, :notice => "Successfully created building."
    else
      render :action => 'new'
    end
  end

  def edit
    @building = Building.find(params[:id])
  end

  def update
    @building = Building.find(params[:id])
    if @building.update_attributes(params[:building])
      redirect_to @building, :notice  => "Successfully updated building."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @building = Building.find(params[:id])
    @building.destroy
    redirect_to buildings_url, :notice => "Successfully destroyed building."
  end
end
