
module EmailHelper
  
  def concat_emails(emails)
    emails.join(", ") unless emails.nil?
  end
  
end