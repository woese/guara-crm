class CustomerActivity < ActiveRecord::Base
  attr_accessor :cusotmer_pj, :business_activity, :activity_id
    
  belongs_to :customer_pj
  belongs_to :business_activity, foreign_key: 'activity_id'
  
  validates :customer_pj_id, presence: true
  validates :activity_id, presence: true
end
