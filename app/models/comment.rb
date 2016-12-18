class Comment < ActiveRecord::Base
  validates :content, :job, presence: true
  belongs_to :job
end
