module RecordHandling
  def save_best
    @best_climbers ||= []
    new_best_climbers = @population.sort.first save_best_size
    new_best_climbers.min.f
    @best_climbers += new_best_climbers
  end

  def make_hill_climb_for_bests
    champions = @best_climbers
                      .delete_tsp_diplicates \
                      .sort.first(hill_climb_record_size)
                      .map do |sol|
                        HillClimbing.new(sol.w, sol.x).solve
                      end
    update_record champions.min
  end

  def make_hill_climb_for_current_bests
    champions = @population
                  .sort.first(save_best_size)
                  .map do |sol|
                    HillClimbing.new(sol.w, sol.x).solve
                  end
    update_record champions.min
  end

  def update_record candidate = nil
    p @counter.to_s + ". avg: " + @population.tsp_avg_f.to_s
    candidate ||= @population.min
    candidate = HillClimbing.new(candidate.w, candidate.x).solve
    if candidate < @solution
      @solution = candidate 
      record_was_improved true
      p "best: " + candidate.f.to_s
    else
      record_was_improved false
    end
  end
end