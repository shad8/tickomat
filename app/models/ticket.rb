class Ticket < ApplicationRecord
  belongs_to :event

  enum selling_option: {
    selling_option_even: 'selling_option_even',
    selling_option_all_together: 'selling_option_all_together',
    selling_option_avoid_one: 'selling_option_avoid_one'
  }

  validates_numericality_of :quantity, :price, { greater_than: 0 }
end
