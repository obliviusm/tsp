module TSPSolvedDataManager
  def find_best_start_solution tsp_array
    tsp_start_best = tsp_array[0]
    tsp_array.each do |tsp_data|
      if tsp_data.start_solution.f < tsp_start_best.start_solution.f
        tsp_start_best = tsp_data
      end
    end

    tsp_start_best
  end
end