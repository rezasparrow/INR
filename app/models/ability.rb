class Ability
	include CanCan::Ability
	def initialize(user)
		user ||= user.new #guest user

		if user.role=='ادمین'
			can :manage, :all
		elsif user.role == 'پزشک'
			can :read, :all
			can :create, Profile
			can :update, Profile do |profile|
				profile.try(:user) == user || user.role?(:پزشک)
		end
		elsif user.role == 'بیمار'
			can :create, Report
			can :update, Report do |report|
				report.try(:user) == user 
			end
		end
	

	end 
end



