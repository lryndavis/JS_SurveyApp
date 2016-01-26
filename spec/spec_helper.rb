ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require('sinatra/activerecord')
require("survey")
require("question")


RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM surveys *;")
    DB.exec("DELETE FROM questions *;")
  end
end
