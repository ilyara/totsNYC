class KukusController < ApplicationController
  # GET /kukus
  # GET /kukus.xml
  def index
    @kukus = Kuku.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kukus }
    end
  end

  # GET /kukus/1
  # GET /kukus/1.xml
  def show
    @kuku = Kuku.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kuku }
    end
  end

  # GET /kukus/new
  # GET /kukus/new.xml
  def new
    @kuku = Kuku.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kuku }
    end
  end

  # GET /kukus/1/edit
  def edit
    @kuku = Kuku.find(params[:id])
  end

  # POST /kukus
  # POST /kukus.xml
  def create
    @kuku = Kuku.new(params[:kuku])

    respond_to do |format|
      if @kuku.save
        format.html { redirect_to(@kuku, :notice => 'Kuku was successfully created.') }
        format.xml  { render :xml => @kuku, :status => :created, :location => @kuku }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kuku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kukus/1
  # PUT /kukus/1.xml
  def update
    @kuku = Kuku.find(params[:id])

    respond_to do |format|
      if @kuku.update_attributes(params[:kuku])
        format.html { redirect_to(@kuku, :notice => 'Kuku was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kuku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kukus/1
  # DELETE /kukus/1.xml
  def destroy
    @kuku = Kuku.find(params[:id])
    @kuku.destroy

    respond_to do |format|
      format.html { redirect_to(kukus_url) }
      format.xml  { head :ok }
    end
  end
end
