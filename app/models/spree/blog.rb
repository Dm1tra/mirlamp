class Spree::Blog < ActiveRecord::Base
  include Paperclip::Glue

  default_scope { order('created_at DESC') }

  validates :title, :body, :seo_title, :meta_keywords, :meta_description, presence: true

  has_attached_file :image,
                    styles: { large: '600x600>' },
                    default_style: :large,
                    url: '/spree/blogs/:id',
                    path: ':rails_root/public/spree/blogs/:id'

  validates_attachment :image, presence: true,
                               content_type: {
                                 content_type: %w(image/jpeg image/jpg image/png image/gif)
                               }

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end
end
