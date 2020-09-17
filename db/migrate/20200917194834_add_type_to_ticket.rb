class AddTypeToTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :type, :string
  end
end
