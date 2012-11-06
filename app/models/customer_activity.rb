class CustomerActivity < ActiveRecord::Base  
  belongs_to :customer_pj
  belongs_to :business_activity, foreign_key: 'activity_id'
  
  validates :customer_pj_id, presence: true
  validates :activity_id, presence: true
end
