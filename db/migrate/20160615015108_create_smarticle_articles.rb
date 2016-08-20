class CreateSmarticleArticles < ActiveRecord::Migration
  def change
    create_table :smarticle_articles do |t|
      t.string  :title
      t.string  :label
      t.string  :smarticleable_type, index: true
      t.integer :smarticleable_id, index: true

      t.timestamps null: false

      t.timestamps null: false
    end
  end
end
