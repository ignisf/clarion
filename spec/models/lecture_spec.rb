require 'rails_helper'

RSpec.describe Lecture, :type => :model do
  let(:event) { build :lecture }

  it_behaves_like 'an event'

  describe 'length' do
    it 'must be between 40 and 45 minutes' do
      event.length = 30
      expect(event).to have_error_on :length

      event.length = 60
      expect(event).to have_error_on :length

      event.length = 40
      expect(event).to_not have_error_on :length

      event.length = 45
      expect(event).to_not have_error_on :length
    end
  end
end
