require_relative "services/xml_parser"
#require_relative "services/timer"
require_relative "algorithms/local_search"
require_relative "lib/tsp_solved_data_manager"

#problems = ["br17", "bays29", "ftv33", "ftv35", "swiss42", "p43", "ftv44"]
problems = ["br17"]
table = {}
problem_containers = {}
problems.each do |filename| 
  table[filename] = []
  tcp_problem = XMLParser.get_tcp_problem "data/#{filename}.xml"
  graph = tcp_problem[:graph]
  problem_containers[:filename] = TSPSolvedDataManager.new filename, LocalSearch.to_s
  tcp_problem[:initialSolutions].each_with_index do |initial_solution, i|
    #i = 0
    #initial_solution = tcp_problem[:initialSolutions][i]
    local_search = LocalSearch.new(graph, initial_solution)
    problem_containers[:filename].push local_search.solve
    table[filename][i] = problem_containers[:filename].last.to_hash
  end
end
p table