class GadfliesController < ApplicationController
  def index
    @gadflies = Gadfly.all
  end

  def show
    @gadfly = Gadfly.find(params[:id])
  end

  def new
    @gadfly = Gadfly.new
  end

  def create
    @gadfly = Gadfly.new(params[:gadfly])
    if @gadfly.save
      redirect_to @gadfly, :notice => "Successfully created gadfly."
    else
      render :action => 'new'
    end
  end

  def edit
    @gadfly = Gadfly.find(params[:id])
  end

  def update
    @gadfly = Gadfly.find(params[:id])
    if @gadfly.update_attributes(params[:gadfly])
      redirect_to @gadfly, :notice  => "Successfully updated gadfly."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gadfly = Gadfly.find(params[:id])
    @gadfly.destroy
    redirect_to gadflies_url, :notice => "Successfully destroyed gadfly."
  end
end
