require 'test_helper'

class CourseMembersTest < ActiveSupport::TestCase

  should "be able to attend course" do
    user = Factory.create(:user)
    course = Factory.create(:course)
    attendance = course.course_members.create(:user_id => user.id)

    assert_kind_of CourseMember, attendance
  end

  should "check_course_member for existing user course pairs" do
    user1 =  Factory.create(:user)
    user2 =  Factory.create(:user)
    course =  Factory.create(:course)
    attendance = course.course_members.create(:user_id => user1.id)

    assert course.check_attendance(user1.id)
    assert !course.check_attendance(user2.id)
  end

end
