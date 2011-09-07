class PlayDatesController < ApplicationController
  # GET /play_dates
  # GET /play_dates.json
  def index
    @play_dates = PlayDate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @play_dates }
    end
  end

  # GET /play_dates/1
  # GET /play_dates/1.json
  def show
    @play_date = PlayDate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @play_date }
    end
  end

  # GET /play_dates/new
  # GET /play_dates/new.json
  def new
    @play_date = PlayDate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @play_date }
    end
  end

  # GET /play_dates/1/edit
  def edit
    @play_date = PlayDate.find(params[:id])
  end

  # POST /play_dates
  # POST /play_dates.json
  def create
    @play_date = PlayDate.new(params[:play_date])

    respond_to do |format|
      if @play_date.save
        format.html { redirect_to @play_date, notice: 'Play date was successfully created.' }
        format.json { render json: @play_date, status: :created, location: @play_date }
      else
        format.html { render action: "new" }
        format.json { render json: @play_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /play_dates/1
  # PUT /play_dates/1.json
  def update
    @play_date = PlayDate.find(params[:id])

    respond_to do |format|
      if @play_date.update_attributes(params[:play_date])
        format.html { redirect_to @play_date, notice: 'Play date was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @play_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /play_dates/1
  # DELETE /play_dates/1.json
  def destroy
    @play_date = PlayDate.find(params[:id])
    @play_date.destroy

    respond_to do |format|
      format.html { redirect_to play_dates_url }
      format.json { head :ok }
    end
  end
end
