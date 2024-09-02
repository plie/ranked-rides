FactoryBot.define do
  factory :ride do
    description { "Grocery Shop" }
    start_address { "1301 W 24th St, Austin, TX 78705" }
    destination_name { "H-E-B" }
    destination_address { "1000 E 41st St, Austin, TX, 78751" }
  end
end
