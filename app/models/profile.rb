class Profile < ApplicationRecord
  belongs_to :user

  has_many :projects, dependent: :destroy

  has_many :follower_relationships, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followed_profiles, through: :follower_relationships, source: :followed
  has_many :followed_relationships, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :followed_relationships, source: :follower

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_one_attached :profile_pic

  def skill_sets=(value)
    super(value.split(',').map(&:strip))
  end

  scope :with_skill_set, lambda { |skill_sets|
    skill_array = skill_sets.split(',').map(&:strip).map(&:downcase)
    skill_array.map do |skill|
      where('lower(skill_sets::text) LIKE ?', "%#{skill}%")
    end.reduce(&:or)
  }
  scope :with_location, ->(location) { where('lower(city) = ?', location.downcase) }
  scope :with_years_of_experience, lambda { |years_of_experience|
    where('work_experience::text LIKE ?', "%\"years_of_experience\":\"#{years_of_experience}\"%")
  }
end
