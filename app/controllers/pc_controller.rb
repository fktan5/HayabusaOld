class PcController < ApplicationController
	require 'builder/xmlmarkup'
  include Jpmobile::ViewSelector
  def index
    @sites = Site.find_all_by_visible true, :order => "id ASC"
  end

  def sitemap
  	urls = []
  	
  	urls << "http://#{request.host_with_port}/"
  	urls << "http://#{request.host_with_port}/about"

  	xml = Builder::XmlMarkup.new
  	xml.instruct!(:xml, :encoding => "UTF-8")
  	xml.urlset(:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9") do
  		urls.each do |url|
  			xml.url do
  				xml.loc url
  				xml.lastmod Date.today.strftime("%Y-%m-%d")
  				xml.changefreq "daily"
  			end
  		end
  	end
  render :xml => xml.target!
  end
end

