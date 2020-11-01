class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @posts = @user.posts.page(params[:page]).per(10)
  end
  

  def following
    @user  = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(1)
    render 'show_follow'
end

def followers
  @user  = User.find(params[:id])
  @users = @user.followers.page(params[:page]).per(1)
  render 'show_follower'
end

end
