RSpec.shared_examples 'an event' do
  it 'is invalid if the event agrement is not accepted' do
    event.agreement = false
    expect(event).to have_error_on :agreement
  end

  it 'is invalid without a title' do
    event.title = ''
    expect(event).to have_error_on :title
  end

  describe 'length' do
    it 'must be present' do
      event.length = ''
      expect(event).to have_error_on :length
    end

    it 'must be a number' do
      event.length = 'foo'
      expect(event).to have_error_on :length
    end

    it 'must be larger than zero' do
      event.length = '-10'
      expect(event).to have_error_on :length
    end
  end

  it 'is invalid without an abstract' do
    event.abstract = ''
    expect(event).to have_error_on :abstract
  end

  it 'is invalid without a description' do
    event.description = ''
    expect(event).to have_error_on :description
  end
end
