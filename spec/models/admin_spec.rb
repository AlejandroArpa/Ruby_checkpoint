require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "is valid with valid attributes" do
    admin = build(:admin)
    expect(admin).to be_valid
  end

  it "is not valid without an email" do
    admin = build(:admin, email: nil)
    expect(admin).to_not be_valid
  end

  it "is not valid without a password" do
    admin = build(:admin, password: nil)
    expect(admin).to_not be_valid
  end

  it "is not valid with a short password" do
    admin = build(:admin, password: "short", password_confirmation: "short")
    expect(admin).to_not be_valid
  end
end
