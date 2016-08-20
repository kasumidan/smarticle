class CreateSmarticleVideos < ActiveRecord::Migration
  def change
    create_table :smarticle_videos do |t|
      t.text :video_id
      t.text :video_type
      t.references :smarticle_section, index: true

      t.timestamps null: false
    end
  end
end
