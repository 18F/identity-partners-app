class HomeController < ApplicationController
  def index
    render :index and return unless user_signed_in?

    if current_user.accounts.count.positive?
      redirect_to accounts_path
    else
      render 'home/authenticated/no_account'
    end
  end
end
