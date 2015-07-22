class VisitorsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @testing = { testing1: "one", testing2: "two", testing3: "three" }
  end
end
