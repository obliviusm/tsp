class TSPSolvedData
  include Comparable
  attr_reader :start_solution, :finish_solution, :time
=begin
  alias :start_solution :s
  alias :finish_solution :f
  alias :time :t
=end
  def initialize start_solution, finish_solution, time
    @start_solution = start_solution
    @finish_solution = finish_solution
    @time = time
  end

  def <=> (other)
    @finish_solution <=> other.finish_solution
  end

  def to_hash
    {s: @start_solution.f, f: @finish_solution.f, t: @time}
  end

  def to_detailed_array
    [@finish_solution.f, @time] + @finish_solution.x
  end
end