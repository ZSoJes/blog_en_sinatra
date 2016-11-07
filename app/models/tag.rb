class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many :blogs
  has_many :posts, through: :blogs

  def self.nuevo_create(list_tags)
    lista = list_tags.split(",")
    lista.each do |t|
    t = t.rstrip.lstrip
    self.create(etiquetas: t)
    end
  end
end
