# オーナーユーザーを作成（存在しない場合のみ）
unless User.exists?(email: 'owner@example.com')
  User.create!(
    email: 'owner@example.com',
    password: 'password123',
    name: 'オーナー太郎',
    role: 'owner'
  )
  puts "オーナーユーザーを作成しました"
end

# 駐車場の初期データ作成（7台分）
puts "駐車場データを作成中..."

(1..7).each do |i|
  ParkingSpace.find_or_create_by!(space_number: "P#{i}") do |space|
    space.user_type = 'resident'
    space.notes = ''
  end
end

puts "駐車場データを作成しました（#{ParkingSpace.count}台分）"