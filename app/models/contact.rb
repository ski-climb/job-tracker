class Contact < ActiveRecord::Base
  belongs_to :company

  validates :name, :email, :company, presence: true
end
