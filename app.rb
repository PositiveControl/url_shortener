require 'sinatra/base'
require 'rerun'

class App < Sinatra::Application

  STORED_URLS = Array.new

  get '/' do
    erb :index
  end

  post '/urls' do
    new_url = Hash.new
    new_id = STORED_URLS.length.to_i + 1
    STORED_URLS.push(new_url[:id] = new_id, new_url[:url] = params[:url_entry])
    redirect ('/urls')
  end

  get '/urls' do
    erb :results, locals: {urls: STORED_URLS}
    erb :tester
  end
end