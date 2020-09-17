class VipTicket < Ticket
  validates_numericality_of :price, { greater_than: 0 }

  def include_gift_package?
    true
  end
end
