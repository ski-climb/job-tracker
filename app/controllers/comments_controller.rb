class CommentsController < ApplicationController

  def create
    @job = find_job(params[:job_id])
    @comment = @job.comments.new(comment_params)
    if @comment.save
      flash[:success] = "Comment was successfully created!"
      redirect_to job_path(@job)
    else
      flash[:danger] = "Comment can't be blank." 
      redirect_to job_path(@job)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
