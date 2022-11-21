class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :is_admin? 
 
  def index
      @users = User.where(role: :trader)
  end

  def show 
    @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(user_params)
      @user.skip_confirmation!
  
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation) 
      end
  
      if @user.save
        redirect_to admin_users_path, notice: "User with email #{@user.email} successfully created!" 
      else
        render :new
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if user_params[:account_status] != @user.account_status 
      ApproveEmailMailer.approve_trader_email(@user).deliver_now
      redirect_to admin_user_path(params[:id])
    elsif @user.update(user_params)
      redirect_to admin_user_path(params[:id])
    else
      render :edit
    end 
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User #{@user.email} has been deleted."
    
  end


  private


    def user_params
        params.require(:user).permit(:account_status, :email, :password, :password_confirmation, :role)
    end

end
