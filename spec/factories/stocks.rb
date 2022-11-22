FactoryBot.define do
  factory :stock do
    user
    symbol {"AMZN"}
    company_name {"Amazon"}
    shares {1}
    cost_price {123.123}
  end
end
