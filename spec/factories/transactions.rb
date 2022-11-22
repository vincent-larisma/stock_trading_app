FactoryBot.define do
  factory :transaction do
    user
    action_type {"sell"}
    company_name {"Amazon"}
    shares {1}
    cost_price {123.123}
  end
end
