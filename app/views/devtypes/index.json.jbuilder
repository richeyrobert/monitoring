json.array!(@devtypes) do |devtype|
  json.extract! devtype, :id, :name, :manufacturer, :model, :notes, :active, :archived_at
  json.url devtype_url(devtype, format: :json)
end
