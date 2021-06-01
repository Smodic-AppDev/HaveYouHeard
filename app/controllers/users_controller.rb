class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed discover ]

  def show
    
  end

  def feed
  
  end 
  
  def user_index
    @followed_users = current_user.leaders.order(last_name: "asc")
    leader_ids = @followed_users.pluck(:recipient_id)
    leader_ids = leader_ids.push(current_user.id)
    @non_followed_users = User.all.where.not(id: leader_ids).order(last_name:"asc")
    render "users/index.html.erb"
  end

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

end