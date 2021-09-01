class AddNameToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :name, :string
  end
end
