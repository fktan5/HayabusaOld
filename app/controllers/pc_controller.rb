class PcController < ApplicationController
  def index
    @sites = Site.find_all_by_visible(true)
  end
end
