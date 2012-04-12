module CoursesHelper

  def attend_course_link
    (current_user.id != @course.user.id) ? (@course.check_attendance(current_user.id)) : true
  end
end
