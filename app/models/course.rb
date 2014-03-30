class Course < ActiveRecord::Base

	has_many :enrollments, :dependent => :destroy
	has_many :assignments, :dependent => :destroy
end
