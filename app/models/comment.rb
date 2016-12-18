class Comment < ActiveRecord::Base
  validates :content, :job, presence: true
  belongs_to :job

  def display_time
    created_at.strftime('%d %b %Y, %l:%M %p')
  end
end
