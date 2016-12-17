class Category < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false }
end
