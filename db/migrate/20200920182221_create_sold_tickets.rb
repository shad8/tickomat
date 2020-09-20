class CreateSoldTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :sold_tickets do |t|
      t.references :order, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
