class ResidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resident, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @residents = Resident.includes(:room).order(move_in_date: :desc)
  end

  def show
  end

  def new
    @resident = Resident.new
  end

  def create
    @resident = Resident.new(resident_params)
    if @resident.save
      create_initial_payment(@resident)
      log_activity('create', '入居者', @resident.name)
      redirect_to @resident, notice: "入居者を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @resident.update(resident_params)
      log_activity('update', '入居者', @resident.name)
      redirect_to @resident, notice: "入居者情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resident_name = @resident.name
    @resident.destroy
    log_activity('destroy', '入居者', resident_name)
    redirect_to residents_path, notice: "入居者を削除しました"
  end

  private

  def set_resident
    @resident = Resident.find(params[:id])
  end

  def resident_params
    params.require(:resident).permit(:room_id, :name, :name_furigana, :phone, :email, :emergency_contact, :emergency_contact_relation, :move_in_date, :move_out_date, :has_pet, :pet_details, :occupants_count, :notes, :parking_fee, :bicycle_fee, :motorcycle_fee)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to residents_path, alert: "この操作はオーナーのみ可能です"
    end
  end

  def create_initial_payment(resident)
    year_month = Date.today.strftime("%Y-%m")
    room = resident.room
    amount = room.rent.to_i + room.management_fee.to_i + resident.parking_fee.to_i + resident.bicycle_fee.to_i + resident.motorcycle_fee.to_i
    
    Payment.create(
      resident: resident,
      year_month: year_month,
      amount: amount,
      status: 'unpaid'
    )
  end
end