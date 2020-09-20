class CreateOrderTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :order_tickets do |t|
      t.references :order, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
