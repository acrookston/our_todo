# encoding: UTF-8
require 'sinatra/base'
require 'haml'

class MyTodo < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public, Proc.new { File.join(root, "public") }
  set :haml, {:format => :html5 }
  
  get '/' do
    haml :'index', :layout => :'layout', :locals => { }
  end
  
  get '/style.css' do
    content_type :css
    scss :'scss/style', :style => :compressed
  end
end
