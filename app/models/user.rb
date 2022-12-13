# frozen_string_literal: true

class User < ApplicationRecord
  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users
  has_secure_password

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates_presence_of :password_digest 
end
