class ChangeBlogsColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :title, :string
    add_column :blogs, :text, :text
    remove_column :blogs, :content, :text
  end
end
