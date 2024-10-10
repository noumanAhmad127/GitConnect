class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :likes, %i[profile_id likeable_id likeable_type], unique: true,
                                                                name: 'index_likes_on_profile_and_likeable'
  end
end
