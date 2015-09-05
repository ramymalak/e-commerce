class AddPasswordDigestToCustomers < ActiveRecord::Migration
  def up
    add_column "customers" ,"password_digest", :string
  end
  def down
    remove_column "customers" ,"password_digest"
  end
end
