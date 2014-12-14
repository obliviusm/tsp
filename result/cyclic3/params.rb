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
    reproduction_type: [:cycle_x, :max_preservative_x, :partially_mapped_x], #:partially_mapped_x, 
    change_type_steps: 8,
    change_type: :cyclic#:got_stuck
  }
  STOP_CRITERIA = {
    iterations: 10,
    max_steps_without_improving: 3,
    type: :improving
  }