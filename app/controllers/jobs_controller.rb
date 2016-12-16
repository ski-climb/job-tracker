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
      redirect_to company_job_path(@company, @job)
    else
      @errors = @job.errors
      render :new
    end
  end

  def show
    @job = find_job(params[:id])
  end

  def edit
    @company = find_company(params[:company_id])
    @job = find_job(params[:id])
  end

  def update
    @company = find_company(params[:company_id])
    @job = find_job(params[:id])
    if @job.update(job_params)
      redirect_to company_job_path(@company, @job)
    else
      @errors = @job.errors
      render :edit
    end
  end

  def destroy
    # implement on your own!
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city)
  end

  def find_job(id)
    Job.find(id)
  end
end
