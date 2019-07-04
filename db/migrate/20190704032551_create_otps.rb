class CreateOtps < ActiveRecord::Migration[5.2]
  def change
    create_table :otps do |t|
      t.references :verifiable, polymorphic: true
      t.string :state
      t.string :mobile
      t.string :authy_id
      t.integer :auth_method
      t.string :token

      t.timestamps
    end
  end
end
