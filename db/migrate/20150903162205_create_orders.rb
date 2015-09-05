class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.string "order_no",  :null => true
      t.references :customers,:null => false
      t.float "total",:limit => 53, :null => false,:default=>0.0
      t.date "date",:null => true

    end
  end
  def down
    drop_table :orders
  end
end
