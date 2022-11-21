class Admin::TransactionsController < ApplicationController
    before_action :authenticate_user!, :is_admin?

    def index
        @transactions = Transaction.all
    end
end
