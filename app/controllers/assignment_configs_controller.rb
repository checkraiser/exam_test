class AssignmentConfigsController < ApplicationController
  before_action :set_course
  before_action :set_assignment
  before_action :set_assignment_config, only: [:show, :edit, :update, :destroy]

  # GET /assignment_configs
  # GET /assignment_configs.json
  def index
    @assignment_configs = @assignment.assignment_configs
  end

  # GET /assignment_configs/1
  # GET /assignment_configs/1.json
  def show
  end

  # GET /assignment_configs/new
  def new
    @assignment_config = @assignment.assignment_configs.new
  end

  # GET /assignment_configs/1/edit
  def edit
  end

  # POST /assignment_configs
  # POST /assignment_configs.json
  def create
    @assignment_config = @assignment.assignment_configs.new(assignment_config_params)

    respond_to do |format|
      if @assignment_config.save
        format.html { redirect_to @assignment_config, notice: 'Assignment config was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment_config }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignment_configs/1
  # PATCH/PUT /assignment_configs/1.json
  def update
    respond_to do |format|
      if @assignment_config.update(assignment_config_params)
        format.html { redirect_to @assignment_config, notice: 'Assignment config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment_configs/1
  # DELETE /assignment_configs/1.json
  def destroy
    @assignment_config.destroy
    respond_to do |format|
      format.html { redirect_to assignment_configs_url }
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
    def set_assignment_config
      @assignment_config = AssignmentConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_config_params
      params.require(:assignment_config).permit(:input, :output)
    end
end
