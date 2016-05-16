namespace :yandex_yml do
  task generate: :environment do
    file = File.new("#{Rails.root}/public/yandex_yml.xml", "w")

    xml = Builder::XmlMarkup.new(target: file, indent: 2)

    xml.yml_catalog(date: Time.zone.now.strftime('%Y-%m-%d %H:%M')) do |yml_catalog|
      yml_catalog.shop do |shop|
        shop.name 'Domvdome.ru'
        shop.company 'Дом в Доме'
        shop.url 'http://domvdome.ru'
        shop.currencies do |currencies|
          currencies.currency(id: 'RUB', rate: '1', plus: '0')
        end
        shop.categories do |categories|
          Spree::Taxonomy.includes(root: :children).find_each do |taxonomy|
            categories.category(taxonomy.name, id: taxonomy.id)
            taxonomy.taxons.each do |children|
              unless children.id == taxonomy.id
                categories.category(children.name, id: children.id, parentId: taxonomy.id)
              end
            end
          end
        end
        shop.local_delivery_cost 300
        shop.offers do |offers|
          Spree::Product.find([1,2,3,4,5,6]).each do |product|
            offers.offer(
              id: product.id, type: 'vendor.model', available: product.stock_items.first.try(:count_on_hand) <= 0 ? false : true
            ) do |info|
              info.url "http://domvdome.ru/products/#{product.slug}"
              info.price product.try(:price).try(:to_i)
              info.currencyId product.currency
              product.taxons.each do |taxon|
                info.categoryId(taxon.id, type: 'Own')
              end
              product.images.each do |image|
                info.picture "http://domvdome.ru" + image.attachment.url
              end
              info.delivery true
              info.local_delivery_cost 300
              if product.id == 4
                info.typePrefix product.taxons.last.try(:name)
              else
                info.typePrefix product.taxons.first.try(:name)
              end


              info.model product.name.gsub("Segafredo Zanetti ", "")
              info.vendor 'Segafredo Zanetti'
              info.description product.description
              product.product_properties.each do |product_property|
                info.param(product_property.value, name: product_property.property.presentation)
              end
            end
          end
        end
      end
    end
  end
end

namespace :product do
  task upload: :environment do
    s = SimpleSpreadsheet::Workbook.read("#{Rails.root}/public/mesmer.xls")
    s.selected_sheet = s.sheets.first
    s.first_row.upto(s.last_row) do |line|
      if s.cell(line, 2) && s.cell(line, 3) && s.cell(line, "I") && s.cell(line, "M")
        article = s.cell(line, 2).to_i.to_s
        name = s.cell(line, 3)
        cost_price = s.cell(line, "I").to_i + 1
        price = s.cell(line, "M").to_i + 1
        product = Spree::Product.find_by_name(name)
        unless product
          product = Spree::Product.create!(
            available_on: Time.zone.now.to_date,
            name: name,
            sku: article,
            cost_price: cost_price,
            price: price,
            shipping_category_id: Spree::ShippingCategory.last.id
          )
        end
      end
    end
  end
end

namespace :product do
  task upload_arivara: :environment do
    s = SimpleSpreadsheet::Workbook.read("#{Rails.root}/public/price_arivera.xls")
    s.selected_sheet = s.sheets.first
    country = Spree::Property.find_or_create_by(name: 'Страна производитель', presentation: 'Страна производитель')
    brend = Spree::Property.find_or_create_by(name: 'Торговая марка', presentation: 'Торговая марка')
    7.upto(s.last_row) do |line|
      if s.cell(line, 2) && s.cell(line, 3) && s.cell(line, "I") && s.cell(line, "M")
        article = s.cell(line, 2).to_i.to_s
        name = s.cell(line, 4)
        cost_price = s.cell(line, "P").to_i + 1
        price = s.cell(line, "Q").to_i + 1
        product = Spree::Product.find_by_name(name)
        taxon_ids = s.cell(line, "P")
        unless product
          product = Spree::Product.new(
            available_on: Time.zone.now.to_date,
            name: name,
            sku: article,
            cost_price: cost_price,
            price: price,
            shipping_category_id: Spree::ShippingCategory.last.id
          )
          country_value = s.cell(line, 6)
          brend_value = s.cell(line, 7)
          product.product_properties.create(property_id: country.id, value: country_value)
          product.product_properties.create(property_id: brend.id, value: brend_value)
          product.taxon_ids = taxon_ids
          product.save!
        end
      end
    end
  end

  task wowhoney: :environment do
    agent = Mechanize.new
    FileUtils.mkdir_p 'upload'
    Dir.chdir("upload")
    download = agent
    default_url = "http://wowhoney.ru/17-produkciya"
    index_page = agent.get(default_url)
    html_index = Nokogiri::HTML(index_page.body, 'UTF-8')
    country = Spree::Property.find_or_create_by(
      name: 'Страна производитель', presentation: 'Страна производитель'
    )
    brend = Spree::Property.find_or_create_by(
      name: 'Торговая марка', presentation: 'Торговая марка'
    )

    country_value = 'Россия'
    brend_value = 'Wow!honey'
    parent_taxon = Spree::Taxonomy.find_or_create_by(name: 'Мед')
    categories = html_index.css(".sfHoverForce li a").map(&:text)
    category_links = html_index.css(".sfHoverForce li a")
    category_links.first(2).each_with_index do |category_link, index|
      category_title = categories[index]
      in_category = index_page.link_with(href: category_link.attributes['href'].value).click

      link_products_html = Nokogiri::HTML(in_category.body, 'UTF-8')
      link_products = link_products_html.css(".ajax_block_product a")

      taxon = Spree::Taxon.find_or_create_by(name: category_title)

      # link_products.each do |link_product|
        link_product = link_products.first
        product = in_category.link_with(href: link_product.attributes['href'].value).click

        product_html = Nokogiri::HTML(product.body, 'UTF-8')
        product_title = product_html.css("h1").first.text.gsub(%r{\"}, '')

        price = product_html.css("#our_price_display").first.text.to_i

        product_body = product_html.css("#more-info .page-product-box").first.text.gsub('Описание', '')

        link_images = product_html.css('#thumbs_list a')

        build_product = Spree::Product.new(
          name: product_title,
          description: product_body,
          available_on: Time.now.to_date - 1.days,
          shipping_category_id: Spree::ShippingCategory.last,
          price: price,
          cost_price: price-price*0.2,
          taxon_ids: [taxon.id],
          shipping_category_id: Spree::ShippingCategory.last.id
        )
        build_product.product_properties.build(property_id: country.id, value: country_value)
        build_product.product_properties.build(property_id: brend.id, value: brend_value)
        link_images.each do |link_image|
          url = link_image.attributes['href'].value

          uri = URI.parse(url)

          download.get(url).save

          file_name = File.basename(uri.path)

          rand_name = Random.rand(1000).to_s + file_name

          File.rename(file_name,  rand_name)

          build_product.images.build(attachment: File.open(rand_name))
        end

        build_product.save!
      # end
    end
  end
end
