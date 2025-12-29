require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  setup do
    @room = Room.create!(room_number: "301", floor_plan: "1K", rent: 50000, status: "occupied")
    @resident = Resident.create!(room: @room, name: "佐藤花子", move_in_date: Date.today, occupants_count: 1)
  end

  test "有効な入金記録を作成できる" do
    payment = Payment.new(
      resident: @resident,
      year_month: "2024-01",
      amount: 50000,
      status: "paid",
      paid_on: Date.today
    )
    assert payment.valid?
  end

  test "金額は必須" do
    payment = Payment.new(resident: @resident, year_month: "2024-01", amount: nil, status: "unpaid")
    assert_not payment.valid?
  end

  test "金額は0以上" do
    payment = Payment.new(resident: @resident, year_month: "2024-01", amount: -1000, status: "unpaid")
    assert_not payment.valid?
  end

  test "同じ入居者の同じ月は重複できない" do
    Payment.create!(resident: @resident, year_month: "2024-01", amount: 50000, status: "paid", paid_on: Date.today)
    payment = Payment.new(resident: @resident, year_month: "2024-01", amount: 50000, status: "paid", paid_on: Date.today)
    assert_not payment.valid?
  end

  test "paid?メソッド" do
    payment = Payment.new(status: "paid")
    assert payment.paid?
  end

  test "unpaid?メソッド" do
    payment = Payment.new(status: "unpaid")
    assert payment.unpaid?
  end
end