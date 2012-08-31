require 'sinatra'
require 'sinatra/contrib'
require 'json'
require 'bundler/setup'
require 'active_resource'
require 'active_support/all'
require 'RMagick'
require "open-uri"

set :root, File.dirname(__FILE__)

configure do
  enable :session
end

class Imageify < Sinatra::Application

  get '/' do
    erb :import
  end

  post '/' do
    @post = params[:post]
  File.open("public/images/temp.jpg", "wb") do |fo|
    fo.write open(@post["image"]).read 
  end
    Annotate.process("public/images/temp.jpg", @post["message"], @post["font_family"], @post["font_size"].to_i, @post["color"], @post["x_coord"].to_i, @post["y_coord"].to_i)
    redirect '/images/annotate.jpg'
  end

  get '/result' do
    content_type 'image/jpg'
    'images/annotate.jpg'
  end

end

require_relative 'models/init'