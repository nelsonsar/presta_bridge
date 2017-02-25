class Store < ApplicationRecord
  belongs_to :user

  validates_presence_of :name
  validates :api_key, presence: true, length: { is: 32 }

  validate :valid_url?

  private

  def valid_url?
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    errors.add(:url, 'Invalid URL given')
  end
end
