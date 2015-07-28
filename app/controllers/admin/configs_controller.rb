class Admin::ConfigsController < AdminController
  before_filter :set_defaults

  def index
  end

  private

  def set_defaults
    @device = Device.find(params[:device_id])
    @backup = Backup.find(params[:backup_id])
    @configs = Config.where(backup_id: @backup.id)
  end
end
