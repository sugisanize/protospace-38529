class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/prototypes/#{@comment.prototype.id}"
    else
      @prototype = @comment.prototype # なぜこの記述が必要なのか説明できない
      @comments = @prototype.comments.includes(:user) # なぜこの記述が必要なのか説明できない
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end