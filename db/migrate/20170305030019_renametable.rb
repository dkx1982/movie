class Renametable < ActiveRecord::Migration[5.0]
  def change
    rename_column :groups, :decription, :description
  end
end
