class IncidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @incidents = Incident.includes(:resident, :room).order(occurred_on: :desc)

    # ステータスでフィルター
    if params[:status].present?
      @incidents = @incidents.where(status: params[:status])
    end
  end

  def show
  end

  def new
    @incident = Incident.new(occurred_on: Date.today)
  end

  def create
    @incident = Incident.new(incident_params)
    if @incident.save
      redirect_to @incident, notice: "対応履歴を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @incident.update(incident_params)
      redirect_to @incident, notice: "対応履歴を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @incident.destroy
    redirect_to incidents_path, notice: "対応履歴を削除しました"
  end

  private

  def set_incident
    @incident = Incident.find(params[:id])
  end

  def incident_params
    params.require(:incident).permit(:resident_id, :room_id, :incident_type, :title, :description, :occurred_on, :resolved_on, :status)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to incidents_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end