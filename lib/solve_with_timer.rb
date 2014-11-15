require_relative "../lib/tsp_solved_data"
require_relative "../services/timer"

module SolveWithTimer
  def solve
    s = @solution
    t = Timer.exec_time do
      algorithm
    end
    f = @solution
    TSPSolvedData.new(s, f, t)
  end
end