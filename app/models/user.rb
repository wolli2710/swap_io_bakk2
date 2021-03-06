class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :zip, :confirmed_at, :user_images_attributes,
                  :description, :user_skills_attributes, :job, :motivation

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :zip
  validates :zip, :numericality => { :only_integer => true }

  has_many :courses, :dependent => :destroy
  has_many :course_members, :through => :courses

  has_and_belongs_to_many :course_requests

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else
      user = User.new(:email => data.email,
                      :first_name => data.first_name,
                      :last_name => data.last_name)
      user
    end
  end

  def has_course_request?(course_request)
    self.course_requests.find_by_id(course_request.id) ? true : false
  end

  def join_course_request(course_request)
    self.has_course_request?(course_request) ? false : self.course_requests << course_request
  end

  def disjoin_course_request(course_request)
      self.course_requests.delete(course_request)
  end

  def get_courses
    self.courses
  end

  def get_course_requests
    self.course_requests
  end

  def get_accepted_course_memberships
    CourseMember.find_all_by_user_id_and_accepted(self.id, 1)
  end

end
