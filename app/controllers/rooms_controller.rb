class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @rooms = Room.all

    # 階数の一覧を取得（部屋番号の1文字目）
    @floors = Room.pluck(:room_number).map { |n| n[0] }.uniq.sort

    # 階数でフィルター
    if params[:floor].present?
      @rooms = @rooms.where("room_number LIKE ?", "#{params[:floor]}%")
    end

    # ソート（デフォルトは部屋番号順）
    @rooms = @rooms.order(:room_number)
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      log_activity('create', '部屋', @room.room_number)
      redirect_to @room, notice: "部屋を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      log_activity('update', '部屋', @room.room_number)
      redirect_to @room, notice: "部屋情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    room_number = @room.room_number
    @room.destroy
    log_activity('destroy', '部屋', room_number)
    redirect_to rooms_path, notice: "部屋を削除しました"
  end


  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_number, :floor_plan, :rent, :management_fee, :status, :notes)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to rooms_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end