json.array!(@newreleases) do |newrelease|
  json.extract! newrelease, :id
  json.url newrelease_url(newrelease, format: :json)
end
