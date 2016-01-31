class Debugger
  include ActiveModel::Model

  # Required Elements
  require 'snmp'
  require 'net/ping'
 
  # Sample Customer Hash
  # {
  # "id": 1,
  # "first_name": "Mark",
  # "last_name": "Holmberg",
  # "email": "mark.d.holmberg@gmail.com",
  # "business_name": "Windrunner Development",
  # "stripe_token": "cus_77FtESdv4IABVL",
  # "description": "Mark Holmberg",
  # "secondary_email_addresses": [
  #   {
  #     "address": "asdfsadfdaf@example.com",
  #     "primary": false
  #   }
  # ],
  # "primary_address": {
  #   "full_address": "1422 Inverness Drive ",
  #   "city": "Mechanicsburg",
  #   "state": "Pennsylvania",
  #   "postal_code": "17050",
  #   "address_type": {
  #     "name": "Physical"
  #   }
  # },
  # "secondary_addresses": [
  #   {
  #     "full_address": "adsfads asfddasf",
  #     "city": "asfdasdf",
  #     "state": "asdfads",
  #     "postal_code": "fadsfadsfas",
  #     "address_type": {
  #       "name": "Service"
  #     }
  #   }
  # ],
  # "primary_phone": {
  #   "full_number": "4357725058",
  #   "prefix": "",
  #   "area_code": "435",
  #   "extension": "",
  #   "phone_number_type": {
  #     "name": "Cellular"
  #   }
  # },
  # "secondary_phone_numbers": [
  #   {
  #     "full_number": "1235551234",
  #     "prefix": "1",
  #     "area_code": "123",
  #     "extension": "1",
  #     "phone_number_type": {
  #       "name": "Fax"
  #     }
  #   }
  # ],

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
    # Lets call a subroutine to find the pppoe session. (returns an array of routers where this username is active.)
    #TODO: add the username to this routine.
    pppoe_result = find_pppoe
    # Now let's try to ping the radio.
    ping_result = pinger
  end 

  def find_pppoe(username)
    # We need to parse a list of Routers and look for a matching PPPOE session.
    return_hash = Hash.new
    return_hash_array = Array.new
    router_list = Router.all
    active_sessions = Hash.new
    i = 0
    active_sessions[:routers] = Array.new
    router_list.each do |router|
      # Cycle through each router and extract the active PPPoE sessions
      # Extract the active sessions on the router via SNMP
      active_sessions[:routers][i] = get_router_active_sessions(router)
      i += 1
    end
    # Now I have a hash with an array of hashes of all the different active PPPOE sessions on all of the routers in active_sessions variable
    # Now I want to cycle through those active sessions and find the PPPoE username that we are looking for. 
    active_sessions[:routers].each do |each_router|
      # This is a list of the active sessions on each router.... Let's find the one that we are looking for.
      each_router[:users].each do |user|
        if user[:username] == username
          # Then we have a match... export this hash
          return_hash_array << user
        end
      end
    end
    return_hash[:usernames] = return_hash_array
  end

  def get_router_active_sessions(router)
    # this is just to test the SNMP functionality
    # snmpwalk -c gU5ewe7RuKUs 10.8.0.10 .1.3.6.1.4.1.9.9.150.1.1
    return_hash = Hash.new
    SNMP::Manager.open(host: router.ip_address, community: router.decrypt_community) do |manager|
      # First get the number of active PPPoE connections on this router
      response = manager.get(["SNMPv2-SMI::enterprises.9.9.150.1.1.1.0"])
      return_hash[:router] = router.ip_address
      return_hash[:count] = response.varbind_list[0].value.to_i
      # Now get the active usernames on this router
      response1 = `snmpwalk -c #{router.decrypt_community} #{router.ip_address} SNMPv2-SMI::enterprises.9.9.150.1.1.3.1.2`
      lines1 = response1.split("\n")
      return_hash[:users] = Array.new
      i = 0
      lines1.each do |line|
        username = line.split("STRING: ").last.gsub!(/[^0-9A-Za-z]/,'')
        return_hash[:users] << {number: i,  username: username }
        i += 1
      end
      # Now let's get the IP addresses for the users and try to apply them to the same array number
      response2 = `snmpwalk -c #{router.decrypt_community} #{router.ip_address} SNMPv2-SMI::enterprises.9.9.150.1.1.3.1.3`
      lines2 = response2.split("\n")
      i = 0
      lines2.each do |line|
        ip_address = line.split("IpAddress: ").last
        return_hash[:users][i][:ip_address] = ip_address
        i += 1
      end
      return_hash
    end
  end

  def pinger(ip_address)
    # This method pings an IP address 5 times and returns the ping results. 
    # include Net
    # Ping::TCP.service_check = true
    pd = Net::Ping::UDP.new(ip_address)
    if pd.ping
      puts "Ping successful"
   else
      puts "Ping unsuccessful: " +  pd.exception
   end
  end

end