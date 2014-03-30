class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :enrollments, :dependent => :destroy
  has_many :assignments, :through => :enrollments, :uniq => true
  has_many :courses, :through => :enrollments, :uniq => true
  has_many :assignment_results, :through => :enrollments, :uniq => true
  has_and_belongs_to_many :roles, :join_table => :users_roles
  
  ROLES = [:admin]
  def is_unique?
    !User.exists?(:email => email) 
  end
  def is_admin?
  	roles.map(&:name).include?("admin")
  end
end
