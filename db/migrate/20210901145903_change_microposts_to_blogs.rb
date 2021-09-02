class ChangeMicropostsToBlogs < ActiveRecord::Migration[6.1]
  def change    
    rename_table :microposts, :blogs
  end
end

