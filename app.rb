require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require("pg")

require ('dotenv/load')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker", :password => ENV['DATABASE_PASS']})

get('/') do
  @projects = Project.all
  erb(:projects)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/new') do
  erb(:project_new)
end

post('/projects') do
  name = params[:project_name]
  project = Project.new({:name => name, :id => nil})
  project.save()
  redirect to('/projects')
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:name])
  redirect to('/projects')
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  redirect to('/projects')
end