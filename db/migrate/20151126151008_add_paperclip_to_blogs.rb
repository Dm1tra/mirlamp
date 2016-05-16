class AddPaperclipToBlogs < ActiveRecord::Migration
  def change
    add_attachment :spree_blogs, :image
  end
end
