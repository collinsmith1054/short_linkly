class ShortLink < ApplicationRecord
  validates :long_link, presence: true
  validates :long_link, format: URI.regexp(%w(http https))

  def encoded_id
    id.to_s(36)
  end
end
