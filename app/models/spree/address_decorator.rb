Spree::Address.class_eval do
  def require_zipcode?
    false
  end
end
