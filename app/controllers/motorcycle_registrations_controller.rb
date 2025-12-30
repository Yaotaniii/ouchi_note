class MotorcycleRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_motorcycle_registration, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @motorcycle_registrations = MotorcycleRegistration.includes(resident: :room).order(:registration_number)
  end

  def new
    @motorcycle_registration = MotorcycleRegistration.new
  end

  def create
    @motorcycle_registration = MotorcycleRegistration.new(motorcycle_registration_params)
    if @motorcycle_registration.save
      log_activity('create', 'バイク置場', "#{@motorcycle_registration.resident.name} - #{@motorcycle_registration.registration_number}")
      redirect_to motorcycle_registrations_path, notice: "バイク置場登録を追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @motorcycle_registration.update(motorcycle_registration_params)
      log_activity('update', 'バイク置場', "#{@motorcycle_registration.resident.name} - #{@motorcycle_registration.registration_number}")
      redirect_to motorcycle_registrations_path, notice: "バイク置場登録を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    info = "#{@motorcycle_registration.resident.name} - #{@motorcycle_registration.registration_number}"
    @motorcycle_registration.destroy
    log_activity('destroy', 'バイク置場', info)
    redirect_to motorcycle_registrations_path, notice: "バイク置場登録を削除しました"
  end

  private

  def set_motorcycle_registration
    @motorcycle_registration = MotorcycleRegistration.find(params[:id])
  end

  def motorcycle_registration_params
    params.require(:motorcycle_registration).permit(:resident_id, :registration_number)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to motorcycle_registrations_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end