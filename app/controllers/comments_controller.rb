class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    redirect_to post_path(@post)
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
