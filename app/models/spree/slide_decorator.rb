Spree::Slide.class_eval do
  scope :published, -> { where(published: true, slider_use: true).order('position ASC') }
  scope :banners, -> { where(published: true, slider_use: false).order('position ASC') }
end
