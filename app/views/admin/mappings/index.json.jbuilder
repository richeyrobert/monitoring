json.array!(@mappings) do |mapping|
  json.extract! mapping, :id, :received_text, :reply_text
  json.url mapping_url(mapping, format: :json)
end
