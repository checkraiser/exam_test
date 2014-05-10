class AssignmentsController < ApplicationController
  before_action :set_course
  before_action :set_enrollment
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = @course.assignments
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment_result = @assignment.assignment_results.where(enrollment_id: @current_enrollment.id, assignment_id: @assignment.id).first_or_create!
  end

  # GET /assignments/new
  def new
    @assignment = @course.assignments.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    ap = assignment_params.clone
    ap[:source] = ap[:source].read if ap[:source].present?
    @assignment = @course.assignments.new(ap)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to [@course, @assignment], notice: 'Assignment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      ap = assignment_params.clone
      ap[:source] = ap[:source].present? ? ap[:source].read : @assignment.source
      if @assignment.update(ap)
        format.html { redirect_to [@course, @assignment], notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to course_assignments_path(@course) }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_enrollment
      @current_enrollment = @course.enrollments.where(user_id: current_user.id).first
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = @course.assignments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:title, :content, :description, :source, :timeout)
    end
end
