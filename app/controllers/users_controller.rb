class UsersController < ApplicationController
    before_action :require_login, except: [:main, :create]
    before_action :require_correct_user, only: [:edit, :update, :destroy]

    def index
        @users = User.where.not(id: User.find(current_user).inviteds).where.not(id: User.find(current_user).inviters).where.not(id: User.find(current_user))
    end

    def main
        if session[:user_id]
          redirect_to "/professional_profile/#{current_user.id}"
        end
    end

    def create
        @user = User.new(name: params[:name], email: params[:email], password: params[:password], description: params[:description])
          if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to "/professional_profile/#{current_user.id}"
          else
            flash[:errors] = @user.errors.full_messages
            redirect_to :back
          end
    end
    def show
        @user = User.find(params[:id])
    end

end
