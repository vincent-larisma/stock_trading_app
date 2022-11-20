class Admin::PendingController < ApplicationController
    def index
        @traders = User.where(account_status: :pending)
        @users = User.all
    end

    private

    def user_params
        params.require(:user).permit(:role, :account_status)
    end 
    
end
