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
        redirect_to admin_users_path, notice: "User with email #{@user.email} successfully created" 
      else
        render :new
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      ApproveEmailMailer.approve_trader_email(@user).deliver_now
      redirect_to admin_user_path(params[:id]), notice: 'Your account has been approved by the admin.'
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
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :account_status)
    end

end
