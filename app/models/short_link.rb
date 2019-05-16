class ShortLink < ApplicationRecord
  validates :long_link, presence: true
  validates :long_link, format: URI.regexp(%w(http https))

  def self.find_by_encoded_id(id)
    find_by(id: id.to_i(36))
  end

  def encoded_id
    id.to_s(36)
  end
end
