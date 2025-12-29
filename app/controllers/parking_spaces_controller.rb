class ParkingSpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parking_space, only: [:edit, :update]
  before_action :authorize_owner!, only: [:edit, :update]

  def index
    @parking_spaces = ParkingSpace.includes(:resident).order(:space_number)
  end

  def edit
  end

  def update
    if @parking_space.update(parking_space_params)
      redirect_to parking_spaces_path, notice: "駐車場情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_parking_space
    @parking_space = ParkingSpace.find(params[:id])
  end

  def parking_space_params
    params.require(:parking_space).permit(:space_number, :user_type, :resident_id, :notes)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to parking_spaces_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end