# -*- encoding : utf-8 -*-
class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|

      t.timestamps
    end
  end
end
