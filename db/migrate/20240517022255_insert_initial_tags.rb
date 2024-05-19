class InsertInitialTags < ActiveRecord::Migration[6.1]
  def change
    10.times do |n|
    Tag.find_or_create_by!(
    id: n + 1,
    name: "タグ#{n + 1}"
  )
    end
  end
end
