class Admin::CoursesController < ApplicationController
  before_action :authenticate_user!
  def index
  	authorize! :manage, Course
    @courses = Course.all
  end
end