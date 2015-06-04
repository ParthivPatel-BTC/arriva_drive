class CohortsController < ApplicationController
	before_filter :find_cohort, only: [:edit, :update, :show, :destroy]
  before_filter :admin_user_required!
  before_filter :all_cohorts_and_behaviors, only: [:new, :edit, :show, :create, :update, :index]

	def new
		unless request.xhr?
			@cohort = Cohort.new	
		else
			@cohort_id_for_score = params[:id] unless params[:id] == '0'
		end
		respond_to do |format|
			format.js {}
			format.html {}
		end		
	end

	def create
		@cohort = Cohort.create(cohort_params)
    if @cohort.valid?
      redirect_to cohorts_path
    else
      render :new,  locals: { cohort: "overall"}
    end
	end

	def update
    unless params[:commit] == "Remove Cohort"
  	  if @cohort.update_attributes(cohort_params)
        redirect_to cohorts_path
      else
        render :edit
      end
    else
      @cohort.destroy
      redirect_to cohorts_path
    end
	end

	def index
		@cohorts = Cohort.all
	end

  private

  def cohort_params
    params.require(:cohort).permit(:name, :year_started, :cohort_type)
  end

  def find_cohort
    @cohort = Cohort.find_by_id(params[:id])
  end

  def all_cohorts_and_behaviors
    @cohorts = Cohort.all
    @behaviours = Behaviour.all
  end

end
