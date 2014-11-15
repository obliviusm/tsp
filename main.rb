require_relative "algorithms/hill_climbing"
require_relative "manager"
#
# => Input Info
#
problems = ["br17", "bays29", "ftv33", "ftv35", "swiss42" , "p43", "ftv44", "ftv47", "att48", "ry48p", "eil51", "berlin52", "ft53", "ftv55", "ftv64", "eil76", "eil101"]  
#problems = ["br17"]
algorithms = [HillClimbing]
#
# => Solving
#
general_time = Timer.exec_time do
  Manager.new(problems, algorithms).solve_problems
end
p general_time