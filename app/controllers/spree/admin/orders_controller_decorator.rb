Spree::Admin::OrdersController.class_eval do
  before_action(
    :load_order,
    only: [:edit, :update, :cancel, :resume, :approve, :resend, :open_adjustments, :close_adjustments, :cart, :generate_pdf]
  )
  respond_to :pdf, only: [:generate_pdf]

  def generate_pdf
    respond_to do |format|
      format.pdf do
        render pdf: @order.number, layout: 'pdf.html.haml'
      end
    end
  end
end
