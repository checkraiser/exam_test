class Ability
  include CanCan::Ability

  def initialize(user)
    if user
        can :manage, Course do |c|
            c.enrollments.teacher.include?(user.id)
        end
        can [:edit, :update], User do |current_user|
            user.id == current_user.id
        end
        Ability.context_types.each do |context, v|
            user.roles.each do |role|
                return nil if v['permissions'][role].nil?
                v['permissions'][role].each do |action|
                    if action['path'].nil?
                        action.each do |object, scope|
                            can action.to_sym, v == 'all' ? object.to_sym : object.send(scope)
                        end
                    else
                        can action.to_sym, v == 'all' ? object.to_sym : object.send(scope) do |cx|
                            cx.id == action['path'].split(',').inject(object) {|res, elem| res = res.send(elem)}.id
                        end
                    end
                end
                v['permissions'][role].each do |action, object|
                    can action.to_sym, object == 'all' ? object.to_sym : object.constantize
                end
            end
        end
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
  
  def self.context_types(file='roles.yml')
    YAML.load(File.read("#{Rails.root.to_s}/config/#{file}"))['types']
  end
end
