Spree::Admin::SlidesController.class_eval do
  before_action :taxonomies, only: [:show]

  private

  def slide_params
    params.require(:slide).permit(
      :name, :body, :link_url, :published, :image,
      :position, :product_id, :col_klass, :slider_use)
  end
end
