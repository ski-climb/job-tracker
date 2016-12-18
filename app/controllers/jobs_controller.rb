class JobsController < ApplicationController
  def index
    @company = find_company(params[:company_id])
    @jobs = @company.jobs
  end

  def new
    @company = find_company(params[:company_id])
    @job = Job.new()
  end

  def create
    @company = find_company(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      flash[:success] = "#{@job.title.capitalize} job at #{@company.name} was successfully created!"
      redirect_to job_path(@job)
    else
      @errors = @job.errors
      render :new
    end
  end

  def show
    @job = find_job(params[:id])
    @comment = Comment.new
  end

  def edit
    @company = find_company(params[:company_id])
    @job = find_job(params[:id])
  end

  def update
    @company = find_company(params[:company_id])
    @job = find_job(params[:id])
    if @job.update(job_params)
      redirect_to job_path(@job)
    else
      @errors = @job.errors
      render :edit
    end
  end

  def destroy
    job = find_job(params[:id])
    job.comments.destroy_all
    job.destroy
    @company = find_company(params[:company_id])
    flash[:success] = "#{job.title} at #{@company.name} was successfully deleted!"
    redirect_to company_jobs_path(@company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
