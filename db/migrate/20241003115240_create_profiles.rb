class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :profile_pic
      t.string :contact_info
      t.string :headline
      t.string :city
      t.integer :years_of_experience
      t.json :skill_sets, default: []
      t.json :social_media_links, default: []
      t.json :education, default: []
      t.json :work_experience, default: []

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
