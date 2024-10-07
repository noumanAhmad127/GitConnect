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

  def self.filter(params)
    profiles = Profile.all

    # Filter by skill sets
    if params[:skill_sets].present?
      skill_set_array = params[:skill_sets].split(',').map(&:strip)
      skill_set_array.each do |skill|
        profiles = profiles.where('skill_sets @> ?', [skill].to_json)
      end
    end

    # Filter by city
    profiles = profiles.where(city: params[:city]) if params[:city].present?

    # Filter by years of experience
    if params[:years_of_experience].present?
      profiles = profiles.where('years_of_experience >= ?', params[:years_of_experience])
    end

    profiles
  end
end
