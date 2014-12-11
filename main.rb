require 'require_all'
#require_all '../tsp'
require_all 'lib'
require_all 'algorithms'
require_all 'services'
require_all 'manager.rb'

#
# => Input Info
#
#problems = ["br17", "bays29", "ftv33", "ftv35", "swiss42" , "p43", "ftv44", "ftv47", "ry48p", "eil51", "berlin52", "ft53", "ftv55", "ftv64", "eil76", "eil101"]  
problems = ["ftv33"]#, "ftv35", "ftv44"]
#problems = ["br17"]
#problems = ["ry48p", "berlin52", "ftv55", "eil76"]
algorithms = [HillClimbing, GeneticCX]
#
# => Solving
#
general_time = Timer.exec_time do
  Manager.new(problems, algorithms).solve_problems
end
p general_time