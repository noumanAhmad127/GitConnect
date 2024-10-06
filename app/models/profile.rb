class Profile < ApplicationRecord
  belongs_to :user

  has_many :projects, dependent: :destroy

  has_one_attached :profile_pic

  def skill_sets=(value)
    super(value.split(',').map(&:strip))
  end
end
