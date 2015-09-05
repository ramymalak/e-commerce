class AddIsAdminColumnToCustomer < ActiveRecord::Migration
  def up
    add_column("customers", "is_admin", :boolean,default: false)
  end
  def down
    remove_column("customers", "is_admin")
  end
end
