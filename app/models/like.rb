class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :likeable, polymorphic: true

  validates :profile_id, uniqueness: { scope: %i[likeable_id likeable_type] }
end
