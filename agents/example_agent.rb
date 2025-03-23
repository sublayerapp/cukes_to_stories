# frozen_string_literal: true

class ExampleAgent < Sublayer::Agents::Base
  trigger_on_files_changed { ["example_file.txt"] }

  goal_condition { @goal_reached }

  check_status do
    @status_checked = true
  end

  step do
    @step_taken = true
    @goal_reached = true
    puts "Example agent step executed"
  end
end
