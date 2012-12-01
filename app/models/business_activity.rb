class BusinessActivity < ActiveRecord::Base
  attr_accessible :enabled, :name, :business_segment
  
  belongs_to :business_segment
end
