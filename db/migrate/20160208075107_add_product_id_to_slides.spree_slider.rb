# This migration comes from spree_slider (originally 20121219124126)
class AddProductIdToSlides < ActiveRecord::Migration
  def change
    add_column :spree_slides, :product_id, :integer
  end
end
