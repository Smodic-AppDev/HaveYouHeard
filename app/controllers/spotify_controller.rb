class SpotifyController < ApplicationController
  #before_action(:spotify_authentication)

  #SPOTIFY APP LOGIN
  def spotify_authentication
    require 'rspotify'
    RSpotify.authenticate(ENV.fetch("Spotify_Client_ID"), ENV.fetch("Spotify_Client_Secret"))
  end

  def search_form
    render "song_search_form"
  end

  def return_search_results
    render "song_search_results"
  end



  end