class AssignmentResult < ActiveRecord::Base

	belongs_to :assignment
	belongs_to :enrollment

	def self.open
		where('pass is NULL or pass = false')
	end
	def locked?
		self.pass == true
	end
end
