# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts "Cleaning database..."
SubTask.destroy_all
Task.destroy_all
Project.destroy_all
User.destroy_all

puts "Creating new instances for User, Project, Task & Subtask..."

# client = User.create(first_name: "Unassigned", last_name: "Unassigned", email: "unassigned@gmail.com", password: "123456", is_contractor: false, address: "Unassigned")
# contractor = User.create(first_name: "Test", last_name: "Test", email: "test@gmail.com", password: "123456", is_contractor: true, address: "Unassigned")

5.times do
  contractor = User.create(first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, email: Faker::Internet.email, password: "123456", is_contractor: true, address: Faker::Address.street_address)
  contractor.photo.attach(io: File.open(Rails.root.join('app/assets/images/contractor.jpeg')),
  filename: 'cat.jpeg')
  puts "Contractor with id: #{contractor.id} has been created"

  client = User.create(first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, email: Faker::Internet.email, password: "123456", is_contractor: false, address: Faker::Address.street_address)
  client.photo.attach(io: File.open(Rails.root.join('app/assets/images/client.jpeg')),
  filename: 'cat.jpeg')
  puts "Client with id: #{client.id} has been created"

  5.times do
    project = Project.create(name: Faker::Construction.subcontract_category, budget: 3000, completed: false, start_date: Date.today, end_date: Date.today + 14, description: Faker::Commerce.department, client: client, contractor: contractor)
    Message.create(content: "Hey there thanks for the project", user: client, project: project)
    Message.create(content: "No problem!", user: contractor, project: project)
    5.times do
      task = Task.create(name: Faker::Construction.subcontract_category, price: 300, completed: false, start_date: Date.today, end_date: Date.today + 14, description: Faker::Commerce.department, priority: "low", project: project)
      5.times do
        SubTask.create(name: Faker::Construction.subcontract_category, completed: false, description: Faker::Commerce.department, task: task)
      end
    end
  end
end

puts "Seeding completed! Enjoy the coding, Contio team."
