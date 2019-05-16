require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  it 'has a valid factory' do
    expect(create(:short_link)).to be_valid
  end

  it { is_expected.to validate_presence_of(:long_link) }
end
