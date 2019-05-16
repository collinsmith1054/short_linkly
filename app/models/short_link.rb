class ShortLink < ApplicationRecord
  validates :long_link, presence: true, uniqueness: true
  validates :long_link, format: URI.regexp(%w(http https))

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
