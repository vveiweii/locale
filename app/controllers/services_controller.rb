class ServicesController < ApplicationController
  def index
    @services = Service.business.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.business_id = params[:business_id]
    if @service.save
      redirect_to request.referer, notice: 'Service was successfully created.'
    else
      redirect_to request.referer, alert: 'Service was not created.'
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    @service.update(service_params)
    redirect_to business_path(@service.business)
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to request.referer, notice: 'Service was successfully deleted.'
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price, :offer)
  end
end
