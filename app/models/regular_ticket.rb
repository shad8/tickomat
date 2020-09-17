class RegularTicket < Ticket
  validates_numericality_of :price, { greater_than: 0 }
end
