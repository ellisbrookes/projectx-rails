# db/seeds.rb
require 'faker'

# Create 9 non admin users
9.times do |_n|
  u = User.create(
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password123',
  )

  u.skip_confirmation!

  avatar_io = StringIO.new(Faker::Avatar.image(size: "50x50", format: "jpg"))
  avatar_io.rewind

  u.avatar.attach(io: avatar_io, filename: 'avatar.jpg', content_type: "image/jpg")
  u.save
end

# Create an admin user
u = User.create(
  full_name: Faker::Name.name,
  email: Faker::Internet.email,
  password: 'admin123',
  is_admin: '1',
)

u.skip_confirmation!
u.save

puts 'Seeded 9 users and 1 admin user into the database'

# Create a company with a title and description
10.times do |_n|
  Company.create(
    name: Faker::Company.name,
    description: Faker::Lorem.sentence(word_count: 20),
    email: Faker::Internet.email,
    user_id:
        Faker::Number.within(range: 1..9),
  )
end

puts 'Seeded 10 companies into the database'

# Create team
10.times do |_n|
  Team.create(
    name: Faker::Team.name,
    description: Faker::Lorem.sentence(word_count: 20),
    email: Faker::Internet.email,
    company_id: Faker::Number.within(range: 1..9),
  )
end

puts 'Seeded 10 teams in the database'

10.times do |_n|
  TeamMember.create(
    user_id: Faker::Number.within(range: 1..9),
    team_id: Faker::Number.within(range: 1..9),
  )
end

puts 'Seeded 10 team_members in the database'

# Create project
10.times do |_n|
  Project.create(
    title: Faker::Company.name,
    description: Faker::Lorem.sentence(word_count: 20),
    start_date: Faker::Date.backward(days: 30),
    completion_date: Faker::Date.forward(days: 30),
    team_id: Faker::Number.within(range: 1..9),
    company_id: Faker::Number.within(range: 1..9),
    estimated_budget: Faker::Commerce.price,
    actual_budget: Faker::Commerce.price,
  )
end

puts 'Seeded 10 projects into the database'

# Create tasks with description etc.
10.times do |_n|
  Task.create(
    name: Faker::Company.name,
    description: Faker::Lorem.sentence(word_count: 20),
    due_date: Faker::Date.backward(days: 30),
    project_id: Faker::Number.within(range: 1..9),
    status: Faker::Lorem.word,
    reporter_id: Faker::Number.within(range: 1..9),
    assigned_to_id: Faker::Number.within(range: 1..9),
    team_id: Faker::Number.within(range: 1..9),
  )
end

puts 'Seeded 10 tasks into the database'

# Create comment with body, user_id and task_id.
10.times do |_n|
  Comment.create(
    body: Faker::Lorem.sentence(word_count: 20).gsub(/[^0-9a-zA-Z\s]/, '')
    user_id: Faker::Number.within(range: 1..9),
    task_id: Faker::Number.within(range: 1..9),
  )
end

puts 'Seeded 10 comments into the database'

# Create sub tasks with description etc.
10.times do |_n|
  SubTask.create(
    name: Faker::Company.name,
    description: Faker::Lorem.sentence(word_count: 20),
    due_date: Faker::Date.backward(days: 30),
    project_id: Faker::Number.within(range: 1..9),
    status: Faker::Lorem.word,
    reporter_id: Faker::Number.within(range: 1..9),
    assigned_to_id: Faker::Number.within(range: 1..9),
    team_id: Faker::Number.within(range: 1..9),
    task_id: Faker::Number.within(range: 1..9),
  )
end

puts 'Seeded 10 sub_tasks into the database'
