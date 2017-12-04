
class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @devices = Device.all
    if params[:search]
      @devices = Device.search(params[:search]).order("created_at DESC")
    else
      @devices = Device.all.order("created_at DESC")
    end
  end

  def show
  end

  def new
    @device = Device.new
  end

  def edit
  end

  def create
    @device = Device.new(device_params)
    @device.seller_id = current_user.id

    if @device.save
      redirect_to @device, notice: 'Device was successfully created.'
    else
      render :new
    end
  end

  def update
    if @device.update(device_params)
      redirect_to @device, notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @device.sold? != true
      @device.destroy
    end

    redirect_to devices_url, notice: 'Location was successfully destroyed.'
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:model, :title, :manufacturer, :condition, :price, :zip_code, :sold?)
  end
end