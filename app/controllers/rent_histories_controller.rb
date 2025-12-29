class RentHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room
  before_action :set_rent_history, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @rent_histories = @room.rent_histories.order(started_on: :desc)
  end

  def new
    @rent_history = @room.rent_histories.new(started_on: Date.today)
  end

  def create
    @rent_history = @room.rent_histories.new(rent_history_params)
    if @rent_history.save
      update_room_rent
      redirect_to room_rent_histories_path(@room), notice: "家賃改定履歴を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @rent_history.update(rent_history_params)
      update_room_rent
      redirect_to room_rent_histories_path(@room), notice: "家賃改定履歴を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @rent_history.destroy
    update_room_rent
    redirect_to room_rent_histories_path(@room), notice: "家賃改定履歴を削除しました"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_rent_history
    @rent_history = @room.rent_histories.find(params[:id])
  end

  def rent_history_params
    params.require(:rent_history).permit(:rent, :started_on, :notes)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to room_rent_histories_path(@room), alert: "この操作はオーナーのみ可能です"
    end
  end

  def update_room_rent
    latest = @room.rent_histories.order(started_on: :desc).first
    if latest
      @room.update(rent: latest.rent)
    end
  end
end