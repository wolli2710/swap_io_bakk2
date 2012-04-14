class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

   field :first_name, :type => String
   field :last_name, :type => String
   field :zip, :type => Integer
   field :job, :type => String
   field :motivation, :type => String
   field :description, :type => String

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
   field :confirmation_token,   :type => String
   field :confirmed_at,         :type => Time
   field :confirmation_sent_at, :type => Time
   field :unconfirmed_email,    :type => String # Only if using reconfirmable

  has_many :courses, :dependent => :destroy
  has_many :course_requests, :dependent => :destroy
 # has_many :course_members #, :through => :courses

  has_and_belongs_to_many :course_requests #, :uniq => true

  embeds_many :user_skills
  #accepts_nested_attributes_for :user_skills

  embeds_many :user_images


  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :zip, :confirmed_at, :user_images_attributes,
                  :description, :user_skills_attributes, :job, :motivation, :unconfirmed_email

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :password
  validates_presence_of :email
  validates_presence_of :zip
  validates :zip, :numericality => { :only_integer => true }


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

  def has_course_request?(course_request_id)
    return true if self.course_request_ids.include? course_request_id
    false
  end

  def join_course_request(course_request_id)
    if self.has_course_request?(course_request_id)
      false
    else
      self.course_request_ids << course_request_id
      self.save
      cr = CourseRequest.find(course_request_id)
      cr.user_ids << self.id
      cr.save
      true
    end
  end

  def disjoin_course_request(course_request_id)
    cr = CourseRequest.find(course_request_id)
    if cr.user_ids.size > 0
      cr.user_ids.delete(self.id)
      cr.save
      true
    else
      false
    end
  end

  def get_courses
    self.courses
  end

  def get_course_requests
    self.course_requests
  end

  def get_accepted_course_memberships
    course_members = []
    self.courses.where(user_id: self.id).each do |f|
      f.course_members.each do |cm|
        course_members << cm if cm.accepted == 1
      end
    end
    course_members
  end

end
