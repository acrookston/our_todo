# encoding: UTF-8
require 'sinatra'
require 'sinatra/base'
require 'haml'
require 'json'

Dir[File.dirname(__FILE__) + "/config/*.rb"].each {|file| require file  }
Dir[File.dirname(__FILE__) + "/helpers/*.rb"].each {|file| require file  }

class OurTodo < Sinatra::Base

  helpers Sinatra::CsrfHelper
  set :root, File.dirname(__FILE__)
  set :public, Proc.new { File.join(root, "public") }
  set :haml, {:format => :html5 }

  get '/.?:format?' do
    haml :'index', :layout => :'layout', :locals => {
      :todos => Todo.all(:sort => [[:completed, :asc], [:created_at, :desc]])
    }
  end

  post '/items.?:format?' do
    item = Todo.create(:title => params[:title]) if params[:title]
    if params[:format] == 'json'
      content_type :json
      if item
        { :id => item.id }.to_json
      else
        { :error => true }.to_json
      end
    else
      redirect '/'
    end
  end

  put %r{/item/([\w]+)\.?([\w]*)} do |id,format|
    item = Todo.find(id)
    attributes = params.reject{|key, val| key == :title || key == :title }
    success = item.update_attributes(attributes) if item && attributes.length > 0
    success ||= false

    if format == 'json'
      content_type :json
      {:success => success}.to_json
    else
      redirect '/'
    end
  end
end
