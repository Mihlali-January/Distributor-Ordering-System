class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.includes(:distributor, :user).order(created_at: :desc)
  end

  def show
    @order = Order.includes(order_items: { sku: :product }).find(params[:id])
  end
end
