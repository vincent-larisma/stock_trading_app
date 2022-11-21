class ApplicationController < ActionController::Base
    def is_admin?
        if !current_user.admin?
            flash[:notice] = "You need to be admin to continue."
            redirect_to root_path
        end
    end

    def is_approved?
        if !current_user.approved?
            flash[:notice] = "You need to be approved to continue."
            redirect_to root_path
        end
    end
end
