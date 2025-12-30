class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # 部屋情報
    @total_rooms = Room.count
    @occupied_rooms = Room.where(status: 'occupied').count
    @vacant_rooms = Room.where(status: 'vacant').count
    @current_residents = Resident.where(move_out_date: nil).count

    # 今月の入金状況
    @current_month = Date.today.strftime("%Y-%m")
    payments_this_month = Payment.where(year_month: @current_month)
    @paid_count = payments_this_month.where(status: 'paid').count
    @unpaid_count = payments_this_month.where(status: 'unpaid').count

    # 滞納アラート
    @delinquent_payments = Payment.includes(resident: :room)
                                  .where(status: 'unpaid')
                                  .order(year_month: :desc)

    # 未解決のクレーム
    @open_incidents = Incident.includes(resident: :room)
                              .where(status: 'open')
                              .order(occurred_on: :desc)
                              .limit(5)

    # 駐車場状況
    @parking_total = ParkingSpace.count
    @parking_used = ParkingSpace.where.not(resident_id: nil).or(ParkingSpace.where(user_type: 'owner')).count
    @parking_available = ParkingSpace.where(resident_id: nil, user_type: 'resident').count

    # 最近の修繕履歴
    @recent_maintenance = MaintenanceRecord.includes(:room)
                                           .order(performed_on: :desc)
                                           .limit(5)

    # 最近の操作履歴
    @recent_activities = ActivityLog.includes(:user).limit(10)
  end
end