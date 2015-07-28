class Device < ActiveRecord::Base
	# RRD is needed for the Ping capability.
  require 'rrd'

  belongs_to :devtype
  has_many :backups


	# This will be used to ping a device to see if it is available. 
	def ping
		result = `ping -c 1 #{ip_address}`
		# Now extract the time that it took for the ping to come back
		result = result.split("time=").last.split(" ").first
		return result
	end

end
