class PhoneIdsController < ApplicationController
  # GET /phone_ids
  # GET /phone_ids.json
  def index
    @phone_ids = PhoneId.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phone_ids }
    end
  end

  # GET /phone_ids/1
  # GET /phone_ids/1.json
  def show
    @phone_id = PhoneId.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phone_id }
    end
  end

  # GET /phone_ids/new
  # GET /phone_ids/new.json
  def new
    @phone_id = PhoneId.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phone_id }
    end
  end

  # GET /phone_ids/1/edit
  def edit
    @phone_id = PhoneId.find(params[:id])
  end

  # POST /phone_ids
  # POST /phone_ids.json
  def create
    @phone_id = PhoneId.new(params[:phone_id])

    respond_to do |format|
      if @phone_id.save
        format.html { redirect_to @phone_id, notice: 'Phone was successfully created.' }
        format.json { render json: @phone_id, status: :created, location: @phone_id }
      else
        format.html { render action: "new" }
        format.json { render json: @phone_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phone_ids/1
  # PUT /phone_ids/1.json
  def update
    @phone_id = PhoneId.find(params[:id])

    respond_to do |format|
      if @phone_id.update_attributes(params[:phone_id])
        format.html { redirect_to @phone_id, notice: 'Phone was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @phone_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_ids/1
  # DELETE /phone_ids/1.json
  def destroy
    @phone_id = PhoneId.find(params[:id])
    @phone_id.destroy

    respond_to do |format|
      format.html { redirect_to phone_ids_url }
      format.json { head :ok }
    end
  end
end
