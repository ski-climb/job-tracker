class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, :category, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments

  scope :by_level_of_interest, -> { order 'level_of_interest DESC' }
  scope :by_location, -> { order 'city' }
  scope :for_location, ->(city) { where(city: city) }
  scope :count_by_location, -> { group(:city).order('count_id DESC').count('id') }
  scope :count_by_level_of_interest, -> { group(:level_of_interest).order('count_id DESC').count('id') }
  scope :rank_companies, -> { group(:company).average(:level_of_interest) }

  def company_name
    company.name
  end

  def category_title
    category.title
  end

  def self.highest_ranked_companies
    rank_companies.to_a.map do |company, average_interest|
      [average_interest.round(0).to_i, company.name]
    end.sort.reverse.take(3)
  end
end
