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
    # This method will need to check the customer database of TQMS for the customer with a phone number that is the from number.
    if params[:Body].include?("status")
      render "status"
    end

  end
end
