require "yaml"
require "sublayer"

# Load any Actions, Generators, and Agents
Dir[File.join(__dir__, "actions", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "generators", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "agents", "*.rb")].each { |file| require file }
Sublayer.configuration.ai_provider = Sublayer::Providers::Gemini
Sublayer.configuration.ai_model = "gemini-1.5-flash-latest"
puts "Welcome to your quick Sublayer script!"
puts "To get started, create some generators, actions, or agents in their respective directories and call them here"
puts "For more information, visit https://docs.sublayer.com"
