json.array!(@fans) do |fan|
  json.extract! fan, :id
  json.url fan_url(fan, format: :json)
end
