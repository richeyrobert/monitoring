class Tqms
  include ActiveModel::Model

  # attr_accessor :email, :message

  # validates :email, presence: true, length: {in:2..255}

  def customer_query(phone_number)
    # This makes a call to the TQMS customer-from-phone-number query interface
    #tqms.tonaquint.com/api/v1/Ufs0VDJddNbq52DkU-w2KA/customers.json?query=4357725992
    phone = phone_number.split("+1").last
    url = "http://tqms.tonaquint.com/api/v1/Ufs0VDJddNbq52DkU-w2KA/customers.json?query=#{phone}"
    response = HTTParty.get(url)
  end 

end