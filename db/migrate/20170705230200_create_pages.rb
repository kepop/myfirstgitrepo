class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.integer "subject_id"  ## This is foreign key. Rails framework automatically translates to proper table name.
      t.string "name", :null =>false
      t.string "permalink", :null => false
      t.integer "position", :null => false
      t.boolean "visible", :default => true

      t.timestamps null: false
    end

    add_index(:pages, "subject_id")
    add_index(:pages, "permalink")
  end

  def down
    drop_table :pages
  end
end
