class AddFieldsToSlides < ActiveRecord::Migration
  def change
    add_column :spree_slides, :col_klass, :string, default: 'col-sm-3'
    add_column :spree_slides, :slider_use, :boolean, default: true, index: true
  end
end
