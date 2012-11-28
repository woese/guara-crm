class City < ActiveRecord::Base
  attr_accessible :name, :state, :state_id
  
  belongs_to :state
  
  include ActiveDisablable
end
