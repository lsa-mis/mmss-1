ActiveAdmin.register CoursePreference do
  menu parent: 'Applicant Info', priority: 2

  permit_params :enrollment_id, :course_id, :ranking

  filter :enrollment_id, as: :select, collection: proc {
    Enrollment.current_camp_year_applications.map { |enrol|
      [enrol.display_name.downcase, enrol.id]
    }.sort
  }
  
  filter :course_id, as: :select, collection: proc {
    Course.where(camp_occurrence_id: CampOccurrence.active)
         .order(camp_occurrence_id: :asc, title: :asc)
  }

  form do |f|
    f.inputs do
      f.input :enrollment_id, as: :select, collection: proc {
        Enrollment.current_camp_year_applications.map { |enrol|
          [enrol.display_name.downcase, enrol.id]
        }.sort
      }
      f.input :course_id, label: 'Course', as: :select,
              collection: proc {
                Course.where(camp_occurrence_id: CampOccurrence.active)
              }
      f.input :ranking, as: :select, collection: (1..12).to_a
    end
    f.actions
  end

  index do
    selectable_column
    actions
    column :id
    column :enrollment
    column 'Session' do |cp|
      cp.course.camp_occurrence.description
    end
    column :course
    column :ranking
    column :created_at
    column :updated_at
  end
end
