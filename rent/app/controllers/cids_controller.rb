class CidsController < ApplicationController
  def index
    @cids = Cid.all
  end

  def show
    @cid = Cid.find(params[:id])
  end

  def new
    @cid = Cid.new
  end

  def create
    @cid = Cid.new(params[:cid])
    if @cid.save
      redirect_to @cid, :notice => "Successfully created cid."
    else
      render :action => 'new'
    end
  end

  def edit
    @cid = Cid.find(params[:id])
  end

  def update
    @cid = Cid.find(params[:id])
    if @cid.update_attributes(params[:cid])
      redirect_to @cid, :notice  => "Successfully updated cid."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @cid = Cid.find(params[:id])
    @cid.destroy
    redirect_to cids_url, :notice => "Successfully destroyed cid."
  end
end
