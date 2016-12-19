class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, :category, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments

  scope :by_level_of_interest, -> { order 'level_of_interest DESC' }
  scope :by_location, -> { order 'city' }
  scope :for_location, ->(city) { where(city: city) }
  scope :count_by_location, -> { Job.group(:city).order('count_id DESC').count('id') }
  scope :count_by_level_of_interest, -> { Job.group(:level_of_interest).order('count_id DESC').count('id') }

  def company_name
    company.name
  end

  def category_title
    category.title
  end
end
