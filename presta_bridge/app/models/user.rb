class User < ApplicationRecord
  has_one :store

  validates_presence_of :name
  validates_presence_of :email

  has_secure_password
end
