class AddActivatedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :integer, default: 0
    add_column :users, :activated_at, :datetime
  end
end
