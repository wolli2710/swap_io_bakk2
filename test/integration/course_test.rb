require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course overview' do
    course1 = Factory.create(:course)
    course2 = Factory.create(:course)

    visit "/courses"

    assert page.has_content?('Begegnungen')
    assert page.has_content?(course1.title)
    assert page.has_content?(course1.description)
    assert page.has_content?(course2.title)
    assert page.has_content?(course2.description)
  end

  should 'show course show action' do
    course = Factory.create(:course)

    visit "/courses/#{course.id}"
    assert page.has_content?(course.title)
    assert page.has_content?(course.description)
  end

  should 'show course new action' do
    visit "/courses/new"
    assert page.has_content?("Titel")
    assert page.has_content?("Beschreibung")
  end

  should 'create new course' do
    visit "/courses/new"
    assert_difference("Course.count") do
      fill_in('course_title', :with => 'Java programmierung')
      fill_in('course_description', :with => 'Applikationsprogrammierung mit Java')
      click_on('Abschicken')
    end
    current_path.to_s == courses_path
    assert page.has_content?("Course created successfully")
  end

end
