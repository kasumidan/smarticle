class CreateSmarticlePictures < ActiveRecord::Migration
  def change
    create_table :smarticle_pictures do |t|
      t.attachment :image
      t.references :smarticle_section, index: true

      t.timestamps null: false
    end
  end
end
