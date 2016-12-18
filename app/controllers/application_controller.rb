class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def find_company(id)
      Company.find(id)
    end

    def find_job(id)
      Job.find(id)
    end
end
