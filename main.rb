require_relative "services/xml_parser"
require_relative "services/timer"
require_relative "algorithms/local_search"


#problems = ["br17", "bays29", "ftv33", "ftv35", "swiss42", "p43", "ftv44"]
problems = ["eil101"]
table = {}
problems.each do |filename| 
  table[filename] = []
  tcp_problem = get_tcp_problem "data/#{filename}.xml"
  graph = tcp_problem[:graph]
  #tcp_problem[:initialSolutions][:path].each_with_index do |solution, i|
    i = 0
    initial_solution = tcp_problem[:initialSolutions][:path][i][:vertex]
    #initial_solution = solution[:vertex]
    table[filename][i] = {}
    local_search = LocalSearch.new(graph, initial_solution)
    table[filename][i][:s] = local_search.f
    table[filename][i][:t] = Timer.exec_time do
      local_search.simple_local_search
    end
    table[filename][i][:f] = local_search.f
  #end
end
p table