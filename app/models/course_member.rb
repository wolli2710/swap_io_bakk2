class CourseMember
  include Mongoid::Document
  include Mongoid::Timestamps

 # belongs_to :user

  embedded_in :course, :inverse_of => :course_members

  field :accepted, :type => Integer, :default => 2
  field :user_id, :type => String

#  validates_presence_of :user_id, :course_id
#  validates_uniqueness_of :user_id, :scope => :course_id

  # def self.update_user_acceptance id, acceptance
  #   course_member = self.find(id)
  #   course_member.update_attribute(:accepted, acceptance)
  #   if acceptance == "1"
  #     SystemMailer.accept_course_member(course_member.user, course_member.course).deliver
  #   elsif acceptance == "0"
  #     SystemMailer.reject_course_member(course_member.user, course_member.course).deliver
  #   end
  #   acceptance == "1" ? true : false
  # end

end
