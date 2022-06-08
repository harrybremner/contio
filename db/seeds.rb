# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts "Cleaning database..."
User.destroy_all
Project.destroy_all
Task.destroy_all
SubTask.destroy_all

puts "Creating new instances for User, Project, Task & Subtask..."

client = User.create(first_name: "Unassigned", last_name: "Unassigned", email: "unassigned@gmail.com", password: "123456", is_contractor: false, address: "Unassigned")
contractor = User.create(first_name: "Test", last_name: "Test", email: "test@gmail.com", password: "123456", is_contractor: true, address: "Unassigned")



5.times do
  contractor = User.create(first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, email: Faker::Internet.email, password: "123456", is_contractor: true, address: Faker::Address.street_address)

  puts "Contractor with id: #{contractor.id} has been created"

  client = User.create(first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, email: Faker::Internet.email, password: "123456", is_contractor: false, address: Faker::Address.street_address)

  puts "Client with id: #{client.id} has been created"

  project = Project.create(name: Faker::Hobby.activity, budget: 3000, completed: false, start_date: Date.today, end_date: Date.today + 14, description: Faker::Commerce.department, client: client, contractor: contractor)

  puts "Project with id: #{project.id} has been created"


  5.times do
    task = Task.create(name: Faker::Hobby.activity, price: 300, completed: false, start_date: Date.today, end_date: Date.today + 14, description: Faker::Commerce.department, priority: "low", project: project)
    5.times do
      SubTask.create(name: Faker::Hobby.activity, completed: false, description: Faker::Commerce.department, task: task)
    end

  end
end

puts "Seeding completed! Enjoy the coding, Contio team."
