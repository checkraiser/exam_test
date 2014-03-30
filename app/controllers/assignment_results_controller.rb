class AssignmentResultsController < ApplicationController
  before_action :set_course
  before_action :set_assignment
  before_action :set_assignment_result, only: [:show, :edit, :update, :destroy]

  # GET /assignment_results
  # GET /assignment_results.json
  def index
    @assignment_results = @assignment.assignment_results
  end

  # GET /assignment_results/1
  # GET /assignment_results/1.json
  def show
  end

  # GET /assignment_results/new
  def new
    @assignment_result = @assignment.assignment_results.new
  end

  # GET /assignment_results/1/edit
  def edit
  end

  # POST /assignment_results
  # POST /assignment_results.json
  def create
    @assignment_result = @assignment.assignment_results.new(assignment_result_params)

    respond_to do |format|
      if @assignment_result.save
        format.html { redirect_to @assignment_result, notice: 'Assignment result was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment_result }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignment_results/1
  # PATCH/PUT /assignment_results/1.json
  def update
    respond_to do |format|
      if @assignment_result.update(assignment_result_params)
        format.html { redirect_to @assignment_result, notice: 'Assignment result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment_results/1
  # DELETE /assignment_results/1.json
  def destroy
    @assignment_result.destroy
    respond_to do |format|
      format.html { redirect_to assignment_results_url }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    def set_assignment
      @assignment = @course.assignments.find(params[:assignment_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment_result
      @assignment_result = AssignmentResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_result_params
      params.require(:assignment_result).permit(:enrollment_id, :pass)
    end
end
