class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string "description",  :null => false
      t.string "name",  :null => false
      t.float "price",:limit => 53, :null => false
      t.integer :status , :null => false,:precision=>1

    end
  end
  def down
    drop_table :products
  end
end
