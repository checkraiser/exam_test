class Course < ActiveRecord::Base

	has_many :enrollments, :dependent => :destroy
	has_many :assignments, :dependent => :destroy

	def to_s
		"#{name} - #{code}"
	end
	
end
