require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should "be able to create user" do
    assert_difference "User.count" do
      user = Factory.create(:user)
      assert_kind_of User, user
    end
  end

  should "not be able to create user without email" do
    assert_no_difference "User.count" do
      user = Factory.build(:user, :email => "")
      user.save
    end
  end

  should "not be able to create user without password" do
    assert_no_difference "User.count" do
      user = Factory.build(:user, :password => "")
      user.save
    end
  end

  should "not be able to create user without zip" do
    assert_no_difference "User.count" do
      user = Factory.build(:user, :zip => "")
      user.save
      user = Factory.build(:user, :zip => "ABCD")
      user.save
    end
  end

  should "have job field" do
    assert_difference "User.count" do
      user = Factory.create(:user, :job => "Computerer")
      assert_equal user.job, "Computerer"
    end
  end

  should "have motivation field" do
    assert_difference "User.count" do
      user = Factory.create(:user, :motivation => "motivation...field")
      assert_equal user.motivation, "motivation...field"
    end
  end

  should "have many courses" do
    assert_difference "Course.count", 2 do
      user   = Factory.create(:user)
      Factory.create(:course, :user_id => user.id)
      Factory.create(:course, :user_id => user.id)
    end
  end

  should "have many course_requests" do
    assert_difference "CourseRequest.count", 2 do
      user =  Factory.create(:user)
      user.course_requests.create(:title => "test", :description => "bli")
      user.course_requests.create(:title => "test", :description => "bliep")
      user.course_requests.each do |f|
        assert_equal f.title, "test"
      end
    end
  end

  context "course_request_exist?" do
    should "find existing course_request" do
      user =  Factory.create(:user)
      course_request = user.course_requests.create(:title => "test", :description => "bli")
      assert_equal true, user.has_course_request?(course_request)
    end

    should "not find course_requests of other users" do
      user =  Factory.create(:user)
      user2 =  Factory.create(:user)
      course_request = user.course_requests.create(:title => "test", :description => "bli")
      assert_equal false, user2.has_course_request?(course_request)
    end
  end

  context "join_course_request" do
    should "join_course_request if not already joined" do
      user =  Factory.create(:user)
      course_request = Factory(:course_request)
      assert_equal [course_request], user.join_course_request(course_request)
      assert_equal false, user.join_course_request(course_request)
    end
  end

  context 'disjoin_course_request' do
    should 'disjoin course request for last user correct' do
      user = Factory.create(:user)
      course_request = Factory(:course_request)
      user.join_course_request(course_request)
      assert_not_nil course_request
      user.disjoin_course_request(course_request)
      assert CourseRequest.find_by_id(course_request.id).nil?
    end

    should 'not delete course request for last user' do
      user1 = Factory.create(:user)
      user2 = Factory.create(:user)
      course_request = Factory(:course_request)
      user1.join_course_request(course_request)
      user2.join_course_request(course_request)
      user1.disjoin_course_request(course_request)
      assert_not_nil CourseRequest.find_by_id(course_request.id)
    end

    should 'not be able to disjoin course request twice' do
      user1 = Factory.create(:user)
      user2 = Factory.create(:user)
      course_request = Factory(:course_request)
      user1.join_course_request(course_request)
      user2.join_course_request(course_request)
      user1.disjoin_course_request(course_request)
      user1.disjoin_course_request(course_request)
      assert_not_nil CourseRequest.find_by_id(course_request.id)
    end
  end

end
