class Event < ApplicationRecord
  validates_presence_of :name, :started_at

  has_many :tickets
end
