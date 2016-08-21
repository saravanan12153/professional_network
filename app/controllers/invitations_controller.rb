class InvitationsController < ApplicationController
before_action :require_login
before_action :require_correct_user, only: [:show]

    def show
        @user = User.find(params[:id])
        @user_inviteds = Invitation.where(user: User.find(session[:user_id])).where(accepted: true)
        @user_invited_bys = Invitation.where(invited: User.find(current_user)).where(accepted: true)
        @inviters = Invitation.where(invited: User.find(current_user)).where(accepted: false)
    end

    def create
        Invitation.create(user: User.find(current_user), invited: User.find(params[:invited]))
          redirect_to :back
    end
    def update
        Invitation.find_by(user: User.find(params[:id]), invited: User.find(current_user)).update(accepted: true)
        redirect_to :back
    end
    def destroy
        Invitation.find_by(user: User.find(params[:inviter]), invited: User.find(current_user)).delete
        redirect_to :back
    end
end
