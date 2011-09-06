class AvatarsController < ApplicationController
  def index
    @avatars = Avatar.all
  end

  def show
    @avatar = Avatar.find(params[:id])
    @role = @avatar.role
  end

  def new
    @avatar = Avatar.new
    @roles = Role.all.map {|role| [role.name, role.id]}
  end

  def create
    @avatar = Avatar.new(params[:avatar])
    @role = Role.find(params[:avatar[:role]])
    if @avatar.save
      redirect_to @avatar, :notice => "Successfully created avatar."
    else
      render :action => 'new'
    end
  end

  def edit
    @avatar = Avatar.find(params[:id])
  end

  def update
    @avatar = Avatar.find(params[:id])
    if @avatar.update_attributes(params[:avatar])
      redirect_to @avatar, :notice  => "Successfully updated avatar."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @avatar = Avatar.find(params[:id])
    @avatar.destroy
    redirect_to avatars_url, :notice => "Successfully destroyed avatar."
  end
end
