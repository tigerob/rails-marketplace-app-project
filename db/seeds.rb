# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# create categories and features

categories = ["Kitchen fridge", "Bar fridge", "Stand-alone freezer"]

if Category.count == 0
    categories.each do |category|
        Category.create(name: category)
        puts "created #{category} category"
    end
end

features = ["Ice dispenser", "Water dispenser", "Adjustable shelves", "Door-open alarm", "LED lights", "Electronic temperature control", "Frost-free freezer", "Reversible door"]

if Feature.count == 0
    features.each do |feature|
        Feature.create(name: feature)
        puts "created #{feature} feature"
    end
end

# create test data

if User.count == 0
    user_1 = User.create! :email => "test@test.com", :password => "test12", :password_confirmation => "test12"
    puts "created a test user"
    user_2 = User.create! :email => "test2@test.com", :password => "test12", :password_confirmation => "test12"
    puts "created a test user"
end

if Listing.count == 0
    Listing.create(title: "Samsung 427L Bottom-mount Fridge", description: "Approximately four years old. I am selling because I am moving house. Perfect working order. Some superficial scratches and marks (see photo).", price: 250, condition: 3, postcode: 3101, brand: "Samsung", model: "SRL456LS", finish: "Stainless Steel Facia", capacity: 427, height: 1700, width: 700, depth: 705, energy_efficiency: 4, user_id: 1, category_id: 1)
    puts "created a test listing"

    Listing.create(title: "Euromaid 87L Top-Mount Bar Fridge", description: "Never used. I won this item in a raffle.", price: 120, condition: 1, postcode: 3101, brand: "Euromaid", model: "ETM87W", finish: "White cabinet/facia", capacity: 87, height: 850, width: 480, depth: 520, energy_efficiency: 2, user_id: 1, category_id: 1)
    puts "created a test listing"

    Listing.create(title: "Haier 519L Chest Freezer", description: "Approximately eight years old. Works fine, but has been reasonably well used.", price: 80, condition: 4, postcode: 3101, brand: "Haier", model: "Unknown", finish: "White cabinet", capacity: 519, height: 845, width: 1645, depth: 745, energy_efficiency: 3, user_id: 1, category_id: 3)
    puts "created a test listing"
end