class GeneticCX < GeneticBase
  SELECTION = {
    max_population: 50,
    max_age: 5,
    crack_for_bests: 2,
    best_percent: 0.02
  }
  MUTATION = {
    percent: 5,
    swap_size: 3
  }
  ITERATIONS = 10
  RECORD = {
    save_best_size: 15,
    hill_climb: 15
  }

  def initialize w, paths
    super
  end

  def solve
    extential_reproduction
    begin 
      saving_reproduction
      mutation
      save_best
      selection aging: true, 
                best_percent: true
    end while stop_criteria
    make_hill_climb_for_bests
  end
end
# Reproduction
# => cross - cycle
# => before start: extential_reproduction
# => saving_reproduction - bother parents and children
# Mutation
# => swap 3 times
# Selection
# => aging 
# => take % from best crack size
# => others fully random
# Stop
# => n cycles
# Record
# => take bests after each iter 
# => at the end make hill climb for bests