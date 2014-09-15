# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
# https://github.com/DatabaseCleaner/database_cleaner
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  DatabaseCleaner.clean_with :truncation
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
