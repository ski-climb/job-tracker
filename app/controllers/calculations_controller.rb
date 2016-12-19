class CalculationsController < ApplicationController

  def dashboard
    @job_count_by_location = Job.count_by_location
    @job_count_by_level_of_interest = Job.count_by_level_of_interest
    @highest_ranked_companies = Job.highest_ranked_companies
  end
end
