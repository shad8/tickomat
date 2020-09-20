class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :event, null: false, foreign_key: true
      t.string :payment_state, null: false, index: true
      t.decimal :paid_amount, null: false

      t.timestamps
    end
  end
end
