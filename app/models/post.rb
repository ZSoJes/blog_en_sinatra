class Post < ActiveRecord::Base
  # Remember to create a migration!
  validates :title, :presence => true
  validates :message, :presence => true

  has_many :blogs
  has_many :tags, through: :blogs
end
