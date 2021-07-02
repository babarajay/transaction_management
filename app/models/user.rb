class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #
  ## Associations
  #
  has_one :account
  has_many :amas, class_name: 'Ama', foreign_key: 'speaker_id'

  #
  ## Validations
  #
  validates(
    :first_name,
    presence: true,
    length: {
      maximum: 100
    }
  )
  validates(
    :last_name,
    presence: true,
    length: {
      maximum: 100
    }
  )
  validates(
    :email,
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    },
    uniqueness: true
  )
  validates(
    :phone_numbers,
    presence: true,
    numericality: true,
    uniqueness: true,
    length: {
      minimum: 10,
      maximum: 13
    }
  )

  #
  ## Callbacks
  #
  after_create :create_account_number

  def create_account_number
    account  = Account.new
    account.user_id = id
    account.account_number = rand(10 ** 10).to_s.rjust(14,'0')
    account.account_type = "Saving"
    account.save
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
