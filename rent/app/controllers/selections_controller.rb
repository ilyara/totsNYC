class SelectionsController < ApplicationController
  def index
    @selections = Selection.all
  end

  def show
    @selection = Selection.find(params[:id])
  end

  def new
    @selection = Selection.new
  end

  def create
    @selection = Selection.new(params[:selection])
    if @selection.save
      redirect_to @selection, :notice => "Successfully created selection."
    else
      render :action => 'new'
    end
  end

  def edit
    @selection = Selection.find(params[:id])
  end

  def update
    @selection = Selection.find(params[:id])
    if @selection.update_attributes(params[:selection])
      redirect_to @selection, :notice  => "Successfully updated selection."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @selection = Selection.find(params[:id])
    @selection.destroy
    redirect_to selections_url, :notice => "Successfully destroyed selection."
  end
end
