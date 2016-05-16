Spree::Admin::TaxonsController.class_eval do
  respond_to :js, only: [:upload_image]

  def upload_image
    @taxon = Spree::Taxon.find(params[:id])
    @taxon.update(icon: params[:upload_image])
    respond_with(@taxon)
  end
end
