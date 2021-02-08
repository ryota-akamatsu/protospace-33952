class CommentsController < ApplicationController
  def create
    
    @comment = Comment.new(comment_params)
    @prototype = Prototype.find(params[:prototype_id])
    @comments = @prototype.comments

    if @comment.save
      redirect_to prototype_path(@prototype.id) # 今回の実装には関係ありませんが、このようにPrefixでパスを指定することが望ましいです。
    else
      
    
      render  "/prototypes/show" # views/tweets/show.html.erbのファイルを参照しています。
    end
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user_id:current_user.id,prototype_id:params[:prototype_id])
  end
end
