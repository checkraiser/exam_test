#encoding: utf-8
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
  validate :check_email
  scope :finder, lambda { |q| where("email like :q", q: "%#{q}%") }
  ROLES = [:admin]
  def is_unique?
    !User.exists?(:email => email) 
  end
  def is_admin?
  	self.roles.map(&:name).include?("admin")
  end
  def is_teacher?
    self.roles.map(&:name).include?("teacher")
  end
  def to_s
    email
  end
  def enrollment(course)
    course.enrollments.where(user_id: self.id).first
  end
  def is_student?(course)
    en = enrollment(course)
    return false unless en
    return en.user_id == self.id
  end
  def is_pass?(assignment)
    course = assignment.course
    en = enrollment(course)
    return false unless en    
    ar = assignment.assignment_results.where(enrollment_id: en.id).first
    return false unless ar
    return ar.pass
  end
  def as_json(options)
    { id: id, text: email }
  end
  private
  def check_email
    errors.add("Errors", ": Hệ thống chỉ chấp nhận email nội bộ!") if !self.email.include?("hueic.edu.vn")
  end
end
