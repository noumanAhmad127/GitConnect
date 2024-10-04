class Profile < ApplicationRecord
  belongs_to :user

  def skill_sets=(value)
    super(value.split(',').map(&:strip))
  end
end
