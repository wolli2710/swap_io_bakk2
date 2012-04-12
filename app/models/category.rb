class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  #has_many :courses

  field :title, :type => String

  attr_accessible :title
  validates_presence_of :title
end
