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

get('/surveys/:id/edit') do
  @survey = Survey.find(params.fetch("id").to_i)
  erb(:survey_edit)
end

post('/surveys/:id') do
  @survey = Survey.find(params.fetch("id").to_i)
  @questions = @survey.questions()
  the_question = params.fetch("the_question")
  survey_id = params.fetch("survey_id")
  id = params.fetch("id")
  question = @survey.questions.new({:the_question => the_question})
  question.save()
  erb(:questions)
end

get('/surveys/:id/delete') do
  @survey = Survey.find(params.fetch("id").to_i)
  @survey.delete
  redirect ('/surveys')
end

delete('/questions/:id') do
  @question = Question.find(params.fetch("id").to_i)
  @survey = @question.survey()
  @questions = @survey.questions()
  id = params[:id].to_i
  Question.delete(id)
  erb(:questions)
end

get('/questions/:id/edit') do
  @question = Question.find(params.fetch("id").to_i)
erb(:question_edit)
end

patch('/questions/:id') do
  the_question = params.fetch("the_question")
  @question = Question.find(params.fetch("id").to_i)
  @survey = @question.survey()
  @questions = @survey.questions()
  @question.update({:the_question => the_question})
  erb(:questions)
end

#other patch/delete format that does NOT redirect to /:id page
# patch('/questions/:id') do
#   the_question = params.fetch("the_question")
#   @question = Question.find(params.fetch("id").to_i)
#   @question.update({:the_question => the_question})
#   redirect ('/surveys')
# end

patch('/surveys/:id') do
  @surveys = Survey.all()
  name = params.fetch("name")
  @survey = Survey.find(params.fetch("id").to_i)
  @survey.update({:name => name})
  erb(:surveys)
end
