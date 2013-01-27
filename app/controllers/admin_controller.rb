# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
	http_basic_authenticate_with :name => "ore", :password => "ore100"
	
	def index
		@sites = Site.all
	end

	def new
	end

	def edit
		@site = Site.find_by_id params[:id]
	end

	def save
		params_site = params[:site]
		site = Site.find_by_id params_site[:id]

		if site == nil
			site = Site.new
		end

		site.title 	 = params_site[:title]
		site.url     = params_site[:url]
		site.comment = params_site[:comment]
		site.img_src = params_site[:img_src]
		site.visible = params_site[:visible]

		if site.valid?
			site.save!
		end		

		redirect_to :action => "index"
	end

	def delete
		site = Site.find_by_id params[:id]
		site.delete
		redirect_to :action => :index
	end
end
