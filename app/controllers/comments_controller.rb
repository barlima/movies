class CommentsController < ApplicationController
  
  def create
    @movie = Movie.find_by(params[:movie_id])
    @comment = Comment.new(comment_params)
    @comment.movie = @movie
    @comment.user = current_user

    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path, flash: { error: "Cannot create a comment" })
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path, notice: "Comment has been deleted" )
  end

  def top_commenters
    # get users comments from 7 days ago (at 00:00)
    @scores = Comment.where("created_at >= ?", 7.days.ago.to_date).group(:user).size
    @scores = @scores.sort_by{|k,v| v}.reverse.first(10)
  end

  private 

  def comment_params
    params.require(:comment).permit(:body)
  end
end