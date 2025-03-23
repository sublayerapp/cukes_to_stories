require "asana"
require "yaml"
require "sublayer"

# Load any Actions, Generators, and Agents
Dir[File.join(__dir__, "actions", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "generators", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "agents", "*.rb")].each { |file| require file }
Sublayer.configuration.ai_provider = Sublayer::Providers::Gemini
Sublayer.configuration.ai_model = "gemini-2.0-flash"

Dir[File.join(__dir__, "features", "*.feature")].each do |feature_file|
  stories = StoryGeneratorFromFeatureFile.new(feature_file: File.read(feature_file)).generate

  puts "Stories: #{stories.count}"

  stories.each do |story|
    AsanaCreateTaskAction.new(
      project_id: ENV["ASANA_PROJECT_ID"],
      name: story[:title],
      description: "#{story[:description]}\n\nAcceptance Criteria:\n\n#{story[:acceptance_criteria]}"
    ).call
  end
end
