class Admin::SkusController < Admin::BaseController
  before_action :set_distributor
  before_action :set_sku, only: %i[edit update]

  def index
    @skus = @distributor.skus.includes(:product)
  end

  def new
    @sku = @distributor.skus.build
  end

  def create
    @sku = @distributor.skus.build(sku_params)
    if @sku.save
      redirect_to admin_distributor_path(@distributor), notice: "SKU added for #{@distributor.name}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @sku.update(sku_params)
      redirect_to admin_distributor_path(@distributor), notice: "SKU pricing updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_distributor
    @distributor = Distributor.find(params[:distributor_id])
  end

  def set_sku
    @sku = @distributor.skus.find(params[:id])
  end

  def sku_params
    params.require(:sku).permit(:product_id, :price_per_unit)
  end
end
