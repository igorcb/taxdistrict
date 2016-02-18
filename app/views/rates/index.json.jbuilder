json.array!(@rates) do |rate|
  json.extract! rate, :id, :district_origin_id, :district_target_id, :price
  json.url rate_url(rate, format: :json)
end
