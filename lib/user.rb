class User < ActiveRecord::Base
  has_many :lists
  has_many :tasks
  has_many :tasks, through: :lists

  def self.find_by_login name
    user = User.where(login: name).first_or_create!
  end

  def list_tasks arg
    if arg == 'nil'
      tasks = self.tasks.where(done: false)
    elsif arg == 'all'
      tasks = self.tasks.order(:done)
    else
      list = self.lists.find_by(name: arg)
      tasks = Task.where(list_id: list.id)
    end
    tasks
  end

  def add_task list, description
    list = self.lists.where(name: list).first_or_create!
    list.tasks.create(description: description)
  end
end
