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
end