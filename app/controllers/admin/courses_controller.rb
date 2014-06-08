class Admin::CoursesController < Admin::AdminController  
  def index  	
    @courses = Course.all
  end
end