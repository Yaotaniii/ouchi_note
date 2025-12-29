require "test_helper"

class ResidentTest < ActiveSupport::TestCase
  setup do
    @room = Room.create!(room_number: "201", floor_plan: "1K", rent: 50000, status: "occupied")
  end

  test "有効な入居者を作成できる" do
    resident = Resident.new(
      room: @room,
      name: "山田太郎",
      move_in_date: Date.today,
      occupants_count: 1
    )
    assert resident.valid?
  end

  test "名前は必須" do
    resident = Resident.new(room: @room, name: nil, move_in_date: Date.today)
    assert_not resident.valid?
    assert_includes resident.errors[:name], "can't be blank"
  end

  test "入居日は必須" do
    resident = Resident.new(room: @room, name: "山田太郎", move_in_date: nil)
    assert_not resident.valid?
  end

  test "current?メソッドは退去日がなければtrue" do
    resident = Resident.create!(room: @room, name: "山田太郎", move_in_date: Date.today, occupants_count: 1)
    assert resident.current?
  end

  test "current?メソッドは退去日があればfalse" do
    resident = Resident.create!(room: @room, name: "山田太郎", move_in_date: 1.year.ago, move_out_date: Date.today, occupants_count: 1)
    assert_not resident.current?
  end
end