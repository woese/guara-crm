module CustomersHelper
  
  def customers_invalids
    #TODO: customers_invalids
    Customer.where(:complete => nil).count
  end
  
  def birthdays
    #TODO: birthdays
    0
  end
  
  def navbar_title
    nil
  end
  
end
