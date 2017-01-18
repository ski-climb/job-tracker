class Contact < ActiveRecord::Base
  belongs_to :company

  validates :name, presence: true

  def company_name
    company ? company.name : ""
  end
end
