class Enrollment < ActiveRecord::Base

	belongs_to :user
	belongs_to :course
	has_many :assignments, :through => :course
	has_many :assignment_results, :dependent => :destroy

	scope :teacher,  where(role: :teacher)
	scope :student,  where(role: :student)

	

end
