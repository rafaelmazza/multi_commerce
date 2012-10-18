module LeadHelper
  def phone(lead)
    "(#{lead.try(:phone_code)}) #{lead.try(:phone)}"
  end
end