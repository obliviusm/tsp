require_relative "services/xml_parser"
require_relative "algorithms/local_search"


problems = ["br17"]
table = {}
problems.each do |filename| 
  table[filename] = {}
  tcp_problem = get_tcp_problem "data/#{filename}.xml"
  graph = tcp_problem[:graph]
  table[filename][:solutions] = []
  tcp_problem[:initialSolutions][:path].each_with_index do |solution, i|
    initial_solution = solution[:vertex]
    table[filename][:solutions][i] = []
    local_search = LocalSearch.new(graph, initial_solution)
    table[filename][:solutions][i][0] = local_search.f
    #p local_search.x, local_search.f
    local_search.simple_local_search
    table[filename][:solutions][i][1] = local_search.f
    #p local_search.x, local_search.f
  end
end
p table