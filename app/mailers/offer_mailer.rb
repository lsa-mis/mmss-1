class OfferMailer < ApplicationMailer
  default from: 'University of Michigan MMSS High School Summer Program <mmss@umich.edu>'

  def offer_email(user)
    @user = User.find(user)
    @offer_letter_text = CampConfiguration.active.last.offer_letter
    @application = ApplicantDetail.find_by(user_id: user)
    @enrollment = Enrollment.current_camp_year_applications.find_by(user_id: user)
    @assigned_courses = @enrollment.course_assignments
    @assigned_sessions = @enrollment.session_assignments
    @url = "https://lsa-math-mmss.miserver.it.umich.edu"
    @camp_config = CampConfiguration.find_by(active: true)
    mail(to: @user.email, subject: "UM MMSS: Offer to attend Michigan Math and Science Scholars")
  end

  def offer_accepted_email(user, session_assignment, course_assignment)
    @user = user
    @offer_letter_text = CampConfiguration.active.last.offer_letter
    @application = ApplicantDetail.find_by(user_id: user)
    @enrollment = Enrollment.current_camp_year_applications.find_by(user_id: user)
    @session_assignment = session_assignment
    if course_assignment.present?
      @course_assignment = course_assignment.course.display_name
    else
      @course_assignment =  "Contact MMSS admin to get a course assignment"
    end
    @url = "https://lsa-math-mmss.miserver.it.umich.edu"
    @camp_config = CampConfiguration.find_by(active: true)
    mail(to: @user.email, subject: "UM MMSS: Offer Accepted")
  end

  def offer_declined_email(user, session_assignment, course_assignment)
    @user = user
    @offer_letter_text = CampConfiguration.active.last.offer_letter
    @application = ApplicantDetail.find_by(user_id: user)
    @enrollment = Enrollment.current_camp_year_applications.find_by(user_id: user)
    @session_assignment = session_assignment
    if course_assignment.present?
      @course_assignment = course_assignment.course.display_name
    else
      @course_assignment =  ""
    end
    @url = "https://lsa-math-mmss.miserver.it.umich.edu"
    @camp_config = CampConfiguration.find_by(active: true)
    mail(to: @user.email, subject: "UM MMSS: Offer Declined")
  end
end


