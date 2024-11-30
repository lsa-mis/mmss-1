RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# Test factories before running specs
FactoryBot.lint 