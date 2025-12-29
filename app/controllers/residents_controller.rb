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
      redirect_to @resident, notice: "入居者を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @resident.update(resident_params)
      redirect_to @resident, notice: "入居者情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resident.destroy
    redirect_to residents_path, notice: "入居者を削除しました"
  end

  private

  def set_resident
    @resident = Resident.find(params[:id])
  end

  def resident_params
    params.require(:resident).permit(
      :room_id, :name, :phone, :email, :emergency_contact,
      :move_in_date, :move_out_date, :has_pet, :pet_details,
      :occupants_count, :notes
    )
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to residents_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end