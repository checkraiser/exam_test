require 'open3'
require 'tempfile'

class AssignmentResultsController < ApplicationController
  before_action :set_course
  before_action :set_assignment
  before_action :set_assignment_result, only: [:show, :edit, :update, :destroy]

  # GET /assignment_results
  # GET /assignment_results.json
  

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
    source_content = assignment_result_params[:source].read
    @assignment_result = @assignment.assignment_results.new({source: source_content})
    
    
    respond_to do |format|
      if @assignment_result.save
        fpath = Rails.root.join('tmp').to_s + "/#{@assignment_result.id.to_s}"
        Dir.mkdir "#{fpath}" unless Dir.exists?(fpath)
        File.open(fpath + '/hello.cpp', 'w') do |f|
          f.write(source_content)
        end
        res = true
        File.open(fpath + '/hello.cpp','r') do |f|
          @assignment.assignment_configs.each do |c|
            File.open(fpath + '/input.txt', 'w') do |f2|
              f2.write(c.input)
              output = `g++ #{f.path} -o #{fpath}/hello.o &&  #{fpath}/hello.o #{f2.path}`
              if output.strip != c.output.strip
                res = false
                break
              end
            end
          end
        end
        @assignment_result.update(pass: res)
        `rm -rf #{fpath}`
        format.html { redirect_to [@course, @assignment, @assignment_result], notice: 'Assignment result was successfully created.' }
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
    source_content = assignment_result_params[:source].read
    respond_to do |format|
      if @assignment_result.update({source: source_content})
        fpath = Rails.root.join('tmp').to_s + "/#{@assignment_result.id.to_s}"
        Dir.mkdir "#{fpath}" unless Dir.exists?(fpath)
        File.open(fpath + '/hello.cpp', 'w') do |f|
          f.write(source_content)
        end
        res = true
        File.open(fpath + '/hello.cpp','r') do |f|
          @assignment.assignment_configs.each do |c|
            File.open(fpath + '/input.txt', 'w') do |f2|
              f2.write(c.input)
              output = `g++ #{f.path} -o #{fpath}/hello.o &&  #{fpath}/hello.o #{f2.path}`
              if output.strip != c.output.strip
                res = false
                break
              end
            end
          end
        end
        @assignment_result.update(pass: res)
        `rm -rf #{fpath}`
        format.html { redirect_to [@course, @assignment, @assignment_result], notice: 'Assignment result was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @assignment_result }
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
      format.html { redirect_to course_assignment_assignment_results_url(@course, @assignment) }
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
      @assignment_result = @assignment.assignment_results.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_result_params
      params.require(:assignment_result).permit(:source, :pass)
    end
end
