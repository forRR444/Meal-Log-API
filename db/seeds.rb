User.find_or_create_by!(email: 'demo@example.com') do |u|
  u.password = 'password123'
  u.nickname = 'デモユーザー'
end

User.find_or_create_by!(email: 'alice@example.com') do |u|
  u.password = 'password123'
  u.nickname = 'アリス'
end

User.find_or_create_by!(email: 'bob@example.com') do |u|
  u.password = 'password123'
  u.nickname = 'ボブ'
end

User.find_or_create_by!(email: 'carol@example.com') do |u|
  u.password = 'password123'
  u.nickname = 'キャロル'
end
