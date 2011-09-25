class ManagersController < ApplicationController
  autocomplete :manager, :name
  
  def search
  end
  
  def index
    @managers = Manager.all
  end

  def show
    @manager = Manager.find(params[:id])
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(params[:manager])
    if @manager.save
      redirect_to @manager, :notice => "Successfully created manager."
    else
      render :action => 'new'
    end
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])
    if @manager.update_attributes(params[:manager])
      redirect_to @manager, :notice  => "Successfully updated manager."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy
    redirect_to managers_url, :notice => "Successfully destroyed manager."
  end
end
