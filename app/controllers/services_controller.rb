class ServicesController < ApplicationController
  def index
    @services = Service.business.all
  end

  def new
    @service = Service.business.new
  end

  def create
    @service = Service.business.new(service_params)

    @service.save
    redirect_to business_path(@service.business)
  end

  def edit

  end

  def update

  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to business_path(@service.business)
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price, :offer, :available, :business_id)
  end
end
