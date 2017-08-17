class CreateSections < ActiveRecord::Migration
  def up
    create_table :sections do |t|
      t.integer "page_id" ## This is foreign key. Rails framework automatically translates to proper table name.
      # same as == t.references :page
      t.string "name", :null =>false
      t.integer "position", :null => false
      t.boolean "visible", :default => true
      t.string "content_type"
      t.text "content"

      t.timestamps null: false
    end

    add_index(:sections, "page_id")
  end

  def down
    drop_table :sections
  end
end
