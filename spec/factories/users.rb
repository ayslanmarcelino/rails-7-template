FactoryBot.define do
  factory(:user) do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    active { true }

    before :create do |resource|
      resource.person = create(:person, owner: resource)
    end
  end
end
