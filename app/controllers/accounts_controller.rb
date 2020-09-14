class AccountsController < ApplicationController

  def index
    if current_user.admin?
      @accounts = Account.all
    else
      @account = Account.find_by(lg_account_id: current_user.lg_account_id)
    end
  end

  def new
    @account = Account.new
    @agencies = Agency.all
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      flash[:success] = 'Account created'
      redirect_to account_path(@account.id)
    else
      render :new
    end
  end

  def edit
    @account = Account.find_by(id: params[:id])
  end

  def update
    account = Account.find_by(id: params[:id])
    account.update!(account_params)
    flash[:success] = 'Account updated'
    redirect_to account_path(account.id)
  end

  def destroy
    if @account.apps.empty? && @account.destroy
      flash[:success] = 'Account deleted'
      return redirect_to accounts_path
    end

    flash[:warning] = 'Deletion failed'
    redirect_back(fallback_location: accounts_path)
  end

  def show
    @account ||= Account.find(params[:id])
  end

  private

  def account_params
    params.require(:account).permit(
      :lg_account_id, :name, :iaa_active, :iaa_7600a, :iaa_7600a_start, :iaa_7600a_end,
      :iaa_7600a_amount, :iaa_7600b, :iaa_7600b_start, :iaa_7600b_end, :iaa_7600b_amount,
      :pricing, :became_partner, :contacts
    )
  end

end
