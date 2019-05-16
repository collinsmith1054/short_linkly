class ShortLink < ApplicationRecord
  validates_uniqueness_of :long_link, scope: :user_id
  validates :long_link, presence: true, format: URI.regexp(%w(http https))
  validates :user_id, presence: true

  before_save :downcase_long_link

  def self.find_by_encoded_id(id)
    find_by(id: id.to_i(36))
  end

  def encoded_id
    id.to_s(36)
  end

  private

  def downcase_long_link
    self.long_link = long_link.downcase
  end
end
