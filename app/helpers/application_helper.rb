module ApplicationHelper
  def collection_cache_key_for(model)
    klass = ('Spree::' + model.to_s.capitalize).constantize
    count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{model.to_s.pluralize}/collection-#{count}-#{max_updated_at}"
  end

  def og_image
    request.protocol + request.host_with_port + @blog.image.url(:large)
  end

  def get_instagram_images
    response = HTTParty.get('https://api.instagram.com/v1/users/self/media/recent/?access_token=2323479556.2a8b41b.82f3fcdde1884e10895be8e7462bf586')
    response['data']
  end

  def variant_price(variant)
    if Spree::Config[:show_variant_full_price]
      variant_full_price(variant)
    else
      variant_price_diff(variant)
    end
  end

  # returns the formatted price for the specified variant as a difference from product price
  def variant_price_diff(variant)
    variant_amount = variant.amount_in(current_currency)
    product_amount = variant.product.amount_in(current_currency)
    return if variant_amount == product_amount || product_amount.nil?
    diff   = variant.amount_in(current_currency) - product_amount
    amount = Spree::Money.new(diff.abs, currency: current_currency).to_html
    label  = diff > 0 ? :add : :subtract
    "(#{Spree.t(label)}: #{amount})".html_safe
  end

  # returns the formatted full price for the variant, if at least one variant price differs from product price
  def variant_full_price(variant)
    product = variant.product
    unless product.variants.active(current_currency).all? { |v| v.price == product.price }
      Spree::Money.new(variant.price, { currency: current_currency }).to_html
    end
  end

  # converts line breaks in product description into <p> tags (for html display purposes)
  def product_description(product)
    if Spree::Config[:show_raw_product_description]
      raw(product.description)
    else
      raw(product.description.gsub(/(.*?)\r?\n\r?\n/m, '<p>\1</p>'))
    end
  end

  def line_item_description(variant)
    ActiveSupport::Deprecation.warn "line_item_description(variant) is deprecated and may be removed from future releases, use line_item_description_text(line_item.description) instead.", caller

    line_item_description_text(variant.product.description)
  end

  def line_item_description_text description_text
    if description_text.present?
      truncate(strip_tags(description_text.gsub('&nbsp;', ' ').squish), length: 100)
    else
      Spree.t(:product_has_no_description)
    end
  end

  def cache_key_for_products
    count = @products.count
    max_updated_at = (@products.maximum(:updated_at) || Date.today).to_s(:number)
    products_cache_keys = "spree/products/all-#{params[:page]}-#{max_updated_at}-#{count}"
    (common_product_cache_keys + [products_cache_keys]).compact.join("/")
  end

  def cache_key_for_product(product = @product)
    (common_product_cache_keys + [product.cache_key, product.possible_promotions]).compact.join("/")
  end

  def available_status(product) # will return a human readable string
    return Spree.t(:discontinued)  if product.discontinued?
    return Spree.t(:deleted)  if product.deleted?

    if product.available?
      Spree.t(:available)
    elsif product.available_on && product.available_on.future?
      Spree.t(:pending_sale)
    else
      Spree.t(:no_available_date_set)
    end
  end

  def link_to_cart(text = nil)
    text = text ? h(text) : Spree.t('cart')
    css_class = nil

    if simple_current_order.nil? or simple_current_order.item_count.zero?
      text = "<span class='glyphicon glyphicon-shopping-cart'></span> (#{Spree.t('empty')})"
      css_class = 'empty'
    else
      text = "<span class='glyphicon glyphicon-shopping-cart'></span> (#{simple_current_order.item_count})  <span class='amount'>#{simple_current_order.display_total.to_html}</span>"
      css_class = 'full'
    end

    link_to text.html_safe, spree.cart_path, class: "cart-info #{css_class}"
  end

  private

  def common_product_cache_keys
    [I18n.locale, current_currency]
  end
end
