class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  default_scope :order => "created_at DESC"

  field :user_id, :type => String
  field :category_id, :type => String
  field :title, :type => String
  field :description, :type => String

  belongs_to :user
  belongs_to :category
  embeds_many :course_members

  validates_presence_of :title, :description, :category_id, :user_id
  attr_accessible :user_id, :category_id, :title, :description

  def provide_course_mailer course_request
    course_request.user_ids.each do |u|
      User.find(u)
      user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
      course_request_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{self.id}"
      SystemMailer.provide_course(user, user_link, course_request_link).deliver
    end
  end

  def self.delete_course user_id, id
    course = self.find(id)
    return unless user_id == course.user_id
    course.get_course_members.each do |member|
      user = User.find(member.user_id)
      SystemMailer.private_message(user, I18n.t('course.destroy.subject'),
                  I18n.t('course.destroy.body', :name => "#{user.first_name} #{user.last_name}") ).deliver
    end
    course.destroy
  end

  def self.course_member_request user, id
    course = self.find(id)
    user_link = "http://wissenteilen.com/#{I18n.t('routes.users.as')}/#{user.id}"
    course_link = "http://wissenteilen.com/#{I18n.t('routes.courses.as')}/#{course.id}"
    SystemMailer.request_course(course.user, user_link, course_link).deliver
  end

  def get_course_members
    self.course_members.all
  end

  def check_attendance(user_id)
    self.course_members.where(user_id: user_id).exists?
  end

  def update_user_acceptance id, acceptance
    course_member = self.course_members.where(:user_ids => id).first
    puts course_member
    user = User.find(course_member.user_ids)
    course_member.accepted = acceptance
    course_member.save
    if acceptance == "1"
      SystemMailer.accept_course_member(user, course_member.course).deliver
    elsif acceptance == "0"
      SystemMailer.reject_course_member(user, course_member.course).deliver
    end
    acceptance == "1" ? true : false
  end



end
