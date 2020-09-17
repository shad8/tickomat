class TicketSerializer < ActiveModel::Serializer
  attributes :id, :price
  attribute :quantity, key: :all_ticket_quantity
  attribute :available_ticket_quantity

  def available_ticket_quantity
    object.quantity
  end
end