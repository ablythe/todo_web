require 'sinatra/base'
require 'pry'
require './db/setup'
require './lib/all'

class TodoWeb < Sinatra::Base
  enable :sessions

  def current_user
    username = session[:username]
    # request.env["HTTP_AUTHORIZATION"]
    User.find_by_login username
  end

  def login_checker
    if session[:username]
      return
    else
      session[:page_saver] = request.env["PATH_INFO"]
      redirect to('/login')
    end
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    session[:username] = params[:username]
    redirect to(session[:page_saver])
  end

  post "/add" do 
    current_user.add_task params['list'], params['task_description']
    redirect back    
  end

  post "/due" do 
    task = Task.find(params['id'])
    task.add_due_date params['due_date']
    redirect back
    end

  post "/complete" do
    task = Task.find(params['id'])
    task.mark_complete! 
    redirect back
  end

  get "/lists/:list/tasks" do
    login_checker
    @tasks = current_user.list_tasks params['list']
    erb :task_list
  end

  get "/lists/all/tasks/next" do 
    login_checker
    tasks = current_user.tasks.random
    tasks.to_json
  end

  get "/search" do 
    login_checker
    search_string = params['search']
    tasks = current_user.tasks.where("description like '%#{search_string}%'")
    tasks.to_json
  end
end

TodoWeb.run!
