habilog_admin = Admin.find_or_create_by!(email: "admin@test.com") do |admin|
  admin.password = 'testtest'
end

tester = Member.find_or_create_by!(email: "tester@test.com") do |member|
  member.account_id = 'tester'
  member.name = '公開テスター'
  member.introduction = "テストアカウントその１。公開設定○、退会フラグ×"
  member.is_private = false
  member.is_active = true
  member.password = 'testtest'
end

privater = Member.find_or_create_by!(email: "privater@test.com") do |member|
  member.account_id = 'privater'
  member.name = '非公開テスター'
  member.introduction = "テストアカウントその２。公開設定×、退会フラグ×"
  member.is_private = true
  member.is_active = true
  member.password = 'testtest'
end

withdrawer = Member.find_or_create_by!(email: "withdrawer@test.com") do |member|
  member.account_id = 'withdrawer'
  member.name = '退会テスター'
  member.introduction = "テストアカウントその３。公開設定○、退会フラグ○"
  member.is_private = false
  member.is_active = false
  member.password = 'testtest'
end

Tag.create!(
  [
    {
      name: '勉強'
    },
    {
      name: '仕事'
    },
    {
      name: '生活'
    },
    {
      name: '趣味'
    },
    {
      name: '思考'
    }
  ]
)