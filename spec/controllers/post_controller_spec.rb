require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe "GET #index" do
    context "when admin is signed in" do
      before do
        sign_in admin
        get :index
      end

      it "assigns all posts to @posts" do
        expect(assigns(:posts)).to eq(Post.all)
      end
    end

    context "when user is signed in" do
      before do
        sign_in user
        get :index
      end

      it "assigns available posts to @posts" do
        expect(assigns(:posts)).to eq(Post.post_availables)
      end

      it "assigns user's posts to @yours_posts" do
        expect(assigns(:yours_posts)).to eq(Post.yours_posts(user))
      end
    end

    context "when no user or admin is signed in" do
      it "assigns available posts to @posts" do
        get :index
        expect(assigns(:posts)).to eq(Post.post_availables)
      end
    end

    context "with category filter" do
      it "assigns posts filtered by category to @posts" do
        get :index, params: { category: 'poetry' }
        expect(assigns(:posts)).to eq(Post.where(category: 'poetry', state: true))
      end
    end
  end
end
