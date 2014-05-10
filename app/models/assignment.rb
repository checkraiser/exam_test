class Assignment < ActiveRecord::Base

	belongs_to :course
	has_many :assignment_configs, :dependent => :destroy
	has_many :assignment_results, :dependent => :destroy

end
