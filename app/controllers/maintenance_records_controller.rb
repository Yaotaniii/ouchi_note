class MaintenanceRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_maintenance_record, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @maintenance_records = MaintenanceRecord.includes(:room).order(performed_on: :desc)
    
    # 部屋でフィルター
    if params[:room_id].present?
      @maintenance_records = @maintenance_records.where(room_id: params[:room_id])
    end
  end

  def show
  end

  def new
    @maintenance_record = MaintenanceRecord.new(room_id: params[:room_id])
  end

  def create
    @maintenance_record = MaintenanceRecord.new(maintenance_record_params)
    if @maintenance_record.save
      redirect_to @maintenance_record, notice: "修繕履歴を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @maintenance_record.update(maintenance_record_params)
      redirect_to @maintenance_record, notice: "修繕履歴を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @maintenance_record.destroy
    redirect_to maintenance_records_path, notice: "修繕履歴を削除しました"
  end

  private

  def set_maintenance_record
    @maintenance_record = MaintenanceRecord.find(params[:id])
  end

  def maintenance_record_params
    params.require(:maintenance_record).permit(:room_id, :title, :description, :performed_on, :cost)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to maintenance_records_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end