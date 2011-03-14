class KukasController < ApplicationController
  # GET /kukas
  # GET /kukas.xml
  def index
    @kukas = Kuka.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kukas }
    end
  end

  # GET /kukas/1
  # GET /kukas/1.xml
  def show
    @kuka = Kuka.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kuka }
    end
  end

  # GET /kukas/new
  # GET /kukas/new.xml
  def new
    @kuka = Kuka.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kuka }
    end
  end

  # GET /kukas/1/edit
  def edit
    @kuka = Kuka.find(params[:id])
  end

  # POST /kukas
  # POST /kukas.xml
  def create
    @kuka = Kuka.new(params[:kuka])

    respond_to do |format|
      if @kuka.save
        format.html { redirect_to(@kuka, :notice => 'Kuka was successfully created.') }
        format.xml  { render :xml => @kuka, :status => :created, :location => @kuka }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kuka.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kukas/1
  # PUT /kukas/1.xml
  def update
    @kuka = Kuka.find(params[:id])

    respond_to do |format|
      if @kuka.update_attributes(params[:kuka])
        format.html { redirect_to(@kuka, :notice => 'Kuka was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kuka.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kukas/1
  # DELETE /kukas/1.xml
  def destroy
    @kuka = Kuka.find(params[:id])
    @kuka.destroy

    respond_to do |format|
      format.html { redirect_to(kukas_url) }
      format.xml  { head :ok }
    end
  end
end
