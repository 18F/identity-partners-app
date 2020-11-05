class HomeController < ApplicationController
  def index
    render :index and return unless user_signed_in?

    # @account = Account.find_by(lg_account_id: current_user.lg_account_id)

    if @account
      render 'home/authenticated/index'
    else
      render 'home/authenticated/no_account'
    end

  end
end
