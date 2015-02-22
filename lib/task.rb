require 'colorize'

class Task <ActiveRecord::Base
  belongs_to :list
  belongs_to :user


  def mark_complete!
    self.update(done: true)
  end

  def add_due_date date
    self.update(due_date: date)
  end

  def display_item 
    color = if self.done == true
      :green
    else
      :red
    end
    done = self.done.to_s.colorize(color)
    puts
    print "#{item.id}  ".ljust(25) + "#{item.description}  ".ljust(25) +
    "#{item.due_date}  ".ljust(25) + "#{done}".ljust(25)
    puts
  end

  def self.random
    items = self.where("due_date is not null") 
    items = self.all if items == []
    random_id = items.map { |i| i.id}.sample
    self.find(random_id) 
  end

end