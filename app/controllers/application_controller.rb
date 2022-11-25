class ApplicationController < ActionController::Base 
    private

    def is_admin?
        if !current_user.admin?
            flash[:notice] = "You need to be an admin to continue."
            redirect_to root_path
        end
    end

    def is_approved?
        if !current_user.approved?
            flash[:notice] = "You need to be approved to continue."
            redirect_to root_path
        end
    end
    
    def not_valid_symbol
        flash[:error] = "Sorry, the symbol is not valid."
        render :find_stock 
    end
end
