class AddAuthMethodToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :auth_method, :integer
  end
end
