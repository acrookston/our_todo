# encoding: UTF-8
require 'sinatra'
require 'sinatra/base'
require 'haml'

Dir[File.dirname(__FILE__) + "/config/*.rb"].each {|file| require file  }
Dir[File.dirname(__FILE__) + "/helpers/*.rb"].each {|file| require file  }

class MyTodo < Sinatra::Base

  helpers Sinatra::CsrfHelper
  set :root, File.dirname(__FILE__)
  set :public, Proc.new { File.join(root, "public") }
  set :haml, {:format => :html5 }

  get '/' do
    todos = Todo.all
    haml :'index', :layout => :'layout', :locals => {
      :todos => todos
    }
  end

  post '/' do
    Todo.create(:title => params[:new_todo_item])unless params[:new_todo_item].empty?
    redirect '/'
  end

  get '/style.css' do
    content_type :css
    scss :'scss/style', :style => :compressed
  end
end
