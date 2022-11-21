class HomeController < ApplicationController
  
  def index
    begin
      if current_user.trader? && current_user.approved?
        redirect_to stocks_path
      elsif current_user.admin?
        redirect_to admin_users_path
      elsif !current_user.approved?
        render :unapproved_users
      end
    rescue 
      render :index
    end
    
  end

  #custom action
  def unapproved_users
  end
end
