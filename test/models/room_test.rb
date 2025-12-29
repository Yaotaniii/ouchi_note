require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test "有効な部屋を作成できる" do
    room = Room.new(
      room_number: "101",
      floor_plan: "1K",
      rent: 50000,
      status: "vacant"
    )
    assert room.valid?
  end

  test "部屋番号は必須" do
    room = Room.new(room_number: nil)
    assert_not room.valid?
    assert_includes room.errors[:room_number], "can't be blank"
  end

  test "部屋番号は重複できない" do
    Room.create!(room_number: "101", floor_plan: "1K", rent: 50000, status: "vacant")
    room = Room.new(room_number: "101")
    assert_not room.valid?
  end

  test "家賃は0以上" do
    room = Room.new(room_number: "102", rent: -1000)
    assert_not room.valid?
  end

  test "statusはoccupiedかvacant" do
    room = Room.new(room_number: "103", status: "invalid")
    assert_not room.valid?
  end
end