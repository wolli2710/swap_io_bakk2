class CourseRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :description, :type => String

  attr_accessible :title, :description

  default_scope :order => "created_at DESC"

  has_and_belongs_to_many :users#, :uniq => true

  validates_presence_of :title, :description
end
