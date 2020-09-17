class EventSerializer < ActiveModel::Serializer
  attributes :id, :started_at
  attribute :all_ticket_quantity
  attribute :available_ticket_quantity

  has_many :tickets, serializer: TicketSerializer

  def all_ticket_quantity
    object.tickets.sum(:quantity)
  end

  def available_ticket_quantity
    object.tickets.sum(:quantity)
  end
end
