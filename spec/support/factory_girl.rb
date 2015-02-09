# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
# https://github.com/DatabaseCleaner/database_cleaner
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  # Clean up and initialize database before 
  # running test exmaples
  config.before(:suite) do
    # Truncate database to clean up garbage from 
    # interrupted or badly written examples
    DatabaseCleaner.clean_with(:truncation)

    # Seed dataase. Use it only for essential
    # to run application data.
    # load "#{Rails.root}/db/seeds.rb"
  end

  config.around(:each) do |example|
    # Use really fast transaction strategy for all 
    # examples except `js: true` capybara specs
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction

    # Start transaction
    DatabaseCleaner.start

    # Run example
    example.run

    # Rollback transaction
    DatabaseCleaner.clean

    # Clear session data
    Capybara.reset_sessions!
  end
end
