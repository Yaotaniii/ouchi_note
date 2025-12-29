class BicycleRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bicycle_registration, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @bicycle_registrations = BicycleRegistration.includes(resident: :room).order(:registration_number)
  end

  def new
    @bicycle_registration = BicycleRegistration.new
  end

  def create
    @bicycle_registration = BicycleRegistration.new(bicycle_registration_params)
    if @bicycle_registration.save
      redirect_to bicycle_registrations_path, notice: "駐輪場登録を追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @bicycle_registration.update(bicycle_registration_params)
      redirect_to bicycle_registrations_path, notice: "駐輪場登録を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bicycle_registration.destroy
    redirect_to bicycle_registrations_path, notice: "駐輪場登録を削除しました"
  end

  private

  def set_bicycle_registration
    @bicycle_registration = BicycleRegistration.find(params[:id])
  end

  def bicycle_registration_params
    params.require(:bicycle_registration).permit(:resident_id, :registration_number)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to bicycle_registrations_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end