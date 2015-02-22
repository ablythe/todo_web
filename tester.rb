require 'httparty'
require 'pry'

url = "http://localhost:4567" # update this if needed

HTTParty.post "#{url}/lists/Homework/tasks", body: { task_name: 'English' }, 
headers: {
      'Authorization' => "ablythe2",
      'User-Agent'    => 'todobot'
    }
sleep 1
binding.pry
HTTParty.patch "#{url}/lists/Homework/tasks/32", body: { action: 'due', due_date: '2015/3/17' }, headers: {
      'Authorization' => "ablythe",
      'User-Agent'    => 'todobot'
    }
sleep 1

HTTParty.patch "#{url}/lists/Homework/tasks/32", body: { action: 'done' }, headers: {
      'Authorization' => "ablythe",
      'User-Agent'    => 'todobot'
    }

sleep 1

puts HTTParty.get "#{url}/search", body: { search: 'English' }, headers: {
      'Authorization' => "ablythe",
      'User-Agent'    => 'todobot'
    }
sleep 1

puts HTTParty.get "#{url}/lists/nil/tasks", body: { search: 'English' }, headers: {
      'Authorization' => "ablythe",
      'User-Agent'    => 'todobot'
    }
sleep 1

puts HTTParty.get "#{url}/lists/all/tasks", body: { search: 'English' }, headers: {
      'Authorization' => "ablythe",
      'User-Agent'    => 'todobot'
    }
sleep 1

puts HTTParty.get "#{url}/lists/all/tasks", body: { search: 'English' }, headers: {
      'Authorization' => "ablythe2",
      'User-Agent'    => 'todobot'
    }
sleep 1

puts HTTParty.get "#{url}/lists/Homework/tasks", body: { search: 'English' }, headers: {
      'Authorization' => "ablythe",
      'User-Agent'    => 'todobot'
    }
sleep 1
puts HTTParty.get "#{url}/lists/all/tasks/next", body: { search: 'English' }, headers: {
      'Authorization' => "ablythe",
      'User-Agent'    => 'todobot'
    }



sleep 1

