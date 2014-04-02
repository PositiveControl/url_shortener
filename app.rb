require 'sinatra/base'
require 'uri'

class App < Sinatra::Application

  STORED_URLS = Array.new
  ERRORMESSAGE = []

  get '/' do
    erb :index, locals: {error_message: ERRORMESSAGE}
  end

  post '/urls' do

    if params[:url_entry].empty?
      ERRORMESSAGE << "URL cannot be blank"
      redirect ('/')
    elsif (params[:url_entry] =~ /^#{URI::regexp}$/) == nil
      ERRORMESSAGE << "The text you entered is not a valid URL"
      redirect ('/')
    else
      new_url = Hash.new
      new_url[:id] = STORED_URLS.length + 1
      new_url[:entered_url] = params[:url_entry]
      STORED_URLS << new_url
      ERRORMESSAGE.clear
      redirect ('/urls')
    end
  end

  get '/urls' do
    urlid = STORED_URLS.length - 1
    erb :results, locals: {urls: STORED_URLS, url_id: urlid}
  end

  get '/:id' do
    url_acces = params[:id].to_i - 1
    orig_url = STORED_URLS[url_acces][:entered_url]
    redirect orig_url
  end

  get '/urls/invalid' do
    erb :invalid_url
  end

end