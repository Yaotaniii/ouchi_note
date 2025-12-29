require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "有効なユーザーを作成できる" do
    user = User.new(
      email: "test@example.com",
      password: "password123",
      name: "テストユーザー",
      role: "owner"
    )
    assert user.valid?
  end

  test "メールアドレスは必須" do
    user = User.new(email: nil, password: "password123", name: "テスト", role: "owner")
    assert_not user.valid?
  end

  test "メールアドレスは重複できない" do
    User.create!(email: "test@example.com", password: "password123", name: "ユーザー1", role: "owner")
    user = User.new(email: "test@example.com", password: "password123", name: "ユーザー2", role: "staff")
    assert_not user.valid?
  end

  test "roleはownerかstaff" do
    user = User.new(email: "test2@example.com", password: "password123", name: "テスト", role: "invalid")
    assert_not user.valid?
  end

  test "owner?メソッド" do
    user = User.new(role: "owner")
    assert user.owner?
  end

  test "staff?メソッド" do
    user = User.new(role: "staff")
    assert user.staff?
  end
end