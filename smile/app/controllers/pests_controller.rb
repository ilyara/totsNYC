class PestsController < ApplicationController
  def index
    @pests = Pest.all
  end

  def show
    @pest = Pest.find(params[:id])
  end

  def new
    @pest = Pest.new
  end

  def create
    @pest = Pest.new(params[:pest])
    if @pest.save
      redirect_to @pest, :notice => "Successfully created pest."
    else
      render :action => 'new'
    end
  end

  def edit
    @pest = Pest.find(params[:id])
  end

  def update
    @pest = Pest.find(params[:id])
    if @pest.update_attributes(params[:pest])
      redirect_to @pest, :notice  => "Successfully updated pest."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @pest = Pest.find(params[:id])
    @pest.destroy
    redirect_to pests_url, :notice => "Successfully destroyed pest."
  end
end
