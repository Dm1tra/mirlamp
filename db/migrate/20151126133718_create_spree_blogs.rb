class CreateSpreeBlogs < ActiveRecord::Migration
  def change
    create_table :spree_blogs do |t|
      t.string :title
      t.string :slug, unique: true
      t.text :body
      t.string :image
      t.string :seo_title
      t.text :meta_keywords
      t.text :meta_description

      t.timestamps null: false
    end
  end
end
