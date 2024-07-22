habilog_admin = Admin.find_or_create_by!(email: "admin@test.com") do |admin|
  admin.password = 'testtest'
end
Tag.delete_all
Tag.create!(
  [
    {
      id: 1,
      name: '勉強'
    },
    {
      id: 2,
      name: '仕事'
    },
    {
      id: 3,
      name: '生活'
    },
    {
      id: 4,
      name: '趣味'
    },
    {
      id: 5,
      name: '思考'
    }
  ]
)