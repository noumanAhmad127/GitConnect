class Post < ApplicationRecord
  belongs_to :profile

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :likes, as: :likeable, dependent: :destroy

  has_many :comments, as: :commentable

  def self.tag_counts
    Tag.select('tags.*, count(post_tag.tag_id) as count').joins(:post_tag).group('post_tag.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  scope :by_tag, ->(tag) { joins(:tags).where(tags: { name: tag }) if tag.present? }

  # Scope to filter posts by popularity (most liked)
  scope :by_popularity, -> { left_joins(:likes).group(:id).order('COUNT(likes.id) DESC') }

  # Scope to filter posts by recency
  scope :by_recency, -> { order(created_at: :desc) }
end
