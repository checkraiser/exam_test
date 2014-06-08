class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    
    cannot :create, Course unless user.is_teacher?
    
    if user.is_admin?            
        can :manage, :all
    end

    
    can :take, Assignment do |as|
        enr = as.course.enrollments.student.where(user_id: user.id).first                    
        ar = AssignmentResult.where(assignment_id: as.id, enrollment_id: enr.id).first if enr
        as.assignment_configs.count > 0 and enr and ar and ar.pass != true                        
    end
    can :manage, Course do |c|
        c.enrollments.teacher.map(&:user_id).include?(user.id)
    end
    can :take, AssignmentResult do |a|
        (can? :take, a.assignment.course) and !a.locked?
    end
    can [:edit, :update], User do |current_user|
        user.id == current_user.id
    end
        
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
    
end
