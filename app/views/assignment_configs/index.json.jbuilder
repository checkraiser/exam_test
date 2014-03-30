json.array!(@assignment_configs) do |assignment_config|
  json.extract! assignment_config, :id, :assignment_id, :input, :output
  json.url assignment_config_url(assignment_config, format: :json)
end
