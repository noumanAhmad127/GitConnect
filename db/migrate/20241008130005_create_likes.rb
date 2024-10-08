class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
      t.index %i[user_id likeable_type likeable_id], unique: true
    end
  end
end
