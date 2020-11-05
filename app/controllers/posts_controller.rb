class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy, :update]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @posts = Post.includes(:user).order('created_at DESC').page(params[:page]).per(5)
    @post = Post.includes(:user)
    @posts = Post.tagged_with(params[:tag_name]).page(params[:page]).per(10) if params[:tag_name]
    @tags = Post.tag_counts_on(:tags).order('count DESC')
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if user_signed_in? && @post.user == current_user
      @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in? && @post.user == current_user
      post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    @posts = Post.searchtext(params[:keyword])
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
