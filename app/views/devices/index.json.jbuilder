json.array!(@devices) do |device|
  json.extract! device, :id, :name, :description, :ip_address, :device_status, :ipv6, :snmp_template
  json.url device_url(device, format: :json)
end
