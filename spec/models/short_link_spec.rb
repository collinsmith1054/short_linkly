require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  it 'has a valid factory' do
    expect(build(:short_link)).to be_valid
  end

  it { is_expected.to validate_presence_of(:long_link) }
  it { is_expected.to validate_presence_of(:user_id) }

  context 'long_link is not unique' do
    let(:long_link) { 'https://www.google.com' }
    let!(:short_link) { create(:short_link, long_link: long_link, user_id: 1) }

    context 'user_id is same' do
      subject { build(:short_link, long_link: long_link, user_id: 1) }

      it { is_expected.to_not be_valid }
    end

    context 'user_id is different' do
      subject { build(:short_link, long_link: long_link, user_id: 2) }

      it { is_expected.to be_valid }
    end
  end

  context 'when long_link is an invalid url' do
    it 'is invalid' do
      expect(build(:short_link, long_link: 'invalid')).to_not be_valid
    end
  end

  describe 'find_by_encoded_id' do
    let(:short_link) { create(:short_link) }
    subject { described_class.find_by_encoded_id(short_link.encoded_id) }

    it 'returns the matching short_link' do
      is_expected.to eq(short_link)
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
