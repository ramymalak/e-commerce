class CreateCustomers < ActiveRecord::Migration
  def up
    create_table :customers do |t|
      t.string "firstname",  :null => false
      t.string "lastname",  :null => false
      t.string "email",  :null => false
    end
  end
  def down
    drop_table :customers
  end
end
