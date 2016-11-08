class Post < ActiveRecord::Base
  # Remember to create a migration!
  validates :titulo, :presence => true, uniqueness: true
  validates :mensaje, :presence => true

  has_many :blogs
  has_many :tags, through: :blogs
end
