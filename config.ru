require 'sinatra'
# this loads all files in ./app , including ./app/controllers/ApplicationController server definition file
require_relative './config/environment.rb'

# run ApplicationController server definition file, imported from ./app/controllers
run ApplicationController
