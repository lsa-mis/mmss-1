# == Schema Information
#
# Table name: travels
#
#  id                :bigint           not null, primary key
#  enrollment_id     :bigint           not null
#  arrival_transport :string(255)
#  arrival_carrier   :string(255)
#  arrival_route_num :string(255)
#  note              :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  arrival_date      :date
#  arrival_time      :time
#  depart_transport  :string(255)
#  depart_route_num  :string(255)
#  depart_date       :date
#  depart_time       :time
#  depart_carrier    :string(255)
#  arrival_session   :string(255)
#  depart_session    :string(255)
#
FactoryBot.define do
  factory :travel do
    association :enrollment
    arrival_transport { "Plane" }
    arrival_carrier { "Delta" }
    arrival_route_num { "DL123" }
    arrival_date { Date.current + 1.month }
    depart_transport { "Plane" }
    depart_carrier { "United" }
    depart_route_num { "UA456" }
    depart_date { Date.current + 2.months }
  end
end
