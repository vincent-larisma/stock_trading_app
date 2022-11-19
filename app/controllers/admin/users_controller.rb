class Admin::UsersController < ApplicationController
    def index
        @users = User.all
        @traders = User.where(account_status: :pending)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
    
        if params[:user][:password].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end
    
        respond_to do |format|
          if @user.save
            format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
          else
            format.html { render :new }
          end
        end
    end

    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to admin_pending_index_path, notice: "Trader has been approved"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def pending_accounts

    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :account_status)
    end
end
