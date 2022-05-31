Task.destroy_all
Project.destroy_all
User.destroy_all

alexandra = User.create!(email: "task@task.com", password: "tasktask", name: 'Alexandra')
new_app = Project.create!(user: alexandra, name: "New App")
puts new_app.name

Task.create!(
  name: "Set up new app",
  estimated_time: 30,
  user: alexandra,
  project: new_app,
  # trello_id: 1
)


Task.create!(
  name: "Feature 1",
  estimated_time: 45,
  user: alexandra,
  project: new_app,
  # trello_id: 2
)

Task.create!(
  name: "Feature 2",
  estimated_time: 20,
  user: alexandra,
  project: new_app,
  # trello_id: 3
)
