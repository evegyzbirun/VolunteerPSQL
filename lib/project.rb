class Project

  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    return_projects = DB.exec('SELECT * FROM projects')
    projects = []
    return_projects.each() do |project|
      name = project.fetch("name")
      id = project.fetch("id").to_i
      projects.push(Project.new({ name: name , id: id }))
    end
    projects
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  
end 
