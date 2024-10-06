class Profile < ApplicationRecord
  belongs_to :user

  has_many :projects, dependent: :destroy

  has_many :follower_relationships, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followed_profiles, through: :follower_relationships, source: :followed

  has_many :followed_relationships, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :followed_relationships, source: :follower

  has_one_attached :profile_pic

  def skill_sets=(value)
    super(value.split(',').map(&:strip))
  end
end
