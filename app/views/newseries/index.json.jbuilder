json.array!(@newseries) do |newseries|
  json.extract! newseries, :id
  json.url newseries_url(newseries, format: :json)
end
