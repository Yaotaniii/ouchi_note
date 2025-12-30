class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @vehicles = Vehicle.includes(resident: :room).order("rooms.room_number")
    
    # 車種でフィルター
    if params[:vehicle_type].present?
      @vehicles = @vehicles.where(vehicle_type: params[:vehicle_type])
    end
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      log_activity('create', '車両', "#{@vehicle.resident.name} - #{@vehicle.plate_number}")
      redirect_to vehicles_path, notice: "車両を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vehicle.update(vehicle_params)
      log_activity('update', '車両', "#{@vehicle.resident.name} - #{@vehicle.plate_number}")
      redirect_to vehicles_path, notice: "車両情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    info = "#{@vehicle.resident.name} - #{@vehicle.plate_number}"
    @vehicle.destroy
    log_activity('destroy', '車両', info)
    redirect_to vehicles_path, notice: "車両を削除しました"
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:resident_id, :vehicle_type, :make_model, :plate_number)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to vehicles_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end