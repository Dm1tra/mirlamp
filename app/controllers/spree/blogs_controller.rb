module Spree
  class BlogsController < Spree::StoreController
    before_filter :taxonomies

    def index
      @title = t('blogs.index.title')
    end

    def show
      @blog = Blog.find(params[:id])
      @title = @blog.seo_title
    end

    private

    def taxonomies
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end
  end
end
