class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :default => nil
    add_column :users, :gender, :string, :default => nil
    add_column :users, :locale, :string, :default => nil
    add_column :users, :link, :string, :default => nil
    add_column :users, :picture, :string, :default => nil
  end
end

# def down
#   remove_column :accounts, :ssl_enabled
# end