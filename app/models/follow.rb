class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'Profile'
  belongs_to :followed, class_name: 'Profile'

  validates :follower_id, exclusion: { in: ->(follow) { [follow.followed_id] }, message: "can't follow yourself" }
end
