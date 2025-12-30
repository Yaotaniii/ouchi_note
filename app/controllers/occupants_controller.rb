class OccupantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resident
  before_action :authorize_owner!

  def new
    @occupant = @resident.occupants.new
  end

  def create
    @occupant = @resident.occupants.new(occupant_params)
    if @occupant.save
      redirect_to resident_path(@resident), notice: "同居人を追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @occupant = @resident.occupants.find(params[:id])
    @occupant.destroy
    redirect_to resident_path(@resident), notice: "同居人を削除しました"
  end

  private

  def set_resident
    @resident = Resident.find(params[:resident_id])
  end

  def occupant_params
    params.require(:occupant).permit(:name, :name_furigana, :relation)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to resident_path(@resident), alert: "この操作はオーナーのみ可能です"
    end
  end
end