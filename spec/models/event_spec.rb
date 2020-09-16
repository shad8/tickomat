require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'is not valid without a name' do
    event = FactoryBot.build(:event, name: '')
    expect(event).to_not be_valid
  end

  it 'is not valid without a start_date' do
    event = FactoryBot.build(:event, started_at: nil)
    expect(event).to_not be_valid
  end
end
