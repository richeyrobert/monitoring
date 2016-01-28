class Debugger
  include ActiveModel::Model

  # Required Elements
  require 'snmp'
  # attr_accessor :email, :message

  # validates :email, presence: true, length: {in:2..255}

  #Sample Device Hash
  # {"uuid"=>"387ddc74-6bd6-4658-93fa-ead453480a36", 
  # "name"=>"JonWard", 
  # "pretty_mac_address"=>"04:18:D6:6E:57:53", 
  # "ip_address"=>"10.8.20.231", 
  # "location"=>{
  #   "latitude"=>"37.075475", 
  #   "longitude"=>"-113.599303", 
  #   "device_location"=>{
  #     "full_address"=>"733 Lava Point Dr. ", 
  #     "city"=>"St. George", 
  #     "state"=>"Utah", 
  #     "postal_code"=>"84770", 
  #     "address_type"=>{
  #       "name"=>"Physical"}
  #     }
  # }, 
  # "device_type"=>{
  #   "device_model_name"=>"NBeamM5", 
  #   "manufacturer_name"=>"Ubiquiti"}, 
  # "access_point"=>{
  #   "name"=>"MotoZooAP", 
  #   "uuid"=>"761350d2-51bf-49d9-abf4-80d3e1e73c00", 
  #   "ssid"=>"TQN-Motozoo", 
  #   "secret_key"=>"T0naqu1nt", 
  #   "access_point_location"=>{
  #     "latitude"=>"37.07618", 
  #     "longitude"=>"-113.591003", 
  #     "primary_address"=>{
  #       "full_address"=>"359 W Hilton Dr ", 
  #       "city"=>"St. George", 
  #       "state"=>"UT", 
  #       "postal_code"=>"84770", 
  #       "address_type"=>{
  #         "name"=>"Physical"}
  #       }
  #     }
  #   }
  # }
  #

  def full_debug(device)
    # This will call multiple individual debugging applications to test a customer's connectivity.
    # Find PPPOE Session
    # Ping Radio
    # Get radio signal, quality, capacity, traffic
    # Get AP stats (signal, quality, capacity, traffic)
    #
    # The device object passed into this function is a hash of many device keys and attributes (see above)
    # 
    # Lets call a subroutine to find the pppoe session.
    pppoe_result = find_pppoe()
  end 

  def find_pppoe
    # We need to parse a list of Routers and look for a matching PPPOE session.
    router_list = Router.all?
    active_sessions = Hash.new
    router_list.each do |router|
      # Cycle through each router and extract the active PPPoE sessions
      # Extract the active sessions on the router via SNMP
      active_sessions[:router]
    end
  end

  def get_router_active_sessions(router)
    # this is just to test the SNMP functionality
    # snmpwalk -c gU5ewe7RuKUs 10.8.0.10 .1.3.6.1.4.1.9.9.150.1.1
    return_hash = Hash.new
    SNMP::Manager.open(host: router.ip_address, community: 'gU5ewe7RuKUs') do |manager|
      # First get the number of active PPPoE connections on this router
      response = manager.get(["SNMPv2-SMI::enterprises.9.9.150.1.1.1.0"])
      return_hash[:count] = response.varbind_list[0].value.to_i
      # Now get the active usernames on this router
      response = `snmpwalk -c gU5ewe7RuKUs 10.8.0.10 SNMPv2-SMI::enterprises.9.9.150.1.1.3.1.2`
      lines = response.split("\n")
      return_hash[:users] = Array.new
      i = 0
      lines.each do |line|
        username = line.split("STRING: ").last.gsub!(/[^0-9A-Za-z]/,'')
        return_hash[:users] << {number: i,  username: username }
        i += 1
      end
      # Now let's get the IP addresses for the users and try to apply them to the same array number
      response2 = `snmpwalk -c gU5ewe7RuKUs 10.8.0.10 SNMPv2-SMI::enterprises.9.9.150.1.1.3.1.3`
      lines = response2.split("\n")
      i = 0
      lines.each do |line|
        ip_address = line.split("IpAddress: ").last
        return_hash[:users][i][:ip_address] = ip_address
        i += 1
      end
    return_hash
end
  end

end