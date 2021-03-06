module StopCriteria
  def stop_criteria
    count
    case stop_criteria_type
    when :improving
      @steps_without_improving < max_steps_without_improving
    else
      @counter < iterations
    end
  end

  def count
    @counter ||= 0
    @counter += 1
    count_events
  end

  def record_was_improved status
    @steps_without_improving ||= 0
    if status
      @steps_without_improving = 0
    else
      @steps_without_improving += 1
    end
  end

  def count_events
    mutation_type_change
    reproduction_change_type
  end
end