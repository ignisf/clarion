require 'rails_helper'

RSpec.describe Workshop, :type => :model do
  let(:event) { build :workshop }

  it_behaves_like 'an event'

  describe 'length' do
    it 'must be between 30 and 120 minutes' do
      event.length = 20
      expect(event).to have_error_on :length

      event.length = 240
      expect(event).to have_error_on :length

      event.length = 30
      expect(event).to_not have_error_on :length

      event.length = 120
      expect(event).to_not have_error_on :length
    end
  end
end
