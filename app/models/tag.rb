class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  # no need to put source because we follow conventions
  has_many :questions, through: :taggings

  validates :name, presence: true, uniqueness: true

end
