class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # 部屋の集計
    @total_rooms = Room.count
    @occupied_rooms = Room.where(status: 'occupied').count
    @vacant_rooms = Room.where(status: 'vacant').count

    # 入居者の集計
    @current_residents = Resident.where(move_out_date: nil).count

    # 今月の入金状況
    @current_month = Date.today.strftime("%Y-%m")
    @paid_count = Payment.where(year_month: @current_month, status: 'paid').count
    @unpaid_count = Payment.where(year_month: @current_month, status: 'unpaid').count

    # 滞納者（今月未払い + 過去に未払いあり）
    @delinquent_payments = Payment.includes(resident: :room)
                                   .where(status: 'unpaid')
                                   .order(year_month: :desc)

    # 未解決のクレーム
    @open_incidents = Incident.includes(:resident, :room)
                              .where(status: 'open')
                              .order(occurred_on: :desc)
                              .limit(5)

    # 最近の修繕履歴
    @recent_maintenance = MaintenanceRecord.includes(:room)
                                           .order(performed_on: :desc)
                                           .limit(5)

    # 駐車場の空き状況
    @parking_total = ParkingSpace.count
    @parking_used = ParkingSpace.where.not(resident_id: nil).or(ParkingSpace.where(user_type: 'owner')).count
    @parking_available = @parking_total - @parking_used
  end
end