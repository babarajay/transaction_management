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

  validates(
    :balance,
    numericality: { greater_than_or_equal_to: 0 }
  )
end
