class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @year_month = params[:year_month] || Date.today.strftime("%Y-%m")
    @payments = Payment.includes(resident: :room)
                       .where(year_month: @year_month)
                       .order("rooms.room_number")
    
    # 現在入居中の入居者で、まだ入金記録がない人を取得
    existing_resident_ids = @payments.pluck(:resident_id)
    @residents_without_payment = Resident.includes(:room)
                                         .where(move_out_date: nil)
                                         .where.not(id: existing_resident_ids)
                                         .order("rooms.room_number")
  end

  def new
    @payment = Payment.new(
      year_month: params[:year_month] || Date.today.strftime("%Y-%m"),
      resident_id: params[:resident_id],
      status: 'paid'
    )
    
    # 入居者が指定されていれば、部屋の家賃を自動セット
    if params[:resident_id].present?
      resident = Resident.find(params[:resident_id])
      @payment.amount = resident.room.rent
      @payment.paid_on = Date.today
    end
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      log_activity('create', '入金', "#{@payment.resident.name} #{@payment.year_month}")
      redirect_to payments_path(year_month: @payment.year_month), notice: "入金を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      log_activity('update', '入金', "#{@payment.resident.name} #{@payment.year_month}")
      redirect_to payments_path(year_month: @payment.year_month), notice: "入金情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    year_month = @payment.year_month
    payment_info = "#{@payment.resident.name} #{@payment.year_month}"
    @payment.destroy
    log_activity('destroy', '入金', payment_info)
    redirect_to payments_path(year_month: year_month), notice: "入金を削除しました"
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:resident_id, :year_month, :amount, :paid_on, :status, :notes)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to payments_path, alert: "この操作はオーナーのみ可能です"
    end
  end
end