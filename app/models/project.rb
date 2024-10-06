class Project < ApplicationRecord
  belongs_to :profile

  has_many_attached :images

  validates :title, presence: true
end
