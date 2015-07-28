class Admin::BackupsController < AdminController
    before_action :load_defaults
  def index 
    @backups = @device.backups
  end

  def show
    
  end

  def new
  end

  private 

  def load_defaults
    @device = Device.find(params[:device_id])
  end
end
