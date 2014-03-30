json.array!(@assignment_results) do |assignment_result|
  json.extract! assignment_result, :id, :enrollment_id, :assignment_id, :pass
  json.url assignment_result_url(assignment_result, format: :json)
end
