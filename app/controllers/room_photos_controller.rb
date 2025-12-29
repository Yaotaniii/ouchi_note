class RoomPhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room
  before_action :authorize_owner!, only: [:new, :create, :destroy]

  def index
    @move_in_photos = @room.room_photos.where(photo_type: 'move_in').order(taken_on: :desc)
    @move_out_photos = @room.room_photos.where(photo_type: 'move_out').order(taken_on: :desc)
  end

  def new
    @room_photo = @room.room_photos.new(photo_type: params[:photo_type] || 'move_in')
  end

  def create
    @room_photo = @room.room_photos.new(room_photo_params)
    if @room_photo.save
      redirect_to room_room_photos_path(@room), notice: "写真を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @room_photo = @room.room_photos.find(params[:id])
    @room_photo.destroy
    redirect_to room_room_photos_path(@room), notice: "写真を削除しました"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def room_photo_params
    params.require(:room_photo).permit(:photo_type, :taken_on, :image)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to room_room_photos_path(@room), alert: "この操作はオーナーのみ可能です"
    end
  end
end