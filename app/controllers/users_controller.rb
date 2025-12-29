class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_owner!
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.order(:role, :name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "ユーザーを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to users_path, notice: "ユーザーを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to users_path, alert: "自分自身は削除できません"
    else
      @user.destroy
      redirect_to users_path, notice: "ユーザーを削除しました"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to dashboard_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end