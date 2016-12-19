class CalculationsController < ApplicationController

  def dashboard
    @job_count_by_location = Job.count_by_location
  end
end
