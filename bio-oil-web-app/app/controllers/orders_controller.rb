class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_distributor!
  before_action :set_order, only: [:show]

  def index
    @orders = current_user.distributor.orders.order(created_at: :desc)
    @total_spent = @orders.sum(:total_cost)
    @order_count = @orders.count
  end

  def show
  end

  def new
    @order = current_user.distributor.orders.build
    @skus = current_user.distributor.skus.includes(:product)
    
    if @skus.empty?
      flash[:alert] = "You don't have any SKUs assigned. Please contact head office."
      redirect_to orders_path
    end
  end

  def create
    @order = current_user.distributor.orders.build(order_params)
    @order.user = current_user
    @order.order_number = "ORD-#{SecureRandom.hex(4).upcase}"
    
    # Calculate costs for items before saving
    @order.order_items.each do |item|
      if item.sku
        item.units = item.pallets.to_i * 4800
        item.cost = item.units * item.sku.price_per_unit
      end
    end
    
    @order.total_cost = @order.order_items.map(&:cost).sum

    if @order.save
      redirect_to @order, notice: "Order was successfully placed."
    else
      @skus = current_user.distributor.skus.includes(:product)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ensure_distributor!
    unless current_user.distributor? && current_user.distributor.present?
      redirect_to root_path, alert: "Access denied. Only distributors can manage orders."
    end
  end

  def set_order
    @order = current_user.distributor.orders.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: "Order not found."
  end

  def order_params
    params.require(:order).permit(:required_delivery_date, order_items_attributes: [:sku_id, :pallets])
  end
end
