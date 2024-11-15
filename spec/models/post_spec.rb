require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { build(:post, user: user) }

  it "creates a post with state true" do
    post = create(:post, :with_state_true, user: user)
    expect(post.state).to be true
  end

  # Validaciones
  it 'is valid with valid attributes' do
    post.title = "A valid title"
    post.body = "A valid body for the post"
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'is invalid without a body' do
    post.body = nil
    expect(post).to_not be_valid
  end

  # Método before_create :set_default_state
  it 'sets the default state to false before creation' do
    new_post = build(:post, state: nil, user: user)
    expect(new_post.state).to be_nil
    new_post.save
    expect(new_post.state).to be_falsey
  end

  # Relaciones
  it 'belongs to a user' do
    expect(post).to respond_to(:user)
  end

  it 'has many comments' do
    expect(post).to respond_to(:comments)
  end

  # Scopes
  describe 'scopes' do
    before do
      create(:post, user: user, state: true, created_at: 5.days.ago)
      create(:post, user: user, state: false, created_at: 2.days.ago)
    end

    it 'returns posts created in the last 30 days with state true' do
      posts = Post.added_in_last_30_days
      expect(posts.count).to eq(1)
      expect(posts.first.state).to eq(true)
    end

    it 'returns posts by a specific user' do
      posts = Post.yours_posts(user)
      expect(posts.count).to eq(2)
    end

    it 'returns available posts with state true' do
      posts = Post.post_availables
      expect(posts.count).to eq(1)
      expect(posts.first.state).to eq(true)
    end
  end

  # Enum
  it 'has a category enum' do
    expect(Post.categories[:poetry]).to eq(0)
    expect(Post.categories[:scifi]).to eq(1)
    expect(Post.categories[:mistery]).to eq(2)
    expect(Post.categories[:horror]).to eq(3)
    expect(Post.categories[:romance]).to eq(4)
  end
end
