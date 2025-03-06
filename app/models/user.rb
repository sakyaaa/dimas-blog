# frozen_string_literal: true

# user model
class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable, :validatable

  has_many :comments
  has_many :articles

  validates :email, presence: true, uniqueness: true
end
