class StoryGeneratorFromFeatureFile < Sublayer::Generators::Base
  llm_output_adapter type: :list_of_named_strings,
    name: "new_stories",
    description: "List of new user stories derived from the feature file",
    item_name: "story",
    attributes: [
      { name: "title", description: "The title of the user story" },
      { name: "description", description: "A detailed description of the user story" },
      { name: "acceptance_criteria", description: "Acceptance criteria for the user story" }
    ]

  def initialize(feature_file:)
    @feature_file = feature_file
  end

  def generate
    super
  end

  def prompt
    <<-PROMPT
      You are an expert product owner with years of experience writing user stories based on specifications.

      You are tasked with analyzing a Cucumber feature file and generating new user stories, descriptions, and acceptance criteria.

      Feature File:
      #{@feature_file}

      Analyze the Feature File provided, taking into account only the scenarios described by the feature file, to identify new user stories that need to be written.
      For each new user story, generate:
      A title in the format of: {user type} can {do something}
      a detailed description in the markdown format in the style of:
      As a {user type},
      I want to {do something}
      so that {I can achieve a goal}.
      and clear acceptance criteria heavily inspired by the body of the scenario also in markdown format

      Ensure that the new user stories are distinct and thoroughly cover all the functionality described in the feature file.
      It is better to have a duplicate story we can remove than to miss one.
    PROMPT
  end
end
