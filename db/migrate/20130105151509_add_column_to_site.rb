# -*- encoding : utf-8 -*-
class AddColumnToSite < ActiveRecord::Migration
  def change
    add_column :sites, :title, :string
  end
end
