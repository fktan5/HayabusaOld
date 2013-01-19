# -*- encoding : utf-8 -*-
class AddVisibleToSite < ActiveRecord::Migration
  def change
    add_column :sites, :visible, :boolean
  end
end
