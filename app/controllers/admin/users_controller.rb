class Admin::UsersController < Admin::AdminController
	def index
		@users = User.all
	end
	def new

	end
	def create

	end
	def destroy

	end
	def import_teachers
		teachers = params[:teachers].read
		if teachers.length > 0
			teachers.gsub!(/\r\n?/, "\n")
			teachers.each_line do |line|
			  u = User.where(email: line.strip).first
			  unless u 
			  	u = User.new(:email => line, :password => '12345678', :password_confirmation => '12345678')
			  	u.roles << Role.find_by_name(:teacher)
			  	u.save
			  end
			end
		end
		redirect_to '/admin/users'
	end
	def import_students
		students = params[:students].read
		if students.length > 0
			students.gsub!(/\r\n?/, "\n")
			students.each_line do |line|
			  u = User.where(email: line.strip).first
			  unless u 
			  	u = User.new(:email => line, :password => '12345678', :password_confirmation => '12345678')			  	
			  	u.save
			  end
			end
		end
		redirect_to '/admin/users'
	end
end
