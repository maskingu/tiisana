class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @posts = Post.includes(:user).order("created_at DESC")
    @post = Post.includes(:user)
  end

  def show
    @posts = Post.includes(:user).order("created_at DESC")
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order("created_at DESC")
    user = User.find(params[:id])
    @user = User.find(params[:id])
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
    @post = Post.find(params[:id])
  if @post.update(post_params)
    redirect_to root_path
  else
    render :edit
  end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
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
      params.require(:post).permit(:title, :content, :image, :likes_count).merge(user_id: current_user.id)
    end
    
    def move_to_index
      unless user_signed_in?
      redirect_to action: :index 
      end
    end
end
