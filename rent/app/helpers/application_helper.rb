module ApplicationHelper
  def map_url
    gmap_base = 'http://maps.googleapis.com/maps/api/staticmap?&size=512x512&maptype=roadmap&sensor=false'
    marker_base = "&markers="
    markers = Building.all.collect {|b| [b.latitude, b.longitude].join(',')} .join('|')
    gmap_base + marker_base + markers
  end
end
