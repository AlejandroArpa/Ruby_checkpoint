require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is valid with a body" do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it "is not valid without a body" do
    comment = build(:comment, body: nil)
    expect(comment).to_not be_valid
  end

  it "is not valid with a body longer than 510 characters" do
    comment = build(:comment, body: "a" * 511)
    expect(comment).to_not be_valid
  end

  it "is valid with a body between 3 and 510 characters" do
    comment = build(:comment, body: "a" * 510)
    expect(comment).to be_valid
  end

  it "is not valid with special characters in the body" do
    comment = build(:comment, body: "This is a comment!@#")
    expect(comment).to_not be_valid
  end

  it "is valid with letters, numbers, and spaces in the body" do
    comment = build(:comment, body: "This is a valid comment 123")
    expect(comment).to be_valid
  end

  it "has a custom error message for invalid body format" do
    comment = build(:comment, body: "Invalid#Comment")
    comment.valid?
    expect(comment.errors[:body]).to include("only allows letters, numbers, and spaces")
  end
end
