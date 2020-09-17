class FreeTicket < Ticket
  attribute :price, default: 0

  validates_numericality_of :price, { equal_to: 0 }
end
