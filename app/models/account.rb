class Account < ApplicationRecord
  #
  ## Associations
  #
  belongs_to :user
  has_many :transactions

  #
  ## Validations
  #
  validates(
    :account_number,
    presence: true,
    numericality: true,
    uniqueness: true,
    length: {
      minimum: 10,
      maximum: 14
    }
  )
end
