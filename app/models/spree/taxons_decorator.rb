Spree::Taxon.class_eval do
  has_attached_file :icon,
    styles: { large: '400x400>' },
    default_style: :large,
    url: '/spree/taxons/:id/:style/:basename.:extension',
    path: ':rails_root/public/spree/taxons/:id/:style/:basename.:extension',
    default_url: 'default_taxon.png'
end
