require 'sinatra/base'
require 'pry'
require './db/setup'
require './lib/all'

class TodoWeb < Sinatra::Base

  def current_user
    username = request.env["HTTP_AUTHORIZATION"]
    User.find_by_login username
  end

  post "/lists/:list/tasks" do 
    current_user.add_task params['list'], params['task_name']
    'OK'
  end

  patch "/lists/:list/tasks/:id" do 
    task = Task.find(params['id'])
    if params['action'] == 'due'
      task.add_due_date params['due_date']
    else params['action'] == 'done'
      task.mark_complete! 
    end
    'OK'
  end

  get "/lists/:list/tasks" do
    tasks = current_user.list_tasks params['list']
    tasks.to_json
  end

  get "/lists/all/tasks/next" do 
    tasks = current_user.tasks.random
    tasks.to_json
  end

  get "/search" do 
    search_string = params['search']
    tasks = current_user.tasks.where("description like '%#{search_string}%'")
    tasks.to_json
  end
end

TodoWeb.run!
