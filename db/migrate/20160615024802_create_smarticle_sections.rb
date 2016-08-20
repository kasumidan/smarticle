class CreateSmarticleSections < ActiveRecord::Migration
  def change
    create_table :smarticle_sections do |t|
      t.string  :title
      t.string  :section_type
      t.integer :display_order
      t.integer  :width
      t.text  :txt
      t.references :smarticle_article, index: true

      t.timestamps null: false
    end
  end
end
