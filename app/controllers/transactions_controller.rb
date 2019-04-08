class TransactionsController < ApplicationController

  def index
    @transactions = current_user.try(:account).try(:transactions)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path }
      else
        format.html { render :new }
        format.json do
          render(
            json: @transaction.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  private

  def transaction_params
    params.require(
      :transaction
    ).permit(
      :account_id,
      :description,
      :account_number,
      :amount,
      :transaction_type
    )
  end

end
