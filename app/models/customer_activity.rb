class CustomerActivity < ActiveRecord::Base
  attr_accessor :cusotmer_pj, :activity
    
  belongs_to :customer_pj
  belongs_to :activity, class_name: "BusinessActivity"
  
  validates :customer_pj_id, presence: true
  validates :activity_id, presence: true
end
