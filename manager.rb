class Manager
  def initialize problems, algorithms
    @problems = problems
    @algorithms = algorithms
    initialize_problem_containers
  end

  def solve_problems
    @problems.each do |problem|
      graph, initial_solutions = get_initial_data problem
      @algorithms.each do |algorithm|
        algorithm_solver = Solver.new(graph, algorithm, initial_solutions.dup)
        @problem_containers[problem][algorithm.to_s] = algorithm_solver.solve
        p problem
      end
    end
    export_to_xls
  end
  
  protected

  def export_to_xls
    tsp_to_xls = TSPtoXLS.new @problem_containers
    @algorithms.each do |algorithm|
      tsp_to_xls.detailed_report algorithm.to_s
    end
    if @algorithms.count == 2
      tsp_to_xls.comparison_report @algorithms[0].to_s, @algorithms[1].to_s
    end
  end

  def initialize_problem_containers
    @problem_containers = {}
    @problems.each do |problem|
      @problem_containers[problem] = {}
    end
  end

  def get_initial_data filename
    tcp_problem = XMLParser.get_tcp_problem "data/#{filename}.xml"
    [ tcp_problem[:graph], tcp_problem[:initialSolutions][0...10] ]
  end
end