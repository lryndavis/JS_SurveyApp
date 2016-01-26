require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/survey")
require("./lib/question")
require("pg")
require("pry")

get('/') do
  erb(:index)
end

get('/surveys') do
  @surveys = Survey.all()
  erb(:surveys)
end

get('/surveys/new') do
  erb(:survey_form)
end

post('/surveys') do
  Survey.create(params).save
  redirect ('/surveys')
end

get('/surveys/:id') do
  @questions = Question.all()
  @survey = Survey.find(params.fetch("id").to_i)
  erb(:questions)
end

post('/surveys/:id') do
  @survey = Survey.find(params.fetch("id").to_i)
  @questions = Question.all()
  the_question = params.fetch("the_question")
  survey_id = params.fetch("survey_id")
  id = params.fetch("id")
  question = Question.new({:the_question => the_question, :survey_id => nil, :id => nil})
  question.save()
  erb(:questions)
end
