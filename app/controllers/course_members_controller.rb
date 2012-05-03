class CourseMembersController < ApplicationController

  def create
    course = Course.find(params[:course_id])
    if course.course_members.create(:user_id => current_user.id)
      Course.course_member_request current_user, course.id
      flash[:message] = I18n.t('course_member.create.success')
      redirect_to courses_path
    else
      flash[:error] = I18n.t('course_member.create.fail')
      redirect_to course_path(course.id)
    end
  end

  def update
    course = Course.where("course_members._id" => BSON::ObjectId(params[:id])).first
    if course_member = course.update_user_acceptance(params[:id], params[:acceptance])
      flash[:message] = I18n.t('course_member.update.success')
    elsif course_member == false
      flash[:message] = I18n.t('course_member.update.rejected')
    else
      flash[:error] = I18n.t('course_member.update.fail')
    end
    redirect_to root_path
  end


end
