FactoryGirl.define do
  factory :venue do
    name     "Awesome Bar"
    email    "venue@example.com"
    phone 	 "0412345678"
    website  "http://www.example.com"
    street 	 "23 King Street"
    suburb 	 "Newtown"
    region   "Inner West"
    postcode "2042"
  end
end