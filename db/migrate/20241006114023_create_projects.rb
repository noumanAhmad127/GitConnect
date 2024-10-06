class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :images
      t.string :demo_link
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
