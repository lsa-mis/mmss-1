RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# Disable factory linting during test runs
FactoryBot.lint_only_failures = true 