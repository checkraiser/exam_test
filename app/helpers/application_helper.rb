module ApplicationHelper
  def my_courses
  	if user_signed_in?
  		current_user.courses
  	else
  		[]
  	end
  end
end
