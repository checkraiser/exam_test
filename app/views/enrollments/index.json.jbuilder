json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :user_id, :course_id, :role
  json.url enrollment_url(enrollment, format: :json)
end
