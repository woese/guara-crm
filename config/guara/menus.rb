
module GUARACRM
  module Menus
    groups = [:customers, :maintence, :help, :current_user]


    ADMINISTRATION =
            {
              :title => "administration",
              :namespace => "admin",
              :items => [
                          [:users, "users_path()"],
                          :user_groups,
                        ]
             }
    
    MAINTENCE =
            {
              :title => "maintenances",
              :namespace => "maintence",
              :items => [
                          :districts,
                          :cities,
                          :states,
                          :business_activities,
                          :business_segments,
                          :business_departments,
                          :company_businesses,
                          :task_types,
                        ]
             }
  end
  
end