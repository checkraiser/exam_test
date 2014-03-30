class AssignmentResult < ActiveRecord::Base

	belongs_to :assignment
	belongs_to :enrollment

	def locked?
		self.pass == true
	end
end
