FactoryBot.define do
  factory :purchase do
    listing { nil }
    buyer { nil }
    seller { nil }
    payment_id { "MyString" }
    receipt_url { "MyString" }
  end
end
