class SpotifyController < ApplicationController
  before_action(:spotify_authentication)

  #SPOTIFY APP LOGIN
  def spotify_authentication
    require 'rspotify'
    RSpotify.authenticate(ENV.fetch("Spotify_Client_ID"), ENV.fetch("Spotify_Client_Secret"))
  end

  def search_form
    render "song_search_form"
  end

  def return_search_results
    song_name = params.fetch("query_song_name")
    if song_name == ""
      redirect_to search_path, alert: "You didn't enter a song"
    else
      @tracks = RSpotify::Track.search(song_name, limit: 12, market: 'US')
      render "song_search_results"
    end
    
  end



end