class CallLogsController < ApplicationController
  def index
    @call_logs = CallLog.all
  end

  def show
    @call_log = CallLog.find(params[:id])
  end

  def new
    @call_log = CallLog.new
  end

  def create
    @call_log = CallLog.new(params[:call_log])
    if @call_log.save
      redirect_to @call_log, :notice => "Successfully created call log."
    else
      render :action => 'new'
    end
  end

  def edit
    @call_log = CallLog.find(params[:id])
  end

  def update
    @call_log = CallLog.find(params[:id])
    if @call_log.update_attributes(params[:call_log])
      redirect_to @call_log, :notice  => "Successfully updated call log."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @call_log = CallLog.find(params[:id])
    @call_log.destroy
    redirect_to call_logs_url, :notice => "Successfully destroyed call log."
  end
end
