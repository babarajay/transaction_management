class AccountsController < ApplicationController
  before_action :load_account

  def edit
  end

  def update
    @account.balance = @account.balance + account_params[:balance].to_f
    respond_to do |format|
      if @account.save
        format.html { redirect_to root_path }
      else
        format.html { render :edit }
        format.json do
          render(
            json: @account.errors,
            status: :unprocessable_entity
          )
        end
      end
    end
  end

  private

  def load_account
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(:balance)
  end
end
