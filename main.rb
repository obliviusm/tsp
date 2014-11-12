require_relative "services/xml_parser"
require_relative "algorithms/local_search"

tcp_problem = get_tcp_problem "data/br17.xml"
graph = tcp_problem[:graph]
initial_solution = tcp_problem[:initialSolutions][:path][0][:vertex]
local_search = LocalSearch.new(graph, initial_solution)
p local_search.x, local_search.f
local_search.simple_local_search
p local_search.x, local_search.f