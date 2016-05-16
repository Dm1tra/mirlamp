# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  config.logo = 'logo.png'
  config.currency = 'RUB'
  config.products_per_page = 100
  if ActiveRecord::Base.connection.table_exists? :spree_countries
    country = Spree::Country.find_by_iso_name('RUSSIAN FEDERATION')
    config.default_country_id = country.id if country.present?
  end
end
Spree::Config[:always_put_site_name_in_title] = false
Spree.user_class = 'Spree::User'
