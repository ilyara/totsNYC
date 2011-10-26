class HomeController < ApplicationController

  def index
    now = Time.now
    logger.info "Ilya: #{now}"
    @listings_available = 15
    @hour = Time.now.hour
    @viewings_today = true if Time.now.hour < 19
    @today = I18n.localize(Date.today, :format => :rakita)
    @tomorrow = I18n.t('date.day_names')[(Time.now + 1.day).wday]
    # @map_url = 'http://maps.googleapis.com/maps/api/staticmap?zoom=14&size=512x512&maptype=roadmap&markers=color:blue|label:S|40.702147,-74.015794&markers=color:green|label:G|40.711614,-74.012318&markers=color:red|color:red|label:C|40.718217,-73.998284&sensor=false'    
  end

end
