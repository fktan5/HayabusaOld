# -*- encoding : utf-8 -*-
class AddCommentToSite < ActiveRecord::Migration
  def change
    add_column :sites, :comment, :string
  end
end
