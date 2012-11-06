require Rails.root.join("app/models/task.rb")

class Task
  after_save :cgmb_make_trivial_customer_a_business_customer  
  
  def self.rules
    { :CMGB => { :"Task::AfterSave" => "make_trivial_a_business_customer" } }
  end
  
  def cgmb_make_trivial_customer_a_business_customer
    if ((interested.is_a? Customer) &&
        (resolution.id == SystemTaskResolution.RESOLVED_WITH_BUSINESS.id))
      interested.is_customer = true
      interested.save!
    end
  end
  
end