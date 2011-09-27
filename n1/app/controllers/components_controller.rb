class ComponentsController < ApplicationController
  def index
    component_name = params[:component].gsub("::", "_").underscore
    render :inline => "<% title 'Testing', false %><%= netzke :#{component_name}, :class_name => '#{params[:component]}', :height => 400 %>", :layout => true
  end
end
