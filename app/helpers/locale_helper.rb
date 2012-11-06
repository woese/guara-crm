module LocaleHelper
  
	def format_datetime(datetime)
	  if datetime.instance_of? String
	    datetime = Time.parse datetime
    end
    
		datetime.strftime("%d/%m/%Y %H:%m") unless datetime==nil
	end
	
	def format_date(date)
	  if date.instance_of? String
	    date = Time.parse date
    end
    
	  date.strftime("%d/%m/%Y") unless date==nil
  end
  
end