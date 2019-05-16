class ShortLink < ApplicationRecord
  validates :long_link, presence: true
end
