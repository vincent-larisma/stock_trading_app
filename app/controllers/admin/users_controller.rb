class Admin::UsersController < ApplicationController
    def index
        @users = User.all
    end

    def new
        @users = User.new
    end

    def create
        @users = User.new
    end
end
