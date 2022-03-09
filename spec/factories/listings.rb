FactoryBot.define do
  factory :listing do
    title { "MyString" }
    description { "MyString" }
    price { 1 }
    condition { 1 }
    postcode { 1 }
    brand { "MyString" }
    model { "MyString" }
    finish { "MyString" }
    capacity { 1 }
    height { 1 }
    width { 1 }
    depth { 1 }
    energy_efficiency { 1 }
    sold { false }
    user { nil }
    category { nil }
  end
end
