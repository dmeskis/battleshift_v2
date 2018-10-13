class AddActivatedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :activation_digest, :string
    add_column :users, :status, :integer, default: 0
  end
end
