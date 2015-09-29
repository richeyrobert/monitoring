class Api::V1::TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # protect_from_forgery :except => [:director, :update_stream, :remove_stream, :create_stream, ]

  def text_test
  end
end
