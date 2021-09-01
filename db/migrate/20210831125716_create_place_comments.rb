class CreatePlaceComments < ActiveRecord::Migration[6.1]
  def change
    create_table :place_comments do |t| 
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
    add_index :place_comments, [:user_id, :place_id, :created_at]
  end
end
