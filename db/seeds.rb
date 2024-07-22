habilog_admin = Admin.find_or_create_by!(email: "admin@test.com") do |admin|
  admin.password = 'testtest'
end
Tag.delete_all
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