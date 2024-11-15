class PostsController < ApplicationController
  before_action :authenticate_admin!, only: [ :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show, :update ]
  before_action :set_post, only: %i[ show edit update destroy ]
  # before_action :set_post, only: [ :show, :edit, :update, :destroy ]


  # GET /posts
  def index
    if admin_signed_in?
      @posts = Post.all
    elsif params[:category].present?
      @posts = Post.where(category: params[:category], state: true)
    else
      @posts = Post.post_availables
    end
    @recent_posts = Post.added_in_last_30_days
    @yours_posts = user_signed_in? ? Post.yours_posts(current_user) : []
  end

  # GET /posts/1
  def show
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    @post.category = @post.category_before_type_cast if @post.category.is_a?(String)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      pp(post_params)
      redirect_to @post, notice: "Post was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
    redirect_to posts_url, notice: "Post was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :category, :state)
    end
end
