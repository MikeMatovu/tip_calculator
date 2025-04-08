class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Ensure admin attribute exists
  attribute :admin, :boolean, default: false
end
