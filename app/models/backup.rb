class Backup < ActiveRecord::Base
  belongs_to :device
  has_many :configurations
end
