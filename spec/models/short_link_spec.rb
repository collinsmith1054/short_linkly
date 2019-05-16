require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  it 'has a valid factory' do
    expect(build(:short_link)).to be_valid
  end

  it { is_expected.to validate_presence_of(:long_link) }

  context 'when long_link is an invalid url' do
    it 'is invalid' do
      expect(build(:short_link, long_link: 'invalid')).to_not be_valid
    end
  end

  describe 'encoded_id' do
    let(:short_link) { create(:short_link) }
    subject { short_link.encoded_id }

    it 'returns a base 36 encoded id' do
      is_expected.to eq(short_link.id.to_s(36))
    end
  end
end
