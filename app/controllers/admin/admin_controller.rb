class Admin::AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :authorize_admin!
	def index

	end
	private
	def authorize_admin!
		authorize! :manage, :all
	end
end
