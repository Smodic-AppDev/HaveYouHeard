class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed ]

  before_action :must_be_owner_to_view, only: %i[ feed ]

  def show
    require 'rspotify'
    RSpotify.authenticate(ENV.fetch("Spotify_Client_ID"), ENV.fetch("Spotify_Client_Secret"))

    user_likes = @user.likes.order(created_at: "desc")
    
    if user_likes.count == 0
      @tracks = 0
    else
      liked_song_ids = user_likes.pluck(:song_id)
      @tracks = RSpotify::Track.find(liked_song_ids)
    end
    
  end

  def feed
    require 'rspotify'
    RSpotify.authenticate(ENV.fetch("Spotify_Client_ID"), ENV.fetch("Spotify_Client_Secret"))

    leader_ids = @user.leaders.pluck(:recipient_id)
    
    feed_likes = Like.all.where(fan_id: leader_ids).order(created_at: "asc")
    
    if feed_likes.nil?
      @tracks = 0
    else
      unique_feed_likes = feed_likes.uniq(&:song_id)
      desc_unique_feed_likes = Like.all.where(id: unique_feed_likes).order(created_at: "desc")
      feed_song_ids = desc_unique_feed_likes.pluck(:song_id)
      @tracks = RSpotify::Track.find(feed_song_ids)
    end
  
  end 
  
  def user_index
    @followed_users = current_user.leaders.order(last_name: "asc")
    @non_followed_users = User.not_leaders_of(current_user).order(last_name:"asc")
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

    def must_be_owner_to_view
      if current_user != @user
        redirect_back fallback_location: root_url, alert: "You're not authorized for that."
      end
    end 

end