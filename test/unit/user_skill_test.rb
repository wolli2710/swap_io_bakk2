require 'test_helper'

class UserSkillTest < ActiveSupport::TestCase

  should 'create user_skills for user' do
    user = Factory.create(:user)
    user.user_skills.create(title: "WTF")
    user.user_skills.create(title: "WTF")
    assert_equal user.user_skills.size, 2
  end

  should 'validate user_skills correct' do
    user = Factory.create(:user)
    user.user_skills.build(title: "" )
    assert_equal user.user_skills.first.valid?, false

    assert_raise Mongoid::Errors::Validations do
      user.save!
    end
  end

end
