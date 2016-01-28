json.array!(@routers) do |router|
  json.extract! router, :id, :name, :ip_address, :model, :connection_info
  json.url router_url(router, format: :json)
end
