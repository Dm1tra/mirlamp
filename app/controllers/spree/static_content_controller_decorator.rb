Spree::StaticContentController.class_eval do
  before_action :taxonomies, only: [:show]

  private

  def taxonomies
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end
end
