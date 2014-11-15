require_relative "algorithms/hill_climbing"
require_relative "manager"

=begin
problems = [
  "br17", 
  "bays29", 
  "ftv33", 
  "ftv35"  , 
  "swiss42" , 
  "p43"      ,
  "ftv44"    ,
  "ftv47"    ,
  "att48"    ,
  "ry48p"    ,
  "eil51"    ,
  "berlin52" ,
  "ft53"     ,
  "ftv55"    ,
  "ftv64"    ,
  "eil76"    ,
  "eil101" 
]  
=end
#
# => Input Info
#
#problems = ["br17", "bays29", "ftv33", "ftv35", "swiss42" , "p43", "ftv44", "ftv47", "att48", "ry48p", "eil51", "berlin52", "ft53", "ftv55", "ftv64", "eil76", "eil101"]  
problems = ["br17"]
algorithms = [HillClimbing]
#
# => Solving
#
#table = {}
problem_containers = {}
general_time = Timer.exec_time do
  problems.each do |filename| 
    table[filename] = []
    tcp_problem = XMLParser.get_tcp_problem "data/#{filename}.xml"
    graph = tcp_problem[:graph]
    problem_containers[filename] = TSPSolvedDataManager.new filename, algorithm.to_s
    tcp_problem[:initialSolutions][0...10].each_with_index do |initial_solution, i|
      #i = 0
      #initial_solution = tcp_problem[:initialSolutions][i]
      algorithms.each do 
      local_search = algorithm1.new(graph, initial_solution)
      problem_containers[filename].push local_search.solve
      table[filename][i] = problem_containers[filename].last.to_hash
    end
  end
  tsp_to_xls = TSPtoXLS.new problem_containers
  tsp_to_xls.detailed_report
end
p general_time
#p table