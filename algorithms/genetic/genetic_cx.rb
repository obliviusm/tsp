class GeneticCX < GeneticBase
  SELECTION = {
    max_population: 5,
    aging: true,
    max_age: 5,
    #crack_for_bests: 1.5,
    best_percent: 0.3,
    #wheel_size: 0.1,
    type: :best_percent
  }
  MUTATION = {
    percent: 5,
    swap_size: 1,
    mutation_type: [:hill_climbing, :swapping],
    change_type_steps: 3
  }
  RECORD = {
    save_best_size: 5#,
    #hill_climb: 5
  }
  REPRODUCTION = {
    reproduction_type: [:partially_mapped_x, :cycle_x, :max_preservative_x],
    change_type_steps: 12
  }
  STOP_CRITERIA = {
    iterations: 10,
    max_steps_without_improving: 40,
    type: :improving
  }

  def initialize w, paths
    super
  end

  def solve
    extential_reproduction
    #extential_mutation
    #save_best
    begin 
      saving_reproduction
      mutation
      #save_best
      make_hill_climb_for_current_bests
      #update_record
      selection
    end while stop_criteria
    #make_hill_climb_for_bests
  end
end

=begin

Reproduction
=> cross - cycle
=> before start: extential_reproduction
=> saving_reproduction - bother parents and children
Mutation
=> swap 3 times
Selection
=> aging 
=> take % from best crack size
=> others fully random
Stop
=> n cycles
Record
=> take bests after each iter 
=> at the end make hill climb for bests
---------------------------------------------------
best_percent
  ftv33 -215, ftv35 -181, ftv44 -258

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
------------------------------------------------------
ftv47 e=19
percent = self.class::SELECTION[:best_percent] * (1 + @counter.to_f / 10.0)

SELECTION = {
    max_population: 50,
    aging: true,
    max_age: 5,
    crack_for_bests: 2,
    best_percent: 0.1,
    #wheel_size: 0.1,
    type: :best_percent
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
------------------------------------------------------
ftv47 e=11
  SELECTION = {
    max_population: 50,
    aging: false,
    max_age: 5,
    crack_for_bests: 2,
    best_percent: 0.2,
    #wheel_size: 0.1,
    type: :best_percent
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
------------------------------------------------------
ftv44 - 1724

  SELECTION = {
    max_population: 100,
    aging: true,
    max_age: 5,
    crack_for_bests: 1.5,
    best_percent: 0.2,
    #wheel_size: 0.1,
    type: :bla
  }
  MUTATION = {
    percent: 5,
    swap_size: 1
  }
  ITERATIONS = 10
  RECORD = {
    save_best_size: 5,
    hill_climb: 5
  }
  REPRODUCTION = {
    reproduction_type: :partially_mapped_x
  }
------------------------------------------------------
ftv44 e1.7
  SELECTION = {
    max_population: 5,
    aging: true,
    max_age: 5,
    crack_for_bests: 1.5,
    best_percent: 0.3,
    #wheel_size: 0.1,
    type: :best_percent
  }
  MUTATION = {
    percent: 5,
    swap_size: 1,
    mutation_type: [:hill_climbing, :swapping],
    change_type_steps: 3
  }
  ITERATIONS = 10
  RECORD = {
    save_best_size: 5,
    hill_climb: 5
  }
  REPRODUCTION = {
    reproduction_type: [:partially_mapped_x, :cycle_x, :max_preservative_x],
    change_type_steps: 12
  }
=end