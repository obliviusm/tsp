require_relative "xml_to_hash"

def reoder_costs_in_graph tsp_problem
  reodered_graph = []
  tsp_problem[:graph][:vertex].each_with_index do |vertex, source_node|
    reodered_graph[source_node] = []
    vertex[:edge].each do |edge|
      #p edge
      dest_node = edge["value"].to_i
      reodered_graph[source_node][dest_node] = edge[:attributes][:cost].to_f.to_i
    end
    #p reodered_graph[source_node]
  end
  tsp_problem[:graph] = reodered_graph
end

def get_tcp_problem filename
  f = File.open filename
  tsp_problem = Hash.from_xml(f)[:travellingSalesmanProblemInstance]
  reoder_costs_in_graph tsp_problem
  f.close
  tsp_problem
end