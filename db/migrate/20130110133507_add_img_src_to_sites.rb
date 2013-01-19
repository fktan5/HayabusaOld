# -*- encoding : utf-8 -*-
class AddImgSrcToSites < ActiveRecord::Migration
  def change
    add_column :sites, :img_src, :string
  end
end
