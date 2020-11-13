class AccountsController < AuthenticatedController

  def index
    if current_user.admin?
      @accounts = Account.all
    else
      @accounts = current_user.accounts
    end
  end

  def show
    @account ||= Account.find(params[:id])
  end
end
