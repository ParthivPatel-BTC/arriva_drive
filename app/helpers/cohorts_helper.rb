module CohortsHelper

  def form_path_for_cohort(cohort)
    cohort.new_record? ? cohorts_path : cohort_path(cohort)
  end

  def form_method_for_cohort(cohort)
    cohort.new_record? ? :post : :put
  end

end
