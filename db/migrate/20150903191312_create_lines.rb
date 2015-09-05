class CreateLines < ActiveRecord::Migration
  def up
    create_table :lines do |t|
      t.references :order,:null => false
      t.references :product,:null => false
      t.integer "qty",:default=>1, :null => false
      t.float "unit_price",:limit => 53, :null => false
      t.float "total_price",:limit => 53, :null => false
    end
  end
  def down
    drop_table :lines
  end
end
