class CourseAssignmentsController < InheritedResources::Base
  before_action :authenticate_admin!

  private

    def course_assignment_params
      params.require(:course_assignment).permit(:enrollment_id, :course_id)
    end

end
