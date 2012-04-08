class Category
  include Mongoid::Document

  has_many :courses

  validates_presence_of :title
end
