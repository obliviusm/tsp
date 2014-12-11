class GeneticCX < GeneticBase
  SELECTION = {
    max_population: 5,
    aging: true,
    max_age: 3,
    crack_for_bests: 2,
    best_percent: 0.2,
    #wheel_size: 0.1,
    type: :probability_wheel
  }
  MUTATION = {
    percent: 5,
    swap_size: 1
  }
  ITERATIONS = 2
  RECORD = {
    save_best_size: 15,
    hill_climb: 15
  }
  REPRODUCTION = {
    reproduction_type: :cycle_x
  }

  def initialize w, paths
    super
  end

  def solve
    #extential_reproduction
    #extential_mutation
    #save_best
    begin 
      saving_reproduction
      mutation
      save_best
      select_time = Timer.exec_time do
        selection
      end
      p select_time
    end while stop_criteria
    make_hill_climb_for_bests
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
=end