class Transaction < ApplicationRecord
  #
  ## Associations
  #
  belongs_to :account

  #
  ## Constant
  #
  TRANSACTION_TYPES = [
    "Withdraw",
    "NEFT",
    "Deposite"
  ].freeze

  #
  ## Validations
  #
  validates(
    :description,
    presence: true,
    length: {
      maximum: 900
    }
  )
  validates(
    :amount,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }
  )
  validates(
    :transaction_type,
    presence: true,
    inclusion: { in: Transaction::TRANSACTION_TYPES }
  )

  #
  ## Callbacks
  #
  before_validation :check_account_number, :check_balance
  after_create :update_balance_in_account

  #
  ## Check account number before transaction
  #
  def check_account_number
    if transaction_type == "NEFT"
      account = Account.find_by(account_number: account_number)
      errors.add(:account_number,"Account is not Exists") if account.blank?
    end
  end

  #
  ## Check the balance in account before transaciton
  #
  def check_balance
    if transaction_type != "Deposite"
      if account.balance <= 0.0 && 
        errors.add(:amount,"You don't have sufficient balance in your account.")
      elsif account.balance < amount
        errors.add(:amount,"Please enter valid amount according to your current balance.")
      end
    end
  end

  #
  ## Update account balance
  #
  def update_balance_in_account
    if transaction_type == "NEFT"
      neft_account = Account.find_by(account_number: account_number)
      account.balance = account.balance - amount

      #
      ## Deposite money account
      #
      Transaction.transaction do
        neft_account.update(balance: neft_account.balance + amount)
        raise ActiveRecord::Rollback
      end
    elsif transaction_type == "Withdraw"
      account.balance = account.balance - amount
    elsif transaction_type == "Deposite"
      account.balance = account.balance + amount
    end

    #
    ## To ensure the successfull transaction
    #
    Transaction.transaction do
      account.save
      raise ActiveRecord::Rollback
    end
  end
end
