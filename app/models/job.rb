class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, :category, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments

  scope :by_level_of_interest, -> { order 'level_of_interest DESC' }
  scope :by_location, -> { order 'city' }

  def company_name
    company.name
  end

  def category_title
    category.title
  end
end
