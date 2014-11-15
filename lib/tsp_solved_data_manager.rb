#require_relative "services/xml_parser"
require_relative "tsp_solved_data"

class TSPSolvedDataManager
  def initialize name, algorithm_name
    @name = name
    @algorithm_name = algorithm_name
    @tsp_solved_data = []
  end

  def push tsp_solved_data
    @tsp_solved_data.push tsp_solved_data
  end

  def last
    @tsp_solved_data.last
  end

  def best
    @tsp_solved_data.min
  end
=begin
  def initialize name, algorithms
    @name = name
    #@initial_solutions = initial_solutions
    #@algorithms = algorithms
    #get_tcp_problem
  end
  def get_tcp_problem
    tcp_problem = XMLParser.get_tcp_problem "data/#{@name}.xml"
    @graph = tcp_problem[:graph]
    initial_solutions = tcp_problem[:initialSolutions]
  end

  def solve
    @algorithms.each do |algorithm|

    end
  end
=end
end