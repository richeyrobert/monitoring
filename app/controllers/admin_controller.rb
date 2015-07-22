class AdminController < ApplicationController
  before_action :authenticate_user!

  before_action :require_admin


  private

  def require_admin
    unless current_user.admin?
      flash[:error] = "Not authorized for this portal!"
      redirect_to appropriate_redirect_url
    end
  end
end
