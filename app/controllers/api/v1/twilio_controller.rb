class Api::V1::TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # protect_from_forgery :except => [:director, :update_stream, :remove_stream, :create_stream, ]

  def text_test
    params.inspect
    # Parameters: 
    # {"ToCountry"=>"US", 
    # "ToState"=>"UT", 
    # "SmsMessageSid"=>"SM5d11339688438ea6840b1ff5cf6b3e33", 
    # "NumMedia"=>"0", 
    # "ToCity"=>"PARK CITY", 
    # "FromZip"=>"84770", 
    # "SmsSid"=>"SM5d11339688438ea6840b1ff5cf6b3e33", 
    # "FromState"=>"UT", 
    # "SmsStatus"=>"received", 
    # "FromCity"=>"ST GEORGE", 
    # "Body"=>"testing 5678", 
    # "FromCountry"=>"US", 
    # "To"=>"+14352141844", 
    # "ToZip"=>"84098", 
    # "NumSegments"=>"1", 
    # "MessageSid"=>"SM5d11339688438ea6840b1ff5cf6b3e33", 
    # "AccountSid"=>"ACfb03eaaab63e59c4a90d5bf07b5f6f70", 
    # "From"=>"+14356691878", 
    # "ApiVersion"=>"2010-04-01"}
    from = params[:From]

  end
  def text_engine
    # For debugging.... Disable the following line
    params.inspect
    # This method will need to check the customer database of TQMS for the customer with a phone number that is the from number.
    # TODO: change the following garbage to do a dynamic lookup from the database for the existence of text command mappings.
    # mapping = Mapping.where('lower(name) = ?', params[:Body].downcase).first 

    # API Procedure:
    # 1. We are going to receive a text
    # 2. See where this phone number is coming from
    # 3. Pull the customer information
    # 4. Execute a text response based on the text received

    # First we need to see if this is a customer we don't know about trying to link their account with us. 
    if params[:Body].downcase.contains == "email"
      email = params[:Body].downcase.split("email ").last
      
    end

    from_number = params[:From]
    t = Tqms.new
    response = t.customer_query(from_number)
    response.inspect
    if response.empty?
      # Then the query failed
      # We probably don't know the phone number. 

    else
      # The response was ok. We should have a customer record as JSON
      # Get the customer record
      devices = response["devices"]

    end






    mapping = Mapping.find_by(received_text: params[:Body].downcase)
    unless mapping.blank?
      # Now we need to determine what to do based on the mapping type...

      # Current mapping types:
      # Robotext - Will automatically send a text response based on the message received.
      # Functionator - Will execute a function based on the text received.

      # Built-in functions:
      # Send open/closed times based on a clock with an open/closed schedule.
      # Send a location/address text based on given criteria.
      # Call back - schedule a call for a CSR to make at a determined time.
      # Lets send back the response for the mapping that we have...
      @response_text = mapping.reply_text
      render 'responder'
    else
      # Send back an error message... "We don't know what you are asking us"
      render 'no_match'
    end
  end
end
