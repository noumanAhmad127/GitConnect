class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :parent
  belongs_to :profile
end
