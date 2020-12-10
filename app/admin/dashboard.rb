ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel link_to("Recent Applications for #{current_camp_year} Camp", admin_applications_path) do
          if Enrollment.current_camp_year_applications.any?
            ul do
              Enrollment.current_camp_year_applications.limit(10).map do |enroll|
                li link_to(enroll.applicant_detail.full_name + ", " + enroll.user.email , admin_application_path(enroll))
              end
            end
          end
        end

        panel link_to("Recent Payments for #{current_camp_year} Camp", admin_payments_path) do
          if Payment.current_camp_payments.any?
            ul do
              Payment.current_camp_payments.limit(10).map do |payment|
                li link_to("#{payment.user.applicant_detail.full_name_and_email} - #{ humanized_money_with_symbol(payment.total_amount.to_f / 100)}", admin_payment_path(payment.id))
              end
            end
          end
        end

        panel link_to("Financial Aid Requests", admin_financial_aid_requests_path) do
          div do
            render("/admin/finaid_requests", model: "dashboard")
          end
        end
      end

      column do
        panel "Session Stats" do
          div do
            render("/admin/session_enrolled", model: "dashboard")
          end

          hr

          div do
            render("/admin/session_assigned", model: "dashboard")
          end

          hr

          div do
            render("/admin/session_applied", model: "dashboard")
          end
        end

        # panel "Financial Aid Requests" do
        #   div do
        #     render("/admin/finaid_requests", model: "dashboard")
        #   end
        # end
      end
    end
  end # content
end
