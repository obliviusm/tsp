require 'spreadsheet'
require_relative '../lib/tsp_solved_data_manager'

class TSPtoXLS
  include TSPSolvedDataManager
  def initialize problems
    @problems = problems
    @filename = "result/tcp#{Time.now.strftime("%d_%H:%M:%S")}.xls"
    @book = Spreadsheet::Workbook.new
  end

  def detailed_report algorithm
    set_current_sheet algorithm
    write_detailed_report_header
    @problems.each_with_index do |(name, algorithms_with_tsp_data), index|
      #p [name, tsp_data, index]
      tsp_data = algorithms_with_tsp_data[algorithm]
      insert_row index + 1, detailed_row(name, tsp_data)
    end
    save_book
  end

  def comparison_report algorithm1, algorithm2
    set_current_sheet "Comparison"
    write_comparison_report_header
    @problems.each_with_index do |(name, data), index|
      row = comparison_row name, data[algorithm1], data[algorithm2]
      insert_row index + 1, row
    end
    save_book
  end

  protected

  def save_book
    File.delete @filename if File.exist? @filename
    @book.write @filename
  end

  def comparison_row name, tsp_data1, tsp_data_2
    tsp_best1, tsp_best2 = tsp_data1.min, tsp_data_2.min
    tsp_start_best = find_best_start_solution(tsp_data1).start_solution.f
    tsp_very_best = GENERAL_PROBLEMS_INFO[name][:f]
    tsp_best1.data_for_comparison(tsp_start_best, tsp_very_best)
    tsp_best2.data_for_comparison(tsp_start_best, tsp_very_best)

    [name] + GENERAL_PROBLEMS_INFO[name].values + [tsp_start_best] +
    tsp_best1.to_comparison_array + tsp_best2.to_comparison_array +
    tsp_best2.compare_array(tsp_best1)
  end

  def detailed_row(name, tsp_data)
    [name] + GENERAL_PROBLEMS_INFO[name].values + tsp_data.min.to_detailed_array
  end

  def insert_row index, row
    #p index, row
    @current_sheet.insert_row index, row.unshift(index)
  end

  def set_current_sheet name
    @current_sheet = @book.create_worksheet :name => name
  end

  def write_comparison_report_header
    @current_sheet.insert_row(0, COMPARISON_REPORT_HEADER)
  end

  def write_detailed_report_header
    @current_sheet.insert_row(0, DETAILED_REPORT_HEADER)
  end

  GENERAL_PROBLEMS_INFO = {
    "br17"      => {n: 17,  f: 39},
    "bays29"    => {n: 29,  f: 2020},
    "ftv33"     => {n: 34,  f: 1286},
    "ftv35"     => {n: 36,  f: 1473},
    "swiss42"   => {n: 17,  f: 1273},
    "p43"       => {n: 43,  f: 5620},
    "ftv44"     => {n: 45,  f: 1613},
    "ftv47"     => {n: 48,  f: 1776},
    "att48"     => {n: 48,  f: 10628},
    "ry48p"     => {n: 48,  f: 14422},
    "eil51"     => {n: 51,  f: 426},
    "berlin52"  => {n: 52,  f: 7542},
    "ft53"      => {n: 53,  f: 6905},
    "ftv55"     => {n: 56,  f: 1608},
    "ftv64"     => {n: 65,  f: 1839},
    "eil76"     => {n: 76,  f: 538},
    "eil101"    => {n: 101, f: 629}
  }.freeze

  DETAILED_REPORT_HEADER = [
    "№",
    "Назва задачі",
    "n",
    "f*",
    "f record",
    "час",
    "Найкращий розв'язок"
  ].freeze

  COMPARISON_REPORT_HEADER = [
    "№",
    "Назва задачі",
    "n",
    "f*",
    "f0",
    "f1",
    "E1",
    "t1",
    "f2",
    "E2",
    "t2",
    "f2-f1",
    "E2-E1",
    "t2/t1"
  ].freeze
end