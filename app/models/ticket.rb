class Ticket < ApplicationRecord
  belongs_to :event
  has_many :sold_tickets

  enum selling_option: {
    selling_option_even: 'selling_option_even',
    selling_option_all_together: 'selling_option_all_together',
    selling_option_avoid_one: 'selling_option_avoid_one'
  }

  validates_numericality_of :quantity, { greater_than: 0 }

  def include_gift_package?
    false
  end
end
