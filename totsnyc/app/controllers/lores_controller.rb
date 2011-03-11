class LoresController < ApplicationController
  # GET /lores
  # GET /lores.xml
  def index
    @lores = Lore.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lores }
    end
  end

  # GET /lores/1
  # GET /lores/1.xml
  def show
    @lore = Lore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lore }
    end
  end

  # GET /lores/new
  # GET /lores/new.xml
  def new
    @lore = Lore.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lore }
    end
  end

  # GET /lores/1/edit
  def edit
    @lore = Lore.find(params[:id])
  end

  # POST /lores
  # POST /lores.xml
  def create
    @lore = Lore.new(params[:lore])

    respond_to do |format|
      if @lore.save
        format.html { redirect_to(@lore, :notice => 'Lore was successfully created.') }
        format.xml  { render :xml => @lore, :status => :created, :location => @lore }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lore.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lores/1
  # PUT /lores/1.xml
  def update
    @lore = Lore.find(params[:id])

    respond_to do |format|
      if @lore.update_attributes(params[:lore])
        format.html { redirect_to(@lore, :notice => 'Lore was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lore.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lores/1
  # DELETE /lores/1.xml
  def destroy
    @lore = Lore.find(params[:id])
    @lore.destroy

    respond_to do |format|
      format.html { redirect_to(lores_url) }
      format.xml  { head :ok }
    end
  end
end
