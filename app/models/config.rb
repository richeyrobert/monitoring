class Config < ActiveRecord::Base
  belongs_to :backup

  # For the file attachment management:
  mount_uploader :configfile, ConfigfileUploader
end
