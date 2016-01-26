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
  id = params[:id].to_i
  @survey = Survey.find(id)
  @questions = @survey.questions()
  erb(:questions)
end

post('/surveys/:id') do
  @survey = Survey.find(params.fetch("id").to_i)
  @questions = @survey.questions()
  the_question = params.fetch("the_question")
  survey_id = params.fetch("survey_id")
  id = params.fetch("id")
  #question = Question.new({:the_question => the_question, :survey_id => survey_id, :id => nil})
  question = @survey.questions.new({:the_question => the_question})
  question.save()
  erb(:questions)
end

delete ('/surveys/:id/delete') do
  id = params[:id].to_i
  Question.delete(id)
  redirect '/surveys'
end
