module RecordHandling
  def save_best
    @best_climbers ||= []
    @best_climbers += @population.sort.first(best_percent * 3)
  end

  def make_hill_climb_for_bests
    champions = @best_climbers
                      .delete_tsp_diplicates
                      .sort.first(best_percent * @n * 3)
                      .map do |sol|
                        HillClimbing.new(sol.w, sol.x).solve
                      end
    update_record champions.min
  end

  def update_record candidate = nil
    candidate ||= @population.min
    @solution = candidate if candidate < @solution
  end
end