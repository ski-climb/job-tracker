class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "Company, #{@company.name}, was successfully created!"
      redirect_to company_path(@company)
    else
      @errors = @company.errors
      render :new
    end
  end

  def show
    @company = find_company(params[:id])
    @jobs = @company.jobs
    @contact = Contact.new
  end

  def edit
    @company = find_company(params[:id])
  end

  def update
    @company = find_company(params[:id])
    @company.update(company_params)
    if @company.save
      flash[:success] = "#{@company.name} updated!"
      redirect_to company_path(@company)
    else
      @errors = @company.errors
      render :edit
    end
  end

  def destroy
    company = find_company(params[:id])
    company.jobs.destroy_all
    company.delete

    flash[:success] = "#{company.name} and all associated jobs for #{company.name} were successfully deleted!"
    redirect_to companies_path
  end


  private

  def company_params
    params.require(:company).permit(:name, :city)
  end
end
