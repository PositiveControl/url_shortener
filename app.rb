require 'sinatra/base'
require 'rerun'

class App < Sinatra::Application

  get '/' do
    erb :index
  end
end