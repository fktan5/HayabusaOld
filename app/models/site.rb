# -*- encoding : utf-8 -*-
class Site < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title, :url, :comment, :visible, :img_src
	validates_presence_of :title, :url, :message => "U must input"
  
  def validate_on_create
  end

  def validate_on_update
  end
end
