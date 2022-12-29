FactoryBot.define do
  factory(:user) do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    active { true }

    person { create(:person, kind: 'user') }
  end
end
