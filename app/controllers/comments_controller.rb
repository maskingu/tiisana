class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = '文字を入力してください'
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメント削除しました'
      redirect_back(fallback_location: post_path)
  end

  
  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
