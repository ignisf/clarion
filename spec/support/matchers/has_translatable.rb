RSpec::Matchers.define :have_translatable do |expected|
  match do |actual|
    I18n.locale = :bg
    actual.send "#{expected.to_s}=", 'Test Bulgarian'

    I18n.locale = :en
    actual.send "#{expected.to_s}=", 'Test English'

    expect(actual.send expected).to eq 'Test English'

    I18n.locale = :bg
    expect(actual.send expected).to eq 'Test Bulgarian'
  end
end
