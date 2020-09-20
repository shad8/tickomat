class EventSerializer < ActiveModel::Serializer
  attributes :id, :started_at
  attribute :all_ticket_quantity
  attribute :available_ticket_quantity
  attribute :ticket_sales_open

  has_many :tickets, serializer: TicketSerializer

  def all_ticket_quantity
    object.all_ticket_quantity
  end

  def available_ticket_quantity
    object.all_ticket_quantity - object.sold_ticket_quantity
  end

  def ticket_sales_open
    object.started_at >= DateTime.current + 1.hour && available_ticket_quantity > 0
  end
end
