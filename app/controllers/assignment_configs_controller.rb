class AssignmentConfigsController < ApplicationController
  before_action :set_course
  before_action :set_assignment
  before_action :set_assignment_config, only: [:show, :edit, :update, :destroy]

  # GET /assignment_configs
  # GET /assignment_configs.json
  def index
    authorize! :manage, @course
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


  def create
    authorize! :manage, @course
    input_file = assignment_config_params[:input]
    input_content = input_file.read
    @assignment_config = @assignment.assignment_configs.create!({input: input_content})
    fpath = Rails.root.join('tmp').to_s + "/#{@assignment_config.id.to_s}"
    Dir.mkdir "#{fpath}" unless Dir.exists?(fpath)
    source = @assignment.source
    File.open(fpath + '/hello.cpp', 'w')  { |f|  f.write(source)  }
    output = `g++ #{fpath + '/hello.cpp'} -o #{fpath}/hello.exe && #{fpath}/hello.exe #{input_content}`
    @assignment_config.update({output: output.try(:strip)})
    `rm -rf #{fpath}`          
    respond_to do |format|
      if @assignment_config.save
        format.html { redirect_to course_assignment_assignment_configs_path(@course, @assignment), notice: 'Assignment config was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment_config }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment_config.errors, status: :unprocessable_entity }
      end
    end
  end
=begin  
  # POST /assignment_configs
  # POST /assignment_configs.json
  def create
    authorize! :manage, @course
    input_file = assignment_config_params[:input]
    input_content = input_file.read
    @assignment_config = @assignment.assignment_configs.create!({input: input_content})
    fpath = Rails.root.join('tmp').to_s + "/#{@assignment_config.id.to_s}"
    Dir.mkdir "#{fpath}" unless Dir.exists?(fpath)
    source = @assignment.source
    File.open(fpath + '/hello.cpp', 'w')  { |f|  f.write(source)  }
    File.open(fpath + '/input.txt', 'w') { |f| f.write(input_content) }
    output = `g++ #{fpath + '/hello.cpp'} -o #{fpath}/hello.exe && #{fpath}/hello.exe #{fpath + '/input.txt'}`
    @assignment_config.update({output: output.try(:strip)})
    `rm -rf #{fpath}`          
    respond_to do |format|
      if @assignment_config.save
        format.html { redirect_to [@course, @assignment, @assignment_config], notice: 'Assignment config was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment_config }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment_config.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # PATCH/PUT /assignment_configs/1
  # PATCH/PUT /assignment_configs/1.json
  def update
    authorize! :manage, @course
    input_file = assignment_config_params[:input]
    input_content = input_file.read
    fpath = Rails.root.join('tmp').to_s + "/#{@assignment_config.id.to_s}"
    Dir.mkdir "#{fpath}" unless Dir.exists?(fpath)
    source = @assignment.source
    File.open(fpath + '/hello.cpp', 'w')  { |f|  f.write(source)  }
    File.open(fpath + '/input.txt', 'w') { |f| f.write(input_content) }
    output = `g++ #{fpath + '/hello.cpp'} -o #{fpath}/hello.o && #{fpath}/hello.o #{fpath + '/input.txt'}`
    respond_to do |format|
      if @assignment_config.update({input: input_content, output: output.try(:strip)})
        `rm -rf #{fpath}`          
        format.html { redirect_to [@course, @assignment, @assignment_config], notice: 'Assignment config was successfully updated.' }
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
    authorize! :manage, @course
    @assignment_config.destroy
    respond_to do |format|
      format.html { redirect_to course_assignment_assignment_configs_url(@course, @assignment) }
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
