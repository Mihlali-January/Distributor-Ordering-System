class Admin::DistributorsController < Admin::BaseController
  before_action :set_distributor, only: %i[show edit update destroy]

  def index
    @distributors = Distributor.all
  end

  def show
  end

  def new
    @distributor = Distributor.new
    @distributor.users.build
  end

  def create
    @distributor = Distributor.new(distributor_params)
    if @distributor.save
      redirect_to admin_distributor_path(@distributor), notice: "Distributor created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @distributor.update(distributor_params)
      redirect_to admin_distributor_path(@distributor), notice: "Distributor updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @distributor.destroy
    redirect_to admin_distributors_path, notice: "Distributor deleted."
  end

  private

  def set_distributor
    @distributor = Distributor.find(params[:id])
  end

  def distributor_params
    params.require(:distributor).permit(:name, :currency, users_attributes: [:email, :password, :password_confirmation, :role])
  end
end
