class UserSkill
  include Mongoid::Document

  field :title, :type => String

  embedded_in :user, :inverse_of => :user_skills

  validates_presence_of :title
  validates_length_of :title, :minimum => 3, :maximum => 256

end
