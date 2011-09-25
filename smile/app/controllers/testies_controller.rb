class TestiesController < ApplicationController
  def index
    @testies = Testie.all
  end

  def show
    respond_to do |format|
      format.html
      format.svg { render :qrcode => request.url }
      format.png { render :qrcode => Time.now.localtime.to_s, :offset => 10 }
    end
  end

  def new
    @testie = Testie.new
  end

  def create
    @testie = Testie.new(params[:testie])
    if @testie.save
      redirect_to @testie, :notice => "Successfully created testie."
    else
      render :action => 'new'
    end
  end

  def edit
    @testie = Testie.find(params[:id])
  end

  def update
    @testie = Testie.find(params[:id])
    if @testie.update_attributes(params[:testie])
      redirect_to @testie, :notice  => "Successfully updated testie."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @testie = Testie.find(params[:id])
    @testie.destroy
    redirect_to testies_url, :notice => "Successfully destroyed testie."
  end
end
