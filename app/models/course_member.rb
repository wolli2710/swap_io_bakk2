class CourseMember
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :course, :inverse_of => :course_members

  field :accepted, :type => Integer, :default => 2
  field :user_id, :type => String

  validates_presence_of :user_id
  validates_uniqueness_of :user_id
end
