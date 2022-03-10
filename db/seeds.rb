# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = ["Kitchen fridge", "Bar fridge", "Stand-alone freezer"]

if Category.count == 0
    categories.each do |category|
        Category.create(name: category)
        puts "created #{category} category"
    end
end

# create test data
if Listing.count == 0
    Listing.create(title: "Samsung 427L Bottom-mount Fridge", description: "Approximately four years old. I am selling because I am moving house. Perfect working order. Some superficial scratches and marks (see photos).", price: 15000, condition: 3, postcode: 3101, brand: "Samsung", model: "SRL456LS", finish: "Stainless Steel Facia", capacity: 427, height: 1700, width: 700, depth: 705, energy_efficiency: 4, user_id: 1, category_id: 1)
    puts "created a test listing"
end