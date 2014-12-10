require_relative "manager"
require_relative "algorithms/hill_climbing"
require_relative "algorithms/hill_climbing_shuffle"
require_relative "algorithms/smoothing_algorithm"
require_relative "algorithms/genetic_algorithm"
#
# => Input Info
#
#problems = ["br17", "bays29", "ftv33", "ftv35", "swiss42" , "p43", "ftv44", "ftv47", "ry48p", "eil51", "berlin52", "ft53", "ftv55", "ftv64", "eil76", "eil101"]  
problems = ["ftv33", "ftv35", "ftv44"]
#problems = ["ry48p", "berlin52", "ftv55", "eil76"]
algorithms = [HillClimbing, GeneticAlgorithm]
#
# => Solving
#
general_time = Timer.exec_time do
  Manager.new(problems, algorithms).solve_problems
end
p general_time