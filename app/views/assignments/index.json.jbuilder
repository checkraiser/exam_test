json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :course_id, :title, :content, :description
  json.url assignment_url(assignment, format: :json)
end
