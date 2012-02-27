require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  should 'be able to create course' do
    course = Factory.create(:course)
    assert course.valid?
  end

  should 'belong to user' do
    assert_difference "Course.count" do
      user = Factory.create(:user)
      course = Factory.create(:course, :user => user)
      assert_equal user.id, course.user_id
    end
  end

  should 'not be valid without user_id' do
    assert_raise ActiveRecord::StatementInvalid do
      Factory.create(:course, :user => nil)
    end
  end

  should 'not be valid without category_id' do
    assert_raise ActiveRecord::RecordInvalid do
      Factory.create(:course, :category => nil)
    end
  end

  should 'belong to category' do
    course = Factory.create(:course)
    assert_kind_of Category, course.category
  end

  should 'not be valid without title' do
    assert_no_difference "Course.count" do
      course = Factory.build(:course)
      course.title = ""
      course.save
    end
  end

  should 'not be valid without description' do
    assert_no_difference "Course.count" do
      course = Factory.build(:course)
      course.description = ""
      course.save
    end
  end

  should 'provide function create_course' do
    user = Factory.create(:user)
    category = Factory.create(:category)
    params = {"title" => "bli", "description" => "bla", "category_id" => category.id.to_s}
    course = Course.create_course params, user.id
    assert course.valid?
  end

  should 'validate course' do
    user = Factory.create(:user)
    category = Factory.create(:category)
    assert_raise ActiveRecord::RecordInvalid do
      params = {"title" => "bli", "description" => "bla", "category_id" => ""}
      Course.create_course params, user.id
    end
    assert_raise ActiveRecord::RecordInvalid do
      params = {"title" => "bli", "description" => "", "category_id" => category.id.to_s}
      Course.create_course params, user.id
    end
    assert_raise ActiveRecord::RecordInvalid do
      params = {"title" => "", "description" => "WTF", "category_id" => category.id.to_s}
      Course.create_course params, user.id
    end
    assert_nothing_raised ActiveRecord::RecordInvalid do
      params = {"title" => "white rabbit", "description" => "WTF", "category_id" => category.id.to_s}
      Course.create_course params, user.id
    end
  end

end
