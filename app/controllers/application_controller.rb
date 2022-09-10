# require_all 'app'

class ApplicationController < Sinatra::Base


  # CREATING API IN CONTROLLER (C) TO HANDLE SERVER RESPONSE TO ACCESS DATA FROM MODEL (M) 

  # setting up content / response to json format
  set :default_content_type, 'application/json'


  # root dir server path/route
  get '/' do
    { message: "Hello world" }.to_json
  end


  # setting up a server to handle "/games" route
  get "/games" do 
    # USING ActiveRecord #Methods To access data from GAME_MODEL in database 

    # controlling response:
    # games = Game.all.order(:title)   #sorting response by title

    # games = Game.all.order(:title).limit(10)   #sorting response by title and limiting number of games returned

    games = Game.all   #returning all games - default sort, by game_id

    games.to_json    # return a json response of array of all games
  end

  # setting up Dynamic route to handle server response to any single game by game_id
  # get "/games/:id" do

  #   # look up the game in the database using its ID
  #   game = Game.find(params[:id])

  #   # return JSON-formatted response of the game data
  #   game.to_json
    
  # end

    #FETCHING GAME DATA WITH OTHER ASSOCIATED DATA (REVIEWS, USERS WHO POSTED REVIEWS)
    get '/games/:id' do
      game = Game.find(params[:id])
  
      # include associated reviews in the JSON response
      game.to_json(only: [:id, :title, :genre, :price], include: {
        reviews: { only: [:comment, :score], include: {
          user: { only: [:name] }
        } }
      })
    end



end
