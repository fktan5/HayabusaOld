# -*- encoding : utf-8 -*-
class AddUrlToSite < ActiveRecord::Migration
  def change
    add_column :sites, :url, :string
  end
end
