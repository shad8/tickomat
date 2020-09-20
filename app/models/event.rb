class Event < ApplicationRecord
  validates_presence_of :name, :started_at

  has_many :tickets
  has_many :orders

  def sold_ticket_quantity
    SoldTicket.joins(:order).where(orders: { event_id: id, payment_state: 'payment_state_paid' }).sum(&:quantity)
  end

  def all_ticket_quantity
    tickets.sum(:quantity)
  end
end
